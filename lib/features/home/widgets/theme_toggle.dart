import 'package:flutter/material.dart';

class ThemeToggle extends StatelessWidget {
  final ThemeMode themeMode;
  final Future<void> Function(ThemeMode) onChanged;
  const ThemeToggle({required this.themeMode, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<ThemeMode>(
      segments: const [
        ButtonSegment(value: ThemeMode.light, label: Text('☀️')),
        ButtonSegment(value: ThemeMode.dark, label: Text('🌙')),
      ],
      selected: {themeMode == ThemeMode.system ? ThemeMode.light : themeMode},
      onSelectionChanged: (s) => onChanged(s.first),
      showSelectedIcon: false,
    );
  }
}
