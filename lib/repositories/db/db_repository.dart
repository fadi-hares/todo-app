import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../models/custom_error.dart';
import '../entity/todo_entity.dart';

part 'db_repository.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final File file = File(path.join(dbFolder.path, 'todo.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [TodoModel])
class DbRepository extends _$DbRepository {
  DbRepository() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // @override
  // MigrationStrategy get migration => MigrationStrategy(
  //       beforeOpen: (details) async {
  //         await customStatement('PRAGMA foreign_keys = ON');
  //       },
  //       onUpgrade: (m, from, to) async {
  //         if (from == 1) {
  //           await m.recreateAllViews();
  //         }
  //       },
  //     );

  Future<List<TodoModelData>> getTodos() async {
    try {
      return await select(todoModel).get();
    } on SqliteException catch (e) {
      throw CustomError(
        message: e.message,
        resultCode: e.extendedResultCode,
      );
    } catch (e) {
      throw CustomError(
        message: e.toString(),
        resultCode: 0,
      );
    }
  }

  Future<TodoModelData> getTodoById(int id) async {
    try {
      return await (select(todoModel)..where((tbl) => tbl.id.equals(id)))
          .getSingle();
    } on SqliteException catch (e) {
      throw CustomError(
        message: e.message,
        resultCode: e.extendedResultCode,
      );
    } catch (e) {
      throw CustomError(
        message: e.toString(),
        resultCode: 0,
      );
    }
  }

  Future<bool> updateTodo(TodoModelCompanion todoModelCompanion) async {
    try {
      return await update(todoModel).replace(todoModelCompanion);
    } on SqliteException catch (e) {
      throw CustomError(
        message: e.message,
        resultCode: e.extendedResultCode,
      );
    } catch (e) {
      throw CustomError(
        message: e.toString(),
        resultCode: 0,
      );
    }
  }

  Future<int> addTodo(TodoModelCompanion todoModelCompanion) async {
    try {
      return await into(todoModel).insert(todoModelCompanion);
    } on SqliteException catch (e) {
      throw CustomError(
        message: e.message,
        resultCode: e.extendedResultCode,
      );
    } catch (e) {
      throw CustomError(
        message: e.toString(),
        resultCode: 0,
      );
    }
  }

  Future<int> deleteTodo(int id) async {
    try {
      return await (delete(todoModel)..where((tbl) => tbl.id.equals(id))).go();
    } on SqliteException catch (e) {
      throw CustomError(
        message: e.message,
        resultCode: e.extendedResultCode,
      );
    } catch (e) {
      throw CustomError(
        message: e.toString(),
        resultCode: 0,
      );
    }
  }
}
