import 'package:flutter/material.dart';
import 'package:untitled/features/expense_tracker/widgets/expenses.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Expenses(),
    ),
  );
}
