import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_test_app_provider/providers/filter_provider.dart';
import 'package:todo_test_app_provider/providers/filtered_todos_provider.dart';
import 'package:todo_test_app_provider/providers/list_provider.dart';
import 'package:todo_test_app_provider/providers/search_provider.dart';
import 'package:todo_test_app_provider/providers/todo_count_provider.dart';
import 'package:todo_test_app_provider/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ListProvider>(
          create: (context) => ListProvider(),
        ),
        ChangeNotifierProvider<SearchProvider>(
          create: (context) => SearchProvider(),
        ),
        ChangeNotifierProvider<FilterProvider>(
          create: (context) => FilterProvider(),
        ),
        ChangeNotifierProxyProvider<ListProvider, TodoCountProvider>(
          create: (context) => TodoCountProvider(),
          update: (
            BuildContext context,
            ListProvider todoList,
            TodoCountProvider? todoCount,
          ) =>
              todoCount!..update(todoList),
        ),
        ChangeNotifierProxyProvider3<ListProvider, FilterProvider,
            SearchProvider, FiltredTodosProvider>(
          create: (context) => FiltredTodosProvider(
            initialFiltredTodo: context.read<ListProvider>().state.todos,
          ),
          update: (
            BuildContext context,
            ListProvider list,
            FilterProvider filter,
            SearchProvider search,
            FiltredTodosProvider? filtredTodos,
          ) =>
              filtredTodos!
                ..update(
                  filterProvider: filter,
                  listProvider: list,
                  searchProvider: search,
                ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
