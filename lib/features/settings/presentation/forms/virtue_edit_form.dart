import 'package:reactive_forms/reactive_forms.dart';

abstract final class VirtueEditForm {
  static const String customDescription = 'customDescription';

  static FormGroup build({String? initial}) {
    return fb.group({
      customDescription: FormControl<String>(
        value: initial ?? '',
        validators: [Validators.required, Validators.minLength(3)],
      ),
    });
  }

  static String valueOf(FormGroup form) =>
      (form.control(customDescription).value as String? ?? '').trim();

  static FormControl<String> descriptionControl(FormGroup form) =>
      form.control(customDescription) as FormControl<String>;
}
