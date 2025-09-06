import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/utils/prefs_helper.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final initialTheme = await PrefsHelper.getThemeMode();

  runApp(
    ProviderScope(
      child: App(initialThemeMode: initialTheme),
    ),
  );
}
