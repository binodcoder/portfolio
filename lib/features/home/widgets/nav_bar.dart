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
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow.withOpacity(0.8),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: cs.outlineVariant.withOpacity(0.4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          NavButton(label: 'Home', onTap: () => onTap('home')),
          NavButton(label: 'About', onTap: () => onTap('about')),
          NavButton(label: 'Skills', onTap: () => onTap('skills')),
          NavButton(label: 'Projects', onTap: () => onTap('projects')),
          NavButton(label: 'Apps', onTap: () => onTap('apps')),
          NavButton(label: 'Contact', onTap: () => onTap('contact')),
          const SizedBox(width: 12),
          Container(width: 1, height: 22, color: cs.outlineVariant.withOpacity(0.5)),
          const SizedBox(width: 12),
          ThemeToggle(
            onChanged: onThemeChanged,
            themeMode: themeMode,
          ),
          const SizedBox(width: 8),
          FilledButton(
            onPressed: () => launchUrlSafe(
                'mailto:binodbhandari@gmail.com?subject=Let\'s work together'),
            child: const Text('Hire Me'),
          ),
        ],
      ),
    );
  }
}
