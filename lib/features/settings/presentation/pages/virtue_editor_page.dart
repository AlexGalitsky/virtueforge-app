import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:virtue_forge/core/l10n/app_localizations_x.dart';
import 'package:virtue_forge/core/theme/stoic_theme_build_context_extension.dart';
import 'package:virtue_forge/core/theme/widgets/widgets.dart';
import 'package:virtue_forge/features/journal/domain/entities/franklin_virtue.dart';
import 'package:virtue_forge/features/settings/presentation/bloc/virtue_editor_bloc.dart';
import 'package:virtue_forge/features/settings/presentation/forms/virtue_edit_form.dart';

class VirtueEditorPage extends StatelessWidget {
  const VirtueEditorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<VirtueEditorBloc, VirtueEditorState>(
      listenWhen: (previous, current) {
        final prevErr =
            previous is VirtueEditorLoaded ? previous.actionError : null;
        final currErr =
            current is VirtueEditorLoaded ? current.actionError : null;
        return currErr != null && currErr != prevErr;
      },
      listener: (context, state) {
        if (state is! VirtueEditorLoaded || state.actionError == null) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.actionError!)),
        );
        context
            .read<VirtueEditorBloc>()
            .add(const VirtueEditorEvent.actionErrorCleared());
      },
      child: const _VirtueEditorView(),
    );
  }
}

class _VirtueEditorView extends StatelessWidget {
  const _VirtueEditorView();

  @override
  Widget build(BuildContext context) {
    final text = context.stoicText;
    final l10n = context.l10n;

    return StoicPageScaffold(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(l10n.editorTitle, style: text.pageTitle),
        ),
        body: BlocBuilder<VirtueEditorBloc, VirtueEditorState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              failure: (message) => Center(child: Text(message, style: text.body)),
              loaded: (virtues, actionError) => ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: virtues.length,
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final virtue = virtues[index];
                  final title = l10n.virtueGridLabel(
                    virtue.defaultWeekNumber,
                    l10n.resolveCatalogKey(virtue.name),
                  );
                  final subtitle = virtue.customDescription?.isNotEmpty == true
                      ? virtue.customDescription!
                      : l10n.resolveCatalogKey(virtue.description);
                  return StoicSettingsTile(
                    icon: Icons.edit_note,
                    title: title,
                    subtitle: subtitle,
                    onTap: () => _openEditSheet(context, virtue),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _openEditSheet(BuildContext context, FranklinVirtue virtue) {
    final l10n = context.l10n;
    final initial = virtue.customDescription?.isNotEmpty == true
        ? virtue.customDescription
        : l10n.resolveCatalogKey(virtue.description);

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor:
          Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return BlocProvider.value(
          value: context.read<VirtueEditorBloc>(),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
              left: 20,
              right: 20,
              top: 24,
            ),
            child: ReactiveFormBuilder(
              form: () => VirtueEditForm.build(initial: initial),
              builder: (context, form, child) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.virtueGridLabel(
                        virtue.defaultWeekNumber,
                        l10n.resolveCatalogKey(virtue.name),
                      ),
                      style: context.stoicText.sheetTitle,
                    ),
                    const SizedBox(height: 16),
                    StoicReactiveTextField(
                      control: VirtueEditForm.descriptionControl(form),
                      label: l10n.editorSubtitle,
                      maxLines: 4,
                    ),
                    const SizedBox(height: 24),
                    ReactiveFormConsumer(
                      builder: (context, form, child) {
                        return StoicPrimaryButton(
                          label: l10n.saveChanges,
                          onPressed: form.valid
                              ? () {
                                  context.read<VirtueEditorBloc>().add(
                                        VirtueEditorEvent.descriptionSaved(
                                          virtueId: virtue.id,
                                          customDescription:
                                              VirtueEditForm.valueOf(form),
                                        ),
                                      );
                                  Navigator.pop(context);
                                }
                              : null,
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
