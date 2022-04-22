import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'list_provider.dart';

class TodoCountState extends Equatable {
  final int todoCount;
  TodoCountState({
    required this.todoCount,
  });

  factory TodoCountState.initial() {
    return TodoCountState(todoCount: 0);
  }

  TodoCountState copyWith({
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

  TodoCountProvider({
    required this.listProvider,
  });

  final ListProvider listProvider;

  void update() {
    final todosCount = listProvider.state.todos
        .where((todo) => todo.isChecked == 0)
        .toList()
        .length;
    _state = _state.copyWith(todoCount: todosCount);
    notifyListeners();
  }
}
