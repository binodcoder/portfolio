import 'package:binodfolio/features/expense_tracker/widgets/expenses.dart';
import 'package:binodfolio/features/favorite_places/screens/favorite_places.dart';
import 'package:binodfolio/features/meal/screens/tabs.dart';
import 'package:binodfolio/features/my_apps/model/item.dart';
import 'package:binodfolio/features/quiz/quiz.dart';
import 'package:binodfolio/features/shopping_list/screens/shopping_list.dart';
import 'package:binodfolio/features/todo/todo.dart';
import 'package:flutter/material.dart';

class AppsSection extends StatelessWidget {
  AppsSection();

  final List<AppItem> items = [
    AppItem('Expenses', Icons.attach_money, Expenses()),
    AppItem('Quiz', Icons.quiz, Quiz()),
    AppItem('Todo', Icons.task, Todos()),
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
        GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: items.map((item) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => item.destination),
                );
              },
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      item.icon,
                      size: 40,
                    ),
                    SizedBox(height: 8),
                    Text(
                      item.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
