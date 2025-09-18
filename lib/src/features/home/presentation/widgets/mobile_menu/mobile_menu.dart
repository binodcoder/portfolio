import 'package:binodfolio/src/core/utils/launch_utils.dart';
import 'package:binodfolio/src/features/home/widgets/mobile_menu/menu_item.dart';
import 'package:binodfolio/src/features/home/widgets/theme_toggle.dart';
import 'package:flutter/material.dart';
import 'package:binodfolio/src/core/responsive/sizes.dart';

class MobileMenu extends StatelessWidget {
  final void Function(String id) onTap;

  const MobileMenu({
    super.key,
    required this.onTap,
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
                    left: context.rem(16),
                    right: context.rem(16),
                    top: context.rem(12),
                    bottom: bottomInset + context.rem(12)),
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
                        ThemeToggle(),
                      ],
                    ),
                    SizedBox(height: context.space(8)),
                    MenuItem(label: 'Home', onTap: () => onTap('home')),
                    MenuItem(label: 'About', onTap: () => onTap('about')),
                    MenuItem(label: 'Skills', onTap: () => onTap('skills')),
                    MenuItem(label: 'Projects', onTap: () => onTap('projects')),
                    MenuItem(label: 'Apps', onTap: () => onTap('apps')),
                    MenuItem(label: 'Contact', onTap: () => onTap('contact')),
                    MenuItem(label: 'Media', onTap: () => onTap('media')),
                    const SizedBox(height: 8),
                    FilledButton(
                      onPressed: () => launchUrlSafe(
                          'mailto:binodcoder@gmail.com?subject=Let\'s work together'),
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
