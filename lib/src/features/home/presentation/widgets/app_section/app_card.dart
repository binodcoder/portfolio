import 'package:binodfolio/src/core/responsive/sizes.dart';
import 'package:binodfolio/src/features/home/presentation/widgets/app_section/app_style.dart';
import 'package:flutter/material.dart';

class AppCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const AppCard(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap});

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  bool _hovering = false;

  AppStyle _styleFor(String title, ColorScheme cs) {
    final t = title.toLowerCase();
    if (t.contains('expense')) {
      return AppStyle(
          [Colors.teal, Colors.green], Icons.account_balance_wallet);
    }
    if (t.contains('quiz')) {
      return AppStyle([Colors.deepPurple, Colors.indigo], Icons.quiz);
    }
    if (t.contains('todo')) {
      return AppStyle([Colors.blue, Colors.lightBlue], Icons.checklist);
    }
    if (t.contains('pomodoro')) {
      return AppStyle([Colors.deepOrange, Colors.redAccent], Icons.timer);
    }
    if (t.contains('breath')) {
      return AppStyle([Colors.teal, Colors.cyan], Icons.air);
    }
    if (t.contains('meal')) {
      return AppStyle([Colors.orange, Colors.amber], Icons.restaurant);
    }
    if (t.contains('shopping')) {
      return AppStyle([Colors.blue, Colors.teal], Icons.shopping_cart);
    }
    if (t.contains('favorite') || t.contains('place')) {
      return AppStyle([Colors.pink, Colors.redAccent], Icons.favorite);
    }
    return AppStyle([cs.primary, cs.secondary], Icons.apps);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final style = _styleFor(widget.title, cs);
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 160),
        curve: Curves.easeOut,
        scale: _hovering ? 1.02 : 1.0,
        child: Card(
          elevation: 0,
          color: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              padding: context.insetsAll(14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon style aligned with About section's right-side items
                  Container(
                    width: context.rem(40),
                    height: context.rem(40),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(context.radius(8)),
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      style.icon,
                      size: context.icon(20),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(height: context.space(10)),
                  Text(widget.title,
                      style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
