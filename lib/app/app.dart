import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../core/utils/prefs_helper.dart';
import '../features/home/home_page.dart';

class App extends StatefulWidget {
  final ThemeMode initialThemeMode;
  const App({super.key, required this.initialThemeMode});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late ThemeMode _mode;

  @override
  void initState() {
    super.initState();
    _mode = widget.initialThemeMode;
  }

  Future<void> _setTheme(ThemeMode mode) async {
    setState(() => _mode = mode);
    await PrefsHelper.setThemeMode(mode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _mode,
      home: HomePage(
        onThemeChanged: _setTheme,
        themeMode: _mode,
      ),
    );
  }
}
