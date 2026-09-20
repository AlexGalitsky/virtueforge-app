import 'package:virtue_forge/features/mentor/domain/services/stoic_prompt_builder.dart';

/// On-device mentor inference (GGUF).
abstract class LocalMentorEngine {
  /// Absolute path of the GGUF currently held in RAM, if any.
  String? get loadedPath;

  /// Whether a model file is loaded for generation.
  bool get isReady;

  /// Whether an audience chat session is open.
  bool get hasSession;

  Future<void> load(String modelPath);

  Future<void> unload();

  /// Opens a multi-turn session with the given system prompt.
  Future<void> beginSession({required String systemPrompt});

  /// Streams reply deltas for one user turn inside the current session.
  Stream<String> reply(String userMessage);

  /// Ends the chat session (keeps the model loaded).
  void endSession();

  /// Cancel in-flight generation if possible.
  Future<void> cancel();
}

/// Convenience for the first user turn from journal context.
extension LocalMentorEngineAudience on LocalMentorEngine {
  Stream<String> generateFirstTurn({required StoicPromptInput input}) async* {
    await beginSession(systemPrompt: StoicPromptBuilder.systemPrompt(input));
    yield* reply(StoicPromptBuilder.userMessage(input));
  }
}
