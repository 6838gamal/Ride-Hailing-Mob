import 'package:flutter/material.dart';

enum AppThemeMode { light, dark, system }

class AppProvider extends ChangeNotifier {
  AppThemeMode _themeMode = AppThemeMode.light;
  bool _isLoggedIn = false;
  bool _onboardingDone = false;
  String _locale = 'en';

  AppThemeMode get themeMode => _themeMode;
  bool get isLoggedIn => _isLoggedIn;
  bool get onboardingDone => _onboardingDone;
  String get locale => _locale;
  bool get isArabic => _locale == 'ar';

  void setThemeMode(AppThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  void setLoggedIn(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  void setOnboardingDone(bool value) {
    _onboardingDone = value;
    notifyListeners();
  }

  void toggleLocale() {
    _locale = _locale == 'en' ? 'ar' : 'en';
    notifyListeners();
  }
}
