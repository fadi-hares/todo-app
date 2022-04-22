import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import '../models/custom_error.dart';
import '../repositories/db/db_repository.dart';

enum ListStatus {
  unknow,
  loading,
  loaded,
  error,
}

class ListState extends Equatable {
  final ListStatus listStatus;
  final List<TodoModelData> todos;
  final CustomError? error;
  ListState({
    required this.listStatus,
    required this.error,
    required this.todos,
  });

  factory ListState.initial() {
    return ListState(
        todos: [],
        listStatus: ListStatus.unknow,
        error: CustomError(message: '', resultCode: 0));
  }

  @override
  List<Object> get props => [todos, listStatus];

  ListState copyWith({
    List<TodoModelData>? todos,
    ListStatus? listStatus,
    CustomError? error,
  }) {
    return ListState(
      todos: todos ?? this.todos,
      listStatus: listStatus ?? this.listStatus,
      error: error ?? this.error,
    );
  }

  @override
  String toString() =>
      'ListState(listStatus: $listStatus, error: $error, todos: $todos )';
}

class ListProvider with ChangeNotifier {
  ListState _state = ListState.initial();
  ListState get state => _state;

  DbRepository dbRepository;
  ListProvider({
    required this.dbRepository,
  });

  void getTodos() async {
    _state = _state.copyWith(listStatus: ListStatus.loading);
    notifyListeners();
    try {
      final todos = await dbRepository.getTodos();
      _state = _state.copyWith(listStatus: ListStatus.loaded, todos: todos);
      notifyListeners();
    } on CustomError catch (e) {
      _state = _state.copyWith(error: e, listStatus: ListStatus.error);
      notifyListeners();
      rethrow;
    }
  }

  void addTodo(TodoModelCompanion todoModelCompanion) {
    _state = _state.copyWith(listStatus: ListStatus.loading);
    notifyListeners();
    try {
      dbRepository.addTodo(todoModelCompanion);
      _state = _state.copyWith(listStatus: ListStatus.loaded);
      getTodos();
      notifyListeners();
    } on CustomError catch (e) {
      _state = _state.copyWith(error: e, listStatus: ListStatus.error);
      notifyListeners();
      rethrow;
    }
  }

  void editTodo(TodoModelCompanion todoModelCompanion) {
    _state = _state.copyWith(listStatus: ListStatus.loading);
    notifyListeners();
    try {
      dbRepository.updateTodo(todoModelCompanion);
      _state = _state.copyWith(listStatus: ListStatus.loaded);
      getTodos();
      notifyListeners();
    } on CustomError catch (e) {
      _state = _state.copyWith(error: e, listStatus: ListStatus.error);
      notifyListeners();
      rethrow;
    }
  }

  void removeTodo(int id) {
    _state = _state.copyWith(listStatus: ListStatus.loading);
    notifyListeners();
    try {
      dbRepository.deleteTodo(id);
      _state = _state.copyWith(listStatus: ListStatus.loaded);
      getTodos();
      notifyListeners();
    } on CustomError catch (e) {
      _state = _state.copyWith(error: e, listStatus: ListStatus.error);
      notifyListeners();
      rethrow;
    }
  }
}
