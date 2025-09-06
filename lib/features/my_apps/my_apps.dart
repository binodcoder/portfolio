import 'package:flutter/material.dart';
import 'package:my_cv/features/expense_tracker/widgets/expenses.dart';
import 'package:my_cv/features/meal/screens/tabs.dart';
import 'package:my_cv/features/todo/todo.dart';
import '../favorite_places/screens/favorite_places.dart';
import '../shopping_list/screens/shopping_list.dart';
import '../quiz/quiz.dart';
import 'model/item.dart';

class MyApps extends StatelessWidget {
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
    return
        //Scaffold(
        // appBar: CustomAppBar(),
        // drawer: MyDrawer(),
        //body:
        Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
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
      //  ),
    );
  }
}
