import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtue_forge/features/mentor/domain/models/mentor_audience.dart';
import 'package:virtue_forge/features/mentor/domain/repositories/mentor_repositories.dart';
import 'package:virtue_forge/features/mentor/domain/services/local_mentor_engine.dart';
import 'package:virtue_forge/features/mentor/domain/services/stoic_prompt_builder.dart';

class AudienceCubit extends Cubit<AudienceUiState> {
  AudienceCubit({
    required MentorModelStore modelStore,
    required AudienceRepository audiences,
    required LocalMentorEngine engine,
    required this.virtueWeekNumber,
    required this.virtueLabel,
    this.misdeedSummary = '',
    this.note = '',
    this.totalMisdeeds = 0,
    this.localeCode = 'ru',
  })  : _store = modelStore,
        _audiences = audiences,
        _engine = engine,
        super(AudienceUiState.initial(
          remaining: modelStore.remainingAudiencesToday(),
          modelReady: modelStore.isInstalled(modelStore.selectedModelId),
          disclaimerAccepted: modelStore.disclaimerAccepted,
          selectedModelId: modelStore.selectedModelId,
        ));

  final MentorModelStore _store;
  final AudienceRepository _audiences;
  final LocalMentorEngine _engine;

  final int virtueWeekNumber;
  final String virtueLabel;
  final String misdeedSummary;
  final String note;
  final int totalMisdeeds;
  final String localeCode;

  StreamSubscription<String>? _genSub;
  final StringBuffer _buffer = StringBuffer();
  String? _savedAudienceId;

  Future<void> acceptDisclaimer() async {
    await _store.acceptDisclaimer();
    emit(state.copyWith(disclaimerAccepted: true));
  }

  void setReflection(String value) {
    emit(state.copyWith(reflection: value));
  }

  void setFollowUp(String value) {
    emit(state.copyWith(followUp: value));
  }

  Future<void> refreshModelStatus() async {
    emit(
      state.copyWith(
        modelReady: _store.isInstalled(_store.selectedModelId),
        selectedModelId: _store.selectedModelId,
        remaining: _store.remainingAudiencesToday(),
      ),
    );
  }

  Future<void> startAudience() async {
    if (!state.disclaimerAccepted) return;
    if (state.remaining <= 0) {
      emit(state.copyWith(error: AudienceError.dailyLimit));
      return;
    }
    if (!_store.isInstalled(_store.selectedModelId)) {
      emit(state.copyWith(error: AudienceError.modelMissing));
      return;
    }

    final path = _store.pathFor(_store.selectedModelId);
    if (path == null) {
      emit(state.copyWith(error: AudienceError.modelMissing));
      return;
    }

    _savedAudienceId = null;
    _buffer.clear();
    emit(
      state.copyWith(
        phase: AudiencePhase.loadingModel,
        turns: const [],
        response: '',
        followUp: '',
        followUpsUsed: 0,
        error: null,
        clearError: true,
        interrupted: false,
      ),
    );

    try {
      await _engine.load(path);
    } catch (e) {
      emit(
        state.copyWith(
          phase: AudiencePhase.idle,
          error: AudienceError.engine,
          errorDetail: e.toString(),
        ),
      );
      return;
    }

    emit(state.copyWith(phase: AudiencePhase.generating));

    final input = StoicPromptInput(
      virtue: virtueLabel,
      misdeed: misdeedSummary.isEmpty ? '—' : misdeedSummary,
      note: note.isEmpty ? '—' : note,
      totalMisdeeds: totalMisdeeds,
      userReflection: state.reflection,
      localeCode: localeCode,
    );

    final userText = StoicPromptBuilder.userMessage(input);
    final turns = [
      ...state.turns,
      AudienceTurn(fromUser: true, text: userText),
      const AudienceTurn(fromUser: false, text: ''),
    ];
    emit(state.copyWith(turns: turns));

    await _listenGeneration(
      _engine.generateFirstTurn(input: input),
      isFirstTurn: true,
    );
  }

  Future<void> sendFollowUp() async {
    if (state.phase != AudiencePhase.done) return;
    if (state.followUpsRemaining <= 0) return;
    final text = state.followUp.trim();
    if (text.isEmpty) return;
    if (!_engine.hasSession) return;

    _buffer.clear();
    final turns = [
      ...state.turns,
      AudienceTurn(fromUser: true, text: text),
      const AudienceTurn(fromUser: false, text: ''),
    ];
    emit(
      state.copyWith(
        phase: AudiencePhase.generating,
        turns: turns,
        followUp: '',
        error: null,
        clearError: true,
        interrupted: false,
      ),
    );

    await _listenGeneration(
      _engine.reply(text),
      isFirstTurn: false,
    );
  }

  Future<void> _listenGeneration(
    Stream<String> stream, {
    required bool isFirstTurn,
  }) async {
    await _genSub?.cancel();
    _genSub = stream.listen(
      (delta) {
        _buffer.write(delta);
        final updated = List<AudienceTurn>.from(state.turns);
        if (updated.isNotEmpty && !updated.last.fromUser) {
          updated[updated.length - 1] =
              AudienceTurn(fromUser: false, text: _buffer.toString());
        }
        emit(
          state.copyWith(
            turns: updated,
            response: _buffer.toString(),
          ),
        );
      },
      onError: (Object e) {
        emit(
          state.copyWith(
            phase: AudiencePhase.done,
            error: AudienceError.engine,
            errorDetail: e.toString(),
          ),
        );
      },
      onDone: () async {
        await _finish(interrupted: false, isFirstTurn: isFirstTurn);
      },
    );
  }

