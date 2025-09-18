import 'package:binodfolio/src/features/meal/providers/categories_provider.dart';
import 'package:binodfolio/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/meal_item.dart';
import 'package:go_router/go_router.dart';

class CategoryMealsScreen extends ConsumerWidget {
  const CategoryMealsScreen({
    super.key,
    required this.categoryId,
  });

  final String categoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(categoryByIdProvider(categoryId));
    final meals = ref.watch(mealsByCategoryProvider(categoryId));

    final title = category?.title;

    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Uh oh ... nothing here!',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'Try selecting a different category!',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
        ],
      ),
    );

    void selectMeal(String mealId) {
      context.goNamed(
        AppRoute.mealDetails.name,
        pathParameters: {'mealId': mealId},
      );
    }

    if (meals.isNotEmpty) {
      final width = MediaQuery.sizeOf(context).width;
      if (width >= 900) {
        content = GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 500,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: meals.length,
          itemBuilder: (ctx, index) => MealItem(
            meal: meals[index],
            onSelectMeal: (meal) => selectMeal(meal.id),
          ),
        );
      } else {
        content = ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx, index) => Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: MealItem(
                meal: meals[index],
                onSelectMeal: (meal) => selectMeal(meal.id),
              ),
            ),
          ),
        );
      }
    }

    if (title == null) return content;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(child: content),
          ],
        ),
      ),
    );
  }
}
