import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode theme = ThemeMode.light;
  String textTheme = 'light';

  onChangeTheme() async {
    if (theme == ThemeMode.light) {
      theme = ThemeMode.dark;
      textTheme = 'dark';
    } else {
      theme = ThemeMode.light;
      textTheme = 'light';
    }

    var pref = await SharedPreferences.getInstance();
    pref.setString('textTheme', textTheme);

    notifyListeners();
  }

  getThemePref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    textTheme = pref.getString('textTheme') ?? 'light';

    if (textTheme == 'light') {
      theme = ThemeMode.light;
    } else {
      theme = ThemeMode.dark;
    }

    notifyListeners();
  }
}
