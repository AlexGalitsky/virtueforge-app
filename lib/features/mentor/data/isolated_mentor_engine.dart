import 'dart:async';
import 'dart:isolate';

import 'package:virtue_forge/features/mentor/data/llamadart_mentor_engine.dart';
import 'package:virtue_forge/features/mentor/domain/services/local_mentor_engine.dart';

/// Runs [LlamadartMentorEngine] in a background isolate so generation
/// does not block the UI isolate (FFI / llama.cpp is CPU-heavy).
class IsolatedMentorEngine implements LocalMentorEngine {
  Isolate? _isolate;
  SendPort? _cmdPort;
  final ReceivePort _fromWorker = ReceivePort();
  StreamSubscription<dynamic>? _fromWorkerSub;

  final _ready = Completer<void>();
  var _starting = false;

  String? _loadedPath;
  var _hasSession = false;
  var _readyFlag = false;

  int _nextId = 1;
  final _pending = <int, Completer<void>>{};
  StreamController<String>? _tokenController;
  int? _activeReplyId;

  @override
  String? get loadedPath => _loadedPath;

  @override
  bool get isReady => _readyFlag && _loadedPath != null;

  @override
  bool get hasSession => _hasSession;

  Future<void> _ensureWorker() async {
    if (_cmdPort != null) {
      await _ready.future;
      return;
    }
    if (_starting) {
      await _ready.future;
      return;
    }
    _starting = true;
    _fromWorkerSub = _fromWorker.listen(_onWorkerMessage);
    _isolate = await Isolate.spawn(
      _mentorIsolateEntry,
      _fromWorker.sendPort,
      debugName: 'virtue_mentor_llm',
    );
    await _ready.future;
  }

  void _onWorkerMessage(dynamic raw) {
    if (raw is! Map) return;
    final map = Map<String, dynamic>.from(raw);

    if (map['type'] == 'port') {
      _cmdPort = map['port'] as SendPort;
      if (!_ready.isCompleted) _ready.complete();
      return;
    }

    final id = map['id'] as int?;
    final type = map['type'] as String?;

    if (type == 'token' && id == _activeReplyId) {
      final text = map['text'] as String? ?? '';
      if (text.isNotEmpty) _tokenController?.add(text);
      return;
    }

    if (type == 'done' && id == _activeReplyId) {
      _activeReplyId = null;
      _tokenController?.close();
      _tokenController = null;
      return;
    }

    if (type == 'error') {
      final err = map['error']?.toString() ?? 'Mentor isolate error';
      if (id != null && _pending.containsKey(id)) {
        _pending.remove(id)?.completeError(StateError(err));
      }
      if (id == _activeReplyId) {
        _activeReplyId = null;
        _tokenController?.addError(StateError(err));
        _tokenController?.close();
        _tokenController = null;
      }
      return;
    }

    if (type == 'ok' && id != null) {
      final c = _pending.remove(id);
      if (c != null && !c.isCompleted) c.complete();
      if (map['loadedPath'] != null) {
        _loadedPath = map['loadedPath'] as String?;
        _readyFlag = _loadedPath != null;
      }
      if (map.containsKey('hasSession')) {
        _hasSession = map['hasSession'] == true;
      }
      if (map['cleared'] == true) {
        _loadedPath = null;
        _readyFlag = false;
        _hasSession = false;
      }
    }
  }

  Future<void> _send(Map<String, dynamic> msg) async {
    await _ensureWorker();
    final id = _nextId++;
    final c = Completer<void>();
    _pending[id] = c;
    msg['id'] = id;
    _cmdPort!.send(msg);
    await c.future;
  }

  @override
  Future<void> load(String modelPath) async {
    await _send({'cmd': 'load', 'path': modelPath});
    _loadedPath = modelPath;
    _readyFlag = true;
  }

