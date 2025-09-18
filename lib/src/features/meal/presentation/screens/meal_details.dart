import 'package:binodfolio/src/features/meal/presentation/providers/favorites_provider.dart';
import 'package:binodfolio/src/features/meal/presentation/providers/meals_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealDetailScreen extends ConsumerWidget {
  const MealDetailScreen({
    super.key,
    required this.mealId,
  });

  final String mealId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meal = ref.watch(mealByIdProvider(mealId));
    if (meal == null) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: Text(
              'Meal not found',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
      );
    }
    final favoriteIds = ref.watch(favoriteMealsProvider);
    final isFavorite = favoriteIds.contains(meal.id);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Row(
                      children: [
                        // if (Navigator.of(context).canPop()) ...[
                        //   const InAppBackButton(),
                        //   const SizedBox(width: 8),
                        // ],
                        Expanded(
                          child: Text(
                            meal.title,
                            style: Theme.of(context).textTheme.titleLarge,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            final wasAdded = ref
                                .read(favoriteMealsProvider.notifier)
                                .toggleMealFavoriteStatus(meal.id);

                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  wasAdded
                                      ? 'Meal added as a favorite'
                                      : 'Meal removed',
                                ),
                              ),
                            );
                          },
                          icon: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (child, animation) {
                              return RotationTransition(
                                turns: Tween<double>(begin: 0.8, end: 1)
                                    .animate(animation),
                                child: child,
                              );
                            },
                            child: Icon(
                              isFavorite ? Icons.star : Icons.star_border,
                              key: ValueKey(isFavorite),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Hero(
                    tag: meal.id,
                    child: Image.network(
                      meal.imageUrl,
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Text(
                    'Ingredients',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  for (final ingredient in meal.ingredients)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '• $ingredient',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    'Steps',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  for (final step in meal.steps)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          step,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
