import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:todo_list/pages/tasks_list.page.dart';
import 'package:todo_list/themes/themes.dart';

void main() {
  initializeDateFormatting(
    "pt_BR",
    null,
  ).then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: lightTheme(),
      darkTheme: darkTheme(),
      home: TasksListPage(),
    );
  }
}
