import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import 'filter_provider.dart';
import 'list_provider.dart';
import 'search_provider.dart';
import '../repositories/db/db_repository.dart';

class FilteredTodosState extends Equatable {
  List<TodoModelData> todos;
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
    List<TodoModelData>? todos,
  }) {
    return FilteredTodosState(
      todos: todos ?? this.todos,
    );
  }
}

class FiltredTodosProvider with ChangeNotifier {
  late FilteredTodosState _state;
  FilteredTodosState get state => _state;

  final List<TodoModelData> initialFiltredTodo;
  FiltredTodosProvider({
    required this.initialFiltredTodo,
  }) {
    _state = FilteredTodosState(todos: initialFiltredTodo);
  }

  void update({
    required FilterProvider filterProvider,
    required SearchProvider searchProvider,
    required ListProvider listProvider,
  }) {
    List<TodoModelData> _filterdTodos;

    switch (filterProvider.state.filter) {
      case Filter.complete:
        _filterdTodos = listProvider.state.todos
            .where((todo) => todo.isChecked == 1)
            .toList();
        break;
      case Filter.active:
        _filterdTodos = listProvider.state.todos
            .where((todo) => todo.isChecked == 0)
            .toList();
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
