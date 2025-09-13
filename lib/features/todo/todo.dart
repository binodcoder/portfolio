import 'package:binodfolio/features/todo/todo_item.dart';
import 'package:flutter/material.dart';

class Todo {
  const Todo(this.text, this.priority);

  final String text;
  final Priority priority;
}

class Todos extends StatefulWidget {
  const Todos({super.key});

  @override
  State<Todos> createState() {
    return _TodosState();
  }
}

class _TodosState extends State<Todos> {
  var _order = 'asc';
  final _todos = [
    const Todo(
      'Learn Flutter',
      Priority.urgent,
    ),
    const Todo(
      'Practice Flutter',
      Priority.normal,
    ),
    const Todo(
      'Explore other courses',
      Priority.low,
    ),
  ];

  List<Todo> get _orderedTodos {
    final sortedTodos = List.of(_todos);
    sortedTodos.sort((a, b) {
      final bComesAfterA = a.text.compareTo(b.text);
      return _order == 'asc' ? bComesAfterA : -bComesAfterA;
    });
    return sortedTodos;
  }

  void _changeOrder() {
    setState(() {
      _order = _order == 'asc' ? 'desc' : 'asc';
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      // if (Navigator.of(context).canPop()) ...[
                      //   const InAppBackButton(),
                      //   const SizedBox(width: 8),
                      // ],
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
                    onPressed: _changeOrder,
                    icon: Icon(
                      _order == 'asc'
                          ? Icons.arrow_downward
                          : Icons.arrow_upward,
                    ),
                    label: Text(
                        'Sort ${_order == 'asc' ? 'Descending' : 'Ascending'}'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.builder(
                  itemCount: _orderedTodos.length,
                  itemBuilder: (context, index) {
                    final todo = _orderedTodos[index];
                    return TodoItem(
                      key: ObjectKey(todo), // ValueKey()
                      todo.text,
                      todo.priority,
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
