import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_test_app_provider/models/todo.dart';
import 'package:todo_test_app_provider/providers/filter_provider.dart';
import 'package:todo_test_app_provider/providers/filtered_todos_provider.dart';
import 'package:todo_test_app_provider/providers/list_provider.dart';

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
                      context
                          .read<ListProvider>()
                          .removeTodo(todoList[index].id);
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
  final List<Todo> todoList;
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
                    context
                        .read<ListProvider>()
                        .editTodo(todoList[index].id, _controller.text);
                    Navigator.pop(context);
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
          value: todoList[index].isChecked,
          onChanged: (newValue) {
            context.read<ListProvider>().toggleTodo(todoList[index].id);
          },
        ),
      ),
    );
  }
}
