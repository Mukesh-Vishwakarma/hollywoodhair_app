import 'dart:ui';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hollywood_hair/model/lang_model.dart';

import '../../../../../util/app_constants.dart';
import '../../../../../util/lang/localization_service.dart';

class LanguagesController extends GetxController {
  var languageList = <LanguageModel>[].obs;
  var selectLang =
      LanguageModel(name: "English", locale: const Locale('en', 'US'))
          .obs; // Initialize with English.

  @override
  void onInit() {
    languageList.value = [
      LanguageModel(name: "English", locale: const Locale('en', 'US')),
      LanguageModel(name: "Polski", locale: const Locale('pl', 'PL')),
      LanguageModel(name: "Español", locale: const Locale('es', 'ES')),
    ];
    getLanguage();
    super.onInit();
  }

  void changeLanguage(LanguageModel selectedLanguage) {
    selectLang.value = selectedLanguage;
    print("jshdbjsdf===>1 ${selectedLanguage.name}");

    GetStorage().write(AppConstants.languageCode, selectedLanguage.name);
    LocalizationService().changeLocale(selectedLanguage.locale!);

    // No need to compare selectedLanguage to strings, just update the selectLang.
  }

  getLanguage() async {
    final languageCode = GetStorage().read(AppConstants.languageCode);
    if (languageCode != null) {
      if (languageCode == "English") {
        selectLang.value =
            LanguageModel(name: "English", locale: const Locale('en', 'US'));
      } else if (languageCode == "Polski") {
        selectLang.value =
            LanguageModel(name: "Polski", locale: const Locale('pl', 'PL'));
      } else {
        selectLang.value =
            LanguageModel(name: "Español", locale: const Locale('es', 'ES'));
      }
    }
  }
}
