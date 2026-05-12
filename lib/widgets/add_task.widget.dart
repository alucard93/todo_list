import 'package:flutter/material.dart';
import 'package:todo_list/models/task.model.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> with SingleTickerProviderStateMixin {
  var isImportant = false;
  var isContainerOpen = false;
  var containerHeight = 0.0;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  late AnimationController iconAnimationController;
  late Animation<double> iconAnimation;
  late Animation<Color?> colorAnimation;

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
  void initState() {
    super.initState();

    iconAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    iconAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(iconAnimationController);

    colorAnimation = ColorTween(
      begin: Colors.red,
      end: Colors.green,
    ).animate(iconAnimationController);

    // iconAnimationController.repeat();
  }

  @override
  void dispose() {
    iconAnimationController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                AnimatedBuilder(
                  animation: iconAnimationController,
                  builder: (_, _) {
                    return Text(
                      "Adicionar Tarefa",
                      style: theme.textTheme.titleLarge!.copyWith(
                        color: colorAnimation.value,
                        fontFamily: "Poppins",
                      ),
                    );
                  },
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

            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: containerHeight,
              child: Visibility(
                visible: containerHeight != 0,
                child: TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Adicionar informações",
                  ),
                ),
              ),
            ),

            Row(
              children: [
                GestureDetector(
                  child: AnimatedIcon(
                    color: colorAnimation.value,
                    icon: AnimatedIcons.menu_close,
                    progress: iconAnimation,
                  ),
                  onTap: () {
                    isContainerOpen = !isContainerOpen;

                    setState(() {
                      if (isContainerOpen) {
                        iconAnimationController.forward();
                        containerHeight = 60;
                      } else {
                        iconAnimationController.reverse();
                        containerHeight = 0;
                      }
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
