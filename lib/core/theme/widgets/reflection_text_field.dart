import 'package:flutter/material.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';

/// Многострочное поле дневника рефлексии: без рамок, терракотовый заголовок.
class ReflectionTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final int maxLines;
  final FocusNode? focusNode;

  const ReflectionTextField({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.onChanged,
    this.maxLines = 3,
    this.focusNode,
  });

  static const Color _darkFill = Color(0xFF222222);
  static const Color _lightFill = Color(0xFFEFEDE8);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = context.colorScheme;
    final text = context.stoicText;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: text.fieldLabel),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          focusNode: focusNode,
          onChanged: onChanged,
          maxLines: maxLines,
          style: text.fieldInput,
          cursorColor: colors.primary,
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
          ),
        ),
      ],
    );
  }
}