  Future<void> stopAudience() async {
    await _engine.cancel();
    await _genSub?.cancel();
    _genSub = null;
    if (_buffer.isNotEmpty) {
      await _finish(interrupted: true, isFirstTurn: _savedAudienceId == null);
    } else {
      emit(state.copyWith(phase: AudiencePhase.done, interrupted: true));
    }
  }

  Future<void> _finish({
    required bool interrupted,
    required bool isFirstTurn,
  }) async {
    final text = _buffer.toString().trim();
    final updated = List<AudienceTurn>.from(state.turns);
    if (updated.isNotEmpty && !updated.last.fromUser) {
      updated[updated.length - 1] =
          AudienceTurn(fromUser: false, text: text);
    }

    final followUpsUsed =
        isFirstTurn ? state.followUpsUsed : state.followUpsUsed + 1;

    emit(
      state.copyWith(
        phase: AudiencePhase.done,
        turns: updated,
        response: text,
        interrupted: interrupted,
        followUpsUsed: followUpsUsed,
      ),
    );

    if (text.isEmpty && updated.where((t) => !t.fromUser).every((t) => t.text.trim().isEmpty)) {
      return;
    }

    final transcript = _transcript(updated);
    final id = _savedAudienceId ??
        DateTime.now().microsecondsSinceEpoch.toString();
    _savedAudienceId = id;

    final audience = MentorAudience(
      id: id,
      createdAt: DateTime.now(),
      virtueWeekNumber: virtueWeekNumber,
      virtueLabel: virtueLabel,
      misdeedSummary: misdeedSummary,
      note: note,
      userReflection: state.reflection,
      aiResponse: transcript,
      modelId: _store.selectedModelId,
      interrupted: interrupted,
    );

    if (isFirstTurn) {
      await _audiences.save(audience);
      if (!interrupted) {
        await _store.recordAudienceCompleted();
      }
    } else {
      await _audiences.updateResponse(id, transcript, interrupted: interrupted);
    }

    emit(state.copyWith(remaining: _store.remainingAudiencesToday()));
  }

  String _transcript(List<AudienceTurn> turns) {
    final en = localeCode.toLowerCase().startsWith('en');
    final you = en ? '— you —' : '— ученик —';
    final mentor = en ? '— mentor —' : '— наставник —';
    final buf = StringBuffer();
    for (final t in turns) {
      if (t.text.trim().isEmpty) continue;
      buf.writeln(t.fromUser ? you : mentor);
      buf.writeln(t.text.trim());
      buf.writeln();
    }
    return buf.toString().trim();
  }

  @override
  Future<void> close() async {
    await _genSub?.cancel();
    await _engine.cancel();
    _engine.endSession();
    return super.close();
  }
}

enum AudiencePhase { idle, loadingModel, generating, done }

enum AudienceError { dailyLimit, modelMissing, engine }

class AudienceTurn {
  const AudienceTurn({required this.fromUser, required this.text});

  final bool fromUser;
  final String text;
}

class AudienceUiState {
  const AudienceUiState({
    required this.phase,
    required this.reflection,
    required this.response,
    required this.remaining,
    required this.modelReady,
    required this.disclaimerAccepted,
    required this.selectedModelId,
    this.turns = const [],
    this.followUp = '',
    this.followUpsUsed = 0,
    this.interrupted = false,
    this.error,
    this.errorDetail,
  });

  factory AudienceUiState.initial({
    required int remaining,
    required bool modelReady,
    required bool disclaimerAccepted,
    required String selectedModelId,
  }) {
    return AudienceUiState(
      phase: AudiencePhase.idle,
      reflection: '',
      response: '',
      remaining: remaining,
      modelReady: modelReady,
      disclaimerAccepted: disclaimerAccepted,
      selectedModelId: selectedModelId,
    );
  }

  final AudiencePhase phase;
  final String reflection;
  final String response;
  final List<AudienceTurn> turns;
  final String followUp;
  final int followUpsUsed;
  final int remaining;
  final bool modelReady;
  final bool disclaimerAccepted;
  final String selectedModelId;
  final bool interrupted;
  final AudienceError? error;
  final String? errorDetail;

  static const maxReflectionLength = 200;
  static const maxFollowUpLength = 200;
  static const maxFollowUps = 3;

  int get followUpsRemaining => (maxFollowUps - followUpsUsed).clamp(0, maxFollowUps);

  bool get canFollowUp =>
      phase == AudiencePhase.done &&
      followUpsRemaining > 0 &&
      !interrupted;

  AudienceUiState copyWith({
    AudiencePhase? phase,
    String? reflection,
    String? response,
    List<AudienceTurn>? turns,
    String? followUp,
    int? followUpsUsed,
    int? remaining,
    bool? modelReady,
    bool? disclaimerAccepted,
    String? selectedModelId,
    bool? interrupted,
    AudienceError? error,
    String? errorDetail,
    bool clearError = false,
  }) {
    return AudienceUiState(
      phase: phase ?? this.phase,
      reflection: reflection ?? this.reflection,
      response: response ?? this.response,
      turns: turns ?? this.turns,
      followUp: followUp ?? this.followUp,
      followUpsUsed: followUpsUsed ?? this.followUpsUsed,
      remaining: remaining ?? this.remaining,
      modelReady: modelReady ?? this.modelReady,
      disclaimerAccepted: disclaimerAccepted ?? this.disclaimerAccepted,
      selectedModelId: selectedModelId ?? this.selectedModelId,
      interrupted: interrupted ?? this.interrupted,
      error: clearError ? null : (error ?? this.error),
      errorDetail: clearError ? null : (errorDetail ?? this.errorDetail),
    );
  }
}
