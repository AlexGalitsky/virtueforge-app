import 'package:flutter/widgets.dart';
import 'package:virtue_forge/generated/l10n/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

/// Резолвер ключей сида БД и week-номеров Франклина → локализованные строки.
extension CatalogLocalizations on AppLocalizations {
  List<String> get weekdayShortLabels => [
        dayMon,
        dayTue,
        dayWed,
        dayThu,
        dayFri,
        daySat,
        daySun,
      ];

  String resolveCatalogKey(String key) {
    switch (key) {
      case 'stoicTemperance':
        return stoicTemperance;
      case 'stoicTemperanceDesc':
        return stoicTemperanceDesc;
      case 'stoicWisdom':
        return stoicWisdom;
      case 'stoicWisdomDesc':
        return stoicWisdomDesc;
      case 'stoicCourage':
        return stoicCourage;
      case 'stoicCourageDesc':
        return stoicCourageDesc;
      case 'stoicJustice':
        return stoicJustice;
      case 'stoicJusticeDesc':
        return stoicJusticeDesc;
      case 'virtueAbstinence':
        return virtueAbstinence;
      case 'virtueAbstinenceDesc':
        return virtueAbstinenceDesc;
      case 'virtueSilence':
        return virtueSilence;
      case 'virtueSilenceDesc':
        return virtueSilenceDesc;
      case 'virtueOrder':
        return virtueOrder;
      case 'virtueOrderDesc':
        return virtueOrderDesc;
      case 'virtueResolution':
        return virtueResolution;
      case 'virtueResolutionDesc':
        return virtueResolutionDesc;
      case 'virtueFrugality':
        return virtueFrugality;
      case 'virtueFrugalityDesc':
        return virtueFrugalityDesc;
      case 'virtueIndustry':
        return virtueIndustry;
      case 'virtueIndustryDesc':
        return virtueIndustryDesc;
      case 'virtueSincerity':
        return virtueSincerity;
      case 'virtueSincerityDesc':
        return virtueSincerityDesc;
      case 'virtueJustice':
        return virtueJustice;
      case 'virtueJusticeDesc':
        return virtueJusticeDesc;
      case 'virtueModeration':
        return virtueModeration;
      case 'virtueModerationDesc':
        return virtueModerationDesc;
      case 'virtueCleanliness':
        return virtueCleanliness;
      case 'virtueCleanlinessDesc':
        return virtueCleanlinessDesc;
      case 'virtueTranquility':
        return virtueTranquility;
      case 'virtueTranquilityDesc':
        return virtueTranquilityDesc;
      case 'virtueChastity':
        return virtueChastity;
      case 'virtueChastityDesc':
        return virtueChastityDesc;
      case 'virtueHumility':
        return virtueHumility;
      case 'virtueHumilityDesc':
        return virtueHumilityDesc;
      case 'authorSeneca':
        return authorSeneca;
      case 'authorMarcus':
        return authorMarcus;
      case 'authorEpictetus':
        return authorEpictetus;
      case 'essaySenecaTitle':
        return essaySenecaTitle;
      case 'essaySenecaSnippet':
        return essaySenecaSnippet;
      case 'essayMarcusTitle':
        return essayMarcusTitle;
      case 'essayMarcusSnippet':
        return essayMarcusSnippet;
      case 'essayEpictetusTitle':
        return essayEpictetusTitle;
      case 'essayEpictetusSnippet':
        return essayEpictetusSnippet;
      case 'authorSeneca':
        return authorSeneca;
      case 'authorMarcus':
        return authorMarcus;
      case 'authorEpictetus':
        return authorEpictetus;
      default:
        return key;
    }
  }

  /// Имя добродетели Франклина по номеру недели цикла (1–13).
  String franklinVirtueName(int weekNumber) {
    switch (weekNumber) {
      case 1:
        return virtueAbstinence;
      case 2:
        return virtueSilence;
      case 3:
        return virtueOrder;
      case 4:
        return virtueResolution;
      case 5:
        return virtueFrugality;
      case 6:
        return virtueIndustry;
      case 7:
        return virtueSincerity;
      case 8:
        return virtueJustice;
      case 9:
        return virtueModeration;
      case 10:
        return virtueCleanliness;
      case 11:
        return virtueTranquility;
      case 12:
        return virtueChastity;
      case 13:
        return virtueHumility;
      default:
        return '';
    }
  }
}
