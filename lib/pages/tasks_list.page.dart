import 'package:flutter/material.dart';
import 'package:todo_list/models/task.model.dart';
import 'package:todo_list/pages/task_detail.page.dart';
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
    final taskUpdated = await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => TaskDetailPage(task: task)));

    if (taskUpdated != null) {
      setState(() {
        tasks[index] = taskUpdated;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tarefas'), centerTitle: true, elevation: 1),

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
                contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),

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
                    color: Colors.indigo,
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
