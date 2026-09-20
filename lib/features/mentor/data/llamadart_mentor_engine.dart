import 'dart:async';

import 'package:llamadart/llamadart.dart';
import 'package:virtue_forge/features/mentor/domain/services/local_mentor_engine.dart';

/// On-device mentor via [llamadart] (llama.cpp GGUF; native runtime via build hook).
class LlamadartMentorEngine implements LocalMentorEngine {
  LlamaEngine? _engine;
  ChatSession? _session;
  StreamSubscription<LlamaCompletionChunk>? _sub;
  String? _loadedPath;

  static const _generation = GenerationParams(
    maxTokens: 512,
    temp: 0.7,
    topP: 0.9,
    topK: 40,
    penalty: 1.1,
  );

  @override
  bool get isReady => _engine != null && _loadedPath != null;

  @override
  String? get loadedPath => _loadedPath;

  @override
  bool get hasSession => _session != null;

  @override
  Future<void> load(String modelPath) async {
    if (_loadedPath == modelPath && _engine != null) return;
    await unload();

    final engine = LlamaEngine(LlamaBackend());
    try {
      await engine.loadModel(
        modelPath,
        modelParams: const ModelParams(
          contextSize: 2048,
          gpuLayers: 0,
        ),
      );
      _engine = engine;
      _loadedPath = modelPath;
    } catch (_) {
      await engine.dispose();
      rethrow;
    }
  }

  @override
  Future<void> unload() async {
    await cancel();
    endSession();
    await _engine?.dispose();
    _engine = null;
    _loadedPath = null;
  }

  @override
  Future<void> beginSession({required String systemPrompt}) async {
    final engine = _engine;
    if (engine == null || _loadedPath == null) {
      throw StateError(
        'Mentor model is not loaded. Register or download a GGUF first '
        '(see docs/local-llm-native.md).',
      );
    }
    _session = ChatSession(engine, systemPrompt: systemPrompt);
  }

  @override
  void endSession() {
    _session?.reset(keepSystemPrompt: false);
    _session = null;
  }

  @override
  Stream<String> reply(String userMessage) {
    final session = _session;
    if (session == null) {
      return Stream.error(
        StateError('No mentor session. Call beginSession first.'),
      );
    }

    final controller = StreamController<String>();
    late final StreamSubscription<LlamaCompletionChunk> sub;
    sub = session
        .create(
      [LlamaTextContent(userMessage)],
      params: _generation,
    )
        .listen(
      (chunk) {
        final piece = chunk.choices.isEmpty
            ? null
            : chunk.choices.first.delta.content;
        if (piece != null && piece.isNotEmpty) {
          controller.add(piece);
        }
      },
      onError: (Object e, StackTrace st) {
        if (!controller.isClosed) {
          controller.addError(e, st);
          controller.close();
        }
      },
      onDone: () {
        if (!controller.isClosed) controller.close();
      },
      cancelOnError: true,
    );
    _sub = sub;

    controller.onCancel = () async {
      await sub.cancel();
      _sub = null;
    };

    return controller.stream;
  }

  @override
  Future<void> cancel() async {
    await _sub?.cancel();
    _sub = null;
  }
}
