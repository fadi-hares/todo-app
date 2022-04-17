import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_test_app_provider/providers/list_provider.dart';

import '../models/todo.dart';

class TodoCountState extends Equatable {
  final int todoCount;
  TodoCountState({
    required this.todoCount,
  });

  factory TodoCountState.initial() {
    return TodoCountState(todoCount: 0);
  }

  TodoCountState copyWith({
    List<Todo>? todos,
    int? todoCount,
  }) {
    return TodoCountState(
      todoCount: todoCount ?? this.todoCount,
    );
  }

  @override
  String toString() => 'TodoCountState( todoCount: $todoCount)';

  @override
  List<Object> get props => [todoCount];
}

class TodoCountProvider with ChangeNotifier {
  TodoCountState _state = TodoCountState.initial();
  TodoCountState get state => _state;

  void update(ListProvider todos) {
    final todosCount = todos.state.todos
        .where((todo) => todo.isChecked == false)
        .toList()
        .length;
    _state = _state.copyWith(todoCount: todosCount);
    notifyListeners();
  }
}
