import 'package:binodfolio/features/expense_tracker/widgets/expenses.dart';
import 'package:binodfolio/features/favorite_places/screens/favorite_places.dart';
import 'package:binodfolio/features/meal/screens/tabs.dart';
import 'package:binodfolio/features/my_apps/model/item.dart';
import 'package:binodfolio/features/quiz/quiz.dart';
import 'package:binodfolio/features/shopping_list/screens/shopping_list.dart';
import 'package:binodfolio/features/todo/todo.dart';
import 'package:binodfolio/features/pomodoro/pomodoro.dart';
import 'package:binodfolio/features/breathing/breathing.dart';
import 'package:flutter/material.dart';

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
        const SizedBox(height: 12),
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

            const spacing = 12.0;
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
                      if (item.title == 'Meal') {
                        Navigator.pushNamed(context, '/meal');
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => item.builder(context)),
                        );
                      }
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
      return _AppStyle([Colors.teal, Colors.green], Icons.account_balance_wallet);
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
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: cs.outlineVariant.withOpacity(0.35)),
                boxShadow: _hovering
                    ? [
                        BoxShadow(
                          color: cs.primary.withOpacity(0.18),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 6),
                        ),
                      ],
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: style.colors.first.withOpacity(0.2),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                            ),
                          ],
                          gradient: LinearGradient(
                            colors: style.colors,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.06),
                          border: Border.all(color: Colors.white.withOpacity(0.18)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(style.icon, color: Colors.white, size: 24),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
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
