import 'package:reactive_forms/reactive_forms.dart';

/// Данные вечерней рефлексии (дихотомия контроля).
class ReflectionNotes {
  final String noteUncontrolled;
  final String noteControlled;

  const ReflectionNotes({
    required this.noteUncontrolled,
    required this.noteControlled,
  });
}

/// Определение формы вечерней рефлексии (не создавать FormGroup в Widget).
abstract final class ReflectionForm {
  static const String noteUncontrolled = 'noteUncontrolled';
  static const String noteControlled = 'noteControlled';

  static FormGroup build({
    String uncontrolled = '',
    String controlled = '',
  }) {
    return fb.group({
      noteUncontrolled: FormControl<String>(
        value: uncontrolled,
        validators: [Validators.required],
      ),
      noteControlled: FormControl<String>(
        value: controlled,
        validators: [Validators.required],
      ),
    });
  }

  static ReflectionNotes toNotes(FormGroup form) {
    return ReflectionNotes(
      noteUncontrolled: form.control(noteUncontrolled).value as String? ?? '',
      noteControlled: form.control(noteControlled).value as String? ?? '',
    );
  }

  static FormControl<String> uncontrolledControl(FormGroup form) =>
      form.control(noteUncontrolled) as FormControl<String>;

  static FormControl<String> controlledControl(FormGroup form) =>
      form.control(noteControlled) as FormControl<String>;
}
