import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/custom_error.dart';
import '../providers/filter_provider.dart';
import '../providers/filtered_todos_provider.dart';
import '../providers/list_provider.dart';
import '../repositories/db/db_repository.dart';
import 'package:drift/drift.dart' as drift;
import '../utils/error_dialog.dart';

class FilterdTodoWidget extends StatefulWidget {
  const FilterdTodoWidget({Key? key}) : super(key: key);

  @override
  State<FilterdTodoWidget> createState() => _FilterdTodoWidgetState();
}

class _FilterdTodoWidgetState extends State<FilterdTodoWidget> {
  Widget _showBackground(int value) {
    return Container(
      alignment: value == 0 ? Alignment.centerLeft : Alignment.centerRight,
      color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final todoList = context.watch<FiltredTodosProvider>().state.todos;
    final todoFilter = context.watch<FilterProvider>().state.filter;

    Widget filterButton(String title, Filter filter) {
      return TextButton(
        onPressed: () {
          context.read<FilterProvider>().changeFilter(filter);
        },
        child: Text(
          title,
          style: TextStyle(
              color: todoFilter == filter ? Colors.blue : Colors.grey),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              filterButton('All', Filter.all),
              filterButton('Completed', Filter.complete),
              filterButton('Active', Filter.active),
            ],
          ),
          SizedBox(height: 20),
          Container(
            height: MediaQuery.of(context).size.height * 1 / 2,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: ListView.separated(
                primary: false,
                shrinkWrap: true,
                separatorBuilder: (context, index) => Divider(),
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: ValueKey(todoList[index].id),
                    onDismissed: (_) {
                      try {
                        context
                            .read<ListProvider>()
                            .removeTodo(todoList[index].id);
                      } on CustomError catch (e) {
                        showErrorDialog(context, e);
                      }
                    },
                    confirmDismiss: (_) {
                      return showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Deleting Todo'),
                          content: Text('Do you really want to delete?'),
                          actions: [
                            TextButton(
                              child: Text('Ok'),
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                            ),
                            TextButton(
                              child: Text('Cancle'),
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    background: _showBackground(0),
                    secondaryBackground: _showBackground(1),
                    child: TodoItem(
                      todoList: todoList,
                      index: index,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TodoItem extends StatelessWidget {
  TodoItem({
    Key? key,
    required this.todoList,
    required this.index,
  }) : super(key: key);

  final int index;
  final List<TodoModelData> todoList;
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Edit Todo'),
            content: TextField(
              autocorrect: true,
              controller: _controller,
              decoration: InputDecoration(hintText: 'Edit the todo'),
            ),
            actions: [
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  if (_controller.text.trim().isNotEmpty) {
                    try {
                      context.read<ListProvider>().editTodo(
                            TodoModelCompanion(
                              id: drift.Value(todoList[index].id),
                              desc: drift.Value(_controller.text),
                              isChecked: drift.Value(todoList[index].isChecked),
                            ),
                          );
                      Navigator.pop(context);
                    } on CustomError catch (e) {
                      showErrorDialog(context, e);
                    }
                  }
                },
              ),
              TextButton(
                child: Text('Cancle'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
      child: ListTile(
        title: Text(todoList[index].desc),
        trailing: Checkbox(
          value: todoList[index].isChecked == 1 ? true : false,
          onChanged: (newValue) {
            try {
              context.read<ListProvider>().editTodo(
                    TodoModelCompanion(
                      id: drift.Value(todoList[index].id),
                      desc: drift.Value(todoList[index].desc),
                      isChecked: drift.Value(newValue == true ? 1 : 0),
                    ),
                  );
            } on CustomError catch (e) {
              showErrorDialog(context, e);
            }
          },
        ),
      ),
    );
  }
}
