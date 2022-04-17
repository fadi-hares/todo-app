import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import 'package:todo_test_app_provider/models/todo.dart';
import 'package:todo_test_app_provider/providers/filter_provider.dart';
import 'package:todo_test_app_provider/providers/list_provider.dart';
import 'package:todo_test_app_provider/providers/search_provider.dart';

class FilteredTodosState extends Equatable {
  List<Todo> todos;
  FilteredTodosState({
    required this.todos,
  });

  factory FilteredTodosState.initial() {
    return FilteredTodosState(todos: []);
  }

  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'FilteredTodosState( todos: $todos)';

  FilteredTodosState copyWith({
    List<Todo>? todos,
  }) {
    return FilteredTodosState(
      todos: todos ?? this.todos,
    );
  }
}

class FiltredTodosProvider with ChangeNotifier {
  late FilteredTodosState _state;

  final List<Todo> initialFiltredTodo;
  FiltredTodosProvider({
    required this.initialFiltredTodo,
  }) {
    _state = FilteredTodosState(todos: initialFiltredTodo);
  }
  FilteredTodosState get state => _state;

  void update({
    required FilterProvider filterProvider,
    required SearchProvider searchProvider,
    required ListProvider listProvider,
  }) {
    List<Todo> _filterdTodos;

    switch (filterProvider.state.filter) {
      case Filter.complete:
        _filterdTodos =
            listProvider.state.todos.where((todo) => todo.isChecked).toList();
        break;
      case Filter.active:
        _filterdTodos =
            listProvider.state.todos.where((todo) => !todo.isChecked).toList();
        break;
      case Filter.all:
      default:
        _filterdTodos = listProvider.state.todos;
    }

    if (searchProvider.state.searchTerm.isNotEmpty) {
      _filterdTodos = _filterdTodos
          .where(
            (todo) => todo.desc
                .toLowerCase()
                .contains(searchProvider.state.searchTerm),
          )
          .toList();
    }

    _state = _state.copyWith(todos: _filterdTodos);
    notifyListeners();
  }
}
