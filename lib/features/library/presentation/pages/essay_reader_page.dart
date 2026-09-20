import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:virtue_forge/core/di/injection_container.dart';
import 'package:virtue_forge/core/l10n/app_localizations_x.dart';
import 'package:virtue_forge/core/theme/stoic_theme.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';
import 'package:virtue_forge/core/theme/widgets/widgets.dart';
import 'package:virtue_forge/features/library/data/essay_reader_preferences.dart';
import 'package:virtue_forge/features/library/domain/models/essay.dart';
import 'package:virtue_forge/features/library/domain/usecases/load_essay_analysis_use_case.dart';
import 'package:virtue_forge/features/library/domain/usecases/load_essay_body_use_case.dart';

enum _ReaderLayer { text, comment }

class _TocEntry {
  const _TocEntry({
    required this.title,
    required this.level,
    required this.key,
  });

  final String title;
  final int level;
  final GlobalKey key;
}

class _MdSection {
  _MdSection({
    required this.heading,
    required this.level,
    required this.body,
    required this.key,
  });

  final String? heading;
  final int level;
  final String body;
  final GlobalKey key;
}

/// Fullscreen stoic reader for a Portico essay.
class EssayReaderPage extends StatefulWidget {
  const EssayReaderPage({
    super.key,
    required this.essay,
    required this.weekEssays,
    required this.prefs,
    required this.loadBody,
    required this.loadAnalysis,
    this.focusWeekNumber,
  });

  final Essay essay;
  final List<Essay> weekEssays;
  final EssayReaderPreferences prefs;
  final LoadEssayBodyUseCase loadBody;
  final LoadEssayAnalysisUseCase loadAnalysis;
  final int? focusWeekNumber;

  static Future<void> open(
    BuildContext context, {
    required Essay essay,
    List<Essay> weekEssays = const [],
    int? focusWeekNumber,
  }) {
    final siblings = weekEssays.isEmpty ? [essay] : weekEssays;
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => EssayReaderPage(
          essay: essay,
          weekEssays: siblings,
          focusWeekNumber: focusWeekNumber,
          prefs: sl<EssayReaderPreferences>(),
          loadBody: sl<LoadEssayBodyUseCase>(),
          loadAnalysis: sl<LoadEssayAnalysisUseCase>(),
        ),
      ),
    );
  }

  @override
  State<EssayReaderPage> createState() => _EssayReaderPageState();
}

class _EssayReaderPageState extends State<EssayReaderPage> {
  EssayReaderPreferences get _prefs => widget.prefs;
  final _scrollController = ScrollController();

  late Essay _essay;
  late double _fontScale;
  late bool _verseMode;

  _ReaderLayer _layer = _ReaderLayer.text;
  bool _chromeVisible = true;
  double _progress = 0;
  bool _resumeApplied = false;
  double _lastScrollPixels = 0;

  Future<String>? _bodyFuture;
  Future<String>? _analysisFuture;
  List<_MdSection> _sections = const [];
  List<_TocEntry> _toc = const [];

  @override
  void initState() {
    super.initState();
    _essay = widget.essay;
    _fontScale = _prefs.fontScale;
    _verseMode = _prefs.verseMode;
    _scrollController.addListener(_onScroll);
    WakelockPlus.enable();
    _loadBody();
  }

  @override
  void dispose() {
    _persistProgress();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    WakelockPlus.disable();
    super.dispose();
  }

