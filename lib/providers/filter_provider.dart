import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

enum Filter {
  all,
  complete,
  active,
}

class FilterState extends Equatable {
  final Filter filter;
  FilterState({
    required this.filter,
  });

  factory FilterState.initial() {
    return FilterState(filter: Filter.all);
  }

  FilterState copyWith({
    Filter? filter,
  }) {
    return FilterState(
      filter: filter ?? this.filter,
    );
  }

  @override
  String toString() => 'FilterState(filter: $filter)';

  @override
  List<Object> get props => [filter];
}

class FilterProvider with ChangeNotifier {
  FilterState _state = FilterState.initial();
  FilterState get state => _state;

  void changeFilter(Filter newFilter) {
    _state = _state.copyWith(filter: newFilter);
    notifyListeners();
  }
}
