import 'package:binodfolio/src/core/theme/theme_controller.dart';
import 'package:binodfolio/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme/app_theme.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeMode mode = ref.watch(themeControllerProvider);
    final goRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: mode,
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
      // routes: {
      //   '/': (ctx) => HomePage(),
      // },
      // onGenerateRoute: (settings) {
      //   switch (settings.name) {
      //     case '/meal/category':
      //       final args = settings.arguments as Map<String, dynamic>;
      //       return MaterialPageRoute(
      //         builder: (_) => MealsScreen(
      //           title: args['title'] as String?,
      //           meals: args['meals'] as List<Meal>,
      //         ),
      //         settings: settings,
      //       );
      //     case '/meal/details':
      //       final meal = settings.arguments as Meal;
      //       return MaterialPageRoute(
      //         builder: (_) => MealDetailScreen(meal: meal),
      //         settings: settings,
      //       );
      //     case '/meal/filters':
      //       return MaterialPageRoute(
      //         builder: (_) => const FiltersScreen(),
      //         settings: settings,
      //       );
      //   }
      //   return null;
      // },
    );
  }
}
