import 'package:flutter/material.dart';
import 'package:granth_flutter/locale/language_kz.dart';
import 'package:granth_flutter/locale/language_ru.dart';
import 'package:granth_flutter/locale/language_en.dart';
import 'package:granth_flutter/locale/languages.dart';
import 'package:nb_utils/nb_utils.dart';

class AppLocalizations extends LocalizationsDelegate<BaseLanguage> {
  const AppLocalizations();

  @override
  Future<BaseLanguage> load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return LanguageEn();
      case 'kk':
        return LanguageKz();
      case 'ru':
        return LanguageRu();
      default:
        return LanguageKz();
    }
  }

  @override
  bool isSupported(Locale locale) =>
      LanguageDataModel.languages().contains(locale.languageCode);

  @override
  bool shouldReload(LocalizationsDelegate<BaseLanguage> old) => false;
}
