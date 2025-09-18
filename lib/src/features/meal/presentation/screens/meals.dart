import 'package:binodfolio/src/features/meal/domain/meal.dart';
import 'package:binodfolio/src/features/meal/presentation/widgets/meal_item.dart';
import 'package:binodfolio/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
  });

  final String? title;
  final List<Meal> meals;

  void selectMeal(BuildContext context, Meal meal) {
    // Navigator.of(context).pushNamed(
    //   '/meal/details',
    //   arguments: meal,
    // );
    context.pushNamed(
      AppRoute.mealDetails.name,
      extra: {
        'meal': meal,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
          const SizedBox(
            height: 16,
          ),
          Text(
            'Try selecting a different category!',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onSurface),
          )
        ],
      ),
    );

    if (meals.isNotEmpty) {
      final width = MediaQuery.sizeOf(context).width;

      if (width >= 900) {
        // On web / wide screens show a responsive grid
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
            onSelectMeal: (meal) => selectMeal(context, meal),
          ),
        );
      } else {
        // On narrow screens, keep a list but constrain item width for web
        content = ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx, index) => Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: MealItem(
                meal: meals[index],
                onSelectMeal: (meal) => selectMeal(context, meal),
              ),
            ),
          ),
        );
      }
    }
    if (title == null) {
      return content;
    }
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  // if (Navigator.of(context).canPop()) ...[
                  //   const InAppBackButton(),
                  //   const SizedBox(width: 8),
                  // ],
                  Text(
                    title!,
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
