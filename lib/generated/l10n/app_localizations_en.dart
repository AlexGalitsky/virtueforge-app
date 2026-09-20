// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'VirtueForge';

  @override
  String get navJournal => 'Journal';

  @override
  String get navTemple => 'Temple';

  @override
  String get navPortico => 'Portico';

  @override
  String get navOrder => 'Order';

  @override
  String get dayMon => 'Mon';

  @override
  String get dayTue => 'Tue';

  @override
  String get dayWed => 'Wed';

  @override
  String get dayThu => 'Thu';

  @override
  String get dayFri => 'Fri';

  @override
  String get daySat => 'Sat';

  @override
  String get daySun => 'Sun';

  @override
  String levelBadge(int level) {
    return 'Lv $level';
  }

  @override
  String get journalGridTitle => 'Fault Journal';

  @override
  String get weekPrev => 'Previous week';

  @override
  String get weekNext => 'Next week';

  @override
  String get weekNavCurrent => 'This week';

  @override
  String weekNavPast(String date) {
    return 'Week of $date';
  }

  @override
  String strikeNoteTitle(String virtue, String day) {
    return '$virtue · $day';
  }

  @override
  String get strikeNotePrompt =>
      'What does this slip reveal about your character?';

  @override
  String get strikeNoteHint => 'Write freely — this is for you alone.';

  @override
  String get strikeNoteSave => 'Save reflection';

  @override
  String get dayStrikeReflectionTitle => 'Day reflection';

  @override
  String get dayStrikeReflectionSubtitle =>
      'Each mark is a separate slip. Add a note when you have time to understand it — not when you are rushing.';

  @override
  String dayStrikeCountLabel(int count) {
    return '$count slips';
  }

  @override
  String dayStrikeItemTitle(int number) {
    return 'Slip $number';
  }

  @override
  String get dayStrikeNotePlaceholder => 'Tap to add a note';

  @override
  String get dayStrikeNoteDelete => 'Delete note';

  @override
  String get dayStrikeAdd => 'Add slip';

  @override
  String get dayStrikeRemove => 'Remove last slip';

  @override
  String get dayStrikeEmptyEditable =>
      'No slips yet. Add one here, or tap today’s column on the grid.';

  @override
  String get dayStrikeEmptyReadonly => 'No slips on this day.';

  @override
  String get gridSwipeNotes => 'Notes';

  @override
  String get gridSwipeInfo => 'Info';

  @override
  String get gridTipTodayOnly => 'Only today’s column can be edited quickly';

  @override
  String get gridTipLongPress => 'Hold a mark to undo an accidental tap';

  @override
  String get gridTipDoubleTap => 'Double-tap a cell to reflect on each slip';

  @override
  String get gridTipSwipe => 'Swipe a virtue left for notes or its description';

  @override
  String get eveningReflection => 'Stoic evening reflection';

  @override
  String get dichotomyControl => 'Dichotomy of control';

  @override
  String get reflectionUncontrolledLabel =>
      'What happened today that was outside my control?';

  @override
  String get reflectionUncontrolledHint =>
      'Other people’s actions, weather, traffic… (Accept as given)';

  @override
  String get reflectionControlledLabel =>
      'How did I handle what was in my power?';

  @override
  String get reflectionControlledHint =>
      'My reactions, decisions, focus on the virtue of the week…';

  @override
  String get finishDay => 'Complete the day';

  @override
  String get reflectionTodayContextTitle => 'Today’s slips';

  @override
  String get reflectionTodayEmpty =>
      'No slips marked today — still a good moment to reflect.';

  @override
  String reflectionVirtueStrikeHeader(String virtue, int count) {
    return '$virtue · $count';
  }

  @override
  String reflectionStrikeLine(int ordinal, String detail) {
    return '$ordinal. $detail';
  }

  @override
  String get reflectionStrikeNoNote => 'no note';

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get quoteMarcusAuthor => 'Marcus Aurelius';

  @override
  String get quoteMarcusBody =>
      '“Waste no more time arguing about what a good man should be. Be one.”';

  @override
  String get onboardingSlide1Title => 'Two systems. One character.';

  @override
  String get onboardingSlide1Body =>
      'We combined Stoic philosophy with Benjamin Franklin’s practical method of self-control. This is a tool for forging your character.';

  @override
  String get onboardingSlide2Title => 'Franklin’s 13 Virtues';

  @override
  String get onboardingSlide2Body =>
      'Each week you focus strictly on one quality of character. In the evening you honestly mark your faults as dots on the grid.';

  @override
  String get onboardingSlide3Title => 'Four Stoic Pillars';

  @override
  String get onboardingSlide3Body =>
      'Your daily discipline feeds the four pillars of the spirit: Wisdom, Courage, Justice, and Temperance. Do not let them crack.';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingForge => 'Forge Character';

  @override
  String get skip => 'Skip';

  @override
  String get templeTitle => 'Temple of Virtues';

  @override
  String get characterStatus => 'CHARACTER STATUS';

  @override
  String get steadfastProgress => 'Steadfast Progress';

  @override
  String currentCycle(int current, int total) {
    return 'Current cycle: $current of $total this year';
  }

  @override
  String get stoicPillarsSection => 'STOIC PILLARS';

  @override
  String get pillarIntegrityMonolith => 'Monolith';

  @override
  String get pillarIntegrityCracked => 'Cracked';

  @override
  String get pillarIntegrityShattered => 'Shattered';

  @override
  String pillarLevelLabel(int level) {
    return 'Level $level';
  }

  @override
  String pillarXpLabel(int current, int next) {
    return '$current / $next XP';
  }

  @override
  String get pillarMottoTemperance => 'Metron Ariston';

  @override
  String get pillarMottoWisdom => 'Know Thyself';

  @override
  String get pillarMottoCourage => 'Amor Fati';

  @override
  String get pillarMottoJustice => 'Suum Cuique';

  @override
  String get stoicTemperance => 'Temperance';

  @override
  String get stoicTemperanceDesc =>
      'Mastery of desires, self-control, and balance.';

  @override
  String get stoicWisdom => 'Wisdom';

  @override
  String get stoicWisdomDesc =>
      'Knowing what is good, evil, and indifferent — and choosing rightly.';

  @override
  String get stoicCourage => 'Courage';

  @override
  String get stoicCourageDesc =>
      'Endurance and fidelity to principles in the face of hardship.';

  @override
  String get stoicJustice => 'Justice';

  @override
  String get stoicJusticeDesc =>
      'Honesty and duty toward others and the world.';

  @override
  String get virtueAbstinence => 'Temperance';

  @override
  String get virtueAbstinenceDesc =>
      'Eat not to dullness; drink not to elevation.';

  @override
  String get virtueSilence => 'Silence';

  @override
  String get virtueSilenceDesc =>
      'Speak not but what may benefit others or yourself; avoid trifling conversation.';

  @override
  String get virtueOrder => 'Order';

  @override
  String get virtueOrderDesc =>
      'Let all your things have their places; let each part of your business have its time.';

  @override
  String get virtueResolution => 'Resolution';

  @override
  String get virtueResolutionDesc =>
      'Resolve to perform what you ought; perform without fail what you resolve.';

  @override
  String get virtueFrugality => 'Frugality';

  @override
  String get virtueFrugalityDesc =>
      'Make no expense but to do good to others or yourself; waste nothing.';

  @override
  String get virtueIndustry => 'Industry';

  @override
  String get virtueIndustryDesc =>
      'Lose no time; be always employed in something useful; cut off all unnecessary actions.';

  @override
  String get virtueSincerity => 'Sincerity';

  @override
  String get virtueSincerityDesc =>
      'Use no hurtful deceit; think innocently and justly, and, if you speak, speak accordingly.';

  @override
  String get virtueJustice => 'Justice';

  @override
  String get virtueJusticeDesc =>
      'Wrong none by doing injuries, or omitting the benefits that are your duty.';

  @override
  String get virtueModeration => 'Moderation';

  @override
  String get virtueModerationDesc =>
      'Avoid extremes; forbear resenting injuries so much as you think they deserve.';

  @override
  String get virtueCleanliness => 'Cleanliness';

  @override
  String get virtueCleanlinessDesc =>
      'Tolerate no uncleanliness in body, clothes, or habitation.';

  @override
  String get virtueTranquility => 'Tranquility';

  @override
  String get virtueTranquilityDesc =>
      'Be not disturbed at trifles, or at accidents common or unavoidable.';

  @override
  String get virtueChastity => 'Chastity';

  @override
  String get virtueChastityDesc =>
      'Rarely use venery but for health or offspring; never to dullness, weakness, or the injury of your own or another’s peace or reputation.';

  @override
  String get virtueHumility => 'Humility';

  @override
  String get virtueHumilityDesc => 'Imitate Jesus and Socrates.';

  @override
  String virtueGridLabel(int number, String name) {
    return '$number. $name';
  }

  @override
  String get porticoTitle => 'Portico of Wisdom';

  @override
  String get forThisWeek => 'SUITED FOR THIS WEEK';

  @override
  String get randomThought => 'RANDOM THOUGHT';

  @override
  String get porticoEmptyWeek => 'No essays tagged for this week yet.';

  @override
  String get essayLoadFailed =>
      'Could not load the text. Check the connection and try again.';

  @override
  String get essayAnalysisLoadFailed => 'Could not load the commentary.';

  @override
  String get readFully => 'Read fully →';

  @override
  String get continueReading => 'Continue →';

  @override
  String get essayReaderTextTab => 'Text';

  @override
  String get essayReaderCommentTab => 'Comment';

  @override
  String get essayReaderHasComment => 'Has commentary';

  @override
  String get essayReaderContents => 'Contents';

  @override
  String get essayReaderFontDecrease => 'Smaller';

  @override
  String get essayReaderFontIncrease => 'Larger';

  @override
  String get essayReaderVerseMode => 'Verse mode';

  @override
  String get essayReaderCopyQuote => 'Copy quote';

  @override
  String get essayReaderQuoteCopied => 'Quote copied';

  @override
  String get essayReaderPrev => 'Previous';

  @override
  String get essayReaderNext => 'Next';

  @override
  String essayReaderFocusHint(String virtue) {
    return 'This week’s focus is $virtue. Notice what from the letter you can practice today.';
  }

  @override
  String get authorSeneca => 'Seneca';

  @override
  String get authorMarcus => 'Marcus Aurelius';

  @override
  String get authorEpictetus => 'Epictetus';

  @override
  String get essaySenecaTitle => 'On the Shortness of Life';

  @override
  String get essaySenecaSnippet =>
      'It is not that we have a short time to live, but that we waste a great deal of it…';

  @override
  String get essayMarcusTitle => 'Meditations. Book 4';

  @override
  String get essayMarcusSnippet =>
      'Time is a river… Scarcely is a thing brought forth before it is swept away.';

  @override
  String get essayEpictetusTitle => 'Wherein lies our good?';

  @override
  String get essayEpictetusSnippet =>
      'Master your thoughts. Everything else is outside your power and does not concern you.';

  @override
  String get orderTitle => 'Order';

  @override
  String get archiveCycles => 'CYCLE ARCHIVE';

  @override
  String get personalSettings => 'PERSONAL SETTINGS';

  @override
  String get birthDateTileTitle => 'Birth date';

  @override
  String get birthDateTileSubtitleEmpty =>
      'Needed for the Memento Mori life grid';

  @override
  String birthDateTileSubtitleSet(String date) {
    return 'Born $date';
  }

  @override
  String get birthDatePageTitle => 'Memento Mori';

  @override
  String get birthDateLead => 'Remember that you will die';

  @override
  String get birthDateDescription =>
      'Stoics kept mortality in view so each week mattered. Enter your birth date and the journal will show a life grid of 80 years × 52 weeks — weeks already lived, weeks forged in VirtueForge, and the thin edge of the present.';

  @override
  String get birthDatePickLabel => 'Your birth date';

  @override
  String get birthDatePickHint => 'Tap to choose';

  @override
  String get birthDateSave => 'Save';

  @override
  String get mementoMoriTitle => 'Memento Mori';

  @override
  String get mementoMoriSetupTitle => 'Set your birth date';

  @override
  String get mementoMoriSetupSubtitle => 'Unlock the life grid (Memento Mori)';

  @override
  String get mementoMoriPlaqueSubtitle =>
      'Open the life calendar — weeks lived and remaining';

  @override
  String mementoMoriWeeksSummary(int lived, int remaining) {
    return 'Lived: $lived wk · Remaining: $remaining wk';
  }

  @override
  String get mementoMoriExploreHint =>
      'Press and drag to explore the canvas of time';

  @override
  String cycleTitle(String roman, int year) {
    return 'Cycle $roman ($year)';
  }

  @override
  String cycleActiveSubtitle(int week, int total) {
    return 'Week $week of $total · in progress';
  }

  @override
  String cycleDoneSubtitle(int percent, String pillar) {
    return 'Success: $percent%. Weak pillar: $pillar';
  }

  @override
  String cycleDoneSubtitleNoWeak(int percent) {
    return 'Success: $percent%';
  }

  @override
  String get archiveEmptyTitle => 'No completed cycles';

  @override
  String get archiveEmptySubtitle =>
      'Finish your first 13 weeks to see the archive.';

  @override
  String get cycleDetailTitle => 'Cycle ledger';

  @override
  String get cycleDetailInProgress => 'in progress';

  @override
  String cycleDetailSuccessLabel(int percent) {
    return '$percent%';
  }

  @override
  String cycleDetailStrikesLabel(int count) {
    return '$count fault marks in this cycle';
  }

  @override
  String cycleDetailWeakPillarLabel(String pillar) {
    return 'Weakest pillar: $pillar';
  }

  @override
  String get cycleDetailCompareTitle => 'COMPARED TO PREVIOUS';

  @override
  String cycleDetailCompareVs(String roman, int year) {
    return 'vs Cycle $roman ($year)';
  }

  @override
  String get cycleDetailCompareSuccess => 'Success';

  @override
  String get cycleDetailCompareStrikes => 'Fault marks';

  @override
  String cycleDetailCompareWeak(String previous, String current) {
    return 'Weak pillar: $previous → $current';
  }

  @override
  String get cycleDetailPillarsTitle => 'PILLARS';

  @override
  String cycleDetailPillarAvgXp(int xp) {
    return 'Avg week XP $xp';
  }

  @override
  String get cycleDetailPillarNoWeeks => 'No focus weeks yet';

  @override
  String get cycleDetailVirtuesTitle => 'THIRTEEN VIRTUES';

  @override
  String get cycleDetailWeeksTitle => 'WEEKS';

  @override
  String get cycleDetailWeeksSubtitle => 'Fault marks per week of the cycle';

  @override
  String get cycleDetailWeeksEmpty => 'No weeks recorded yet.';

  @override
  String cycleDetailCleanDaysTotal(int count) {
    return 'Clean days across weeks: $count';
  }

  @override
  String get editorTitle => 'Franklin wording editor';

  @override
  String get editorSubtitle => 'Adapt the 13 virtues to your own life';

  @override
  String get focusSelectTileTitle => 'Choose week focus';

  @override
  String get focusSelectTileSubtitleAuto =>
      'Classic Franklin sequence (automatic)';

  @override
  String focusSelectTileSubtitleAutoNamed(int number, String name) {
    return 'Week $number: $name (automatic)';
  }

  @override
  String focusSelectTileSubtitleManual(int number, String name) {
    return 'Week $number: $name (manual shift)';
  }

  @override
  String get focusSelectTitle => 'WEEK FOCUS';

  @override
  String get focusSelectSubtitle => 'Carve your discipline';

  @override
  String focusSelectHint(int number) {
    return 'Virtue #$number: hold this quality in focus for the next 7 days. The sequence continues from here.';
  }

  @override
  String get focusSelectConfirm => 'Set as week focus';

  @override
  String get saveChanges => 'Save';

  @override
  String get privacyTitle => 'Sanctity of the Journal';

  @override
  String get privacySubtitle => 'All data stays only on this device';

  @override
  String get privacyManifestAppBar => 'Portico · Fortress';

  @override
  String get privacyManifestTitle => 'Data Fortress: Manifesto';

  @override
  String get privacyManifestLead =>
      'Your journal, your faults, and your virtues are your private inner court. We believe digital discipline should never cost you privacy.';

  @override
  String get privacyManifestNoCloudTitle => 'No cloud sync for your journal.';

  @override
  String get privacyManifestNoCloudBody =>
      'Your journal, faults, and reflections stay on this device. We do not sync them to our servers or sell them.';

  @override
  String get privacyManifestNoAccountsTitle => 'No accounts.';

  @override
  String get privacyManifestNoAccountsBody =>
      'We do not need your name, email, or phone number. You remain anonymous.';

  @override
  String get privacyManifestAutonomyTitle => 'What may use the network.';

  @override
  String get privacyManifestAutonomyBody =>
      'Portico may fetch quotes and library essays from our content API (with on-device cache). The optional Mentor may download a model you choose (e.g. Hugging Face). Your journal never leaves the device.';

  @override
  String get privacyManifestClosing =>
      'Your journal remains yours. Content and optional models are separate from your private practice.';

  @override
  String get preferencesTitle => 'PREFERENCES';

  @override
  String get languageTitle => 'Language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageRussian => 'Русский';

  @override
  String get themeTitle => 'Appearance';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get reminderTitle => 'Evening reflection reminder';

  @override
  String reminderSubtitle(String time) {
    return 'Daily at $time';
  }

  @override
  String get reminderOffSubtitle => 'Off — tap time to choose, then enable';

  @override
  String get gestureTipsTitle => 'Gesture tips';

  @override
  String get gestureTipsSubtitleOn => 'Show tips under the journal grid';

  @override
  String get gestureTipsSubtitleOff => 'Hidden';

  @override
  String get reminderNotificationTitle => 'Evening reflection';

  @override
  String get reminderNotificationBody => 'Take a moment to review your day.';

  @override
  String get reminderPermissionDenied => 'Notification permission was denied';

  @override
  String get tutorialMementoTitle => 'You are here. Right now.';

  @override
  String get tutorialMementoBody =>
      'This is not a game — it is an account of time that never returns. Set your birth date and open the life grid.';

  @override
  String get tutorialSetBirthDate => 'Set birth date';

  @override
  String get tutorialOpenLifeGrid => 'Open life grid';

  @override
  String get tutorialArchetypeTitle =>
      'Philosophy without action is only words.';

  @override
  String get tutorialArchetypeBody =>
      'Choose a pillar for your first cycle. It receives +50 XP so you do not begin at absolute zero.';

  @override
  String get tutorialArchetypeReplayBody =>
      'Choose a pillar again to revisit the idea. The +50 XP bonus was already granted.';

  @override
  String get tutorialPickArchetypeHint => 'Select a pillar to continue';

  @override
  String get tutorialArchetypeWisdom =>
      'I want clearer, more conscious decisions.';

  @override
  String get tutorialArchetypeCourage => 'I want to face fear and act.';

  @override
  String get tutorialArchetypeJustice =>
      'I want honesty with myself and others.';

  @override
  String get tutorialArchetypeTemperance =>
      'I seek hard self-control and discipline.';

  @override
  String get tutorialContractTitle => 'Order rule: a fault is not defeat.';

  @override
  String get tutorialContractBody =>
      'Marking your mistakes is an act of Courage. The Franklin grid is not here to prove you are bad — it reveals hidden cracks so you can mend them in the Temple. Be honest. Your journal stays on this device; nobody syncs it to a cloud account.';

  @override
  String get tutorialContractCta => 'I accept the fight';

  @override
  String get tutorialContractPrivacyNote =>
      'Journal stays on-device. Portico may use the network for texts; Mentor downloads are opt-in.';

  @override
  String get tutorialGestureTitle => 'Practice the grid';

  @override
  String get tutorialGestureTap => 'Tap today’s focus cell to mark a fault.';

  @override
  String get tutorialGestureHold =>
      'Hold to undo. Mistakes can always be corrected.';

  @override
  String get tutorialGestureSwipe => 'Swipe left for notes and virtue info.';

  @override
  String get tutorialGestureDone =>
      'You know the gestures. Continue when ready.';

  @override
  String get tutorialSandboxFocus => 'Focus virtue';

  @override
  String get tutorialSandboxNotes => 'Notes';

  @override
  String get tutorialFinaleTitle => 'Your first 13-week cycle has begun.';

  @override
  String get tutorialFinaleBody =>
      'Each week the focus advances to the next virtue. Tonight at 20:00 we await you for the first evening reflection.';

  @override
  String get tutorialEnterJournal => 'Enter the Journal';

  @override
  String get tutorialReplayTitle => 'Practice tutorial';

  @override
  String get tutorialReplaySubtitle =>
      'Replay initiation without resetting your journal';

  @override
  String get tutorialOfferTitle => 'Order initiation';

  @override
  String get tutorialOfferBody =>
      'Would you like a short initiation: Memento Mori, pillar choice, the contract, and Journal gestures?';

  @override
  String get tutorialOfferAccept => 'Begin initiation';

  @override
  String get tutorialOfferLater => 'Later';

  @override
  String get tutorialOfferLaterHint =>
      'You can open initiation anytime in Order → “Practice tutorial”.';

  @override
  String get ledgerExportTileTitle => 'Ledger of the Soul';

  @override
  String get ledgerExportTileSubtitle => 'A yearly character audit in print';

  @override
  String get ledgerExportAppBar => 'Order · Ledger';

  @override
  String get ledgerExportTitle => 'Ledger of the Soul';

  @override
  String get ledgerExportLead =>
      'Franklin kept paper volumes of his character. The Order prepares the same honor for the digital journal — a strict PDF in the spirit of an old book.';

  @override
  String get ledgerExportBody =>
      'The scriptorium has not yet opened the press. When the smiths finish the layout, you will forge a volume here: cycle grids, black marks, and evening notes — so you may hold a yearly audit of the soul in your hands.';

  @override
  String get ledgerExportClosing =>
      'The press is still being forged. Patience is also a virtue.';

  @override
  String get pillarDetailTitle => 'Pillar audit';

  @override
  String pillarDetailXpRemaining(int xp, int level) {
    return '$xp XP left to level $level';
  }

  @override
  String pillarDetailIntegrityLine(String status, String detail) {
    return 'State: $status ($detail)';
  }

  @override
  String get pillarDetailStatusCleanWeek => 'Clean week';

  @override
  String pillarDetailStatusWeekStrikes(int count) {
    return '$count faults this week in this pillar';
  }

  @override
  String get pillarDetailAuditTitle => 'Character audit (this cycle)';

  @override
  String pillarDetailStrikeCount(int count) {
    return '$count faults';
  }

  @override
  String get pillarDetailStrikeIdeal => '0 — Ideal';

  @override
  String get pillarDetailLedgerTitle => 'XP ledger';

  @override
  String get pillarDetailLedgerEmpty =>
      'No XP events yet. Mark faults or finish clean days.';

  @override
  String get pillarDetailRulesTitle => 'How this pillar is forged';

  @override
  String get pillarDetailRulesForge => 'What builds the pillar';

  @override
  String pillarDetailRulesForgeBody(int clean, int base) {
    return '+$clean XP — each fully clean day (zero faults on the grid).\n+$base XP — week base for the focus category (before clean-day bonuses and penalties).';
  }

  @override
  String get pillarDetailRulesBreak => 'What cracks the pillar';

  @override
  String pillarDetailRulesBreakBody(int focus, int nonFocus) {
    return '−$focus XP — each fault in the focus virtue of the week.\n−$nonFocus XP — each fault in other virtues of this pillar.';
  }

  @override
  String get pillarDetailRulesFloorNote =>
      'A pillar level never drops. Past victories are protected. Penalties can only bring current-level XP down to 0.';

  @override
  String get xpEventWeekBase => 'Week base (focus category)';

  @override
  String get xpEventCleanDay => 'Clean day';

  @override
  String get xpEventFocusStrike => 'Fault — focus virtue';

  @override
  String get xpEventNonFocusStrike => 'Fault — other virtue in pillar';

  @override
  String get xpEventArchetypeBonus => 'Tutorial archetype bonus';

  @override
  String get pillarCoachSnackbar =>
      'Temple updated. Tap a pillar to see your audit and XP rules.';

  @override
  String get pillarCoachBanner =>
      'Tap a pillar to see the audit of your strengths and how XP is forged.';

  @override
  String get pillarCoachDismiss => 'Dismiss';

  @override
  String get templeDustTitle => 'The Temple gathers the dust of oblivion.';

  @override
  String templeDustBody(int days, int xp) {
    return '$days day(s) away — each pillar lost $xp XP. Return to practice.';
  }

  @override
  String get xpEventDust => 'Dust of oblivion';

  @override
  String get debugSectionTitle => 'Debug';

  @override
  String get debugSimulateDustTitle => 'Simulate 5 days of dust';

  @override
  String get debugSimulateDustSubtitle =>
      'Backdate activity and apply Temple dust';

  @override
  String get debugSimulateDustDone =>
      'Dust applied. Open Temple to see the banner.';

  @override
  String get mentorAudienceCta => 'Audience with a mentor';

  @override
  String get mentorAudienceCtaSub =>
      'On-device lapse review with a short follow-up dialogue';

  @override
  String get mentorAudienceTitle => 'Portico audience';

  @override
  String get mentorModelsTitle => 'Mentor models';

  @override
  String get mentorModelsLead =>
      'Download the light model or point to a local .gguf. Inference stays on this device.';

  @override
  String get mentorFocusLabel => 'Week focus';

  @override
  String mentorRemainingToday(int count) {
    return 'Audiences left today: $count';
  }

  @override
  String get mentorNeedModel => 'Download or register a model file first.';

  @override
  String get mentorOpenModels => 'Open models';

  @override
  String get mentorReflectionLabel => 'Your words (max 200 characters)';

  @override
  String get mentorEnterAudience => 'Enter the audience';

  @override
  String get mentorStopAudience => 'Stop the mentor';

  @override
  String get mentorResponseLabel => 'Dialogue';

  @override
  String get mentorTurnYou => 'You';

  @override
  String get mentorTurnMentor => 'Mentor';

  @override
  String get mentorLoadingModel => 'Loading model into memory…';

  @override
  String get mentorLoadingModelHint =>
      'On a weaker device this can take from tens of seconds to a couple of minutes. No percent is normal — the file is being read from disk.';

  @override
  String get mentorThinking => 'Mentor is answering…';

  @override
  String get mentorFollowUpLabel => 'Continue (max 200 characters)';

  @override
  String get mentorSendFollowUp => 'Reply to mentor';

  @override
  String mentorFollowUpsLeft(int count) {
    return 'Follow-ups left in this audience: $count';
  }

  @override
  String get mentorSavedDone => 'Saved to on-device audience history.';

  @override
  String get mentorSavedInterrupted =>
      'Audience interrupted. Text saved to history.';

  @override
  String get mentorHistoryTitle => 'Audience history';

  @override
  String get mentorHistoryDetailTitle => 'Audience';

  @override
  String get mentorHistoryEmpty => 'No saved audiences yet.';

  @override
  String get mentorHistoryInterrupted => 'interrupted';

  @override
  String mentorDailyLimit(int count) {
    return 'No audiences left today (limit $count).';
  }

  @override
  String get mentorEngineFailed =>
      'Could not start the model (llamadart). Check the GGUF and first-build native runtime — docs/local-llm-native.md.';

  @override
  String get mentorDisclaimerTitle => 'Before the audience';

  @override
  String get mentorDisclaimerBody =>
      'The Portico mentor is an on-device language model, not a living philosopher and not a medical or psychological service. Answers may be wrong. If you are in crisis, contact professionals and local help resources.\n\nReflections and prompts are not sent to VirtueForge servers for generation.';

  @override
  String get mentorDisclaimerAccept => 'I understand — continue';

  @override
  String get mentorDownloadStarting => 'Preparing download…';

  @override
  String get mentorDownloadResolving => 'Resolving file on Hugging Face…';

  @override
  String get mentorDownloadCheckingCache => 'Checking local cache / resuming…';

  @override
  String get mentorDownloadDownloading => 'Downloading';

  @override
  String get mentorDownloadVerifying => 'Verifying file…';

  @override
  String get mentorDownloadFailed => 'Download failed';

  @override
  String get mentorDownloadCancelled => 'Download cancelled';

  @override
  String get mentorDownloadAlreadyReady =>
      'Model is already installed on this device';

  @override
  String get mentorDownloadIndeterminateHint =>
      'Percent may be unknown during resume or cache checks. If the spinner runs for a while, keep the screen open — work may continue in the background.';

  @override
  String mentorDownloadPercent(int percent) {
    return '$percent%';
  }

  @override
  String mentorDownloadBytes(String receivedMb, String totalMb, int percent) {
    return '$receivedMb / $totalMb MB ($percent%)';
  }

  @override
  String mentorDownloadBytesOnly(String receivedMb) {
    return '$receivedMb MB downloaded…';
  }

  @override
  String get mentorDownloadDone => 'Model ready';

  @override
  String get mentorDownloadHf => 'Download from Hugging Face';

  @override
  String get mentorDownloadHfAgain => 'Check install';

  @override
  String get mentorPickLocal => 'Choose .gguf';

  @override
  String get mentorClearPath => 'Clear path';

  @override
  String get mentorModelRegistered => 'Model path saved';

  @override
  String get mentorSelectedBadge => 'selected';

  @override
  String get mentorWeakTitle => 'This device may struggle';

  @override
  String get mentorWeakBody =>
      'We recommend the light model (1.5B). A 3B model may be slow and warm the phone.';

  @override
  String get mentorWeakKeepLight => 'Keep 1.5B';

  @override
  String get mentorWeakUseHeavy => 'Use 3B anyway';

  @override
  String get mentorWeakDeviceToggle => 'Treat device as weak';

  @override
  String get mentorWeakDeviceToggleSub => 'Warn when selecting 3B models';

  @override
  String get mentorWeakDeviceToggleSubAuto =>
      'Detected from device RAM (<6 GB). You can override.';

  @override
  String get mentorWifiOnlyToggle => 'Wi‑Fi only for model downloads';

  @override
  String get mentorWifiOnlyToggleSub =>
      'Block multi‑GB downloads on mobile data (recommended)';

  @override
  String get mentorWifiRequiredTitle => 'Wi‑Fi recommended';

  @override
  String mentorWifiRequiredBody(String size) {
    return 'This model is about $size. Prefer Wi‑Fi to avoid mobile data charges, or continue on cellular.';
  }

  @override
  String get mentorWifiRequiredWait => 'Wait for Wi‑Fi';

  @override
  String get mentorWifiRequiredContinue => 'Use mobile data';

  @override
  String get mentorDownloadOffline => 'No network connection.';

  @override
  String get mentorDownloadWifiBlocked =>
      'Download blocked: connect to Wi‑Fi or allow mobile data.';

  @override
  String get mentorLicenseGateTitle => 'License required';

  @override
  String get mentorLicenseGateQwenResearch =>
      'Qwen 2.5 3B uses Alibaba’s Research / Tongyi license. Review it before using this model in a free consumer app. By continuing you confirm you accept that license for these weights.';

  @override
  String get mentorLicenseGateLlama =>
      'Llama 3.2 is subject to Meta’s Llama 3.2 Community License and Acceptable Use Policy. By continuing you accept those terms. Attribution: Built with Llama.';

  @override
  String get mentorLicenseGateAccept => 'I accept';

  @override
  String get mentorLicenseGateCancel => 'Cancel';

  @override
  String get mentorLicenseNoticeButton => 'NOTICE / licenses';

  @override
  String get mentorBuiltWithLlama => 'Built with Llama';

  @override
  String get mentorLicenseNoticeTitle => 'Third-party notices';

  @override
  String get mentorLicenseFootnote =>
      'Qwen 1.5B — Apache 2.0. Qwen 3B — check Research License. Llama 3.2 — Community License; when used: Built with Llama.';

  @override
  String get mentorOrderTileTitle => 'About the on-device mentor';

  @override
  String get mentorOrderTileSubtitle => 'Models, licenses, clear audiences';

  @override
  String get mentorAboutTitle => 'On-device mentor';

  @override
  String get mentorAboutBody =>
      'VirtueForge can use local models (Qwen 2.5 and/or Meta Llama 3.2) for journal audiences: a first review plus up to three short follow-ups. Inference runs on-device. Model files download only with your consent.\n\nThe daily limit on new audiences protects battery and heat; follow-ups inside one audience do not spend the limit.\n\nBuilt with Llama (when Llama is installed).';

  @override
  String get mentorMemoryEyebrow => 'Held in device memory';

  @override
  String mentorMemoryHeld(String model) {
    return '$model stays loaded after an audience so the next visit is faster.';
  }

  @override
  String get mentorMemoryHint =>
      'Release the weights if the phone runs hot or RAM is tight. The file on disk stays.';

  @override
  String get mentorMemoryRelease => 'Release from memory';

  @override
  String get mentorMemoryReleased =>
      'Memory freed. The model file remains on disk.';

  @override
  String get mentorClearAudiences => 'Clear saved audiences';

  @override
  String get mentorClearAudiencesDone => 'Audience archive cleared';
}
