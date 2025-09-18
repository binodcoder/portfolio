import 'package:binodfolio/src/features/meal/data/dummy_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/meal.dart';

final mealsProvider = Provider((ref) {
  return dummyMeals;
});

final mealByIdProvider = Provider.family<Meal?, String>((ref, id) {
  for (final m in dummyMeals) {
    if (m.id == id) return m;
  }
  return null;
});
