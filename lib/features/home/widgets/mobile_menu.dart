import 'package:flutter/material.dart';
import 'package:my_cv/features/home/widgets/theme_toggle.dart';

class MobileMenu extends StatelessWidget {
  final ThemeMode themeMode;
  final Future<void> Function(ThemeMode) onThemeChanged;
  final void Function(String id) onTap;

  const MobileMenu({
    required this.onTap,
    required this.onThemeChanged,
    required this.themeMode,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: 'Menu',
      onSelected: (id) => id == 'theme' ? null : onTap(id),
      itemBuilder: (ctx) => [
        const PopupMenuItem(value: 'home', child: Text('Home')),
        const PopupMenuItem(value: 'about', child: Text('About')),
        const PopupMenuItem(value: 'skills', child: Text('Skills')),
        const PopupMenuItem(value: 'projects', child: Text('Projects')),
        const PopupMenuItem(value: 'apps', child: Text('Apps')),
        const PopupMenuItem(value: 'contact', child: Text('Contact')),
        PopupMenuItem(
          enabled: false,
          value: 'theme',
          child: Row(
            children: [
              const Text('Theme'),
              const Spacer(),
              ThemeToggle(themeMode: themeMode, onChanged: onThemeChanged),
            ],
          ),
        ),
      ],
    );
  }
}
