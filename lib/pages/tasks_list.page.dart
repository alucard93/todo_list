import 'package:flutter/material.dart';
import 'package:todo_list/models/task.model.dart';

class TasksListPage extends StatefulWidget {
  const TasksListPage({super.key});

  @override
  State<TasksListPage> createState() => _TasksListPageState();
}

class _TasksListPageState extends State<TasksListPage> {
  final List<Task> tasks = [
    Task(
      title: "Marcar uma reunião",
      description: "Reunião sobre negócios",
      isImportant: true,
    ),

    Task(title: "Comprar mantimentos", description: "Leite, pão, ovos, frutas"),

    Task(
      title: "Fazer exercícios",
      description: "Caminhada de 30 minutos no parque",
      isImportant: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tarefas'), centerTitle: true, elevation: 1),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text("Adicionar"),
        icon: Icon(Icons.add),
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (ctx, index) {
            final task = tasks[index];

            return Card(
              elevation: 3,
              color: Colors.indigo[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                title: Text(task.title),
                subtitle: Text(task.description ?? ""),
                leading: Checkbox(
                  value: task.isCompleted,
                  onChanged: (value) {
                    setState(() {
                      task.changeStatus(value ?? false);
                    });
                  },
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                trailing: IconButton(
                  icon: Icon(
                    task.isImportant ? Icons.star : Icons.star_border,
                    color: Colors.indigo,
                  ),
                  onPressed: () {
                    setState(() {
                      task.changeImportance();
                    });
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
