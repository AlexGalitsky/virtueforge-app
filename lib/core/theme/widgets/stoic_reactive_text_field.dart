import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:virtue_forge/core/l10n/app_localizations_x.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';

/// Стоическое многострочное поле для reactive_forms (`formControl:`, не formControlName).
class StoicReactiveTextField extends StatelessWidget {
  final FormControl<String> control;
  final String label;
  final String? hint;
  final int maxLines;

  const StoicReactiveTextField({
    super.key,
    required this.control,
    required this.label,
    this.hint,
    this.maxLines = 3,
  });

  static const Color _darkFill = Color(0xFF222222);
  static const Color _lightFill = Color(0xFFEFEDE8);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = context.colorScheme;
    final text = context.stoicText;
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: text.fieldLabel),
        const SizedBox(height: 8),
        ReactiveTextField<String>(
          formControl: control,
          maxLines: maxLines,
          style: text.fieldInput,
          cursorColor: colors.primary,
          validationMessages: {
            ValidationMessage.required: (_) => l10n.fieldRequired,
          },
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: text.fieldHint,
            filled: true,
            fillColor: isDark ? _darkFill : _lightFill,
            contentPadding: const EdgeInsets.all(14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: colors.primary.withValues(alpha: 0.5),
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colors.error, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colors.error, width: 1),
            ),
          ),
        ),
      ],
    );
  }
}
