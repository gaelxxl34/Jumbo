import 'package:translator/translator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class TranslationService with ChangeNotifier {
  late GoogleTranslator translator;
  String _currentLanguageCode = 'fr'; // Default language
  late SharedPreferences prefs;

  TranslationService() {
    translator = GoogleTranslator();
    _init();
  }

  String get currentLanguageCode => _currentLanguageCode;

  set currentLanguageCode(String newLanguageCode) {
    _currentLanguageCode = newLanguageCode;
    notifyListeners(); // Notify all listening widgets to rebuild
    saveSelectedLanguage(newLanguageCode); // Save the new language to SharedPreferences
  }

  Future<void> _init() async {
    prefs = await SharedPreferences.getInstance();
    await _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    String? storedLanguage = prefs.getString('selectedLanguage');
    if (storedLanguage != null) {
      _currentLanguageCode = storedLanguage;
      notifyListeners(); // Notify listeners in case the language has changed
    } else {
      // If no language is saved, default to French
      await prefs.setString('selectedLanguage', _currentLanguageCode);
    }
  }

  Future<void> saveSelectedLanguage(String languageCode) async {
    await prefs.setString('selectedLanguage', languageCode);
    _currentLanguageCode = languageCode;
    notifyListeners(); // Notify listeners in case the language has changed
  }

  Future<String> translate(String text) async {
    Translation translation = await translator.translate(text, to: _currentLanguageCode);
    return translation.text;
  }
}



class TranslatedText extends StatelessWidget {
  final String textKey;
  final TextStyle? style; // Optional parameter for text style

  TranslatedText(this.textKey, {this.style});

  @override
  Widget build(BuildContext context) {
    final translationService = Provider.of<TranslationService>(context, listen: false);

    return FutureBuilder<String>(
      future: translationService.translate(textKey),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          // Apply the provided style, if any
          return Text(snapshot.data!, style: style);
        } else {
          // Show a progress indicator while the translation is loading
          return CircularProgressIndicator();
        }
      },
    );
  }
}

