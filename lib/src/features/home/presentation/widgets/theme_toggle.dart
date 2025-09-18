import 'package:binodfolio/src/core/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeToggle extends ConsumerWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeControllerProvider);

    final isDark = themeMode == ThemeMode.dark;
    return IconButton(
      tooltip: isDark ? 'Switch to light' : 'Switch to dark',
      icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
      onPressed: () => ref.read(themeControllerProvider.notifier).setTheme(
            isDark ? ThemeMode.light : ThemeMode.dark,
          ),
    );
  }
}