  void _loadBody() {
    _resumeApplied = false;
    _sections = const [];
    _toc = const [];
    final id = _essay.id;
    _bodyFuture = widget.loadBody(id).then((md) {
      if (mounted && _essay.id == id) {
        setState(() => _parseBody(md));
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _applyResumeIfNeeded();
        });
      }
      return md;
    });
    _analysisFuture = _essay.hasAnalysis
        ? widget.loadAnalysis(id)
        : null;
    _layer = _ReaderLayer.text;
    _progress = _prefs.progressFor(id) ?? 0;
  }

  void _switchEssay(Essay next) {
    if (next.id == _essay.id) return;
    _persistProgress();
    setState(() {
      _essay = next;
      _loadBody();
    });
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }
  }

  int get _indexInWeek {
    final i = widget.weekEssays.indexWhere((e) => e.id == _essay.id);
    return i < 0 ? 0 : i;
  }

  Essay? get _prevEssay {
    final i = _indexInWeek;
    if (i <= 0 || widget.weekEssays.length < 2) return null;
    return widget.weekEssays[i - 1];
  }

  Essay? get _nextEssay {
    final i = _indexInWeek;
    if (i < 0 || i >= widget.weekEssays.length - 1) return null;
    return widget.weekEssays[i + 1];
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final pos = _scrollController.position;
    final max = pos.maxScrollExtent;
    final pixels = pos.pixels;
    final nextProgress = max <= 0 ? 0.0 : (pixels / max).clamp(0.0, 1.0);

    final delta = pixels - _lastScrollPixels;
    _lastScrollPixels = pixels;

    var chrome = _chromeVisible;
    if (delta > 6 && pixels > 48) {
      chrome = false;
    } else if (delta < -6) {
      chrome = true;
    }

    if ((nextProgress - _progress).abs() > 0.01 || chrome != _chromeVisible) {
      setState(() {
        _progress = nextProgress;
        _chromeVisible = chrome;
      });
    }
  }

  void _persistProgress() {
    _prefs.saveProgress(_essay.id, _progress);
  }

  void _applyResumeIfNeeded() {
    if (_resumeApplied || !_scrollController.hasClients) return;
    final saved = _prefs.progressFor(_essay.id);
    if (saved == null || saved < 0.05 || saved > 0.95) {
      _resumeApplied = true;
      return;
    }
    final max = _scrollController.position.maxScrollExtent;
    if (max <= 0) return;
    _resumeApplied = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.jumpTo(
        (saved * _scrollController.position.maxScrollExtent).clamp(
          0.0,
          _scrollController.position.maxScrollExtent,
        ),
      );
    });
  }

  Future<void> _bumpFont(double delta) async {
    final next = (_fontScale + delta).clamp(
      EssayReaderPreferences.minFontScale,
      EssayReaderPreferences.maxFontScale,
    );
    await _prefs.setFontScale(next);
    setState(() => _fontScale = next);
  }

  Future<void> _toggleVerseMode() async {
    final next = !_verseMode;
    await _prefs.setVerseMode(next);
    setState(() => _verseMode = next);
  }

  void _parseBody(String markdown) {
    _sections = _splitMarkdownSections(markdown);
    _toc = [
      for (final s in _sections)
        if (s.heading != null)
          _TocEntry(title: s.heading!, level: s.level, key: s.key),
    ];
  }

  Future<void> _showToc() async {
    if (_toc.isEmpty) return;
    final selected = await showModalBottomSheet<_TocEntry>(
      context: context,
      showDragHandle: true,
      builder: (ctx) {
        final l10n = ctx.l10n;
        final text = ctx.stoicText;
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
                child: Text(l10n.essayReaderContents, style: text.sheetTitle),
              ),
              for (final entry in _toc)
                ListTile(
                  contentPadding: EdgeInsets.only(
                    left: 16.0 + (entry.level - 2).clamp(0, 2) * 16.0,
                    right: 16,
                  ),
                  title: Text(entry.title, style: text.body),
                  onTap: () => Navigator.pop(ctx, entry),
                ),
            ],
          ),
        );
      },
    );
    if (selected == null || !mounted) return;
    final target = selected.key.currentContext;
    if (target != null && target.mounted) {
      await Scrollable.ensureVisible(
        target,
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
        alignment: 0.08,
      );
    }
  }

  String _displayMarkdown(String raw) {
    if (!_verseMode) return raw;
    // Keep blank lines; promote single newlines to stanza breaks.
    return raw.replaceAllMapped(
      RegExp(r'(?<!\n)\n(?!\n)'),
      (_) => '\n\n',
    );
  }

  Color _parchmentTop(bool isDark) =>
      isDark ? const Color(0xFF1A1814) : const Color(0xFFF7F1E6);

  Color _parchmentBottom(bool isDark) =>
      isDark ? const Color(0xFF12100E) : const Color(0xFFEFE6D8);

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final l10n = context.l10n;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasComment = _essay.hasAnalysis;

    return StoicPageScaffold(
      child: Scaffold(
        backgroundColor: _parchmentBottom(isDark),
        body: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [_parchmentTop(isDark), _parchmentBottom(isDark)],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                AnimatedSize(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  child: _chromeVisible
                      ? _ReaderChrome(
                          title: _essay.sourceWork ?? l10n.porticoTitle,
                          hasComment: hasComment,
                          layer: _layer,
                          canShowToc: _layer == _ReaderLayer.text &&
                              _toc.isNotEmpty,
                          onBack: () => Navigator.of(context).maybePop(),
                          onLayerChanged: (layer) {
                            setState(() => _layer = layer);
                          },
                          onToc: _showToc,
                          onFontDown: () => _bumpFont(-0.08),
                          onFontUp: () => _bumpFont(0.08),
                          verseMode: _verseMode,
                          onToggleVerse: _toggleVerseMode,
                        )
                      : const SizedBox(width: double.infinity),
                ),
                LinearProgressIndicator(
                  value: _layer == _ReaderLayer.text ? _progress : null,
                  minHeight: 2,
                  backgroundColor: colors.outline.withValues(alpha: 0.15),
                  color: colors.primary.withValues(alpha: 0.7),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () =>
                        setState(() => _chromeVisible = !_chromeVisible),
                    onHorizontalDragEnd: (details) {
                      final v = details.primaryVelocity ?? 0;
                      if (v < -400) {
                        final next = _nextEssay;
                        if (next != null) _switchEssay(next);
                      } else if (v > 400) {
                        final prev = _prevEssay;
                        if (prev != null) _switchEssay(prev);
                      }
                    },
                    child: _layer == _ReaderLayer.text
                        ? _buildTextLayer(context)
                        : _buildCommentLayer(context),
                  ),
                ),
                AnimatedSlide(
                  duration: const Duration(milliseconds: 220),
                  offset: _chromeVisible ? Offset.zero : const Offset(0, 1),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 180),
                    opacity: _chromeVisible ? 1 : 0,
                    child: _ReaderNavBar(
                      prev: _prevEssay,
                      next: _nextEssay,
                      onPrev: _prevEssay == null
                          ? null
                          : () => _switchEssay(_prevEssay!),
                      onNext: _nextEssay == null
                          ? null
                          : () => _switchEssay(_nextEssay!),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextLayer(BuildContext context) {
    final l10n = context.l10n;
    final text = context.stoicText;

    return FutureBuilder<String>(
      future: _bodyFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || snapshot.data == null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                snapshot.error?.toString() ?? l10n.essayLoadFailed,
                style: text.body,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        if (_sections.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return SelectionArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxW = (constraints.maxWidth * 0.92)
                  .clamp(0.0, 42 * 17.0 * _fontScale);
              return Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxW),
                  child: ListView(
                    controller: _scrollController,
                    padding: const EdgeInsets.fromLTRB(22, 16, 22, 48),
                    children: [
                      Text(
                        _essay.title,
                        style: text.pageTitle.copyWith(
                          fontFamily: StoicTheme.fontSerif,
                          fontSize: 28 * _fontScale,
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        context.l10n.resolveCatalogKey(_essay.authorKey),
                        style: text.captionAccent.copyWith(
                          fontSize: 13 * _fontScale,
                        ),
                      ),
                      const SizedBox(height: 20),
                      for (final section in _sections) ...[
                        if (section.heading != null)
                          Padding(
                            key: section.key,
                            padding: const EdgeInsets.only(bottom: 10, top: 8),
                            child: Text(
                              section.heading!,
                              style: (section.level <= 2
                                      ? text.sheetTitle
                                      : text.tileTitle)
                                  .copyWith(
                                fontFamily: StoicTheme.fontSerif,
                                fontSize:
                                    (section.level <= 2 ? 22.0 : 18.0) *
                                        _fontScale,
                                height: 1.35,
                              ),
                            ),
                          )
                        else
                          SizedBox(key: section.key, height: 0),
                        MarkdownBody(
                          data: _displayMarkdown(section.body),
                          selectable: false,
                          styleSheet: _styleSheet(context),
                        ),
                        const SizedBox(height: 12),
                      ],
                      const SizedBox(height: 28),
                      _FocusCta(
                        virtueLabel: context.l10n.franklinVirtueName(
                          widget.focusWeekNumber ?? _essay.virtueWeekNumber,
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildCommentLayer(BuildContext context) {
    final l10n = context.l10n;
    final text = context.stoicText;
    final future = _analysisFuture;

    if (future == null) {
      return Center(
        child: Text(l10n.essayAnalysisLoadFailed, style: text.body),
      );
    }

    return FutureBuilder<String>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError || snapshot.data == null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                l10n.essayAnalysisLoadFailed,
                style: text.body,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        return SelectionArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxW = (constraints.maxWidth * 0.92)
                  .clamp(0.0, 42 * 17.0 * _fontScale);
              return Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxW),
                  child: Markdown(
                    data: snapshot.data!,
                    selectable: false,
                    padding: const EdgeInsets.fromLTRB(22, 16, 22, 40),
                    styleSheet: _styleSheet(context),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  MarkdownStyleSheet _styleSheet(BuildContext context) {
    final text = context.stoicText;
    final colors = context.colorScheme;
    final baseSize = (_verseMode ? 16.5 : 17.0) * _fontScale;
    final height = _verseMode ? 1.95 : 1.75;

    return MarkdownStyleSheet(
      p: text.body.copyWith(
        height: height,
        fontSize: baseSize,
        letterSpacing: _verseMode ? 0.2 : 0,
        color: colors.onSurface.withValues(alpha: 0.92),
      ),
      h1: text.pageTitle.copyWith(
        fontFamily: StoicTheme.fontSerif,
        fontSize: 26 * _fontScale,
        height: 1.3,
        color: colors.onSurface,
      ),
      h2: text.sheetTitle.copyWith(
        fontFamily: StoicTheme.fontSerif,
        fontSize: 22 * _fontScale,
        height: 1.3,
        color: colors.onSurface,
      ),
      h3: text.tileTitle.copyWith(
        fontFamily: StoicTheme.fontSerif,
        fontSize: 18 * _fontScale,
        color: colors.onSurface,
      ),
      em: text.body.copyWith(
        fontStyle: FontStyle.italic,
        fontSize: baseSize,
        height: height,
      ),
      strong: text.body.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: baseSize,
        height: height,
      ),
      listBullet: text.body.copyWith(fontSize: baseSize, height: height),
      blockquote: text.quote.copyWith(
        fontSize: baseSize,
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
      horizontalRuleDecoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: colors.outline.withValues(alpha: 0.25),
          ),
        ),
      ),
    );
  }
}

class _ReaderChrome extends StatelessWidget {
  const _ReaderChrome({
    required this.title,
    required this.hasComment,
    required this.layer,
    required this.canShowToc,
    required this.onBack,
    required this.onLayerChanged,
    required this.onToc,
    required this.onFontDown,
    required this.onFontUp,
    required this.verseMode,
    required this.onToggleVerse,
  });

  final String title;
  final bool hasComment;
  final _ReaderLayer layer;
  final bool canShowToc;
  final VoidCallback onBack;
  final ValueChanged<_ReaderLayer> onLayerChanged;
  final VoidCallback onToc;
  final VoidCallback onFontDown;
  final VoidCallback onFontUp;
  final bool verseMode;
  final VoidCallback onToggleVerse;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final text = context.stoicText;
    final l10n = context.l10n;

    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 0, 4, 4),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: onBack,
                  icon: Icon(Icons.arrow_back, color: colors.onSurface),
                ),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: text.captionAccent,
                  ),
                ),
                IconButton(
                  tooltip: l10n.essayReaderFontDecrease,
                  onPressed: onFontDown,
                  icon: Text(
                    'A−',
                    style: text.captionAccent.copyWith(fontSize: 14),
                  ),
                ),
                IconButton(
                  tooltip: l10n.essayReaderFontIncrease,
                  onPressed: onFontUp,
                  icon: Text(
                    'A+',
                    style: text.captionAccent.copyWith(fontSize: 16),
                  ),
                ),
                if (canShowToc)
                  IconButton(
                    tooltip: l10n.essayReaderContents,
                    onPressed: onToc,
                    icon: Icon(Icons.list_alt_outlined, color: colors.onSurface),
                  ),
                PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert, color: colors.onSurface),
                  onSelected: (value) {
                    if (value == 'verse') onToggleVerse();
                  },
                  itemBuilder: (context) => [
                    CheckedPopupMenuItem<String>(
                      value: 'verse',
                      checked: verseMode,
                      child: Text(l10n.essayReaderVerseMode),
                    ),
                  ],
                ),
              ],
            ),
            if (hasComment)
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                child: SegmentedButton<_ReaderLayer>(
                  segments: [
                    ButtonSegment(
                      value: _ReaderLayer.text,
                      label: Text(l10n.essayReaderTextTab),
                    ),
                    ButtonSegment(
                      value: _ReaderLayer.comment,
                      label: Text(l10n.essayReaderCommentTab),
                    ),
                  ],
                  selected: {layer},
                  onSelectionChanged: (set) {
                    if (set.isNotEmpty) onLayerChanged(set.first);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ReaderNavBar extends StatelessWidget {
  const _ReaderNavBar({
    required this.prev,
    required this.next,
    required this.onPrev,
    required this.onNext,
  });

  final Essay? prev;
  final Essay? next;
  final VoidCallback? onPrev;
  final VoidCallback? onNext;

  @override
  Widget build(BuildContext context) {
    if (prev == null && next == null) {
      return const SizedBox.shrink();
    }
    final colors = context.colorScheme;
    final text = context.stoicText;
    final l10n = context.l10n;

    return Material(
      color: colors.surface.withValues(alpha: 0.72),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  onPressed: onPrev,
                  icon: const Icon(Icons.chevron_left),
                  label: Text(
                    prev?.title ?? l10n.essayReaderPrev,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: text.captionAccent,
                  ),
                ),
              ),
              Expanded(
                child: TextButton.icon(
                  onPressed: onNext,
                  iconAlignment: IconAlignment.end,
                  icon: const Icon(Icons.chevron_right),
                  label: Text(
                    next?.title ?? l10n.essayReaderNext,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                    style: text.captionAccent,
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

class _FocusCta extends StatelessWidget {
  const _FocusCta({required this.virtueLabel});

  final String virtueLabel;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final text = context.stoicText;
    final l10n = context.l10n;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: colors.outline.withValues(alpha: 0.3)),
        ),
      ),
      child: Text(
        l10n.essayReaderFocusHint(virtueLabel),
        style: text.body.copyWith(
          height: 1.55,
          color: colors.onSurface.withValues(alpha: 0.72),
          fontSize: 14,
        ),
      ),
    );
  }
}

List<_MdSection> _splitMarkdownSections(String markdown) {
  final lines = markdown.replaceAll('\r\n', '\n').split('\n');
  final sections = <_MdSection>[];
  String? heading;
  var level = 2;
  final buf = StringBuffer();

  void flush() {
    final body = buf.toString().trimRight();
    if (heading == null && body.trim().isEmpty) {
      buf.clear();
      return;
    }
    sections.add(
      _MdSection(
        heading: heading,
        level: level,
        body: body.trim().isEmpty ? ' ' : body,
        key: GlobalKey(),
      ),
    );
    buf.clear();
  }

  final headingRe = RegExp(r'^(#{2,3})\s+(.+?)\s*$');
  for (final line in lines) {
    final match = headingRe.firstMatch(line);
    if (match != null) {
      flush();
      heading = match.group(2)!.trim();
      level = match.group(1)!.length;
      continue;
    }
    buf.writeln(line);
  }
  flush();

  if (sections.isEmpty) {
    sections.add(
      _MdSection(heading: null, level: 2, body: markdown, key: GlobalKey()),
    );
  }
  return sections;
}
