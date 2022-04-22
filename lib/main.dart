import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/filter_provider.dart';
import 'providers/filtered_todos_provider.dart';
import 'providers/list_provider.dart';
import 'providers/search_provider.dart';
import 'providers/todo_count_provider.dart';
import 'repositories/db/db_repository.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DbRepository>(
          create: (context) => DbRepository(),
        ),
        ChangeNotifierProxyProvider<DbRepository, ListProvider>(
          create: (context) =>
              ListProvider(dbRepository: context.read<DbRepository>()),
          update: (BuildContext context, DbRepository dbRepository,
                  ListProvider? listProvider) =>
              listProvider!..getTodos(),
        ),
        ChangeNotifierProvider<SearchProvider>(
          create: (context) => SearchProvider(),
        ),
        ChangeNotifierProvider<FilterProvider>(
          create: (context) => FilterProvider(),
        ),
        ChangeNotifierProxyProvider<ListProvider, TodoCountProvider>(
          create: (context) =>
              TodoCountProvider(listProvider: context.read<ListProvider>()),
          update: (
            BuildContext context,
            ListProvider listProvider,
            TodoCountProvider? todoCount,
          ) =>
              todoCount!..update(),
        ),
        ChangeNotifierProxyProvider3<ListProvider, FilterProvider,
            SearchProvider, FiltredTodosProvider>(
          create: (context) => FiltredTodosProvider(
            initialFiltredTodo: context.read<ListProvider>().state.todos,
          ),
          update: (
            BuildContext context,
            ListProvider dbRepository,
            FilterProvider filterProvider,
            SearchProvider searchProvider,
            FiltredTodosProvider? filtredTodosProvider,
          ) =>
              filtredTodosProvider!
                ..update(
                  filterProvider: filterProvider,
                  searchProvider: searchProvider,
                  listProvider: dbRepository,
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
