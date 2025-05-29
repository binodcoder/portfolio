import 'package:flutter/material.dart';
import 'package:my_cv/features/meal/data/dummy_data.dart';
import 'package:my_cv/features/meal/models/category.dart';
import 'package:my_cv/features/meal/screens/meals.dart';
import 'package:my_cv/features/meal/widgets/category_grid_item.dart';
import '../models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.availableMeals,
  });

  final List<Meal> availableMeals;

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () => _selectCategory(
              context,
              category,
            ),
          )
        // availableCategories
        //     .map((category) => CategoryGridItem(category: category))
        //     .toList()
      ],
    );
  }
}
