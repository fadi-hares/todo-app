import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/custom_error.dart';
import '../providers/search_provider.dart';
import '../repositories/db/db_repository.dart';
import '../utils/error_dialog.dart';

import '../providers/list_provider.dart';

class FormElements extends StatefulWidget {
  FormElements({Key? key}) : super(key: key);

  @override
  State<FormElements> createState() => _FormElementsState();
}

class _FormElementsState extends State<FormElements> {
  final _addTodo = GlobalKey<FormState>();

  final TextEditingController _addTodoController = TextEditingController();

  final TextEditingController _searchTodoController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _addTodoController.dispose();
    _searchTodoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _addTodo,
          child: TextFormField(
            controller: _addTodoController,
            decoration: InputDecoration(
              labelText: 'What to do?',
            ),
            onFieldSubmitted: (String? value) {
              _addTodo.currentState!.save();
              if (_addTodo.currentState!.validate()) {
                try {
                  context.read<ListProvider>().addTodo(
                        TodoModelCompanion(
                          desc: drift.Value(value!),
                          isChecked: drift.Value(0),
                        ),
                      );
                } on CustomError catch (e) {
                  showErrorDialog(context, e);
                }
              }
              _addTodoController.clear();
            },
            validator: (String? value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a valid value';
              }
              if (value.length < 2) {
                return 'Please enter a text have a 2 characters at least';
              }
              return null;
            },
          ),
        ),
        SizedBox(height: 10.0),
        TextField(
          controller: _searchTodoController,
          decoration: InputDecoration(
            fillColor: Colors.grey[200],
            border: InputBorder.none,
            filled: true,
            label: Text('Search Todos'),
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (String? value) {
            if (_searchTodoController.text.isNotEmpty) {
              context.read<SearchProvider>().search(value!);
            } else {
              context.read<SearchProvider>().search('');
            }
          },
        ),
      ],
    );
  }
}
