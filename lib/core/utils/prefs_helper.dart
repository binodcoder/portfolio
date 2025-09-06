import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper {
  static const _themeKey = 'themeMode';

  static Future<ThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_themeKey);

    switch (saved) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  static Future<void> setThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    final value;
    switch (mode) {
      case ThemeMode.dark:
        value = 'dark';
        break;
      case ThemeMode.light:
        value = 'light';
        break;
      case ThemeMode.system:
      default:
        value = 'system';
        break;
    }
    await prefs.setString(_themeKey, value);
  }
}
