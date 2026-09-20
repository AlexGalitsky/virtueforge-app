// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'VirtueForge';

  @override
  String get navJournal => 'Журнал';

  @override
  String get navTemple => 'Храм';

  @override
  String get navPortico => 'Портик';

  @override
  String get navOrder => 'Орден';

  @override
  String get dayMon => 'Пн';

  @override
  String get dayTue => 'Вт';

  @override
  String get dayWed => 'Ср';

  @override
  String get dayThu => 'Чт';

  @override
  String get dayFri => 'Пт';

  @override
  String get daySat => 'Сб';

  @override
  String get daySun => 'Вс';

  @override
  String levelBadge(int level) {
    return 'Ур. $level';
  }

  @override
  String get journalGridTitle => 'Журнал проступков';

  @override
  String get weekPrev => 'Предыдущая неделя';

  @override
  String get weekNext => 'Следующая неделя';

  @override
  String get weekNavCurrent => 'Эта неделя';

  @override
  String weekNavPast(String date) {
    return 'Неделя с $date';
  }

  @override
  String strikeNoteTitle(String virtue, String day) {
    return '$virtue · $day';
  }

  @override
  String get strikeNotePrompt =>
      'Что этот проступок говорит о вашем характере?';

  @override
  String get strikeNoteHint => 'Пишите свободно — это только для вас.';

  @override
  String get strikeNoteSave => 'Сохранить размышление';

  @override
  String get dayStrikeReflectionTitle => 'Рефлексия дня';

  @override
  String get dayStrikeReflectionSubtitle =>
      'Каждая отметка — отдельный проступок. Заметку добавляйте, когда есть время осмыслить, а не на бегу.';

  @override
  String dayStrikeCountLabel(int count) {
    return 'Проступков: $count';
  }

  @override
  String dayStrikeItemTitle(int number) {
    return 'Проступок $number';
  }

  @override
  String get dayStrikeNotePlaceholder => 'Нажмите, чтобы добавить заметку';

  @override
  String get dayStrikeNoteDelete => 'Удалить заметку';

  @override
  String get dayStrikeAdd => 'Добавить проступок';

  @override
  String get dayStrikeRemove => 'Убрать последний проступок';

  @override
  String get dayStrikeEmptyEditable =>
      'Пока пусто. Добавьте здесь или тапните столбец «Сегодня» на сетке.';

  @override
  String get dayStrikeEmptyReadonly => 'В этот день проступков нет.';

  @override
  String get gridSwipeNotes => 'Заметки';

  @override
  String get gridSwipeInfo => 'Справка';

  @override
  String get gridTipTodayOnly => 'Быстро правится только столбец «Сегодня»';

  @override
  String get gridTipLongPress =>
      'Удерживайте отметку, чтобы отменить случайный тап';

  @override
  String get gridTipDoubleTap =>
      'Двойной тап по ячейке — рефлексия по каждому проступку';

  @override
  String get gridTipSwipe =>
      'Свайпните добродетель влево — заметки или описание';

  @override
  String get eveningReflection => 'Вечерняя рефлексия стоика';

  @override
  String get dichotomyControl => 'Дихотомия контроля';

  @override
  String get reflectionUncontrolledLabel =>
      'Что сегодня произошло вне моего контроля?';

  @override
  String get reflectionUncontrolledHint =>
      'Поступки других, погода, пробки… (Принять как данность)';

  @override
  String get reflectionControlledLabel =>
      'Как я управлял тем, что было в моей власти?';

  @override
  String get reflectionControlledHint =>
      'Мои реакции, решения, фокус на добродетели…';

  @override
  String get finishDay => 'Завершить день';

  @override
  String get reflectionTodayContextTitle => 'Проступки сегодня';

  @override
  String get reflectionTodayEmpty =>
      'Сегодня отметок нет — всё равно стоит оглянуться.';

  @override
  String reflectionVirtueStrikeHeader(String virtue, int count) {
    return '$virtue · $count';
  }

  @override
  String reflectionStrikeLine(int ordinal, String detail) {
    return '$ordinal. $detail';
  }

  @override
  String get reflectionStrikeNoNote => 'без заметки';

  @override
  String get fieldRequired => 'Обязательное поле';

  @override
  String get quoteMarcusAuthor => 'Марк Аврелий';

  @override
  String get quoteMarcusBody =>
      '«Не рассуждай о том, каким должен быть хороший человек. Будь им».';

  @override
  String get onboardingSlide1Title => 'Две системы. Один характер.';

  @override
  String get onboardingSlide1Body =>
      'Мы объединили стоическую философию с практическим методом контроля Бенджамина Франклина. Это инструмент выковывания вашей личности.';

  @override
  String get onboardingSlide2Title => '13 Добродетелей Франклина';

  @override
  String get onboardingSlide2Body =>
      'Каждую неделю вы фокусируетесь строго на одном качестве характера. Вечером вы честно фиксируете свои проступки в виде точек на сетке.';

  @override
  String get onboardingSlide3Title => '4 Стоические Колонны';

  @override
  String get onboardingSlide3Body =>
      'Ваш ежедневный контроль питает четыре главных столпа духа: Мудрость, Мужество, Справедливость и Умеренность. Не дайте им дать трещину.';

  @override
  String get onboardingNext => 'Далее';

  @override
  String get onboardingForge => 'Выковать Характер';

  @override
  String get skip => 'Пропустить';

  @override
  String get templeTitle => 'Храм Добродетелей';

  @override
  String get characterStatus => 'СТАТУС ХАРАКТЕРА';

  @override
  String get steadfastProgress => 'Стойкий Прогресс';

  @override
  String currentCycle(int current, int total) {
    return 'Текущий цикл: $current из $total в этом году';
  }

  @override
  String get stoicPillarsSection => 'СТОИЧЕСКИЕ КОЛОННЫ';

  @override
  String get pillarIntegrityMonolith => 'Монолит';

  @override
  String get pillarIntegrityCracked => 'Трещины';

  @override
  String get pillarIntegrityShattered => 'Разрушена';

  @override
  String pillarLevelLabel(int level) {
    return 'Уровень $level';
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
  String get stoicTemperance => 'Умеренность';

  @override
  String get stoicTemperanceDesc => 'Контроль желаний и баланс';

  @override
  String get stoicWisdom => 'Мудрость';

  @override
  String get stoicWisdomDesc => 'Принятие правильных решений';

  @override
  String get stoicCourage => 'Мужество';

  @override
  String get stoicCourageDesc => 'Стойкость перед трудностями';

  @override
  String get stoicJustice => 'Справедливость';

  @override
  String get stoicJusticeDesc => 'Честность и долг перед миром';

  @override
  String get virtueAbstinence => 'Воздержание';

  @override
  String get virtueAbstinenceDesc => 'Не ешь до одурения, не пей до опьянения.';

  @override
  String get virtueSilence => 'Молчание';

  @override
  String get virtueSilenceDesc =>
      'Говори только то, что может принести пользу тебе или другим; избегай пустых разговоров.';

  @override
  String get virtueOrder => 'Порядок';

  @override
  String get virtueOrderDesc =>
      'Пусть для каждой вещи будет свое место; пусть для каждого дела будет свое время.';

  @override
  String get virtueResolution => 'Решительность';

  @override
  String get virtueResolutionDesc =>
      'Решай делать то, что должно; исполняй безвременно то, что решил.';

  @override
  String get virtueFrugality => 'Бережливость';

  @override
  String get virtueFrugalityDesc =>
      'Трать деньги только на то, что приносит благо другим или тебе; ничего не растрачивай попусту.';

  @override
  String get virtueIndustry => 'Трудолюбие';

  @override
  String get virtueIndustryDesc =>
      'Не теряй времени даром; всегда будь занят чем-то полезным; отменяй все ненужные действия.';

  @override
  String get virtueSincerity => 'Искренность';

  @override
  String get virtueSincerityDesc =>
      'Не используй вредного обмана; мысли чисто и справедливо; если говоришь, то так и думай.';

  @override
  String get virtueJustice => 'Справедливость';

  @override
  String get virtueJusticeDesc =>
      'Не причиняй никому вреда, совершая проступки или упуская добрые дела, которые входят в твои обязанности.';

  @override
  String get virtueModeration => 'Умеренность';

  @override
  String get virtueModerationDesc =>
      'Избегай крайностей; сдерживай обиду на причиненный вред, даже если думаешь, что он того заслуживает.';

  @override
  String get virtueCleanliness => 'Чистоплотность';

  @override
  String get virtueCleanlinessDesc =>
      'Не допускай ни малейшей грязи на теле, в одежде или в доме.';

  @override
  String get virtueTranquility => 'Спокойствие';

  @override
  String get virtueTranquilityDesc =>
      'Не волнуйся по пустякам, из-за мелких происшествий или неизбежных случаев.';

  @override
  String get virtueChastity => 'Целомудрие';

  @override
  String get virtueChastityDesc =>
      'Редко предавайся сладострастию — только для здоровья или продления рода; никогда не доводи до ущерба для своего или чужого мира и репутации.';

  @override
  String get virtueHumility => 'Скромность';

  @override
  String get virtueHumilityDesc => 'Подражай Иисусу и Сократу.';

  @override
  String virtueGridLabel(int number, String name) {
    return '$number. $name';
  }

  @override
  String get porticoTitle => 'Портик мудрости';

  @override
  String get forThisWeek => 'ПОДХОДИТ ДЛЯ ЭТОЙ НЕДЕЛИ';

  @override
  String get randomThought => 'СЛУЧАЙНАЯ МЫСЛЬ';

  @override
  String get porticoEmptyWeek => 'Пока нет эссе для этой недели.';

  @override
  String get essayLoadFailed =>
      'Не удалось загрузить текст. Проверьте сеть и попробуйте снова.';

  @override
  String get essayAnalysisLoadFailed => 'Не удалось загрузить комментарий.';

  @override
  String get readFully => 'Читать полностью →';

  @override
  String get continueReading => 'Продолжить →';

  @override
  String get essayReaderTextTab => 'Текст';

  @override
  String get essayReaderCommentTab => 'Комментарий';

  @override
  String get essayReaderHasComment => 'Есть комментарий';

  @override
  String get essayReaderContents => 'Оглавление';

  @override
  String get essayReaderFontDecrease => 'Мельче';

  @override
  String get essayReaderFontIncrease => 'Крупнее';

  @override
  String get essayReaderVerseMode => 'Режим строф';

  @override
  String get essayReaderCopyQuote => 'Скопировать цитату';

  @override
  String get essayReaderQuoteCopied => 'Цитата скопирована';

  @override
  String get essayReaderPrev => 'Предыдущее';

  @override
  String get essayReaderNext => 'Следующее';

  @override
  String essayReaderFocusHint(String virtue) {
    return 'На этой неделе в фокусе — $virtue. Заметь, что из письма можно взять в практику сегодня.';
  }

  @override
  String get authorSeneca => 'Сенека';

  @override
  String get authorMarcus => 'Марк Аврелий';

  @override
  String get authorEpictetus => 'Эпиктет';

  @override
  String get essaySenecaTitle => 'О краткости жизни';

  @override
  String get essaySenecaSnippet =>
      'Не мало времени мы имеем, а много теряем. Жизнь уходит на пустяки…';

  @override
  String get essayMarcusTitle => 'К самому себе. Книга 4';

  @override
  String get essayMarcusSnippet =>
      'Время есть река… Едва появится что-нибудь, как уже уносится течением.';

  @override
  String get essayEpictetusTitle => 'В чем наше благо?';

  @override
  String get essayEpictetusSnippet =>
      'Владей своими мыслями. Всё остальное — вне твоей власти и тебя не касается.';

  @override
  String get orderTitle => 'Орден';

  @override
  String get archiveCycles => 'АРХИВ ЦИКЛОВ';

  @override
  String get personalSettings => 'ЛИЧНЫЕ НАСТРОЙКИ';

  @override
  String get birthDateTileTitle => 'Дата рождения';

  @override
  String get birthDateTileSubtitleEmpty => 'Нужна для сетки жизни Memento Mori';

  @override
  String birthDateTileSubtitleSet(String date) {
    return 'Рождение: $date';
  }

  @override
  String get birthDatePageTitle => 'Memento Mori';

  @override
  String get birthDateLead => 'Помни, что ты смертен';

  @override
  String get birthDateDescription =>
      'Стоики держали конечность жизни перед глазами, чтобы каждая неделя имела вес. Укажите дату рождения — в журнале появится сетка жизни (80 лет × 52 недели): прожитое, выкованное в VirtueForge и тонкая грань настоящего.';

  @override
  String get birthDatePickLabel => 'Ваша дата рождения';

  @override
  String get birthDatePickHint => 'Нажмите, чтобы выбрать';

  @override
  String get birthDateSave => 'Сохранить';

  @override
  String get mementoMoriTitle => 'Memento Mori';

  @override
  String get mementoMoriSetupTitle => 'Укажите дату рождения';

  @override
  String get mementoMoriSetupSubtitle => 'Откройте сетку жизни (Memento Mori)';

  @override
  String get mementoMoriPlaqueSubtitle =>
      'Календарь жизни — прожитые и оставшиеся недели';

  @override
  String mementoMoriWeeksSummary(int lived, int remaining) {
    return 'Прожито: $lived нед. · Осталось: $remaining нед.';
  }

  @override
  String get mementoMoriExploreHint =>
      'Зажмите и ведите пальцем, чтобы исследовать холст времени';

  @override
  String cycleTitle(String roman, int year) {
    return 'Цикл $roman ($year)';
  }

  @override
  String cycleActiveSubtitle(int week, int total) {
    return 'Неделя $week из $total · в процессе';
  }

  @override
  String cycleDoneSubtitle(int percent, String pillar) {
    return 'Успех: $percent%. Слабая колонна: $pillar';
  }

  @override
  String cycleDoneSubtitleNoWeak(int percent) {
    return 'Успех: $percent%';
  }

  @override
  String get archiveEmptyTitle => 'Нет завершённых циклов';

  @override
  String get archiveEmptySubtitle =>
      'Завершите первые 13 недель, чтобы увидеть архив.';

  @override
  String get cycleDetailTitle => 'Гроссбух цикла';

  @override
  String get cycleDetailInProgress => 'в процессе';

  @override
  String cycleDetailSuccessLabel(int percent) {
    return '$percent%';
  }

  @override
  String cycleDetailStrikesLabel(int count) {
    return '$count отметок проступков в этом цикле';
  }

  @override
  String cycleDetailWeakPillarLabel(String pillar) {
    return 'Слабейшая колонна: $pillar';
  }

  @override
  String get cycleDetailCompareTitle => 'СРАВНЕНИЕ С ПРЕДЫДУЩИМ';

  @override
  String cycleDetailCompareVs(String roman, int year) {
    return 'vs Цикл $roman ($year)';
  }

  @override
  String get cycleDetailCompareSuccess => 'Успех';

  @override
  String get cycleDetailCompareStrikes => 'Проступки';

  @override
  String cycleDetailCompareWeak(String previous, String current) {
    return 'Слабая колонна: $previous → $current';
  }

  @override
  String get cycleDetailPillarsTitle => 'КОЛОННЫ';

  @override
  String cycleDetailPillarAvgXp(int xp) {
    return 'Ср. XP недели $xp';
  }

  @override
  String get cycleDetailPillarNoWeeks => 'Ещё не было фокусных недель';

  @override
  String get cycleDetailVirtuesTitle => 'ТРИНАДЦАТЬ ДОБРОДЕТЕЛЕЙ';

  @override
  String get cycleDetailWeeksTitle => 'НЕДЕЛИ';

  @override
  String get cycleDetailWeeksSubtitle => 'Проступки по неделям цикла';

  @override
  String get cycleDetailWeeksEmpty => 'Пока нет записанных недель.';

  @override
  String cycleDetailCleanDaysTotal(int count) {
    return 'Чистых дней за недели: $count';
  }

  @override
  String get editorTitle => 'Редактор формулировок Франклина';

  @override
  String get editorSubtitle => 'Адаптируйте 13 добродетелей под свою жизнь';

  @override
  String get focusSelectTileTitle => 'Выбрать фокус недели';

  @override
  String get focusSelectTileSubtitleAuto =>
      'Классический порядок Франклина (авто)';

  @override
  String focusSelectTileSubtitleAutoNamed(int number, String name) {
    return 'Неделя $number: $name (авто)';
  }

  @override
  String focusSelectTileSubtitleManual(int number, String name) {
    return 'Неделя $number: $name (ручной сдвиг)';
  }

  @override
  String get focusSelectTitle => 'ФОКУС НА НЕДЕЛЮ';

  @override
  String get focusSelectSubtitle => 'Высеки свою дисциплину';

  @override
  String focusSelectHint(int number) {
    return 'Добродетель №$number: удерживайте её в фокусе 7 дней. Дальше цикл продолжается с этого места.';
  }

  @override
  String get focusSelectConfirm => 'Сделать фокусом недели';

  @override
  String get saveChanges => 'Сохранить';

  @override
  String get privacyTitle => 'Неприкосновенность журнала';

  @override
  String get privacySubtitle => 'Все данные хранятся только на этом устройстве';

  @override
  String get privacyManifestAppBar => 'Портик · Крепость';

  @override
  String get privacyManifestTitle => 'Крепость данных: Манифест';

  @override
  String get privacyManifestLead =>
      'Твой журнал, твои проступки и твои добродетели — это твой личный внутренний суд. Мы считаем, что цифровая дисциплина не должна стоить тебе приватности.';

  @override
  String get privacyManifestNoCloudTitle => 'Журнал не уходит в облако.';

  @override
  String get privacyManifestNoCloudBody =>
      'Журнал, проступки и рефлексии хранятся на этом устройстве. Мы не синхронизируем их на наши серверы и не продаём.';

  @override
  String get privacyManifestNoAccountsTitle => 'Никаких аккаунтов.';

  @override
  String get privacyManifestNoAccountsBody =>
      'Нам не нужно твоё имя, почта или номер телефона. Ты остаёшься инкогнито.';

  @override
  String get privacyManifestAutonomyTitle => 'Что может использовать сеть.';

  @override
  String get privacyManifestAutonomyBody =>
      'Портик может загружать цитаты и эссе с нашего content API (с кэшем на устройстве). Опциональный Наставник может скачать выбранную тобой модель (например, с Hugging Face). Журнал устройство не покидает.';

  @override
  String get privacyManifestClosing =>
      'Журнал остаётся твоим. Контент и опциональные модели — отдельно от личной практики.';

  @override
  String get preferencesTitle => 'НАСТРОЙКИ';

  @override
  String get languageTitle => 'Язык';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageRussian => 'Русский';

  @override
  String get themeTitle => 'Оформление';

  @override
  String get themeSystem => 'Системная';

  @override
  String get themeLight => 'Светлая';

  @override
  String get themeDark => 'Тёмная';

  @override
  String get reminderTitle => 'Вечернее напоминание о рефлексии';

  @override
  String reminderSubtitle(String time) {
    return 'Ежедневно в $time';
  }

  @override
  String get reminderOffSubtitle => 'Выкл. — выберите время, затем включите';

  @override
  String get gestureTipsTitle => 'Подсказки жестов';

  @override
  String get gestureTipsSubtitleOn => 'Показывать подсказки под сеткой журнала';

  @override
  String get gestureTipsSubtitleOff => 'Скрыты';

  @override
  String get reminderNotificationTitle => 'Вечерняя рефлексия';

  @override
  String get reminderNotificationBody =>
      'Уделите минуту, чтобы подвести итог дня.';

  @override
  String get reminderPermissionDenied => 'Разрешение на уведомления отклонено';

  @override
  String get tutorialMementoTitle => 'Вы здесь. Прямо сейчас.';

  @override
  String get tutorialMementoBody =>
      'Это не игра — это учёт времени, которое безвозвратно уходит. Укажите дату рождения и откройте сетку жизни.';

  @override
  String get tutorialSetBirthDate => 'Указать дату рождения';

  @override
  String get tutorialOpenLifeGrid => 'Открыть сетку жизни';

  @override
  String get tutorialArchetypeTitle => 'Философия без действия — просто слова.';

  @override
  String get tutorialArchetypeBody =>
      'Выберите колонну для первого цикла. Она получит +50 XP, чтобы вы не начинали с абсолютного нуля.';

  @override
  String get tutorialArchetypeReplayBody =>
      'Выберите колонну снова, чтобы вспомнить смысл. Бонус +50 XP уже был начислен.';

  @override
  String get tutorialPickArchetypeHint => 'Выберите колонну, чтобы продолжить';

  @override
  String get tutorialArchetypeWisdom =>
      'Хочу принимать более осознанные решения.';

  @override
  String get tutorialArchetypeCourage => 'Хочу преодолеть страх и действовать.';

  @override
  String get tutorialArchetypeJustice =>
      'Хочу быть честным с собой и окружающими.';

  @override
  String get tutorialArchetypeTemperance =>
      'Ищу жёсткий самоконтроль и дисциплину.';

  @override
  String get tutorialContractTitle =>
      'Правило Ордена: проступок — не поражение.';

  @override
  String get tutorialContractBody =>
      'Фиксировать ошибки — акт Мужества. Сетка Франклина не для того, чтобы показать, какой вы плохой. Она обнажает трещины характера, чтобы вы могли заделать их в Храме. Будьте честны. Журнал остаётся на этом устройстве — мы не синхронизируем его в облачный аккаунт.';

  @override
  String get tutorialContractCta => 'Я принимаю бой';

  @override
  String get tutorialContractPrivacyNote =>
      'Журнал на устройстве. Портик может ходить в сеть за текстами; загрузка моделей Наставника — только по выбору.';

  @override
  String get tutorialGestureTitle => 'Тренировка сетки';

  @override
  String get tutorialGestureTap =>
      'Тапните по ячейке фокусной добродетели — отметить проступок.';

  @override
  String get tutorialGestureHold =>
      'Удерживайте, чтобы отменить. Ошибку всегда можно исправить.';

  @override
  String get tutorialGestureSwipe => 'Свайпните влево — заметки и справка.';

  @override
  String get tutorialGestureDone => 'Жесты освоены. Можно продолжать.';

  @override
  String get tutorialSandboxFocus => 'Фокусная добродетель';

  @override
  String get tutorialSandboxNotes => 'Заметки';

  @override
  String get tutorialFinaleTitle => 'Ваш первый 13-недельный цикл запущен.';

  @override
  String get tutorialFinaleBody =>
      'Каждую неделю фокус смещается на следующую добродетель. Сегодня в 20:00 ждём вас на первую вечернюю рефлексию.';

  @override
  String get tutorialEnterJournal => 'Войти в Журнал';

  @override
  String get tutorialReplayTitle => 'Пройти туториал';

  @override
  String get tutorialReplaySubtitle => 'Повторить инициацию без сброса журнала';

  @override
  String get tutorialOfferTitle => 'Инициация Ордена';

  @override
  String get tutorialOfferBody =>
      'Хотите пройти краткое обучение: Memento Mori, выбор колонны, контракт и жесты Журнала?';

  @override
  String get tutorialOfferAccept => 'Пройти инициацию';

  @override
  String get tutorialOfferLater => 'Позже';

  @override
  String get tutorialOfferLaterHint =>
      'Инициацию можно открыть в любой момент в Ордене → «Пройти туториал».';

  @override
  String get ledgerExportTileTitle => 'Гроссбух души';

  @override
  String get ledgerExportTileSubtitle =>
      'Годовой аудит характера в печатном виде';

  @override
  String get ledgerExportAppBar => 'Орден · Гроссбух';

  @override
  String get ledgerExportTitle => 'Гроссбух души';

  @override
  String get ledgerExportLead =>
      'Франклин хранил бумажные тома своего характера. Орден готовит ту же честь для цифрового журнала — строгий PDF в духе старинной книги.';

  @override
  String get ledgerExportBody =>
      'Скрипторий ещё не открыл печать. Когда кузнецы завершат верстку, здесь можно будет выковать том: сетки циклов, чёрные точки и вечерние заметки — чтобы держать годовой аудит души в руках.';

  @override
  String get ledgerExportClosing =>
      'Печать ещё куётся. Терпение — тоже добродетель.';

  @override
  String get pillarDetailTitle => 'Аудит колонны';

  @override
  String pillarDetailXpRemaining(int xp, int level) {
    return 'Осталось $xp XP до уровня $level';
  }

  @override
  String pillarDetailIntegrityLine(String status, String detail) {
    return 'Состояние: $status ($detail)';
  }

  @override
  String get pillarDetailStatusCleanWeek => 'чистая неделя';

  @override
  String pillarDetailStatusWeekStrikes(int count) {
    return '$count проступков за неделю в этой колонне';
  }

  @override
  String get pillarDetailAuditTitle => 'Аудит характера (этот цикл)';

  @override
  String pillarDetailStrikeCount(int count) {
    return '$count проступков';
  }

  @override
  String get pillarDetailStrikeIdeal => '0 — идеально';

  @override
  String get pillarDetailLedgerTitle => 'Лента XP';

  @override
  String get pillarDetailLedgerEmpty =>
      'Пока нет событий XP. Отмечайте проступки или держите чистые дни.';

  @override
  String get pillarDetailRulesTitle => 'Как ковать эту колонну';

  @override
  String get pillarDetailRulesForge => 'Что строит колонну';

  @override
  String pillarDetailRulesForgeBody(int clean, int base) {
    return '+$clean XP — каждый абсолютно чистый день (0 проступков по всей сетке).\n+$base XP — база недели для фокусной категории (до бонусов чистых дней и штрафов).';
  }

  @override
  String get pillarDetailRulesBreak => 'Что разрушает колонну';

  @override
  String pillarDetailRulesBreakBody(int focus, int nonFocus) {
    return '−$focus XP — каждый проступок в фокусной добродетели недели.\n−$nonFocus XP — каждый проступок в остальных добродетелях этой колонны.';
  }

  @override
  String get pillarDetailRulesFloorNote =>
      'Уровень колонны никогда не падает. Прошлые победы защищены. Штрафы могут опустить опыт текущего уровня только до 0.';

  @override
  String get xpEventWeekBase => 'База недели (фокусная категория)';

  @override
  String get xpEventCleanDay => 'Чистый день';

  @override
  String get xpEventFocusStrike => 'Проступок — фокусная добродетель';

  @override
  String get xpEventNonFocusStrike => 'Проступок — другая добродетель колонны';

  @override
  String get xpEventArchetypeBonus => 'Бонус архетипа из туториала';

  @override
  String get pillarCoachSnackbar =>
      'Храм обновился. Нажмите на колонну, чтобы увидеть аудит и правила XP.';

  @override
  String get pillarCoachBanner =>
      'Нажмите на колонну, чтобы увидеть аудит ваших сил и правила начисления опыта.';

  @override
  String get pillarCoachDismiss => 'Закрыть';

  @override
  String get templeDustTitle => 'Храм покрывается пылью забвения.';

  @override
  String templeDustBody(int days, int xp) {
    return '$days дн. без практики — каждая колонна потеряла $xp XP. Вернитесь к практике.';
  }

  @override
  String get xpEventDust => 'Пыль забвения';

  @override
  String get debugSectionTitle => 'Отладка';

  @override
  String get debugSimulateDustTitle => 'Симулировать 5 дней пыли';

  @override
  String get debugSimulateDustSubtitle =>
      'Откатить активность и начислить пыль Храма';

  @override
  String get debugSimulateDustDone =>
      'Пыль применена. Открой Храм, чтобы увидеть баннер.';

  @override
  String get mentorAudienceCta => 'Аудиенция с наставником';

  @override
  String get mentorAudienceCtaSub =>
      'Офлайн-разбор проступка и короткое продолжение беседы';

  @override
  String get mentorAudienceTitle => 'Аудиенция в Портике';

  @override
  String get mentorModelsTitle => 'Модели наставника';

  @override
  String get mentorModelsLead =>
      'Скачайте лёгкую модель или укажите локальный файл .gguf. Инференс только на этом устройстве.';

  @override
  String get mentorFocusLabel => 'Фокус недели';

  @override
  String mentorRemainingToday(int count) {
    return 'Аудиенций сегодня: осталось $count';
  }

  @override
  String get mentorNeedModel => 'Сначала скачайте или укажите файл модели.';

  @override
  String get mentorOpenModels => 'Открыть модели';

  @override
  String get mentorReflectionLabel => 'Ваша реплика (до 200 символов)';

  @override
  String get mentorEnterAudience => 'Войти в аудиенцию';

  @override
  String get mentorStopAudience => 'Прервать наставника';

  @override
  String get mentorResponseLabel => 'Беседа';

  @override
  String get mentorTurnYou => 'Вы';

  @override
  String get mentorTurnMentor => 'Наставник';

  @override
  String get mentorLoadingModel => 'Загрузка модели в память…';

  @override
  String get mentorLoadingModelHint =>
      'На слабом устройстве это может занять от десятков секунд до пары минут. Индикатор без процента — нормально: файл читается с диска.';

  @override
  String get mentorThinking => 'Наставник отвечает…';

  @override
  String get mentorFollowUpLabel => 'Продолжить беседу (до 200 символов)';

  @override
  String get mentorSendFollowUp => 'Ответить наставнику';

  @override
  String mentorFollowUpsLeft(int count) {
    return 'Можно ещё реплик в этой аудиенции: $count';
  }

  @override
  String get mentorSavedDone => 'Сохранено в историю аудиенций на устройстве.';

  @override
  String get mentorSavedInterrupted =>
      'Беседа прервана. Текст сохранён в историю.';

  @override
  String get mentorHistoryTitle => 'История аудиенций';

  @override
  String get mentorHistoryDetailTitle => 'Аудиенция';

  @override
  String get mentorHistoryEmpty => 'Пока нет сохранённых аудиенций.';

  @override
  String get mentorHistoryInterrupted => 'прервана';

  @override
  String mentorDailyLimit(int count) {
    return 'На сегодня аудиенции исчерпаны (лимит $count).';
  }

  @override
  String get mentorEngineFailed =>
      'Не удалось запустить модель (llamadart). Проверьте GGUF и первый билд native runtime — docs/local-llm-native.md.';

  @override
  String get mentorDisclaimerTitle => 'Перед аудиенцией';

  @override
  String get mentorDisclaimerBody =>
      'Наставник Портика — локальная языковая модель, а не живой философ и не медицинская или психологическая служба. Ответы могут содержать ошибки. При кризисе обратитесь к специалистам и службам помощи в вашем регионе.\n\nРефлексии и промпт не отправляются на серверы VirtueForge ради генерации.';

  @override
  String get mentorDisclaimerAccept => 'Понятно, продолжить';

  @override
  String get mentorDownloadStarting => 'Подготовка загрузки…';

  @override
  String get mentorDownloadResolving => 'Поиск файла на Hugging Face…';

  @override
  String get mentorDownloadCheckingCache =>
      'Проверка локального кэша / докачка…';

  @override
  String get mentorDownloadDownloading => 'Скачивание';

  @override
  String get mentorDownloadVerifying => 'Проверка файла…';

  @override
  String get mentorDownloadFailed => 'Ошибка загрузки';

  @override
  String get mentorDownloadCancelled => 'Загрузка отменена';

  @override
  String get mentorDownloadAlreadyReady =>
      'Модель уже установлена на устройстве';

  @override
  String get mentorDownloadIndeterminateHint =>
      'Процент может быть неизвестен (докачка или проверка кэша). Если индикатор крутится долго — не закрывайте экран: работа может идти в фоне.';

  @override
  String mentorDownloadPercent(int percent) {
    return '$percent%';
  }

  @override
  String mentorDownloadBytes(String receivedMb, String totalMb, int percent) {
    return '$receivedMb / $totalMb МБ ($percent%)';
  }

  @override
  String mentorDownloadBytesOnly(String receivedMb) {
    return '$receivedMb МБ скачано…';
  }

  @override
  String get mentorDownloadDone => 'Модель готова';

  @override
  String get mentorDownloadHf => 'Скачать с Hugging Face';

  @override
  String get mentorDownloadHfAgain => 'Проверить установку';

  @override
  String get mentorPickLocal => 'Указать .gguf';

  @override
  String get mentorClearPath => 'Убрать путь';

  @override
  String get mentorModelRegistered => 'Путь к модели сохранён';

  @override
  String get mentorSelectedBadge => 'выбрана';

  @override
  String get mentorWeakTitle => 'Устройство может не потянуть';

  @override
  String get mentorWeakBody =>
      'Рекомендуем лёгкую модель (1.5B). 3B может работать медленно и греть телефон.';

  @override
  String get mentorWeakKeepLight => 'Оставить 1.5B';

  @override
  String get mentorWeakUseHeavy => 'Всё равно 3B';

  @override
  String get mentorWeakDeviceToggle => 'Считать устройство слабым';

  @override
  String get mentorWeakDeviceToggleSub => 'Предупреждать при выборе моделей 3B';

  @override
  String get mentorWeakDeviceToggleSubAuto =>
      'Определено по RAM устройства (<6 ГБ). Можно переопределить.';

  @override
  String get mentorWifiOnlyToggle => 'Только Wi‑Fi для загрузки моделей';

  @override
  String get mentorWifiOnlyToggleSub =>
      'Блокировать многогигабайтные загрузки в мобильной сети (рекомендуется)';

  @override
  String get mentorWifiRequiredTitle => 'Нужен Wi‑Fi';

  @override
  String mentorWifiRequiredBody(String size) {
    return 'Модель около $size. Лучше качать по Wi‑Fi, чтобы не сжечь мобильный трафик — или продолжить по сотовой сети.';
  }

  @override
  String get mentorWifiRequiredWait => 'Подождать Wi‑Fi';

  @override
  String get mentorWifiRequiredContinue => 'Качать по мобильной сети';

  @override
  String get mentorDownloadOffline => 'Нет сети.';

  @override
  String get mentorDownloadWifiBlocked =>
      'Загрузка заблокирована: подключите Wi‑Fi или разрешите мобильные данные.';

  @override
  String get mentorLicenseGateTitle => 'Нужна лицензия';

  @override
  String get mentorLicenseGateQwenResearch =>
      'Qwen 2.5 3B — лицензия Research / Tongyi (Alibaba). Перед использованием в бесплатном приложении ознакомьтесь с условиями. Продолжая, вы подтверждаете принятие лицензии на эти веса.';

  @override
  String get mentorLicenseGateLlama =>
      'Llama 3.2 подчиняется Meta Llama 3.2 Community License и Acceptable Use Policy. Продолжая, вы принимаете эти условия. Атрибуция: Built with Llama.';

  @override
  String get mentorLicenseGateAccept => 'Принимаю';

  @override
  String get mentorLicenseGateCancel => 'Отмена';

  @override
  String get mentorLicenseNoticeButton => 'NOTICE / лицензии';

  @override
  String get mentorBuiltWithLlama => 'Built with Llama';

  @override
  String get mentorLicenseNoticeTitle => 'Сторонние уведомления';

  @override
  String get mentorLicenseFootnote =>
      'Qwen 1.5B — Apache 2.0. Qwen 3B — проверьте Research License. Llama 3.2 — Community License; при использовании: Built with Llama.';

  @override
  String get mentorOrderTileTitle => 'О локальном наставнике';

  @override
  String get mentorOrderTileSubtitle => 'Модели, лицензии и очистка аудиенций';

  @override
  String get mentorAboutTitle => 'Локальный наставник';

  @override
  String get mentorAboutBody =>
      'VirtueForge может использовать локальные модели (Qwen 2.5 и/или Meta Llama 3.2) для аудиенций по записям журнала: первый разбор и до трёх коротких продолжений. Инференс на устройстве. Файлы моделей — только по вашему согласию.\n\nДневной лимит новых аудиенций бережёт батарею и нагрев телефона; реплики внутри одной аудиенции лимит не тратят.\n\nBuilt with Llama (если установлена Llama).';

  @override
  String get mentorMemoryEyebrow => 'В памяти устройства';

  @override
  String mentorMemoryHeld(String model) {
    return '$model удерживается после аудиенции — следующий вход быстрее.';
  }

  @override
  String get mentorMemoryHint =>
      'Отпустите веса, если телефон греется или не хватает RAM. Файл на диске останется.';

  @override
  String get mentorMemoryRelease => 'Отпустить из памяти';

  @override
  String get mentorMemoryReleased =>
      'Память освобождена. Файл модели на месте.';

  @override
  String get mentorClearAudiences => 'Очистить сохранённые аудиенции';

  @override
  String get mentorClearAudiencesDone => 'Архив аудиенций очищен';
}
