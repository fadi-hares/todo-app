import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Todo extends Equatable {
  final String id;
  final String desc;
  final bool isChecked;
  Todo({
    String? id,
    required this.desc,
    this.isChecked = false,
  }) : id = id ?? Uuid().v4();

  @override
  List<Object> get props => [id, desc, isChecked];

  @override
  String toString() => 'Todo(id: $id, desc: $desc, isChecked: $isChecked)';
}
