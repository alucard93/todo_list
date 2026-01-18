import 'package:flutter/material.dart';
import 'package:todo_list/models/task.model.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  var isImportant = false;
  var showDescription = false;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void addTask() {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final task = Task(
      title: titleController.text,
      description: descriptionController.text.isEmpty
          ? null
          : descriptionController.text,
      isImportant: isImportant,
    );
    Navigator.of(context).pop(task); // Return the new task to the caller
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),

      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Adicionar Tarefa",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),

                Spacer(),

                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close),
                ),
              ],
            ),

            Divider(thickness: 2, height: 0),

            SizedBox(height: 15),

            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "O que você quer fazer hoje?",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Campo obrigatório';
                }
                return null;
              },
            ),

            if (showDescription)
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Adicionar informações",
                ),
              ),

            Row(
              children: [
                GestureDetector(
                  child: Icon(Icons.sort),
                  onTap: () {
                    setState(() {
                      showDescription = !showDescription;
                    });
                  },
                ),
                SizedBox(width: 20),
                GestureDetector(
                  child: isImportant
                      ? Icon(Icons.star)
                      : Icon(Icons.star_border),
                  onTap: () {
                    setState(() {
                      isImportant = !isImportant;
                    });
                  },
                ),
                Spacer(),
                TextButton(onPressed: addTask, child: Text("Adicionar")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
