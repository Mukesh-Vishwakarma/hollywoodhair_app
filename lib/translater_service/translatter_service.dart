import 'dart:ui';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mlkit_translation/google_mlkit_translation.dart';

import '../model/lang_model.dart';
import '../util/app_constants.dart';

class TranslationService  extends GetxController {
  late final TranslateLanguage sourceLanguage;

  TranslationService({this.sourceLanguage = TranslateLanguage.polish});


  @override
  void onInit() {
    super.onInit();
  }


  Future<String?> translate(String sourceText, TranslateLanguage targetLanguage) async {

    final onDeviceTranslator = OnDeviceTranslator(
      sourceLanguage: sourceLanguage,
      targetLanguage: targetLanguage,
    );

    if (sourceText.isNotEmpty) {
      try {
        final translation = await onDeviceTranslator.translateText(sourceText);
        onDeviceTranslator.close(); // Close the translator when done
        return translation;
      } catch (e) {
        print("Translation error: $e");
      }
    }
    onDeviceTranslator.close(); // Close the translator in case of an error
    return null;
  }

}


// final TranslationService translationService = TranslationService();
//
// final translatedText = await translationService.translate("Hello, world!", TranslateLanguage.french);
// if (translatedText != null) {
// // Do something with the translated text
// } else {
// // Handle the case where translation failed
// }