import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat.yMd();

final uuid = Uuid();

enum Classification { food, travel, leisure, work }

const categoryIcons = {
  Classification.food: Icons.fastfood,
  Classification.travel: Icons.flight,
  Classification.leisure: Icons.sports_soccer,
  Classification.work: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Classification category;

  String get formattedDate => formatter.format(date);
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.classification,
    required this.expenses,
  });

  ExpenseBucket.forCategory(
    List<Expense> allExpenses,
    this.classification,
  ) : expenses = allExpenses
            .where((expense) => expense.category == classification)
            .toList();

  final Classification classification;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum = sum + expense.amount;
    }
    return sum;
  }
}
