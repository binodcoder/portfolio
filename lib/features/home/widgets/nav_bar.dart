import 'package:binodfolio/core/utils/launch_utils.dart';
import 'package:binodfolio/features/home/widgets/nav_button.dart';
import 'package:binodfolio/features/home/widgets/theme_toggle.dart';
import 'package:flutter/material.dart';
import 'package:binodfolio/core/responsive/sizes.dart';

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
      padding: context.insetsSymmetric(h: 12, v: 8),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(context.radius(32)),
        border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: context.rem(18),
            offset: Offset(0, context.rem(6)),
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
          SizedBox(width: context.space(12)),
          Container(width: 1, height: context.rem(22), color: cs.outlineVariant.withValues(alpha: 0.5)),
          SizedBox(width: context.space(12)),
          ThemeToggle(
            onChanged: onThemeChanged,
            themeMode: themeMode,
          ),
          SizedBox(width: context.space(8)),
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
