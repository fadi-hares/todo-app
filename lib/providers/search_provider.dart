import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class SearchState extends Equatable {
  String searchTerm;
  SearchState({
    required this.searchTerm,
  });

  factory SearchState.initial() {
    return SearchState(searchTerm: '');
  }

  @override
  List<Object> get props => [searchTerm];

  @override
  String toString() => 'SearchState(searchTerm: $searchTerm)';

  SearchState copyWith({
    String? searchTerm,
  }) {
    return SearchState(
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }
}

class SearchProvider with ChangeNotifier {
  SearchState _state = SearchState.initial();
  SearchState get state => _state;

  void search(String searchTerm) {
    _state = _state.copyWith(searchTerm: searchTerm);
    notifyListeners();
  }
}
