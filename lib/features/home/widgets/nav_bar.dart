import 'package:binodfolio/core/utils/launch_utils.dart';
import 'package:binodfolio/features/home/widgets/nav_button.dart';
import 'package:binodfolio/features/home/widgets/theme_toggle.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final void Function(String id) onTap;
  final Future<void> Function(ThemeMode) onThemeChanged;
  final ThemeMode themeMode;

  const NavBar({
    required this.onTap,
    required this.onThemeChanged,
    required this.themeMode,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NavButton(label: 'Home', onTap: () => onTap('home')),
        NavButton(label: 'About', onTap: () => onTap('about')),
        NavButton(label: 'Skills', onTap: () => onTap('skills')),
        NavButton(label: 'Projects', onTap: () => onTap('projects')),
        NavButton(label: 'Apps', onTap: () => onTap('apps')),
        NavButton(label: 'Contact', onTap: () => onTap('contact')),
        const SizedBox(width: 16),
        ThemeToggle(
          onChanged: onThemeChanged,
          themeMode: themeMode,
        ),
        const SizedBox(width: 8),
        FilledButton.tonal(
          onPressed: () => launchUrlSafe(
              'mailto:binodbhandari@gmail.com?subject=Let\'s work together'),
          child: const Text('Hire Me'),
        ),
      ],
    );
  }
}
