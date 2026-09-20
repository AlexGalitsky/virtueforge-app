import 'package:reactive_forms/reactive_forms.dart';

/// Форма краткого контекста проступка (double-tap по ячейке).
abstract final class StrikeNoteForm {
  static const String note = 'note';

  static FormGroup build({String initial = ''}) {
    return fb.group({
      note: FormControl<String>(value: initial),
    });
  }

  static String? toNote(FormGroup form) {
    final value = form.control(note).value as String?;
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) return null;
    return trimmed;
  }

  static FormControl<String> noteControl(FormGroup form) =>
      form.control(note) as FormControl<String>;
}
