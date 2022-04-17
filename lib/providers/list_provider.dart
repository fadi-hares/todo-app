import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../models/todo.dart';

// ignore: must_be_immutable
class ListState extends Equatable {
  List<Todo> todos;
  ListState({
    required this.todos,
  });

  factory ListState.initial() {
    return ListState(todos: [
      Todo(desc: 'clean the room'),
      Todo(desc: 'go to shopping'),
      Todo(desc: 'go to walk'),
    ]);
  }

  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'ListState(todos: $todos)';

  ListState copyWith({
    List<Todo>? todos,
  }) {
    return ListState(
      todos: todos ?? this.todos,
    );
  }
}

class ListProvider with ChangeNotifier {
  ListState _state = ListState.initial();
  ListState get state => _state;

  void addTodo(String desc) {
    final newTodo = Todo(desc: desc);
    final newTodos = [..._state.todos, newTodo];
    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }

  void editTodo(String id, String newDesc) {
    final newTodos = _state.todos.map((todo) {
      if (todo.id == id) {
        return Todo(
          desc: newDesc,
          id: id,
          isChecked: todo.isChecked,
        );
      }
      return todo;
    }).toList();
    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }

  void toggleTodo(String id) {
    final newTodos = _state.todos.map((todo) {
      if (todo.id == id) {
        return Todo(
          desc: todo.desc,
          id: id,
          isChecked: !todo.isChecked,
        );
      }
      return todo;
    }).toList();
    _state = _state.copyWith(todos: newTodos);
    notifyListeners();
  }

  void removeTodo(String id) {
    final newtodos = _state.todos.where((todo) => todo.id != id).toList();
    _state = _state.copyWith(todos: newtodos);
    notifyListeners();
  }
}
