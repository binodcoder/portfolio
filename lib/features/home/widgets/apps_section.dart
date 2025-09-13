import 'package:binodfolio/features/expense_tracker/widgets/expenses.dart';
import 'package:binodfolio/features/favorite_places/screens/favorite_places.dart';
import 'package:binodfolio/features/home/models/app_item.dart';
import 'package:binodfolio/features/meal/screens/tabs.dart';
import 'package:binodfolio/features/quiz/quiz.dart';
import 'package:binodfolio/features/shopping_list/screens/shopping_list.dart';
import 'package:binodfolio/features/todo/todo.dart';
import 'package:binodfolio/features/pomodoro/pomodoro.dart';
import 'package:binodfolio/features/breathing/breathing.dart';
import 'package:flutter/material.dart';
import 'package:binodfolio/core/responsive/sizes.dart';

class AppsSection extends StatelessWidget {
  AppsSection();

  final List<AppItem> items = [
    AppItem('Expenses', Icons.attach_money, (_) => Expenses()),
    AppItem('Quiz', Icons.quiz, (_) => Quiz()),
    AppItem('Todo', Icons.task, (_) => Todos()),
    AppItem('Pomodoro', Icons.timer, (_) => const PomodoroApp()),
    AppItem('Breathing', Icons.self_improvement, (_) => const BreathingApp()),
    AppItem('Meal', Icons.set_meal, (_) => const TabsScreen()),
    AppItem('Shopping List', Icons.shop, (_) => const ShoppingListScreen()),
    AppItem('Favorite Places', Icons.favorite, (_) => FavoritePlaceScreen()),
  ];
  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Apps',
            style: t.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
        SizedBox(height: context.space(10)),
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;

            // Keep mobile at 2 columns; scale up columns for wider screens.
            int crossAxisCount = 2; // default for mobile
            if (width >= 600 && width < 900) {
              crossAxisCount = 3;
            } else if (width >= 900 && width < 1200) {
              crossAxisCount = 4;
            } else if (width >= 1200) {
              crossAxisCount = 5;
            }

            final spacing = context.space(16);
            final itemWidth =
                (width - spacing * (crossAxisCount - 1)) / crossAxisCount;
            return Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: items.map((item) {
                return SizedBox(
                  width: itemWidth,
                  child: _AppCard(
                    icon: item.icon,
                    title: item.title,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => item.builder(context)),
                      );
                    },
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}

class _AppCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  const _AppCard(
      {required this.icon, required this.title, required this.onTap});

  @override
  State<_AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<_AppCard> {
  bool _hovering = false;

  _AppStyle _styleFor(String title, ColorScheme cs) {
    final t = title.toLowerCase();
    if (t.contains('expense')) {
      return _AppStyle(
          [Colors.teal, Colors.green], Icons.account_balance_wallet);
    }
    if (t.contains('quiz')) {
      return _AppStyle([Colors.deepPurple, Colors.indigo], Icons.quiz);
    }
    if (t.contains('todo')) {
      return _AppStyle([Colors.blue, Colors.lightBlue], Icons.checklist);
    }
    if (t.contains('pomodoro')) {
      return _AppStyle([Colors.deepOrange, Colors.redAccent], Icons.timer);
    }
    if (t.contains('breath')) {
      return _AppStyle([Colors.teal, Colors.cyan], Icons.air);
    }
    if (t.contains('meal')) {
      return _AppStyle([Colors.orange, Colors.amber], Icons.restaurant);
    }
    if (t.contains('shopping')) {
      return _AppStyle([Colors.blue, Colors.teal], Icons.shopping_cart);
    }
    if (t.contains('favorite') || t.contains('place')) {
      return _AppStyle([Colors.pink, Colors.redAccent], Icons.favorite);
    }
    return _AppStyle([cs.primary, cs.secondary], Icons.apps);
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

class _AppStyle {
  final List<Color> colors;
  final IconData icon;
  const _AppStyle(this.colors, this.icon);
}
