import 'package:flutter/material.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';

/// Карточка цитаты дня с иконкой кавычек и Serif-шрифтом.
///
/// Длинный текст по умолчанию обрезан фиксированной высотой; тап раскрывает.
class QuoteCard extends StatefulWidget {
  final String quote;
  final String author;

  /// Высота области текста в свёрнутом виде.
  final double collapsedQuoteHeight;

  const QuoteCard({
    super.key,
    required this.quote,
    required this.author,
    this.collapsedQuoteHeight = 72,
  });

  @override
  State<QuoteCard> createState() => _QuoteCardState();
}

class _QuoteCardState extends State<QuoteCard> {
  var _expanded = false;

  @override
  void didUpdateWidget(covariant QuoteCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.quote != widget.quote) {
      _expanded = false;
    }
  }

  void _toggle() => setState(() => _expanded = !_expanded);

  @override
  Widget build(BuildContext context) {
    final primary = context.colorScheme.primary;
    final surface = context.colorScheme.surface;
    final onSurface = context.colorScheme.onSurface;
    final focus = context.stoicColors.focusHighlight ?? surface;
    final text = context.stoicText;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _toggle,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [focus, surface],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: primary.withValues(alpha: 0.25),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.format_quote, color: primary, size: 28),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.author.toUpperCase(),
                      style: text.eyebrow,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    _expanded
                        ? Icons.expand_less_rounded
                        : Icons.expand_more_rounded,
                    size: 20,
                    color: onSurface.withValues(alpha: 0.45),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              AnimatedSize(
                duration: const Duration(milliseconds: 280),
                curve: Curves.easeInOutCubic,
                alignment: Alignment.topCenter,
                child: _expanded
                    ? Text(widget.quote, style: text.quote)
                    : ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: widget.collapsedQuoteHeight,
                        ),
                        child: ShaderMask(
                          shaderCallback: (bounds) {
                            return const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.black, Colors.transparent],
                              stops: [
                                0.6,
                                1.0,
                              ], // Текст начинает плавно исчезать после 60% высоты
                            ).createShader(bounds);
                          },
                          blendMode: BlendMode.dstIn,
                          // Оставляет только те части текста, где маска непрозрачна
                          child: Text(
                            widget.quote,
                            style: text.quote,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
