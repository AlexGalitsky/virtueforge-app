import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtue_forge/core/l10n/app_localizations_x.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';
import 'package:virtue_forge/core/theme/widgets/widgets.dart';
import 'package:virtue_forge/features/settings/domain/models/app_settings.dart';
import 'package:virtue_forge/features/settings/presentation/cubit/settings_cubit.dart';

/// Order sub-page: explain Memento Mori and save the user's birth date.
class BirthDatePage extends StatefulWidget {
  const BirthDatePage({super.key});

  @override
  State<BirthDatePage> createState() => _BirthDatePageState();
}

class _BirthDatePageState extends State<BirthDatePage> {
  DateTime? _draft;
  var _draftInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_draftInitialized) return;
    _draftInitialized = true;
    _draft = context.read<SettingsCubit>().state.birthDate;
  }

  @override
  Widget build(BuildContext context) {
    final text = context.stoicText;
    final l10n = context.l10n;
    final colors = context.colorScheme;

    return StoicPageScaffold(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(l10n.birthDatePageTitle, style: text.pageTitle),
        ),
        body: BlocBuilder<SettingsCubit, AppSettings>(
          buildWhen: (previous, current) =>
              previous.birthDate != current.birthDate,
          builder: (context, settings) {
            final display = _draft ?? settings.birthDate;
            return ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
              children: [
                Text(l10n.birthDateLead, style: text.sheetTitle),
                const SizedBox(height: 12),
                Text(
                  l10n.birthDateDescription,
                  style: text.body.copyWith(
                    color: colors.onSurface.withValues(alpha: 0.75),
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 28),
                Text(l10n.birthDatePickLabel, style: text.eyebrowAccent),
                const SizedBox(height: 10),
                Material(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(14),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () => _pickDate(context, display),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 18,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.cake_outlined,
                            color: colors.primary,
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              display == null
                                  ? l10n.birthDatePickHint
                                  : _formatDate(display),
                              style: text.tileTitle.copyWith(
                                color: display == null
                                    ? colors.onSurface.withValues(alpha: 0.45)
                                    : colors.onSurface,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.calendar_month_outlined,
                            color: colors.onSurface.withValues(alpha: 0.45),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                StoicPrimaryButton(
                  label: l10n.birthDateSave,
                  onPressed: display == null
                      ? null
                      : () async {
                          await context
                              .read<SettingsCubit>()
                              .setBirthDate(display);
                          if (!context.mounted) return;
                          Navigator.of(context).pop();
                        },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _pickDate(BuildContext context, DateTime? current) async {
    final now = DateTime.now();
    final initial = current ?? DateTime(now.year - 30, now.month, now.day);
    final picked = await showDatePicker(
      context: context,
      initialDate: initial.isAfter(now) ? now : initial,
      firstDate: DateTime(1900),
      lastDate: now,
      helpText: context.l10n.birthDatePickLabel,
    );
    if (picked == null || !mounted) return;
    setState(() => _draft = DateTime(picked.year, picked.month, picked.day));
  }

  String _formatDate(DateTime date) {
    final d = date.day.toString().padLeft(2, '0');
    final m = date.month.toString().padLeft(2, '0');
    return '$d.$m.${date.year}';
  }
}
