import 'package:flutter/material.dart';
import 'package:todo_list/models/task.model.dart';
import 'package:todo_list/routes.dart';

import 'package:todo_list/themes/app_colors.dart';
import 'package:todo_list/widgets/add_task.widget.dart';

class TasksListPage extends StatefulWidget {
  const TasksListPage({super.key});

  @override
  State<TasksListPage> createState() => _TasksListPageState();
}

class _TasksListPageState extends State<TasksListPage> {
  final List<Task> tasks = [];

  void addTask() async {
    final newTask = await showModalBottomSheet<Task>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
      ),
      isScrollControlled: true,
      context: context,
      builder: (ctx) => const AddTask(),
    );

    setState(() {
      if (newTask != null) {
        tasks.add(newTask);
      }
    });
  }

  void updateTask(Task task, int index) async {
    // final taskUpdated = await Navigator.of(
    //   context,
    // ).push(MaterialPageRoute(builder: (context) => TaskDetailPage(task: task)));

    final resultUpdate = await Navigator.of(
      context,
    ).pushNamed(MyRoutes.taskDetail, arguments: task);

    if (resultUpdate != null) {
      setState(() {
        if (resultUpdate is Task) {
          tasks[index] = resultUpdate;
        } else {
          tasks.removeAt(index);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Tarefas'),
        centerTitle: true,
        elevation: 1,
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.of(
              //   context,
              // ).push(MaterialPageRoute(builder: (context) => ConfigPage()));
              Navigator.of(context).pushNamed(MyRoutes.configUser);
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (ctx, index) {
            final task = tasks[index];

            return Card(
              child: ListTile(
                leading: Checkbox(
                  value: task.isCompleted,
                  onChanged: (value) {
                    setState(() {
                      task.changeStatus(value ?? false);
                    });
                  },
                ),
                title: Text(task.title),
                subtitle: (task.description ?? '').isNotEmpty
                    ? Text(task.description!)
                    : null,
                trailing: IconButton(
                  icon: Icon(
                    task.isImportant ? Icons.star : Icons.star_border,
                    color: appColors.primaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      task.changeImportance();
                    });
                  },
                ),

                onTap: () => updateTask(task, index),
              ),
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(600)),
        onPressed: addTask,
        label: Text("Nova tarefa"),
        icon: Icon(Icons.add),
      ),
    );
  }
}
