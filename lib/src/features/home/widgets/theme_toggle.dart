import 'package:flutter/material.dart';

class ThemeToggle extends StatelessWidget {
  final ThemeMode themeMode;
  final Future<void> Function(ThemeMode) onChanged;
  const ThemeToggle({required this.themeMode, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final isDark = themeMode == ThemeMode.dark;
    return IconButton(
      tooltip: isDark ? 'Switch to light' : 'Switch to dark',
      icon: Icon(isDark ? Icons.dark_mode : Icons.light_mode),
      onPressed: () => onChanged(isDark ? ThemeMode.light : ThemeMode.dark),
    );
  }
}
