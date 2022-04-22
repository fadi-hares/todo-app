// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_repository.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class TodoModelData extends DataClass implements Insertable<TodoModelData> {
  final int id;
  final String desc;
  final int isChecked;
  TodoModelData(
      {required this.id, required this.desc, required this.isChecked});
  factory TodoModelData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return TodoModelData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      desc: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}desc'])!,
      isChecked: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_checked'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['desc'] = Variable<String>(desc);
    map['is_checked'] = Variable<int>(isChecked);
    return map;
  }

  TodoModelCompanion toCompanion(bool nullToAbsent) {
    return TodoModelCompanion(
      id: Value(id),
      desc: Value(desc),
      isChecked: Value(isChecked),
    );
  }

  factory TodoModelData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TodoModelData(
      id: serializer.fromJson<int>(json['id']),
      desc: serializer.fromJson<String>(json['desc']),
      isChecked: serializer.fromJson<int>(json['isChecked']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'desc': serializer.toJson<String>(desc),
      'isChecked': serializer.toJson<int>(isChecked),
    };
  }

  TodoModelData copyWith({int? id, String? desc, int? isChecked}) =>
      TodoModelData(
        id: id ?? this.id,
        desc: desc ?? this.desc,
        isChecked: isChecked ?? this.isChecked,
      );
  @override
  String toString() {
    return (StringBuffer('TodoModelData(')
          ..write('id: $id, ')
          ..write('desc: $desc, ')
          ..write('isChecked: $isChecked')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, desc, isChecked);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TodoModelData &&
          other.id == this.id &&
          other.desc == this.desc &&
          other.isChecked == this.isChecked);
}

class TodoModelCompanion extends UpdateCompanion<TodoModelData> {
  final Value<int> id;
  final Value<String> desc;
  final Value<int> isChecked;
  const TodoModelCompanion({
    this.id = const Value.absent(),
    this.desc = const Value.absent(),
    this.isChecked = const Value.absent(),
  });
  TodoModelCompanion.insert({
    this.id = const Value.absent(),
    required String desc,
    required int isChecked,
  })  : desc = Value(desc),
        isChecked = Value(isChecked);
  static Insertable<TodoModelData> custom({
    Expression<int>? id,
    Expression<String>? desc,
    Expression<int>? isChecked,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (desc != null) 'desc': desc,
      if (isChecked != null) 'is_checked': isChecked,
    });
  }

  TodoModelCompanion copyWith(
      {Value<int>? id, Value<String>? desc, Value<int>? isChecked}) {
    return TodoModelCompanion(
      id: id ?? this.id,
      desc: desc ?? this.desc,
      isChecked: isChecked ?? this.isChecked,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (desc.present) {
      map['desc'] = Variable<String>(desc.value);
    }
    if (isChecked.present) {
      map['is_checked'] = Variable<int>(isChecked.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodoModelCompanion(')
          ..write('id: $id, ')
          ..write('desc: $desc, ')
          ..write('isChecked: $isChecked')
          ..write(')'))
        .toString();
  }
}

class $TodoModelTable extends TodoModel
    with TableInfo<$TodoModelTable, TodoModelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TodoModelTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _descMeta = const VerificationMeta('desc');
  @override
  late final GeneratedColumn<String?> desc = GeneratedColumn<String?>(
      'desc', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _isCheckedMeta = const VerificationMeta('isChecked');
  @override
  late final GeneratedColumn<int?> isChecked = GeneratedColumn<int?>(
      'is_checked', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, desc, isChecked];
  @override
  String get aliasedName => _alias ?? 'todo_model';
  @override
  String get actualTableName => 'todo_model';
  @override
  VerificationContext validateIntegrity(Insertable<TodoModelData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('desc')) {
      context.handle(
          _descMeta, desc.isAcceptableOrUnknown(data['desc']!, _descMeta));
    } else if (isInserting) {
      context.missing(_descMeta);
    }
    if (data.containsKey('is_checked')) {
      context.handle(_isCheckedMeta,
          isChecked.isAcceptableOrUnknown(data['is_checked']!, _isCheckedMeta));
    } else if (isInserting) {
      context.missing(_isCheckedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TodoModelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return TodoModelData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TodoModelTable createAlias(String alias) {
    return $TodoModelTable(attachedDatabase, alias);
  }
}

abstract class _$DbRepository extends GeneratedDatabase {
  _$DbRepository(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $TodoModelTable todoModel = $TodoModelTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [todoModel];
}
