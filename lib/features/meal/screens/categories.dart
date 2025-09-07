import 'package:binodfolio/features/meal/data/dummy_data.dart';
import 'package:binodfolio/features/meal/models/category.dart';
import 'package:binodfolio/features/meal/widgets/category_grid_item.dart';
import 'package:flutter/material.dart';

import '../models/meal.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    required this.availableMeals,
  });

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).pushNamed(
      '/meal/category',
      arguments: {
        'title': category.title,
        'meals': filteredMeals,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          int columns;
          if (width >= 1200) {
            columns = 5;
          } else if (width >= 900) {
            columns = 4;
          } else if (width >= 400) {
            // Make mobile tiles smaller by using 3 columns on typical phones
            columns = 3;
          } else {
            columns = 2;
          }

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: GridView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  childAspectRatio: 1.1,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 25,
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
                ],
              ),
            ),
          );
        },
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.3),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        ),
        child: child,
      ),
    );
  }
}
