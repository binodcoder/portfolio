import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Priority { urgent, normal, low }

class TodoItemModel {
  final String id;
  final String text;
  final Priority priority;
  final bool done;

  const TodoItemModel({
    required this.id,
    required this.text,
    required this.priority,
    this.done = false,
  });

  TodoItemModel copyWith({
    String? id,
    String? text,
    Priority? priority,
    bool? done,
  }) {
    return TodoItemModel(
      id: id ?? this.id,
      text: text ?? this.text,
      priority: priority ?? this.priority,
      done: done ?? this.done,
    );
  }
}

class TodosState {
  final List<TodoItemModel> items;
  final bool ascending;

  const TodosState({
    required this.items,
    this.ascending = true,
  });

  TodosState copyWith({
    List<TodoItemModel>? items,
    bool? ascending,
  }) {
    return TodosState(
      items: items ?? this.items,
      ascending: ascending ?? this.ascending,
    );
  }

  List<TodoItemModel> get orderedItems {
    final sorted = List<TodoItemModel>.of(items);
    sorted.sort((a, b) => a.text.compareTo(b.text));
    return ascending ? sorted : sorted.reversed.toList();
  }
}

class TodosNotifier extends StateNotifier<TodosState> {
  TodosNotifier()
      : super(
          TodosState(
            items: const [
              TodoItemModel(id: '1', text: 'Learn Flutter', priority: Priority.urgent),
              TodoItemModel(id: '2', text: 'Practice Flutter', priority: Priority.normal),
              TodoItemModel(id: '3', text: 'Explore other courses', priority: Priority.low),
            ],
          ),
        );

  void toggleOrder() {
    state = state.copyWith(ascending: !state.ascending);
  }

  void toggleDone(String id) {
    final idx = state.items.indexWhere((e) => e.id == id);
    if (idx == -1) return;
    final updated = state.items[idx].copyWith(done: !state.items[idx].done);
    final items = [...state.items];
    items[idx] = updated;
    state = state.copyWith(items: items);
  }

  void addTodo(TodoItemModel item) {
    state = state.copyWith(items: [...state.items, item]);
  }

  void removeTodo(String id) {
    state = state.copyWith(items: state.items.where((e) => e.id != id).toList());
  }
}

final todosProvider = StateNotifierProvider<TodosNotifier, TodosState>((ref) {
  return TodosNotifier();
});

