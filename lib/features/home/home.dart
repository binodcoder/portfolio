import 'package:flutter/material.dart';
import 'package:my_cv/features/expense_tracker/widgets/expenses.dart';
import 'package:my_cv/features/meal/screens/tabs.dart';
import 'package:my_cv/features/todo/todo.dart';
import '../../common_widgets/app_bar.dart';
import '../favorite_places/screens/favorite_places.dart';
import '../shopping_list/screens/shopping_list.dart';
import 'widgets/drawer/drawer.dart';
import '../quiz/quiz.dart';
import 'model/home_item.dart';

class Home extends StatelessWidget {
  final List<HomeItem> items = [
    HomeItem('Expenses', Icons.attach_money, Expenses()),
    HomeItem('Quiz', Icons.quiz, Quiz()),
    HomeItem('Todo', Icons.task, Todos()),
    HomeItem('Meal', Icons.set_meal, TabsScreen()),
    HomeItem('Shopping List', Icons.shop, ShoppingListScreen()),
    HomeItem('Favorite Places', Icons.favorite, FavoritePlaceScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: MyDrawer(),
      body: Padding(
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
      ),
    );
  }
}
