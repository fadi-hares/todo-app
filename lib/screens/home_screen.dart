import 'package:flutter/material.dart';
import 'package:todo_test_app_provider/widgets/filterded_todo_widget.dart';
import 'package:todo_test_app_provider/widgets/forms_element.dart';
import 'package:todo_test_app_provider/widgets/header.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Header(),
                FormElements(),
                FilterdTodoWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
