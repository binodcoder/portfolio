import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_cv/features/intro/intro_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 96, 59, 181),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Color.fromARGB(255, 5, 99, 125),
);

ThemeData theme = ThemeData().copyWith(
  colorScheme: kColorScheme,
  appBarTheme: AppBarTheme().copyWith(
    backgroundColor: kColorScheme.onPrimaryContainer,
    foregroundColor: kColorScheme.primaryContainer,
  ),
  cardTheme: CardTheme().copyWith(
    color: kColorScheme.primaryContainer,
    margin: EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kColorScheme.primaryContainer,
    ),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
  iconTheme: IconThemeData().copyWith(
    color: kColorScheme.onPrimaryContainer,
  ),
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  colorScheme: kDarkColorScheme,
  cardTheme: CardTheme().copyWith(
    color: kDarkColorScheme.secondaryContainer,
    margin: EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 8,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kDarkColorScheme.primaryContainer,
      foregroundColor: kDarkColorScheme.onPrimaryContainer,
    ),
  ),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final saved = prefs.getString('themeMode');
  final initial = (saved == 'dark')
      ? ThemeMode.dark
      : (saved == 'light')
          ? ThemeMode.light
          : ThemeMode.system;
  runApp(
    ProviderScope(
      child: App(
        initialThemeMode: initial,
      ),
    ),
  );
}

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
        value = 'system';
        break;
    }
    await prefs.setString('themeMode', value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      darkTheme: darkTheme,
      themeMode: _mode,
      home: HomePage(
        onThemeChanged: _setTheme,
        themeMode: _mode,
      ),
    );
  }
}
