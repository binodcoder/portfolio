import 'package:binodfolio/features/expense_tracker/models/expense.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'chat/chat.dart';
import 'package:binodfolio/common_widgets/in_app_back_button.dart';
import 'expenses_list/expenses_list.dart';
import 'new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
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
  ];

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Expense deleted'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

  void _openAddExpenseOverlay() {
    final width = MediaQuery.of(context).size.width;
    final useDialog = kIsWeb || width >= 700;

    if (useDialog) {
      showDialog(
        context: context,
        builder: (ctx) => Dialog(
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: NewExpense(
              onAddExpense: _addExpense,
            ),
          ),
        ),
      );
    } else {
      showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        showDragHandle: true,
        builder: (ctx) => NewExpense(
          onAddExpense: _addExpense,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = Center(
      child: Text('No expenses found. Start adding some!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    final isWeb = kIsWeb;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Builder(builder: (context) {
                final header = Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        if (Navigator.of(context).canPop()) ...[
                          const InAppBackButton(),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          'Flutter ExpenseTracker',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                    if (!(!isWeb && width < 700))
                      ElevatedButton.icon(
                        onPressed: _openAddExpenseOverlay,
                        icon: const Icon(Icons.add),
                        label: const Text('Add Expense'),
                      ),
                  ],
                );

                final content = width < 800
                    ? Column(
                        children: [
                          header,
                          const SizedBox(height: 8),
                          Chart(expenses: _registeredExpenses),
                          const SizedBox(height: 8),
                          Expanded(child: mainContent),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                header,
                                const SizedBox(height: 8),
                                Chart(expenses: _registeredExpenses),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(child: mainContent),
                        ],
                      );
                return content;
              }),
            ),
          ),
        ),
      ),
      floatingActionButton: (!isWeb && width < 700)
          ? FloatingActionButton(
              onPressed: _openAddExpenseOverlay,
              tooltip: 'Add Expense',
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
