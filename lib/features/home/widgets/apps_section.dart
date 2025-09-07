import 'package:binodfolio/features/expense_tracker/widgets/expenses.dart';
import 'package:binodfolio/features/favorite_places/screens/favorite_places.dart';
import 'package:binodfolio/features/meal/screens/tabs.dart';
import 'package:binodfolio/features/my_apps/model/item.dart';
import 'package:binodfolio/features/quiz/quiz.dart';
import 'package:binodfolio/features/shopping_list/screens/shopping_list.dart';
import 'package:binodfolio/features/todo/todo.dart';
import 'package:binodfolio/features/pomodoro/pomodoro.dart';
import 'package:flutter/material.dart';

class AppsSection extends StatelessWidget {
  AppsSection();

  final List<AppItem> items = [
    AppItem('Expenses', Icons.attach_money, Expenses()),
    AppItem('Quiz', Icons.quiz, Quiz()),
    AppItem('Todo', Icons.task, Todos()),
    AppItem('Pomodoro', Icons.timer, PomodoroApp()),
    AppItem('Meal', Icons.set_meal, TabsScreen()),
    AppItem('Shopping List', Icons.shop, ShoppingListScreen()),
    AppItem('Favorite Places', Icons.favorite, FavoritePlaceScreen()),
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

            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                // Slightly tighter aspect to avoid overly tall cards on web.
                childAspectRatio: 1.1,
              ),
              itemBuilder: (context, index) {
                final item = items[index];
                return GestureDetector(
                  onTap: () {
                    if (item.title == 'Meal') {
                      Navigator.pushNamed(context, '/meal');
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => item.destination),
                      );
                    }
                  },
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          item.icon,
                          size: 40,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item.title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
