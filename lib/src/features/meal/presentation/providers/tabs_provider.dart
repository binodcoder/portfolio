import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Controls the currently selected tab index for the Meals feature.
final mealTabIndexProvider = StateProvider<int>((ref) => 0);
