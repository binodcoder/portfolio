import 'package:binodfolio/core/utils/launch_utils.dart';
import 'package:binodfolio/features/home/widgets/theme_toggle.dart';
import 'package:flutter/material.dart';

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
    return IconButton(
      tooltip: 'Menu',
      icon: const Icon(Icons.menu),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          showDragHandle: true,
          builder: (ctx) {
            final bottomInset = MediaQuery.of(ctx).viewInsets.bottom;
            return SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    left: 16, right: 16, top: 12, bottom: bottomInset + 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Menu',
                            style: Theme.of(ctx)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.w800)),
                        const Spacer(),
                        ThemeToggle(
                          themeMode: themeMode,
                          onChanged: (mode) async {
                            Navigator.of(ctx).pop();
                            await onThemeChanged(mode);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _MenuItem(label: 'Home', onTap: () => onTap('home')),
                    _MenuItem(label: 'About', onTap: () => onTap('about')),
                    _MenuItem(label: 'Skills', onTap: () => onTap('skills')),
                    _MenuItem(
                        label: 'Projects', onTap: () => onTap('projects')),
                    _MenuItem(label: 'Apps', onTap: () => onTap('apps')),
                    _MenuItem(label: 'Contact', onTap: () => onTap('contact')),
                    const SizedBox(height: 8),
                    FilledButton(
                      onPressed: () => launchUrlSafe(
                          'mailto:binodbhandari@gmail.com?subject=Let\'s work together'),
                      child: const Text('Hire Me'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _MenuItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _MenuItem({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      title: Text(label,
          style: t.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
      trailing: Icon(Icons.chevron_right, color: cs.outline),
      onTap: () {
        Navigator.of(context).pop();
        // Trigger after sheet closes for smoothness
        WidgetsBinding.instance.addPostFrameCallback((_) => onTap());
      },
    );
  }
}
