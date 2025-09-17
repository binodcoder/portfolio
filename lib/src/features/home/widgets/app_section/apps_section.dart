import 'package:binodfolio/features/expense_tracker/widgets/expenses.dart';
import 'package:binodfolio/features/favorite_places/screens/favorite_places.dart';
import 'package:binodfolio/features/home/models/app_item.dart';
import 'package:binodfolio/features/home/widgets/app_section/app_card.dart';
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
                  child: AppCard(
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
