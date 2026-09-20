import 'package:flutter/material.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';

/// Контурная кнопка с терракотовой обводкой (вечерняя рефлексия).
class StoicOutlinedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool dimmed;

  const StoicOutlinedButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon = Icons.brightness_3,
    this.dimmed = false,
  });

  @override
  Widget build(BuildContext context) {
    final primary = context.colorScheme.primary;
    final opacity = dimmed ? 0.45 : 1.0;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: Opacity(
        opacity: opacity,
        child: OutlinedButton.icon(
          onPressed: onPressed,
          icon: icon != null
              ? Icon(icon, color: primary, size: 20)
              : const SizedBox.shrink(),
          label: Text(label, style: context.stoicText.buttonOutlined),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: primary, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ),
    );
  }
}
