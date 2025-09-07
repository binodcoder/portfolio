import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'core/utils/prefs_helper.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Use path-based URLs on the web so the browser back button works naturally
  // and the address bar reflects navigation (no hash fragment).
  usePathUrlStrategy();
  final initialTheme = await PrefsHelper.getThemeMode();

  runApp(
    ProviderScope(
      child: App(initialThemeMode: initialTheme),
    ),
  );
}
