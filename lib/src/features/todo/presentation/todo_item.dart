import 'package:binodfolio/src/features/todo/providers/todos_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoItem extends ConsumerWidget {
  const TodoItem({super.key, required this.itemId});

  final String itemId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(todosProvider);
    final item = state.items.firstWhere((e) => e.id == itemId);

    IconData icon = Icons.low_priority;
    switch (item.priority) {
      case Priority.urgent:
        icon = Icons.notifications_active;
        break;
      case Priority.normal:
        icon = Icons.list;
        break;
      case Priority.low:
        icon = Icons.low_priority;
        break;
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
            value: item.done,
            onChanged: (_) => ref.read(todosProvider.notifier).toggleDone(item.id),
          ),
          const SizedBox(width: 6),
          Icon(icon),
          const SizedBox(width: 12),
          Text(item.text),
        ],
      ),
    );
  }
}
