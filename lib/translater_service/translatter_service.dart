import 'package:google_mlkit_translation/google_mlkit_translation.dart';

class TranslationService {
  final TranslateLanguage sourceLanguage;

  TranslationService({this.sourceLanguage = TranslateLanguage.polish});

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