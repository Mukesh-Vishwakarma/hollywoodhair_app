import 'dart:ui';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hollywood_hair/util/lang/pl.dart';
import 'en.dart';
import 'es.dart';

class LocalizationService extends Translations {
  final _box = GetStorage();
  final _key = 'lang';

  // Default locale
  static const Locale fallbackLocale = Locale('en', 'US');
  late Locale _locale;

  // Supported languages
  static final List<String> supportedLanguages = ['en', 'ge'];

  // Supported locales
  static final List<Locale> supportedLocales = [
    const Locale('en', 'US'),
    const Locale('es', 'SP'),
    const Locale('pl', 'PL'),
  ];

  LocalizationService() {
    // Initialize the locale from the storage
    _locale = Locale(loadLangFromBox());
    // Load the translations for the current locale
    _loadTranslations();
  }

  Locale get locale => _locale;

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en_US,
        'se_SP': es_SP,
        'pl_PL': pl_PL,
      };

  // Change the locale and save it to storage
  Future<void> changeLocale(Locale newLocale) async {
    _locale = newLocale;
    saveLangToBox(newLocale.languageCode);
    await Get.updateLocale(newLocale);
  }

  String loadLangFromBox() => _box.read(_key) ?? fallbackLocale.languageCode;

  saveLangToBox(String lang) => _box.write(_key, lang);

  _loadTranslations() {
    // Implement loading translations based on the current locale if needed
    // You can load translations from your language files here
  }
}
