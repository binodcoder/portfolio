import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/expense.dart';

class ExpensesNotifier extends StateNotifier<List<Expense>> {
  ExpensesNotifier()
      : super([
          Expense(
            title: 'New Shoes',
            amount: 69.99,
            date: DateTime.now(),
            category: Classification.food,
          ),
          Expense(
            title: 'Weekly Groceries',
            amount: 16.53,
            date: DateTime.now(),
            category: Classification.travel,
          ),
        ]);

  void add(Expense expense) {
    state = [...state, expense];
  }

  void remove(Expense expense) {
    state = state.where((e) => e.id != expense.id).toList();
  }

  void insert(int index, Expense expense) {
    final next = [...state];
    if (index < 0 || index > next.length) {
      next.add(expense);
    } else {
      next.insert(index, expense);
    }
    state = next;
  }
}

final expensesProvider =
    StateNotifierProvider<ExpensesNotifier, List<Expense>>((ref) {
  return ExpensesNotifier();
});

