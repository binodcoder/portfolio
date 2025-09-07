import 'package:binodfolio/features/expense_tracker/widgets/expenses.dart';
import 'package:binodfolio/features/meal/screens/tabs.dart';
import 'package:binodfolio/features/todo/todo.dart';
import 'package:flutter/material.dart';

import '../favorite_places/screens/favorite_places.dart';
import '../shopping_list/screens/shopping_list.dart';
import '../quiz/quiz.dart';
import 'model/item.dart';
import '../pomodoro/pomodoro.dart';

class MyApps extends StatelessWidget {
  final List<AppItem> items = [
    AppItem('Expenses', Icons.attach_money, (_) => Expenses()),
    AppItem('Quiz', Icons.quiz, (_) => Quiz()),
    AppItem('Todo', Icons.task, (_) => Todos()),
    AppItem('Pomodoro', Icons.timer, (_) => const PomodoroApp()),
    AppItem('Meal', Icons.set_meal, (_) => const TabsScreen()),
    AppItem('Shopping List', Icons.shop, (_) => const ShoppingListScreen()),
    AppItem('Favorite Places', Icons.favorite, (_) => FavoritePlaceScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;

          int crossAxisCount = 2; // keep mobile at 2
          if (width >= 600 && width < 900) {
            crossAxisCount = 3;
          } else if (width >= 900 && width < 1200) {
            crossAxisCount = 4;
          } else if (width >= 1200) {
            crossAxisCount = 5;
          }

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.1,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return GestureDetector(
                onTap: () {
                  if (item.title == 'Meal') {
                    Navigator.pushNamed(context, '/meal');
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => item.builder(context)),
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
    );
  }
}
