import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/expense.dart';
import 'expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    final platform = defaultTargetPlatform;
    final isDesktopLike = kIsWeb ||
        platform == TargetPlatform.macOS ||
        platform == TargetPlatform.windows ||
        platform == TargetPlatform.linux;

    final list = ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) {
        final item = ExpenseItem(
          expenses[index],
          showDelete: isDesktopLike,
          onRemove: () => onRemoveExpense(expenses[index]),
        );

        if (isDesktopLike) {
          return item;
        }

        return Dismissible(
          background: Container(
            color: Theme.of(context).colorScheme.error.withAlpha(20),
            margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal,
            ),
          ),
          onDismissed: (direction) {
            onRemoveExpense(expenses[index]);
          },
          key: ValueKey(expenses[index]),
          child: item,
        );
      },
    );

    return isDesktopLike
        ? Scrollbar(thumbVisibility: true, child: list)
        : Scrollbar(child: list);
  }
}
