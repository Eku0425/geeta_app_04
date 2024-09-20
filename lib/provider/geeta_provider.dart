import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../modal/modal.dart';

class Geetaprovider extends ChangeNotifier {
  bool isDark = false;
  void ChangeTheme() {
    isDark = !isDark;
    notifyListeners();
  }

  List<GeetaModal> Geetalist = [];

  Future<void> jsonParsing() async {
    String json =  await rootBundle.loadString('assets/json/shlok.json');
    List photo = jsonDecode(json);
    Geetalist = photo.map((e) => GeetaModal.fromJson(e)).toList();
    notifyListeners();
  }

  Geetaprovider() {
    jsonParsing();
  }
}
