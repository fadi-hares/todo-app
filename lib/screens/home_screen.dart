import 'package:flutter/material.dart';
import '../providers/list_provider.dart';
import '../widgets/filterded_todo_widget.dart';
import '../widgets/forms_element.dart';
import '../widgets/header.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listState = context.watch<ListProvider>().state.listStatus;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: listState == ListStatus.loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : listState == ListStatus.error
                  ? Center(
                      child: Text('Error has occurred'),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
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
