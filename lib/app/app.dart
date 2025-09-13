import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../core/utils/prefs_helper.dart';
import '../features/home/home_page.dart';
import '../features/meal/screens/meals.dart';
import '../features/meal/screens/meal_details.dart';
import '../features/meal/screens/filters.dart';
import '../features/meal/models/meal.dart';

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
      // Clamp system text scaling and apply responsive typography
      builder: (context, child) {
        final mq = MediaQuery.of(context);
        final size = mq.size;
        // Baseline width for phone design (e.g., iPhone 12/13 = 390)
        const baselineWidth = 390.0;
        // Scale typography relative to width, softly clamped to avoid extremes
        final widthScale = (size.width / baselineWidth).clamp(0.90, 1.15);

        // Respect user scaling but clamp to reduce overflow on very large settings
        final clampedTextScale =
            mq.textScaler.clamp(minScaleFactor: 0.90, maxScaleFactor: 1.20);

        // Start from current theme and scale its text + icon themes
        final baseTheme = Theme.of(context);
        final scaled = baseTheme.copyWith(
          textTheme: baseTheme.textTheme.apply(fontSizeFactor: widthScale),
          iconTheme: baseTheme.iconTheme.copyWith(
            size: (baseTheme.iconTheme.size ?? 24) * widthScale,
          ),
        );

        return MediaQuery(
          data: mq.copyWith(textScaler: clampedTextScale),
          child: Theme(data: scaled, child: child!),
        );
      },
      routes: {
        '/': (ctx) => HomePage(
              onThemeChanged: _setTheme,
              themeMode: _mode,
            ),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/meal/category':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (_) => MealsScreen(
                title: args['title'] as String?,
                meals: args['meals'] as List<Meal>,
              ),
              settings: settings,
            );
          case '/meal/details':
            final meal = settings.arguments as Meal;
            return MaterialPageRoute(
              builder: (_) => MealDetailScreen(meal: meal),
              settings: settings,
            );
          case '/meal/filters':
            return MaterialPageRoute(
              builder: (_) => const FiltersScreen(),
              settings: settings,
            );
        }
        return null;
      },
    );
  }
}
