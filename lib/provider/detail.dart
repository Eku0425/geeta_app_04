import 'package:flutter/material.dart';

class DetailProvider extends ChangeNotifier {
  String selectedLanguage = 'Sanskrit';

  void languageTranslate(String value) {
    selectedLanguage = value;
    notifyListeners();
  }
}
