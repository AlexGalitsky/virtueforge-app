import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:virtue_forge/core/theme/stoic_theme.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';

/// Compact Portico-style markdown for mentor replies (not a full essay reader).
class MentorMarkdownBody extends StatelessWidget {
  const MentorMarkdownBody({
    super.key,
    required this.data,
    this.fontSize = 16,
  });

  final String data;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final text = context.stoicText;
    final colors = context.colorScheme;
    const height = 1.65;

    return MarkdownBody(
      data: data,
      selectable: true,
      styleSheet: MarkdownStyleSheet(
        p: text.body.copyWith(
          height: height,
          fontSize: fontSize,
          color: colors.onSurface.withValues(alpha: 0.92),
        ),
        h1: text.sheetTitle.copyWith(
          fontFamily: StoicTheme.fontSerif,
          fontSize: fontSize + 4,
          height: 1.3,
        ),
        h2: text.tileTitle.copyWith(
          fontFamily: StoicTheme.fontSerif,
          fontSize: fontSize + 2,
          height: 1.3,
        ),
        h3: text.tileTitle.copyWith(
          fontFamily: StoicTheme.fontSerif,
          fontSize: fontSize + 1,
        ),
        em: text.body.copyWith(
          fontStyle: FontStyle.italic,
          fontSize: fontSize,
          height: height,
        ),
        strong: text.body.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: fontSize,
          height: height,
        ),
        listBullet: text.body.copyWith(fontSize: fontSize, height: height),
        blockquote: text.quote.copyWith(
          fontSize: fontSize,
          height: height,
          color: colors.onSurface.withValues(alpha: 0.75),
        ),
        blockquoteDecoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: colors.primary.withValues(alpha: 0.5),
              width: 2,
            ),
          ),
        ),
        code: text.captionAccent.copyWith(
          fontSize: fontSize - 1,
          fontFamily: 'monospace',
        ),
        horizontalRuleDecoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: colors.outline.withValues(alpha: 0.25),
            ),
          ),
        ),
      ),
    );
  }
}
