import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:todo_list/pages/tasks_list.page.dart';
import 'package:todo_list/store/theme.store.dart';
import 'package:todo_list/themes/themes.dart';

void main() {
  GetIt.I.registerSingleton<ThemeStore>(ThemeStore());

  initializeDateFormatting(
    "pt_BR",
    null,
  ).then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: GetIt.I.get<ThemeStore>().theMode,
      builder: (_, themeMode, _) {
        return MaterialApp(
          title: 'Todo List',
          debugShowCheckedModeBanner: false,
          themeMode: themeMode,
          theme: lightTheme(),
          darkTheme: darkTheme(),
          home: TasksListPage(),
        );
      },
    );
  }
}
