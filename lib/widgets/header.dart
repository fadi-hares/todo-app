import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/todo_count_provider.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'TODO',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.1,
          ),
        ),
        Text(
          '${context.watch<TodoCountProvider>().state.todoCount} items left',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.05,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
