import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsModel with ChangeNotifier {
  SettingsModel({
    this.defaultThemeMode,
    this.defaultFontScale,
  }) {
    setup();
  }

  String defaultThemeMode;
  double defaultFontScale;

  void setup() {
    _themeMode = defaultThemeMode;
    _fontScale = defaultFontScale;
    notifyListeners();
  }

  String _themeMode = 'system';
  String get themeMode => _themeMode;
    
  // ignore: avoid_void_async
  void updateThemeMode(String value) async {
    _themeMode = value;
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', value);
  }

  double _fontScale = 1;
  double get fontScale => _fontScale;
  
  // ignore: avoid_void_async
  void updateFontScale(double value) async {
    _fontScale = value;
    notifyListeners();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('fontScale', value);
  }
}
