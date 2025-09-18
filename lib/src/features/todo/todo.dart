import 'package:binodfolio/src/features/todo/providers/todos_provider.dart';
import 'package:binodfolio/src/features/todo/todo_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Todos extends ConsumerWidget {
  const Todos({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todosState = ref.watch(todosProvider);
    final ordered = todosState.orderedItems;
    final ascending = todosState.ascending;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Todo',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  TextButton.icon(
                    onPressed: () => ref.read(todosProvider.notifier).toggleOrder(),
                    icon: Icon(
                      ascending ? Icons.arrow_downward : Icons.arrow_upward,
                    ),
                    label: Text('Sort ${ascending ? 'Descending' : 'Ascending'}'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: ordered.length,
                  itemBuilder: (context, index) {
                    final todo = ordered[index];
                    return TodoItem(
                      key: ValueKey(todo.id),
                      itemId: todo.id,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
