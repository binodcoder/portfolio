import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/meal.dart';
import 'meals_provider.dart';

/// Stores favorite meals as a set of meal IDs for stability across instances.
class FavoriteMealNotifier extends StateNotifier<Set<String>> {
  FavoriteMealNotifier() : super(<String>{});

  bool toggleMealFavoriteStatus(String mealId) {
    final isFav = state.contains(mealId);
    if (isFav) {
      final next = {...state}..remove(mealId);
      state = next;
      return false;
    } else {
      final next = {...state}..add(mealId);
      state = next;
      return true;
    }
  }
}

/// Exposes the set of favorite meal IDs.
final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealNotifier, Set<String>>((ref) {
  return FavoriteMealNotifier();
});

/// Maps favorite IDs to Meal objects from the full meals list.
final favoriteMealsListProvider = Provider<List<Meal>>((ref) {
  final ids = ref.watch(favoriteMealsProvider);
  final all = ref.watch(mealsProvider);
  return all.where((m) => ids.contains(m.id)).toList();
});