  @override
  Future<void> unload() async {
    await cancel();
    if (_cmdPort == null) {
      _loadedPath = null;
      _readyFlag = false;
      _hasSession = false;
      return;
    }
    await _send({'cmd': 'unload'});
    _loadedPath = null;
    _readyFlag = false;
    _hasSession = false;
  }

  @override
  Future<void> beginSession({required String systemPrompt}) async {
    await _send({'cmd': 'begin', 'system': systemPrompt});
    _hasSession = true;
  }

  @override
  void endSession() {
    // Fire-and-forget; mirror local flag immediately.
    _hasSession = false;
    if (_cmdPort == null) return;
    final id = _nextId++;
    _cmdPort!.send({'cmd': 'end', 'id': id});
  }

  @override
  Stream<String> reply(String userMessage) {
    final controller = StreamController<String>();
    _tokenController = controller;

    () async {
      try {
        await _ensureWorker();
        final id = _nextId++;
        _activeReplyId = id;
        _cmdPort!.send({'cmd': 'reply', 'id': id, 'text': userMessage});
      } catch (e, st) {
        if (!controller.isClosed) {
          controller.addError(e, st);
          await controller.close();
        }
      }
    }();

    controller.onCancel = () async {
      await cancel();
    };

    return controller.stream;
  }

  @override
  Future<void> cancel() async {
    if (_cmdPort == null) return;
    final id = _nextId++;
    _cmdPort!.send({'cmd': 'cancel', 'id': id});
    _activeReplyId = null;
    if (_tokenController != null && !_tokenController!.isClosed) {
      await _tokenController!.close();
    }
    _tokenController = null;
  }

  Future<void> dispose() async {
    await cancel();
    await _fromWorkerSub?.cancel();
    _isolate?.kill(priority: Isolate.immediate);
    _isolate = null;
    _cmdPort = null;
  }
}

@pragma('vm:entry-point')
void _mentorIsolateEntry(SendPort mainSend) {
  final engine = LlamadartMentorEngine();
  final inbox = ReceivePort();
  mainSend.send({'type': 'port', 'port': inbox.sendPort});

  StreamSubscription<String>? replySub;

  inbox.listen((raw) async {
    if (raw is! Map) return;
    final msg = Map<String, dynamic>.from(raw);
    final id = msg['id'] as int? ?? 0;
    final cmd = msg['cmd'] as String?;

    try {
      switch (cmd) {
        case 'load':
          await engine.load(msg['path'] as String);
          mainSend.send({
            'type': 'ok',
            'id': id,
            'loadedPath': engine.loadedPath,
            'hasSession': engine.hasSession,
          });
        case 'unload':
          await replySub?.cancel();
          replySub = null;
          await engine.unload();
          mainSend.send({
            'type': 'ok',
            'id': id,
            'cleared': true,
            'hasSession': false,
          });
        case 'begin':
          await engine.beginSession(systemPrompt: msg['system'] as String);
          mainSend.send({
            'type': 'ok',
            'id': id,
            'hasSession': true,
            'loadedPath': engine.loadedPath,
          });
        case 'end':
          engine.endSession();
          mainSend.send({'type': 'ok', 'id': id, 'hasSession': false});
        case 'cancel':
          await replySub?.cancel();
          replySub = null;
          await engine.cancel();
          mainSend.send({'type': 'ok', 'id': id});
        case 'reply':
          await replySub?.cancel();
          final text = msg['text'] as String? ?? '';
          replySub = engine.reply(text).listen(
            (delta) {
              mainSend.send({'type': 'token', 'id': id, 'text': delta});
            },
            onError: (Object e) {
              mainSend.send({'type': 'error', 'id': id, 'error': e.toString()});
            },
            onDone: () {
              mainSend.send({'type': 'done', 'id': id});
            },
            cancelOnError: true,
          );
        default:
          mainSend.send({
            'type': 'error',
            'id': id,
            'error': 'Unknown cmd: $cmd',
          });
      }
    } catch (e) {
      mainSend.send({'type': 'error', 'id': id, 'error': e.toString()});
    }
  });
}
