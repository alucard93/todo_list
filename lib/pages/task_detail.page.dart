import 'package:flutter/material.dart';
import 'package:todo_list/models/task.model.dart';

class TaskDetailPage extends StatefulWidget {
  final Task task;

  const TaskDetailPage({super.key, required this.task});

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  final titleController = TextEditingController(text: widget.task.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              !widget.task.isImportant ? Icons.star_border : Icons.star,
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(labelText: 'Título')),

            SizedBox(height: 20),

            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Descrição',
              ),
              maxLines: 5,
            ),

            SizedBox(height: 40),

            TextButton(onPressed: () {}, child: Text('Salvar tarefaa')),

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
