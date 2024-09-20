import 'package:flutter/material.dart';

class LangugeProvider extends ChangeNotifier {
  int LanguageIndex = 0;

  void translateLanguage() {
    if (LanguageIndex < 3) {
      LanguageIndex++;
      notifyListeners();
    } else {
      notifyListeners();
      LanguageIndex = 0;
    }
  }
}
