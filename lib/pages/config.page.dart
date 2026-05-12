import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/store/theme.store.dart';

class ConfigPage extends StatelessWidget {
  final store = GetIt.I.get<ThemeStore>();
  ConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações do usuário'),
        centerTitle: true,
        elevation: 1,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Tema: '),
              DropdownButton(
                value: store.theMode.value,
                onChanged: (option) {
                  store.setThemeMode(option!);
                },
                items: [
                  DropdownMenuItem(
                    value: ThemeMode.light,
                    child: Text('Claro'),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.dark,
                    child: Text('Escuro'),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.system,
                    child: Text('Sistema'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
