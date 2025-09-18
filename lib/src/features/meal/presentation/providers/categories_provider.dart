import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/category.dart';
import '../../data/dummy_data.dart';
import 'filters_provider.dart';
import '../../domain/meal.dart';

/// Exposes the available meal categories.
final categoriesProvider =
    Provider<List<Category>>((ref) => availableCategories);

/// Holds the currently selected category (for viewing meals of a category).
/// Lookup a category by its id.
final categoryByIdProvider = Provider.family<Category?, String>((ref, id) {
  try {
    return availableCategories.firstWhere((c) => c.id == id);
  } catch (_) {
    return null;
  }
});

/// Meals for a specific category (after applying active filters).
final mealsByCategoryProvider = Provider.family<List<Meal>, String>((ref, id) {
  final availableMeals = ref.watch(filteredMealsProvider);
  return availableMeals.where((m) => m.categories.contains(id)).toList();
});
