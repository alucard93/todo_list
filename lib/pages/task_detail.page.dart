import 'package:flutter/material.dart';
import 'package:todo_list/models/task.model.dart';

class TaskDetailPage extends StatefulWidget {
  final Task task;

  const TaskDetailPage({super.key, required this.task});

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  late bool isImportant;

  @override
  void initState() {
    super.initState();
    isImportant = widget.task.isImportant;
    titleController.text = widget.task.title;
    descriptionController.text = widget.task.description ?? '';
  }

  saveTask() {
    final updatedTask = widget.task;
    updatedTask.isImportant = isImportant;
    updatedTask.title = titleController.text;
    updatedTask.description = descriptionController.text.isEmpty
        ? null
        : descriptionController.text;

    Navigator.of(context).pop(updatedTask);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isImportant = !isImportant;
              });
            },
            icon: Icon(!isImportant ? Icons.star_border : Icons.star),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Título'),
            ),

            SizedBox(height: 20),

            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Descrição',
              ),
              maxLines: 5,
            ),

            SizedBox(height: 40),

            TextButton(
              onPressed: () {
                saveTask();
              },
              child: Text('Salvar tarefa'),
            ),

            Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Criada Sex, 24 de mar"),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete_outline),
                  iconSize: 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
