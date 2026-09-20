import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'VirtueForge'**
  String get appTitle;

  /// No description provided for @navJournal.
  ///
  /// In en, this message translates to:
  /// **'Journal'**
  String get navJournal;

  /// No description provided for @navTemple.
  ///
  /// In en, this message translates to:
  /// **'Temple'**
  String get navTemple;

  /// No description provided for @navPortico.
  ///
  /// In en, this message translates to:
  /// **'Portico'**
  String get navPortico;

  /// No description provided for @navOrder.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get navOrder;

  /// No description provided for @dayMon.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get dayMon;

  /// No description provided for @dayTue.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get dayTue;

  /// No description provided for @dayWed.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get dayWed;

  /// No description provided for @dayThu.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get dayThu;

  /// No description provided for @dayFri.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get dayFri;

  /// No description provided for @daySat.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get daySat;

  /// No description provided for @daySun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get daySun;

  /// No description provided for @levelBadge.
  ///
  /// In en, this message translates to:
  /// **'Lv {level}'**
  String levelBadge(int level);

  /// No description provided for @journalGridTitle.
  ///
  /// In en, this message translates to:
  /// **'Fault Journal'**
  String get journalGridTitle;

  /// No description provided for @weekPrev.
  ///
  /// In en, this message translates to:
  /// **'Previous week'**
  String get weekPrev;

  /// No description provided for @weekNext.
  ///
  /// In en, this message translates to:
  /// **'Next week'**
  String get weekNext;

  /// No description provided for @weekNavCurrent.
  ///
  /// In en, this message translates to:
  /// **'This week'**
  String get weekNavCurrent;

  /// No description provided for @weekNavPast.
  ///
  /// In en, this message translates to:
  /// **'Week of {date}'**
  String weekNavPast(String date);

  /// No description provided for @strikeNoteTitle.
  ///
  /// In en, this message translates to:
  /// **'{virtue} · {day}'**
  String strikeNoteTitle(String virtue, String day);

  /// No description provided for @strikeNotePrompt.
  ///
  /// In en, this message translates to:
  /// **'What does this slip reveal about your character?'**
  String get strikeNotePrompt;

  /// No description provided for @strikeNoteHint.
  ///
  /// In en, this message translates to:
  /// **'Write freely — this is for you alone.'**
  String get strikeNoteHint;

  /// No description provided for @strikeNoteSave.
  ///
  /// In en, this message translates to:
  /// **'Save reflection'**
  String get strikeNoteSave;

  /// No description provided for @dayStrikeReflectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Day reflection'**
  String get dayStrikeReflectionTitle;

  /// No description provided for @dayStrikeReflectionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Each mark is a separate slip. Add a note when you have time to understand it — not when you are rushing.'**
  String get dayStrikeReflectionSubtitle;

  /// No description provided for @dayStrikeCountLabel.
  ///
  /// In en, this message translates to:
  /// **'{count} slips'**
  String dayStrikeCountLabel(int count);

  /// No description provided for @dayStrikeItemTitle.
  ///
  /// In en, this message translates to:
  /// **'Slip {number}'**
  String dayStrikeItemTitle(int number);

  /// No description provided for @dayStrikeNotePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Tap to add a note'**
  String get dayStrikeNotePlaceholder;

  /// No description provided for @dayStrikeNoteDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete note'**
  String get dayStrikeNoteDelete;

  /// No description provided for @dayStrikeAdd.
  ///
  /// In en, this message translates to:
  /// **'Add slip'**
  String get dayStrikeAdd;

  /// No description provided for @dayStrikeRemove.
  ///
  /// In en, this message translates to:
  /// **'Remove last slip'**
  String get dayStrikeRemove;

  /// No description provided for @dayStrikeEmptyEditable.
  ///
  /// In en, this message translates to:
  /// **'No slips yet. Add one here, or tap today’s column on the grid.'**
  String get dayStrikeEmptyEditable;

  /// No description provided for @dayStrikeEmptyReadonly.
  ///
  /// In en, this message translates to:
  /// **'No slips on this day.'**
  String get dayStrikeEmptyReadonly;

  /// No description provided for @gridSwipeNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get gridSwipeNotes;

  /// No description provided for @gridSwipeInfo.
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get gridSwipeInfo;

  /// No description provided for @gridTipTodayOnly.
  ///
  /// In en, this message translates to:
  /// **'Only today’s column can be edited quickly'**
  String get gridTipTodayOnly;

  /// No description provided for @gridTipLongPress.
  ///
  /// In en, this message translates to:
  /// **'Hold a mark to undo an accidental tap'**
  String get gridTipLongPress;

  /// No description provided for @gridTipDoubleTap.
  ///
  /// In en, this message translates to:
  /// **'Double-tap a cell to reflect on each slip'**
  String get gridTipDoubleTap;

  /// No description provided for @gridTipSwipe.
  ///
  /// In en, this message translates to:
  /// **'Swipe a virtue left for notes or its description'**
  String get gridTipSwipe;

  /// No description provided for @eveningReflection.
  ///
  /// In en, this message translates to:
  /// **'Stoic evening reflection'**
  String get eveningReflection;

  /// No description provided for @dichotomyControl.
  ///
  /// In en, this message translates to:
  /// **'Dichotomy of control'**
  String get dichotomyControl;

  /// No description provided for @reflectionUncontrolledLabel.
  ///
  /// In en, this message translates to:
  /// **'What happened today that was outside my control?'**
  String get reflectionUncontrolledLabel;

  /// No description provided for @reflectionUncontrolledHint.
  ///
  /// In en, this message translates to:
  /// **'Other people’s actions, weather, traffic… (Accept as given)'**
  String get reflectionUncontrolledHint;

  /// No description provided for @reflectionControlledLabel.
  ///
  /// In en, this message translates to:
  /// **'How did I handle what was in my power?'**
  String get reflectionControlledLabel;

  /// No description provided for @reflectionControlledHint.
  ///
  /// In en, this message translates to:
  /// **'My reactions, decisions, focus on the virtue of the week…'**
  String get reflectionControlledHint;

  /// No description provided for @finishDay.
  ///
  /// In en, this message translates to:
  /// **'Complete the day'**
  String get finishDay;

  /// No description provided for @reflectionTodayContextTitle.
  ///
  /// In en, this message translates to:
  /// **'Today’s slips'**
  String get reflectionTodayContextTitle;

  /// No description provided for @reflectionTodayEmpty.
  ///
  /// In en, this message translates to:
  /// **'No slips marked today — still a good moment to reflect.'**
  String get reflectionTodayEmpty;

  /// No description provided for @reflectionVirtueStrikeHeader.
  ///
  /// In en, this message translates to:
  /// **'{virtue} · {count}'**
  String reflectionVirtueStrikeHeader(String virtue, int count);

  /// No description provided for @reflectionStrikeLine.
  ///
  /// In en, this message translates to:
  /// **'{ordinal}. {detail}'**
  String reflectionStrikeLine(int ordinal, String detail);

  /// No description provided for @reflectionStrikeNoNote.
  ///
  /// In en, this message translates to:
  /// **'no note'**
  String get reflectionStrikeNoNote;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;

  /// No description provided for @quoteMarcusAuthor.
  ///
  /// In en, this message translates to:
  /// **'Marcus Aurelius'**
  String get quoteMarcusAuthor;

  /// No description provided for @quoteMarcusBody.
  ///
  /// In en, this message translates to:
  /// **'“Waste no more time arguing about what a good man should be. Be one.”'**
  String get quoteMarcusBody;

  /// No description provided for @onboardingSlide1Title.
  ///
  /// In en, this message translates to:
  /// **'Two systems. One character.'**
  String get onboardingSlide1Title;

  /// No description provided for @onboardingSlide1Body.
  ///
  /// In en, this message translates to:
  /// **'We combined Stoic philosophy with Benjamin Franklin’s practical method of self-control. This is a tool for forging your character.'**
  String get onboardingSlide1Body;

  /// No description provided for @onboardingSlide2Title.
  ///
  /// In en, this message translates to:
  /// **'Franklin’s 13 Virtues'**
  String get onboardingSlide2Title;

  /// No description provided for @onboardingSlide2Body.
  ///
  /// In en, this message translates to:
  /// **'Each week you focus strictly on one quality of character. In the evening you honestly mark your faults as dots on the grid.'**
  String get onboardingSlide2Body;

  /// No description provided for @onboardingSlide3Title.
  ///
  /// In en, this message translates to:
  /// **'Four Stoic Pillars'**
  String get onboardingSlide3Title;

  /// No description provided for @onboardingSlide3Body.
  ///
  /// In en, this message translates to:
  /// **'Your daily discipline feeds the four pillars of the spirit: Wisdom, Courage, Justice, and Temperance. Do not let them crack.'**
  String get onboardingSlide3Body;

  /// No description provided for @onboardingNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// No description provided for @onboardingForge.
  ///
  /// In en, this message translates to:
  /// **'Forge Character'**
  String get onboardingForge;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @templeTitle.
  ///
  /// In en, this message translates to:
  /// **'Temple of Virtues'**
  String get templeTitle;

  /// No description provided for @characterStatus.
  ///
  /// In en, this message translates to:
  /// **'CHARACTER STATUS'**
  String get characterStatus;

  /// No description provided for @steadfastProgress.
  ///
  /// In en, this message translates to:
  /// **'Steadfast Progress'**
  String get steadfastProgress;

  /// No description provided for @currentCycle.
  ///
  /// In en, this message translates to:
  /// **'Current cycle: {current} of {total} this year'**
  String currentCycle(int current, int total);

  /// No description provided for @stoicPillarsSection.
  ///
  /// In en, this message translates to:
  /// **'STOIC PILLARS'**
  String get stoicPillarsSection;

  /// No description provided for @pillarIntegrityMonolith.
  ///
  /// In en, this message translates to:
  /// **'Monolith'**
  String get pillarIntegrityMonolith;

  /// No description provided for @pillarIntegrityCracked.
  ///
  /// In en, this message translates to:
  /// **'Cracked'**
  String get pillarIntegrityCracked;

  /// No description provided for @pillarIntegrityShattered.
  ///
  /// In en, this message translates to:
  /// **'Shattered'**
  String get pillarIntegrityShattered;

  /// No description provided for @pillarLevelLabel.
  ///
  /// In en, this message translates to:
  /// **'Level {level}'**
  String pillarLevelLabel(int level);

  /// No description provided for @pillarXpLabel.
  ///
  /// In en, this message translates to:
  /// **'{current} / {next} XP'**
  String pillarXpLabel(int current, int next);

  /// No description provided for @pillarMottoTemperance.
  ///
  /// In en, this message translates to:
  /// **'Metron Ariston'**
  String get pillarMottoTemperance;

  /// No description provided for @pillarMottoWisdom.
  ///
  /// In en, this message translates to:
  /// **'Know Thyself'**
  String get pillarMottoWisdom;

  /// No description provided for @pillarMottoCourage.
  ///
  /// In en, this message translates to:
  /// **'Amor Fati'**
  String get pillarMottoCourage;

  /// No description provided for @pillarMottoJustice.
  ///
  /// In en, this message translates to:
  /// **'Suum Cuique'**
  String get pillarMottoJustice;

  /// No description provided for @stoicTemperance.
  ///
  /// In en, this message translates to:
  /// **'Temperance'**
  String get stoicTemperance;

  /// No description provided for @stoicTemperanceDesc.
  ///
  /// In en, this message translates to:
  /// **'Mastery of desires, self-control, and balance.'**
  String get stoicTemperanceDesc;

  /// No description provided for @stoicWisdom.
  ///
  /// In en, this message translates to:
  /// **'Wisdom'**
  String get stoicWisdom;

  /// No description provided for @stoicWisdomDesc.
  ///
  /// In en, this message translates to:
  /// **'Knowing what is good, evil, and indifferent — and choosing rightly.'**
  String get stoicWisdomDesc;

  /// No description provided for @stoicCourage.
  ///
  /// In en, this message translates to:
  /// **'Courage'**
  String get stoicCourage;

  /// No description provided for @stoicCourageDesc.
  ///
  /// In en, this message translates to:
  /// **'Endurance and fidelity to principles in the face of hardship.'**
  String get stoicCourageDesc;

  /// No description provided for @stoicJustice.
  ///
  /// In en, this message translates to:
  /// **'Justice'**
  String get stoicJustice;

  /// No description provided for @stoicJusticeDesc.
  ///
  /// In en, this message translates to:
  /// **'Honesty and duty toward others and the world.'**
  String get stoicJusticeDesc;

  /// No description provided for @virtueAbstinence.
  ///
  /// In en, this message translates to:
  /// **'Temperance'**
  String get virtueAbstinence;

  /// No description provided for @virtueAbstinenceDesc.
  ///
  /// In en, this message translates to:
  /// **'Eat not to dullness; drink not to elevation.'**
  String get virtueAbstinenceDesc;

  /// No description provided for @virtueSilence.
  ///
  /// In en, this message translates to:
  /// **'Silence'**
  String get virtueSilence;

  /// No description provided for @virtueSilenceDesc.
  ///
  /// In en, this message translates to:
  /// **'Speak not but what may benefit others or yourself; avoid trifling conversation.'**
  String get virtueSilenceDesc;

  /// No description provided for @virtueOrder.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get virtueOrder;

  /// No description provided for @virtueOrderDesc.
  ///
  /// In en, this message translates to:
  /// **'Let all your things have their places; let each part of your business have its time.'**
  String get virtueOrderDesc;

  /// No description provided for @virtueResolution.
  ///
  /// In en, this message translates to:
  /// **'Resolution'**
  String get virtueResolution;

  /// No description provided for @virtueResolutionDesc.
  ///
  /// In en, this message translates to:
  /// **'Resolve to perform what you ought; perform without fail what you resolve.'**
  String get virtueResolutionDesc;

  /// No description provided for @virtueFrugality.
  ///
  /// In en, this message translates to:
  /// **'Frugality'**
  String get virtueFrugality;

  /// No description provided for @virtueFrugalityDesc.
  ///
  /// In en, this message translates to:
  /// **'Make no expense but to do good to others or yourself; waste nothing.'**
  String get virtueFrugalityDesc;

  /// No description provided for @virtueIndustry.
  ///
  /// In en, this message translates to:
  /// **'Industry'**
  String get virtueIndustry;

  /// No description provided for @virtueIndustryDesc.
  ///
  /// In en, this message translates to:
  /// **'Lose no time; be always employed in something useful; cut off all unnecessary actions.'**
  String get virtueIndustryDesc;

  /// No description provided for @virtueSincerity.
  ///
  /// In en, this message translates to:
  /// **'Sincerity'**
  String get virtueSincerity;

  /// No description provided for @virtueSincerityDesc.
  ///
  /// In en, this message translates to:
  /// **'Use no hurtful deceit; think innocently and justly, and, if you speak, speak accordingly.'**
  String get virtueSincerityDesc;

  /// No description provided for @virtueJustice.
  ///
  /// In en, this message translates to:
  /// **'Justice'**
  String get virtueJustice;

  /// No description provided for @virtueJusticeDesc.
  ///
  /// In en, this message translates to:
  /// **'Wrong none by doing injuries, or omitting the benefits that are your duty.'**
  String get virtueJusticeDesc;

  /// No description provided for @virtueModeration.
  ///
  /// In en, this message translates to:
  /// **'Moderation'**
  String get virtueModeration;

  /// No description provided for @virtueModerationDesc.
  ///
  /// In en, this message translates to:
  /// **'Avoid extremes; forbear resenting injuries so much as you think they deserve.'**
  String get virtueModerationDesc;

  /// No description provided for @virtueCleanliness.
  ///
  /// In en, this message translates to:
  /// **'Cleanliness'**
  String get virtueCleanliness;

  /// No description provided for @virtueCleanlinessDesc.
  ///
  /// In en, this message translates to:
  /// **'Tolerate no uncleanliness in body, clothes, or habitation.'**
  String get virtueCleanlinessDesc;

  /// No description provided for @virtueTranquility.
  ///
  /// In en, this message translates to:
  /// **'Tranquility'**
  String get virtueTranquility;

  /// No description provided for @virtueTranquilityDesc.
  ///
  /// In en, this message translates to:
  /// **'Be not disturbed at trifles, or at accidents common or unavoidable.'**
  String get virtueTranquilityDesc;

  /// No description provided for @virtueChastity.
  ///
  /// In en, this message translates to:
  /// **'Chastity'**
  String get virtueChastity;

  /// No description provided for @virtueChastityDesc.
  ///
  /// In en, this message translates to:
  /// **'Rarely use venery but for health or offspring; never to dullness, weakness, or the injury of your own or another’s peace or reputation.'**
  String get virtueChastityDesc;

  /// No description provided for @virtueHumility.
  ///
  /// In en, this message translates to:
  /// **'Humility'**
  String get virtueHumility;

  /// No description provided for @virtueHumilityDesc.
  ///
  /// In en, this message translates to:
  /// **'Imitate Jesus and Socrates.'**
  String get virtueHumilityDesc;

  /// No description provided for @virtueGridLabel.
  ///
  /// In en, this message translates to:
  /// **'{number}. {name}'**
  String virtueGridLabel(int number, String name);

  /// No description provided for @porticoTitle.
  ///
  /// In en, this message translates to:
  /// **'Portico of Wisdom'**
  String get porticoTitle;

  /// No description provided for @forThisWeek.
  ///
  /// In en, this message translates to:
  /// **'SUITED FOR THIS WEEK'**
  String get forThisWeek;

  /// No description provided for @randomThought.
  ///
  /// In en, this message translates to:
  /// **'RANDOM THOUGHT'**
  String get randomThought;

  /// No description provided for @porticoEmptyWeek.
  ///
  /// In en, this message translates to:
  /// **'No essays tagged for this week yet.'**
  String get porticoEmptyWeek;

  /// No description provided for @essayLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not load the text. Check the connection and try again.'**
  String get essayLoadFailed;

  /// No description provided for @essayAnalysisLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not load the commentary.'**
  String get essayAnalysisLoadFailed;

  /// No description provided for @readFully.
  ///
  /// In en, this message translates to:
  /// **'Read fully →'**
  String get readFully;

  /// No description provided for @continueReading.
  ///
  /// In en, this message translates to:
  /// **'Continue →'**
  String get continueReading;

  /// No description provided for @essayReaderTextTab.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get essayReaderTextTab;

  /// No description provided for @essayReaderCommentTab.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get essayReaderCommentTab;

  /// No description provided for @essayReaderHasComment.
  ///
  /// In en, this message translates to:
  /// **'Has commentary'**
  String get essayReaderHasComment;

  /// No description provided for @essayReaderContents.
  ///
  /// In en, this message translates to:
  /// **'Contents'**
  String get essayReaderContents;

  /// No description provided for @essayReaderFontDecrease.
  ///
  /// In en, this message translates to:
  /// **'Smaller'**
  String get essayReaderFontDecrease;

  /// No description provided for @essayReaderFontIncrease.
  ///
  /// In en, this message translates to:
  /// **'Larger'**
  String get essayReaderFontIncrease;

  /// No description provided for @essayReaderVerseMode.
  ///
  /// In en, this message translates to:
  /// **'Verse mode'**
  String get essayReaderVerseMode;

  /// No description provided for @essayReaderCopyQuote.
  ///
  /// In en, this message translates to:
  /// **'Copy quote'**
  String get essayReaderCopyQuote;

  /// No description provided for @essayReaderQuoteCopied.
  ///
  /// In en, this message translates to:
  /// **'Quote copied'**
  String get essayReaderQuoteCopied;

  /// No description provided for @essayReaderPrev.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get essayReaderPrev;

  /// No description provided for @essayReaderNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get essayReaderNext;

  /// No description provided for @essayReaderFocusHint.
  ///
  /// In en, this message translates to:
  /// **'This week’s focus is {virtue}. Notice what from the letter you can practice today.'**
  String essayReaderFocusHint(String virtue);

  /// No description provided for @authorSeneca.
  ///
  /// In en, this message translates to:
  /// **'Seneca'**
  String get authorSeneca;

  /// No description provided for @authorMarcus.
  ///
  /// In en, this message translates to:
  /// **'Marcus Aurelius'**
  String get authorMarcus;

  /// No description provided for @authorEpictetus.
  ///
  /// In en, this message translates to:
  /// **'Epictetus'**
  String get authorEpictetus;

  /// No description provided for @essaySenecaTitle.
  ///
  /// In en, this message translates to:
  /// **'On the Shortness of Life'**
  String get essaySenecaTitle;

  /// No description provided for @essaySenecaSnippet.
  ///
  /// In en, this message translates to:
  /// **'It is not that we have a short time to live, but that we waste a great deal of it…'**
  String get essaySenecaSnippet;

  /// No description provided for @essayMarcusTitle.
  ///
  /// In en, this message translates to:
  /// **'Meditations. Book 4'**
  String get essayMarcusTitle;

  /// No description provided for @essayMarcusSnippet.
  ///
  /// In en, this message translates to:
  /// **'Time is a river… Scarcely is a thing brought forth before it is swept away.'**
  String get essayMarcusSnippet;

  /// No description provided for @essayEpictetusTitle.
  ///
  /// In en, this message translates to:
  /// **'Wherein lies our good?'**
  String get essayEpictetusTitle;

  /// No description provided for @essayEpictetusSnippet.
  ///
  /// In en, this message translates to:
  /// **'Master your thoughts. Everything else is outside your power and does not concern you.'**
  String get essayEpictetusSnippet;

  /// No description provided for @orderTitle.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get orderTitle;

  /// No description provided for @archiveCycles.
  ///
  /// In en, this message translates to:
  /// **'CYCLE ARCHIVE'**
  String get archiveCycles;

  /// No description provided for @personalSettings.
  ///
  /// In en, this message translates to:
  /// **'PERSONAL SETTINGS'**
  String get personalSettings;

  /// No description provided for @birthDateTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Birth date'**
  String get birthDateTileTitle;

  /// No description provided for @birthDateTileSubtitleEmpty.
  ///
  /// In en, this message translates to:
  /// **'Needed for the Memento Mori life grid'**
  String get birthDateTileSubtitleEmpty;

  /// No description provided for @birthDateTileSubtitleSet.
  ///
  /// In en, this message translates to:
  /// **'Born {date}'**
  String birthDateTileSubtitleSet(String date);

  /// No description provided for @birthDatePageTitle.
  ///
  /// In en, this message translates to:
  /// **'Memento Mori'**
  String get birthDatePageTitle;

  /// No description provided for @birthDateLead.
  ///
  /// In en, this message translates to:
  /// **'Remember that you will die'**
  String get birthDateLead;

  /// No description provided for @birthDateDescription.
  ///
  /// In en, this message translates to:
  /// **'Stoics kept mortality in view so each week mattered. Enter your birth date and the journal will show a life grid of 80 years × 52 weeks — weeks already lived, weeks forged in VirtueForge, and the thin edge of the present.'**
  String get birthDateDescription;

  /// No description provided for @birthDatePickLabel.
  ///
  /// In en, this message translates to:
  /// **'Your birth date'**
  String get birthDatePickLabel;

  /// No description provided for @birthDatePickHint.
  ///
  /// In en, this message translates to:
  /// **'Tap to choose'**
  String get birthDatePickHint;

  /// No description provided for @birthDateSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get birthDateSave;

  /// No description provided for @mementoMoriTitle.
  ///
  /// In en, this message translates to:
  /// **'Memento Mori'**
  String get mementoMoriTitle;

  /// No description provided for @mementoMoriSetupTitle.
  ///
  /// In en, this message translates to:
  /// **'Set your birth date'**
  String get mementoMoriSetupTitle;

  /// No description provided for @mementoMoriSetupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock the life grid (Memento Mori)'**
  String get mementoMoriSetupSubtitle;

  /// No description provided for @mementoMoriPlaqueSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Open the life calendar — weeks lived and remaining'**
  String get mementoMoriPlaqueSubtitle;

  /// No description provided for @mementoMoriWeeksSummary.
  ///
  /// In en, this message translates to:
  /// **'Lived: {lived} wk · Remaining: {remaining} wk'**
  String mementoMoriWeeksSummary(int lived, int remaining);

  /// No description provided for @mementoMoriExploreHint.
  ///
  /// In en, this message translates to:
  /// **'Press and drag to explore the canvas of time'**
  String get mementoMoriExploreHint;

  /// No description provided for @cycleTitle.
  ///
  /// In en, this message translates to:
  /// **'Cycle {roman} ({year})'**
  String cycleTitle(String roman, int year);

  /// No description provided for @cycleActiveSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Week {week} of {total} · in progress'**
  String cycleActiveSubtitle(int week, int total);

  /// No description provided for @cycleDoneSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Success: {percent}%. Weak pillar: {pillar}'**
  String cycleDoneSubtitle(int percent, String pillar);

  /// No description provided for @cycleDoneSubtitleNoWeak.
  ///
  /// In en, this message translates to:
  /// **'Success: {percent}%'**
  String cycleDoneSubtitleNoWeak(int percent);

  /// No description provided for @archiveEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No completed cycles'**
  String get archiveEmptyTitle;

  /// No description provided for @archiveEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Finish your first 13 weeks to see the archive.'**
  String get archiveEmptySubtitle;

  /// No description provided for @cycleDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Cycle ledger'**
  String get cycleDetailTitle;

  /// No description provided for @cycleDetailInProgress.
  ///
  /// In en, this message translates to:
  /// **'in progress'**
  String get cycleDetailInProgress;

  /// No description provided for @cycleDetailSuccessLabel.
  ///
  /// In en, this message translates to:
  /// **'{percent}%'**
  String cycleDetailSuccessLabel(int percent);

  /// No description provided for @cycleDetailStrikesLabel.
  ///
  /// In en, this message translates to:
  /// **'{count} fault marks in this cycle'**
  String cycleDetailStrikesLabel(int count);

  /// No description provided for @cycleDetailWeakPillarLabel.
  ///
  /// In en, this message translates to:
  /// **'Weakest pillar: {pillar}'**
  String cycleDetailWeakPillarLabel(String pillar);

  /// No description provided for @cycleDetailCompareTitle.
  ///
  /// In en, this message translates to:
  /// **'COMPARED TO PREVIOUS'**
  String get cycleDetailCompareTitle;

  /// No description provided for @cycleDetailCompareVs.
  ///
  /// In en, this message translates to:
  /// **'vs Cycle {roman} ({year})'**
  String cycleDetailCompareVs(String roman, int year);

  /// No description provided for @cycleDetailCompareSuccess.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get cycleDetailCompareSuccess;

  /// No description provided for @cycleDetailCompareStrikes.
  ///
  /// In en, this message translates to:
  /// **'Fault marks'**
  String get cycleDetailCompareStrikes;

  /// No description provided for @cycleDetailCompareWeak.
  ///
  /// In en, this message translates to:
  /// **'Weak pillar: {previous} → {current}'**
  String cycleDetailCompareWeak(String previous, String current);

  /// No description provided for @cycleDetailPillarsTitle.
  ///
  /// In en, this message translates to:
  /// **'PILLARS'**
  String get cycleDetailPillarsTitle;

  /// No description provided for @cycleDetailPillarAvgXp.
  ///
  /// In en, this message translates to:
  /// **'Avg week XP {xp}'**
  String cycleDetailPillarAvgXp(int xp);

  /// No description provided for @cycleDetailPillarNoWeeks.
  ///
  /// In en, this message translates to:
  /// **'No focus weeks yet'**
  String get cycleDetailPillarNoWeeks;

  /// No description provided for @cycleDetailVirtuesTitle.
  ///
  /// In en, this message translates to:
  /// **'THIRTEEN VIRTUES'**
  String get cycleDetailVirtuesTitle;

  /// No description provided for @cycleDetailWeeksTitle.
  ///
  /// In en, this message translates to:
  /// **'WEEKS'**
  String get cycleDetailWeeksTitle;

  /// No description provided for @cycleDetailWeeksSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Fault marks per week of the cycle'**
  String get cycleDetailWeeksSubtitle;

  /// No description provided for @cycleDetailWeeksEmpty.
  ///
  /// In en, this message translates to:
  /// **'No weeks recorded yet.'**
  String get cycleDetailWeeksEmpty;

  /// No description provided for @cycleDetailCleanDaysTotal.
  ///
  /// In en, this message translates to:
  /// **'Clean days across weeks: {count}'**
  String cycleDetailCleanDaysTotal(int count);

  /// No description provided for @editorTitle.
  ///
  /// In en, this message translates to:
  /// **'Franklin wording editor'**
  String get editorTitle;

  /// No description provided for @editorSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Adapt the 13 virtues to your own life'**
  String get editorSubtitle;

  /// No description provided for @focusSelectTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose week focus'**
  String get focusSelectTileTitle;

  /// No description provided for @focusSelectTileSubtitleAuto.
  ///
  /// In en, this message translates to:
  /// **'Classic Franklin sequence (automatic)'**
  String get focusSelectTileSubtitleAuto;

  /// No description provided for @focusSelectTileSubtitleAutoNamed.
  ///
  /// In en, this message translates to:
  /// **'Week {number}: {name} (automatic)'**
  String focusSelectTileSubtitleAutoNamed(int number, String name);

  /// No description provided for @focusSelectTileSubtitleManual.
  ///
  /// In en, this message translates to:
  /// **'Week {number}: {name} (manual shift)'**
  String focusSelectTileSubtitleManual(int number, String name);

  /// No description provided for @focusSelectTitle.
  ///
  /// In en, this message translates to:
  /// **'WEEK FOCUS'**
  String get focusSelectTitle;

  /// No description provided for @focusSelectSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Carve your discipline'**
  String get focusSelectSubtitle;

  /// No description provided for @focusSelectHint.
  ///
  /// In en, this message translates to:
  /// **'Virtue #{number}: hold this quality in focus for the next 7 days. The sequence continues from here.'**
  String focusSelectHint(int number);

  /// No description provided for @focusSelectConfirm.
  ///
  /// In en, this message translates to:
  /// **'Set as week focus'**
  String get focusSelectConfirm;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveChanges;

  /// No description provided for @privacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Sanctity of the Journal'**
  String get privacyTitle;

  /// No description provided for @privacySubtitle.
  ///
  /// In en, this message translates to:
  /// **'All data stays only on this device'**
  String get privacySubtitle;

  /// No description provided for @privacyManifestAppBar.
  ///
  /// In en, this message translates to:
  /// **'Portico · Fortress'**
  String get privacyManifestAppBar;

  /// No description provided for @privacyManifestTitle.
  ///
  /// In en, this message translates to:
  /// **'Data Fortress: Manifesto'**
  String get privacyManifestTitle;

  /// No description provided for @privacyManifestLead.
  ///
  /// In en, this message translates to:
  /// **'Your journal, your faults, and your virtues are your private inner court. We believe digital discipline should never cost you privacy.'**
  String get privacyManifestLead;

  /// No description provided for @privacyManifestNoCloudTitle.
  ///
  /// In en, this message translates to:
  /// **'No cloud sync for your journal.'**
  String get privacyManifestNoCloudTitle;

  /// No description provided for @privacyManifestNoCloudBody.
  ///
  /// In en, this message translates to:
  /// **'Your journal, faults, and reflections stay on this device. We do not sync them to our servers or sell them.'**
  String get privacyManifestNoCloudBody;

  /// No description provided for @privacyManifestNoAccountsTitle.
  ///
  /// In en, this message translates to:
  /// **'No accounts.'**
  String get privacyManifestNoAccountsTitle;

  /// No description provided for @privacyManifestNoAccountsBody.
  ///
  /// In en, this message translates to:
  /// **'We do not need your name, email, or phone number. You remain anonymous.'**
  String get privacyManifestNoAccountsBody;

  /// No description provided for @privacyManifestAutonomyTitle.
  ///
  /// In en, this message translates to:
  /// **'What may use the network.'**
  String get privacyManifestAutonomyTitle;

  /// No description provided for @privacyManifestAutonomyBody.
  ///
  /// In en, this message translates to:
  /// **'Portico may fetch quotes and library essays from our content API (with on-device cache). The optional Mentor may download a model you choose (e.g. Hugging Face). Your journal never leaves the device.'**
  String get privacyManifestAutonomyBody;

  /// No description provided for @privacyManifestClosing.
  ///
  /// In en, this message translates to:
  /// **'Your journal remains yours. Content and optional models are separate from your private practice.'**
  String get privacyManifestClosing;

  /// No description provided for @preferencesTitle.
  ///
  /// In en, this message translates to:
  /// **'PREFERENCES'**
  String get preferencesTitle;

  /// No description provided for @languageTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageTitle;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageRussian.
  ///
  /// In en, this message translates to:
  /// **'Русский'**
  String get languageRussian;

  /// No description provided for @themeTitle.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get themeTitle;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @reminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Evening reflection reminder'**
  String get reminderTitle;

  /// No description provided for @reminderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Daily at {time}'**
  String reminderSubtitle(String time);

  /// No description provided for @reminderOffSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Off — tap time to choose, then enable'**
  String get reminderOffSubtitle;

  /// No description provided for @gestureTipsTitle.
  ///
  /// In en, this message translates to:
  /// **'Gesture tips'**
  String get gestureTipsTitle;

  /// No description provided for @gestureTipsSubtitleOn.
  ///
  /// In en, this message translates to:
  /// **'Show tips under the journal grid'**
  String get gestureTipsSubtitleOn;

  /// No description provided for @gestureTipsSubtitleOff.
  ///
  /// In en, this message translates to:
  /// **'Hidden'**
  String get gestureTipsSubtitleOff;

  /// No description provided for @reminderNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Evening reflection'**
  String get reminderNotificationTitle;

  /// No description provided for @reminderNotificationBody.
  ///
  /// In en, this message translates to:
  /// **'Take a moment to review your day.'**
  String get reminderNotificationBody;

  /// No description provided for @reminderPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Notification permission was denied'**
  String get reminderPermissionDenied;

  /// No description provided for @tutorialMementoTitle.
  ///
  /// In en, this message translates to:
  /// **'You are here. Right now.'**
  String get tutorialMementoTitle;

  /// No description provided for @tutorialMementoBody.
  ///
  /// In en, this message translates to:
  /// **'This is not a game — it is an account of time that never returns. Set your birth date and open the life grid.'**
  String get tutorialMementoBody;

  /// No description provided for @tutorialSetBirthDate.
  ///
  /// In en, this message translates to:
  /// **'Set birth date'**
  String get tutorialSetBirthDate;

  /// No description provided for @tutorialOpenLifeGrid.
  ///
  /// In en, this message translates to:
  /// **'Open life grid'**
  String get tutorialOpenLifeGrid;

  /// No description provided for @tutorialArchetypeTitle.
  ///
  /// In en, this message translates to:
  /// **'Philosophy without action is only words.'**
  String get tutorialArchetypeTitle;

  /// No description provided for @tutorialArchetypeBody.
  ///
  /// In en, this message translates to:
  /// **'Choose a pillar for your first cycle. It receives +50 XP so you do not begin at absolute zero.'**
  String get tutorialArchetypeBody;

  /// No description provided for @tutorialArchetypeReplayBody.
  ///
  /// In en, this message translates to:
  /// **'Choose a pillar again to revisit the idea. The +50 XP bonus was already granted.'**
  String get tutorialArchetypeReplayBody;

  /// No description provided for @tutorialPickArchetypeHint.
  ///
  /// In en, this message translates to:
  /// **'Select a pillar to continue'**
  String get tutorialPickArchetypeHint;

  /// No description provided for @tutorialArchetypeWisdom.
  ///
  /// In en, this message translates to:
  /// **'I want clearer, more conscious decisions.'**
  String get tutorialArchetypeWisdom;

  /// No description provided for @tutorialArchetypeCourage.
  ///
  /// In en, this message translates to:
  /// **'I want to face fear and act.'**
  String get tutorialArchetypeCourage;

  /// No description provided for @tutorialArchetypeJustice.
  ///
  /// In en, this message translates to:
  /// **'I want honesty with myself and others.'**
  String get tutorialArchetypeJustice;

  /// No description provided for @tutorialArchetypeTemperance.
  ///
  /// In en, this message translates to:
  /// **'I seek hard self-control and discipline.'**
  String get tutorialArchetypeTemperance;

  /// No description provided for @tutorialContractTitle.
  ///
  /// In en, this message translates to:
  /// **'Order rule: a fault is not defeat.'**
  String get tutorialContractTitle;

  /// No description provided for @tutorialContractBody.
  ///
  /// In en, this message translates to:
  /// **'Marking your mistakes is an act of Courage. The Franklin grid is not here to prove you are bad — it reveals hidden cracks so you can mend them in the Temple. Be honest. Your journal stays on this device; nobody syncs it to a cloud account.'**
  String get tutorialContractBody;

  /// No description provided for @tutorialContractCta.
  ///
  /// In en, this message translates to:
  /// **'I accept the fight'**
  String get tutorialContractCta;

  /// No description provided for @tutorialContractPrivacyNote.
  ///
  /// In en, this message translates to:
  /// **'Journal stays on-device. Portico may use the network for texts; Mentor downloads are opt-in.'**
  String get tutorialContractPrivacyNote;

  /// No description provided for @tutorialGestureTitle.
  ///
  /// In en, this message translates to:
  /// **'Practice the grid'**
  String get tutorialGestureTitle;

  /// No description provided for @tutorialGestureTap.
  ///
  /// In en, this message translates to:
  /// **'Tap today’s focus cell to mark a fault.'**
  String get tutorialGestureTap;

  /// No description provided for @tutorialGestureHold.
  ///
  /// In en, this message translates to:
  /// **'Hold to undo. Mistakes can always be corrected.'**
  String get tutorialGestureHold;

  /// No description provided for @tutorialGestureSwipe.
  ///
  /// In en, this message translates to:
  /// **'Swipe left for notes and virtue info.'**
  String get tutorialGestureSwipe;

  /// No description provided for @tutorialGestureDone.
  ///
  /// In en, this message translates to:
  /// **'You know the gestures. Continue when ready.'**
  String get tutorialGestureDone;

  /// No description provided for @tutorialSandboxFocus.
  ///
  /// In en, this message translates to:
  /// **'Focus virtue'**
  String get tutorialSandboxFocus;

  /// No description provided for @tutorialSandboxNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get tutorialSandboxNotes;

  /// No description provided for @tutorialFinaleTitle.
  ///
  /// In en, this message translates to:
  /// **'Your first 13-week cycle has begun.'**
  String get tutorialFinaleTitle;

  /// No description provided for @tutorialFinaleBody.
  ///
  /// In en, this message translates to:
  /// **'Each week the focus advances to the next virtue. Tonight at 20:00 we await you for the first evening reflection.'**
  String get tutorialFinaleBody;

  /// No description provided for @tutorialEnterJournal.
  ///
  /// In en, this message translates to:
  /// **'Enter the Journal'**
  String get tutorialEnterJournal;

  /// No description provided for @tutorialReplayTitle.
  ///
  /// In en, this message translates to:
  /// **'Practice tutorial'**
  String get tutorialReplayTitle;

  /// No description provided for @tutorialReplaySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Replay initiation without resetting your journal'**
  String get tutorialReplaySubtitle;

  /// No description provided for @tutorialOfferTitle.
  ///
  /// In en, this message translates to:
  /// **'Order initiation'**
  String get tutorialOfferTitle;

  /// No description provided for @tutorialOfferBody.
  ///
  /// In en, this message translates to:
  /// **'Would you like a short initiation: Memento Mori, pillar choice, the contract, and Journal gestures?'**
  String get tutorialOfferBody;

  /// No description provided for @tutorialOfferAccept.
  ///
  /// In en, this message translates to:
  /// **'Begin initiation'**
  String get tutorialOfferAccept;

  /// No description provided for @tutorialOfferLater.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get tutorialOfferLater;

  /// No description provided for @tutorialOfferLaterHint.
  ///
  /// In en, this message translates to:
  /// **'You can open initiation anytime in Order → “Practice tutorial”.'**
  String get tutorialOfferLaterHint;

  /// No description provided for @ledgerExportTileTitle.
  ///
  /// In en, this message translates to:
  /// **'Ledger of the Soul'**
  String get ledgerExportTileTitle;

  /// No description provided for @ledgerExportTileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A yearly character audit in print'**
  String get ledgerExportTileSubtitle;

  /// No description provided for @ledgerExportAppBar.
  ///
  /// In en, this message translates to:
  /// **'Order · Ledger'**
  String get ledgerExportAppBar;

  /// No description provided for @ledgerExportTitle.
  ///
  /// In en, this message translates to:
  /// **'Ledger of the Soul'**
  String get ledgerExportTitle;

  /// No description provided for @ledgerExportLead.
  ///
  /// In en, this message translates to:
  /// **'Franklin kept paper volumes of his character. The Order prepares the same honor for the digital journal — a strict PDF in the spirit of an old book.'**
  String get ledgerExportLead;

  /// No description provided for @ledgerExportBody.
  ///
  /// In en, this message translates to:
  /// **'The scriptorium has not yet opened the press. When the smiths finish the layout, you will forge a volume here: cycle grids, black marks, and evening notes — so you may hold a yearly audit of the soul in your hands.'**
  String get ledgerExportBody;

  /// No description provided for @ledgerExportClosing.
  ///
  /// In en, this message translates to:
  /// **'The press is still being forged. Patience is also a virtue.'**
  String get ledgerExportClosing;

  /// No description provided for @pillarDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Pillar audit'**
  String get pillarDetailTitle;

  /// No description provided for @pillarDetailXpRemaining.
  ///
  /// In en, this message translates to:
  /// **'{xp} XP left to level {level}'**
  String pillarDetailXpRemaining(int xp, int level);

  /// No description provided for @pillarDetailIntegrityLine.
  ///
  /// In en, this message translates to:
  /// **'State: {status} ({detail})'**
  String pillarDetailIntegrityLine(String status, String detail);

  /// No description provided for @pillarDetailStatusCleanWeek.
  ///
  /// In en, this message translates to:
  /// **'Clean week'**
  String get pillarDetailStatusCleanWeek;

  /// No description provided for @pillarDetailStatusWeekStrikes.
  ///
  /// In en, this message translates to:
  /// **'{count} faults this week in this pillar'**
  String pillarDetailStatusWeekStrikes(int count);

  /// No description provided for @pillarDetailAuditTitle.
  ///
  /// In en, this message translates to:
  /// **'Character audit (this cycle)'**
  String get pillarDetailAuditTitle;

  /// No description provided for @pillarDetailStrikeCount.
  ///
  /// In en, this message translates to:
  /// **'{count} faults'**
  String pillarDetailStrikeCount(int count);

  /// No description provided for @pillarDetailStrikeIdeal.
  ///
  /// In en, this message translates to:
  /// **'0 — Ideal'**
  String get pillarDetailStrikeIdeal;

  /// No description provided for @pillarDetailLedgerTitle.
  ///
  /// In en, this message translates to:
  /// **'XP ledger'**
  String get pillarDetailLedgerTitle;

  /// No description provided for @pillarDetailLedgerEmpty.
  ///
  /// In en, this message translates to:
  /// **'No XP events yet. Mark faults or finish clean days.'**
  String get pillarDetailLedgerEmpty;

  /// No description provided for @pillarDetailRulesTitle.
  ///
  /// In en, this message translates to:
  /// **'How this pillar is forged'**
  String get pillarDetailRulesTitle;

  /// No description provided for @pillarDetailRulesForge.
  ///
  /// In en, this message translates to:
  /// **'What builds the pillar'**
  String get pillarDetailRulesForge;

  /// No description provided for @pillarDetailRulesForgeBody.
  ///
  /// In en, this message translates to:
  /// **'+{clean} XP — each fully clean day (zero faults on the grid).\n+{base} XP — week base for the focus category (before clean-day bonuses and penalties).'**
  String pillarDetailRulesForgeBody(int clean, int base);

  /// No description provided for @pillarDetailRulesBreak.
  ///
  /// In en, this message translates to:
  /// **'What cracks the pillar'**
  String get pillarDetailRulesBreak;

  /// No description provided for @pillarDetailRulesBreakBody.
  ///
  /// In en, this message translates to:
  /// **'−{focus} XP — each fault in the focus virtue of the week.\n−{nonFocus} XP — each fault in other virtues of this pillar.'**
  String pillarDetailRulesBreakBody(int focus, int nonFocus);

  /// No description provided for @pillarDetailRulesFloorNote.
  ///
  /// In en, this message translates to:
  /// **'A pillar level never drops. Past victories are protected. Penalties can only bring current-level XP down to 0.'**
  String get pillarDetailRulesFloorNote;

  /// No description provided for @xpEventWeekBase.
  ///
  /// In en, this message translates to:
  /// **'Week base (focus category)'**
  String get xpEventWeekBase;

  /// No description provided for @xpEventCleanDay.
  ///
  /// In en, this message translates to:
  /// **'Clean day'**
  String get xpEventCleanDay;

  /// No description provided for @xpEventFocusStrike.
  ///
  /// In en, this message translates to:
  /// **'Fault — focus virtue'**
  String get xpEventFocusStrike;

  /// No description provided for @xpEventNonFocusStrike.
  ///
  /// In en, this message translates to:
  /// **'Fault — other virtue in pillar'**
  String get xpEventNonFocusStrike;

  /// No description provided for @xpEventArchetypeBonus.
  ///
  /// In en, this message translates to:
  /// **'Tutorial archetype bonus'**
  String get xpEventArchetypeBonus;

  /// No description provided for @pillarCoachSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Temple updated. Tap a pillar to see your audit and XP rules.'**
  String get pillarCoachSnackbar;

  /// No description provided for @pillarCoachBanner.
  ///
  /// In en, this message translates to:
  /// **'Tap a pillar to see the audit of your strengths and how XP is forged.'**
  String get pillarCoachBanner;

  /// No description provided for @pillarCoachDismiss.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get pillarCoachDismiss;

  /// No description provided for @templeDustTitle.
  ///
  /// In en, this message translates to:
  /// **'The Temple gathers the dust of oblivion.'**
  String get templeDustTitle;

  /// No description provided for @templeDustBody.
  ///
  /// In en, this message translates to:
  /// **'{days} day(s) away — each pillar lost {xp} XP. Return to practice.'**
  String templeDustBody(int days, int xp);

  /// No description provided for @xpEventDust.
  ///
  /// In en, this message translates to:
  /// **'Dust of oblivion'**
  String get xpEventDust;

  /// No description provided for @debugSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Debug'**
  String get debugSectionTitle;

  /// No description provided for @debugSimulateDustTitle.
  ///
  /// In en, this message translates to:
  /// **'Simulate 5 days of dust'**
  String get debugSimulateDustTitle;

  /// No description provided for @debugSimulateDustSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Backdate activity and apply Temple dust'**
  String get debugSimulateDustSubtitle;

  /// No description provided for @debugSimulateDustDone.
  ///
  /// In en, this message translates to:
  /// **'Dust applied. Open Temple to see the banner.'**
  String get debugSimulateDustDone;

  /// No description provided for @mentorAudienceCta.
  ///
  /// In en, this message translates to:
  /// **'Audience with a mentor'**
  String get mentorAudienceCta;

  /// No description provided for @mentorAudienceCtaSub.
  ///
  /// In en, this message translates to:
  /// **'On-device lapse review with a short follow-up dialogue'**
  String get mentorAudienceCtaSub;

  /// No description provided for @mentorAudienceTitle.
  ///
  /// In en, this message translates to:
  /// **'Portico audience'**
  String get mentorAudienceTitle;

  /// No description provided for @mentorModelsTitle.
  ///
  /// In en, this message translates to:
  /// **'Mentor models'**
  String get mentorModelsTitle;

  /// No description provided for @mentorModelsLead.
  ///
  /// In en, this message translates to:
  /// **'Download the light model or point to a local .gguf. Inference stays on this device.'**
  String get mentorModelsLead;

  /// No description provided for @mentorFocusLabel.
  ///
  /// In en, this message translates to:
  /// **'Week focus'**
  String get mentorFocusLabel;

  /// No description provided for @mentorRemainingToday.
  ///
  /// In en, this message translates to:
  /// **'Audiences left today: {count}'**
  String mentorRemainingToday(int count);

  /// No description provided for @mentorNeedModel.
  ///
  /// In en, this message translates to:
  /// **'Download or register a model file first.'**
  String get mentorNeedModel;

  /// No description provided for @mentorOpenModels.
  ///
  /// In en, this message translates to:
  /// **'Open models'**
  String get mentorOpenModels;

  /// No description provided for @mentorReflectionLabel.
  ///
  /// In en, this message translates to:
  /// **'Your words (max 200 characters)'**
  String get mentorReflectionLabel;

  /// No description provided for @mentorEnterAudience.
  ///
  /// In en, this message translates to:
  /// **'Enter the audience'**
  String get mentorEnterAudience;

  /// No description provided for @mentorStopAudience.
  ///
  /// In en, this message translates to:
  /// **'Stop the mentor'**
  String get mentorStopAudience;

  /// No description provided for @mentorResponseLabel.
  ///
  /// In en, this message translates to:
  /// **'Dialogue'**
  String get mentorResponseLabel;

  /// No description provided for @mentorTurnYou.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get mentorTurnYou;

  /// No description provided for @mentorTurnMentor.
  ///
  /// In en, this message translates to:
  /// **'Mentor'**
  String get mentorTurnMentor;

  /// No description provided for @mentorLoadingModel.
  ///
  /// In en, this message translates to:
  /// **'Loading model into memory…'**
  String get mentorLoadingModel;

  /// No description provided for @mentorLoadingModelHint.
  ///
  /// In en, this message translates to:
  /// **'On a weaker device this can take from tens of seconds to a couple of minutes. No percent is normal — the file is being read from disk.'**
  String get mentorLoadingModelHint;

  /// No description provided for @mentorThinking.
  ///
  /// In en, this message translates to:
  /// **'Mentor is answering…'**
  String get mentorThinking;

  /// No description provided for @mentorFollowUpLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue (max 200 characters)'**
  String get mentorFollowUpLabel;

  /// No description provided for @mentorSendFollowUp.
  ///
  /// In en, this message translates to:
  /// **'Reply to mentor'**
  String get mentorSendFollowUp;

  /// No description provided for @mentorFollowUpsLeft.
  ///
  /// In en, this message translates to:
  /// **'Follow-ups left in this audience: {count}'**
  String mentorFollowUpsLeft(int count);

  /// No description provided for @mentorSavedDone.
  ///
  /// In en, this message translates to:
  /// **'Saved to on-device audience history.'**
  String get mentorSavedDone;

  /// No description provided for @mentorSavedInterrupted.
  ///
  /// In en, this message translates to:
  /// **'Audience interrupted. Text saved to history.'**
  String get mentorSavedInterrupted;

  /// No description provided for @mentorHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Audience history'**
  String get mentorHistoryTitle;

  /// No description provided for @mentorHistoryDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Audience'**
  String get mentorHistoryDetailTitle;

  /// No description provided for @mentorHistoryEmpty.
  ///
  /// In en, this message translates to:
  /// **'No saved audiences yet.'**
  String get mentorHistoryEmpty;

  /// No description provided for @mentorHistoryInterrupted.
  ///
  /// In en, this message translates to:
  /// **'interrupted'**
  String get mentorHistoryInterrupted;

  /// No description provided for @mentorDailyLimit.
  ///
  /// In en, this message translates to:
  /// **'No audiences left today (limit {count}).'**
  String mentorDailyLimit(int count);

  /// No description provided for @mentorEngineFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not start the model (llamadart). Check the GGUF and first-build native runtime — docs/local-llm-native.md.'**
  String get mentorEngineFailed;

  /// No description provided for @mentorDisclaimerTitle.
  ///
  /// In en, this message translates to:
  /// **'Before the audience'**
  String get mentorDisclaimerTitle;

  /// No description provided for @mentorDisclaimerBody.
  ///
  /// In en, this message translates to:
  /// **'The Portico mentor is an on-device language model, not a living philosopher and not a medical or psychological service. Answers may be wrong. If you are in crisis, contact professionals and local help resources.\n\nReflections and prompts are not sent to VirtueForge servers for generation.'**
  String get mentorDisclaimerBody;

  /// No description provided for @mentorDisclaimerAccept.
  ///
  /// In en, this message translates to:
  /// **'I understand — continue'**
  String get mentorDisclaimerAccept;

  /// No description provided for @mentorDownloadStarting.
  ///
  /// In en, this message translates to:
  /// **'Preparing download…'**
  String get mentorDownloadStarting;

  /// No description provided for @mentorDownloadResolving.
  ///
  /// In en, this message translates to:
  /// **'Resolving file on Hugging Face…'**
  String get mentorDownloadResolving;

  /// No description provided for @mentorDownloadCheckingCache.
  ///
  /// In en, this message translates to:
  /// **'Checking local cache / resuming…'**
  String get mentorDownloadCheckingCache;

  /// No description provided for @mentorDownloadDownloading.
  ///
  /// In en, this message translates to:
  /// **'Downloading'**
  String get mentorDownloadDownloading;

  /// No description provided for @mentorDownloadVerifying.
  ///
  /// In en, this message translates to:
  /// **'Verifying file…'**
  String get mentorDownloadVerifying;

  /// No description provided for @mentorDownloadFailed.
  ///
  /// In en, this message translates to:
  /// **'Download failed'**
  String get mentorDownloadFailed;

  /// No description provided for @mentorDownloadCancelled.
  ///
  /// In en, this message translates to:
  /// **'Download cancelled'**
  String get mentorDownloadCancelled;

  /// No description provided for @mentorDownloadAlreadyReady.
  ///
  /// In en, this message translates to:
  /// **'Model is already installed on this device'**
  String get mentorDownloadAlreadyReady;

  /// No description provided for @mentorDownloadIndeterminateHint.
  ///
  /// In en, this message translates to:
  /// **'Percent may be unknown during resume or cache checks. If the spinner runs for a while, keep the screen open — work may continue in the background.'**
  String get mentorDownloadIndeterminateHint;

  /// No description provided for @mentorDownloadPercent.
  ///
  /// In en, this message translates to:
  /// **'{percent}%'**
  String mentorDownloadPercent(int percent);

  /// No description provided for @mentorDownloadBytes.
  ///
  /// In en, this message translates to:
  /// **'{receivedMb} / {totalMb} MB ({percent}%)'**
  String mentorDownloadBytes(String receivedMb, String totalMb, int percent);

  /// No description provided for @mentorDownloadBytesOnly.
  ///
  /// In en, this message translates to:
  /// **'{receivedMb} MB downloaded…'**
  String mentorDownloadBytesOnly(String receivedMb);

  /// No description provided for @mentorDownloadDone.
  ///
  /// In en, this message translates to:
  /// **'Model ready'**
  String get mentorDownloadDone;

  /// No description provided for @mentorDownloadHf.
  ///
  /// In en, this message translates to:
  /// **'Download from Hugging Face'**
  String get mentorDownloadHf;

  /// No description provided for @mentorDownloadHfAgain.
  ///
  /// In en, this message translates to:
  /// **'Check install'**
  String get mentorDownloadHfAgain;

  /// No description provided for @mentorPickLocal.
  ///
  /// In en, this message translates to:
  /// **'Choose .gguf'**
  String get mentorPickLocal;

  /// No description provided for @mentorClearPath.
  ///
  /// In en, this message translates to:
  /// **'Clear path'**
  String get mentorClearPath;

  /// No description provided for @mentorModelRegistered.
  ///
  /// In en, this message translates to:
  /// **'Model path saved'**
  String get mentorModelRegistered;

  /// No description provided for @mentorSelectedBadge.
  ///
  /// In en, this message translates to:
  /// **'selected'**
  String get mentorSelectedBadge;

  /// No description provided for @mentorWeakTitle.
  ///
  /// In en, this message translates to:
  /// **'This device may struggle'**
  String get mentorWeakTitle;

  /// No description provided for @mentorWeakBody.
  ///
  /// In en, this message translates to:
  /// **'We recommend the light model (1.5B). A 3B model may be slow and warm the phone.'**
  String get mentorWeakBody;

  /// No description provided for @mentorWeakKeepLight.
  ///
  /// In en, this message translates to:
  /// **'Keep 1.5B'**
  String get mentorWeakKeepLight;

  /// No description provided for @mentorWeakUseHeavy.
  ///
  /// In en, this message translates to:
  /// **'Use 3B anyway'**
  String get mentorWeakUseHeavy;

  /// No description provided for @mentorWeakDeviceToggle.
  ///
  /// In en, this message translates to:
  /// **'Treat device as weak'**
  String get mentorWeakDeviceToggle;

  /// No description provided for @mentorWeakDeviceToggleSub.
  ///
  /// In en, this message translates to:
  /// **'Warn when selecting 3B models'**
  String get mentorWeakDeviceToggleSub;

  /// No description provided for @mentorWeakDeviceToggleSubAuto.
  ///
  /// In en, this message translates to:
  /// **'Detected from device RAM (<6 GB). You can override.'**
  String get mentorWeakDeviceToggleSubAuto;

  /// No description provided for @mentorWifiOnlyToggle.
  ///
  /// In en, this message translates to:
  /// **'Wi‑Fi only for model downloads'**
  String get mentorWifiOnlyToggle;

  /// No description provided for @mentorWifiOnlyToggleSub.
  ///
  /// In en, this message translates to:
  /// **'Block multi‑GB downloads on mobile data (recommended)'**
  String get mentorWifiOnlyToggleSub;

  /// No description provided for @mentorWifiRequiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Wi‑Fi recommended'**
  String get mentorWifiRequiredTitle;

  /// No description provided for @mentorWifiRequiredBody.
  ///
  /// In en, this message translates to:
  /// **'This model is about {size}. Prefer Wi‑Fi to avoid mobile data charges, or continue on cellular.'**
  String mentorWifiRequiredBody(String size);

  /// No description provided for @mentorWifiRequiredWait.
  ///
  /// In en, this message translates to:
  /// **'Wait for Wi‑Fi'**
  String get mentorWifiRequiredWait;

  /// No description provided for @mentorWifiRequiredContinue.
  ///
  /// In en, this message translates to:
  /// **'Use mobile data'**
  String get mentorWifiRequiredContinue;

  /// No description provided for @mentorDownloadOffline.
  ///
  /// In en, this message translates to:
  /// **'No network connection.'**
  String get mentorDownloadOffline;

  /// No description provided for @mentorDownloadWifiBlocked.
  ///
  /// In en, this message translates to:
  /// **'Download blocked: connect to Wi‑Fi or allow mobile data.'**
  String get mentorDownloadWifiBlocked;

  /// No description provided for @mentorLicenseGateTitle.
  ///
  /// In en, this message translates to:
  /// **'License required'**
  String get mentorLicenseGateTitle;

  /// No description provided for @mentorLicenseGateQwenResearch.
  ///
  /// In en, this message translates to:
  /// **'Qwen 2.5 3B uses Alibaba’s Research / Tongyi license. Review it before using this model in a free consumer app. By continuing you confirm you accept that license for these weights.'**
  String get mentorLicenseGateQwenResearch;

  /// No description provided for @mentorLicenseGateLlama.
  ///
  /// In en, this message translates to:
  /// **'Llama 3.2 is subject to Meta’s Llama 3.2 Community License and Acceptable Use Policy. By continuing you accept those terms. Attribution: Built with Llama.'**
  String get mentorLicenseGateLlama;

  /// No description provided for @mentorLicenseGateAccept.
  ///
  /// In en, this message translates to:
  /// **'I accept'**
  String get mentorLicenseGateAccept;

  /// No description provided for @mentorLicenseGateCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get mentorLicenseGateCancel;

  /// No description provided for @mentorLicenseNoticeButton.
  ///
  /// In en, this message translates to:
  /// **'NOTICE / licenses'**
  String get mentorLicenseNoticeButton;

  /// No description provided for @mentorBuiltWithLlama.
  ///
  /// In en, this message translates to:
  /// **'Built with Llama'**
  String get mentorBuiltWithLlama;

  /// No description provided for @mentorLicenseNoticeTitle.
  ///
  /// In en, this message translates to:
  /// **'Third-party notices'**
  String get mentorLicenseNoticeTitle;

  /// No description provided for @mentorLicenseFootnote.
  ///
  /// In en, this message translates to:
  /// **'Qwen 1.5B — Apache 2.0. Qwen 3B — check Research License. Llama 3.2 — Community License; when used: Built with Llama.'**
  String get mentorLicenseFootnote;

  /// No description provided for @mentorOrderTileTitle.
  ///
  /// In en, this message translates to:
  /// **'About the on-device mentor'**
  String get mentorOrderTileTitle;

  /// No description provided for @mentorOrderTileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Models, licenses, clear audiences'**
  String get mentorOrderTileSubtitle;

  /// No description provided for @mentorAboutTitle.
  ///
  /// In en, this message translates to:
  /// **'On-device mentor'**
  String get mentorAboutTitle;

  /// No description provided for @mentorAboutBody.
  ///
  /// In en, this message translates to:
  /// **'VirtueForge can use local models (Qwen 2.5 and/or Meta Llama 3.2) for journal audiences: a first review plus up to three short follow-ups. Inference runs on-device. Model files download only with your consent.\n\nThe daily limit on new audiences protects battery and heat; follow-ups inside one audience do not spend the limit.\n\nBuilt with Llama (when Llama is installed).'**
  String get mentorAboutBody;

  /// No description provided for @mentorMemoryEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Held in device memory'**
  String get mentorMemoryEyebrow;

  /// No description provided for @mentorMemoryHeld.
  ///
  /// In en, this message translates to:
  /// **'{model} stays loaded after an audience so the next visit is faster.'**
  String mentorMemoryHeld(String model);

  /// No description provided for @mentorMemoryHint.
  ///
  /// In en, this message translates to:
  /// **'Release the weights if the phone runs hot or RAM is tight. The file on disk stays.'**
  String get mentorMemoryHint;

  /// No description provided for @mentorMemoryRelease.
  ///
  /// In en, this message translates to:
  /// **'Release from memory'**
  String get mentorMemoryRelease;

  /// No description provided for @mentorMemoryReleased.
  ///
  /// In en, this message translates to:
  /// **'Memory freed. The model file remains on disk.'**
  String get mentorMemoryReleased;

  /// No description provided for @mentorClearAudiences.
  ///
  /// In en, this message translates to:
  /// **'Clear saved audiences'**
  String get mentorClearAudiences;

  /// No description provided for @mentorClearAudiencesDone.
  ///
  /// In en, this message translates to:
  /// **'Audience archive cleared'**
  String get mentorClearAudiencesDone;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
