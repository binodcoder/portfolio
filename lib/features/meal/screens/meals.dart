import 'package:flutter/material.dart';
import 'package:my_cv/features/meal/models/meal.dart';
import 'package:my_cv/features/meal/widgets/meal_item.dart';

import 'meal_detail_screen.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    required this.title,
    required this.meals,
  });

  final String title;
  final List<Meal> meals;

  void _onMealSelected(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailScreen(
          meal: meal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        children: [
          for (final m in meals)
            MealItem(
              meal: m,
              onMealSelected: () => _onMealSelected(context, m),
            ),
        ],
      ),
    );
  }
}
