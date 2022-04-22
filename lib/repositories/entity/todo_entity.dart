import 'package:drift/drift.dart';

class TodoModel extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get desc => text().named('desc')();
  IntColumn get isChecked => integer().named('is_checked')();
}
