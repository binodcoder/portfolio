import 'package:binodfolio/src/core/utils/prefs_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeController extends StateNotifier<ThemeMode> {
  ThemeController() : super(ThemeMode.system) {
    loadTheme();
  }

  Future<void> loadTheme() async {
    state = await PrefsHelper.getThemeMode();
  }

  Future<void> setTheme(ThemeMode mode) async {
    state = mode;
    await PrefsHelper.setThemeMode(mode);
  }
}

final themeControllerProvider =
    StateNotifierProvider<ThemeController, ThemeMode>((ref) {
  return ThemeController();
});
