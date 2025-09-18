import 'package:binodfolio/src/features/expense_tracker/models/expense.dart';
import 'package:binodfolio/src/features/expense_tracker/providers/expenses_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:binodfolio/src/core/responsive/breakpoints.dart';

import 'chat/chat.dart';
import 'expenses_list/expenses_list.dart';
import 'new_expense.dart';

class Expenses extends ConsumerWidget {
  const Expenses({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = context.screenWidth;
    final isWeb = kIsWeb;
    final isCompactMobile = !isWeb && width < kDialogSheetSwitch;

    final expenses = ref.watch(expensesProvider);

    void openAddExpenseOverlay() {
      final useDialog = kIsWeb || context.screenWidth >= kDialogSheetSwitch;

      if (useDialog) {
        showDialog(
          context: context,
          builder: (ctx) => Dialog(
            insetPadding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: const NewExpense(),
            ),
          ),
        );
      } else {
        showModalBottomSheet(
          useSafeArea: true,
          isScrollControlled: true,
          context: context,
          showDragHandle: true,
          builder: (ctx) => const NewExpense(),
        );
      }
    }

    void removeExpense(Expense expense) {
      final expenseIndex = ref.read(expensesProvider).indexOf(expense);
      ref.read(expensesProvider.notifier).remove(expense);

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 3),
          content: Text('Expense deleted'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              ref.read(expensesProvider.notifier).insert(expenseIndex, expense);
            },
          ),
        ),
      );
    }

    Widget mainContent = Center(
      child: Text('No expenses found. Start adding some!'),
    );

    if (expenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: expenses,
        onRemoveExpense: removeExpense,
      );
    }
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
                        // if (Navigator.of(context).canPop()) ...[
                        //   const InAppBackButton(),
                        //   const SizedBox(width: 8),
                        // ],
                        Text(
                          'Expense Tracker',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                    if (!isCompactMobile)
                      ElevatedButton.icon(
                        onPressed: openAddExpenseOverlay,
                        icon: const Icon(Icons.add),
                        label: const Text('Add Expense'),
                      ),
                  ],
                );

                final content = width < kTwoPaneExpense
                    ? Column(
                        children: [
                          header,
                          const SizedBox(height: 8),
                          Chart(expenses: expenses),
                          const SizedBox(height: 8),
                          Expanded(child: mainContent),
                        ],
                      )
                    : Column(
                        children: [
                          header,
                          const SizedBox(height: 8),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Chart(expenses: expenses),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(child: mainContent),
                              ],
                            ),
                          ),
                        ],
                      );
                return content;
              }),
            ),
          ),
        ),
      ),
      floatingActionButton: isCompactMobile
          ? FloatingActionButton(
              onPressed: openAddExpenseOverlay,
              tooltip: 'Add Expense',
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
