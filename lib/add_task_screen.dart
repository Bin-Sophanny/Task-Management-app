import 'package:flutter/material.dart';
import 'package:task_management/model/task_model.dart';
import 'package:task_management/services/Database_services.dart';

class AddTaskScreen extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final DatabaseServices databaseServices = DatabaseServices();
  final Task? task;

  AddTaskScreen({Key? key, this.task}) : super(key: key) {
    if (task != null) {
      titleController.text = task!.title;
      descriptionController.text = task!.description;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade200,
      appBar: AppBar(
        title: Text(task == null ? "Add Task" : "Edit Task"),
        backgroundColor: Colors.blueGrey.shade200,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              maxLines: 10,
              minLines: 10,
            ),
            const SizedBox(height: 20),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                  ),
                  const SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: () async {
                      if (task == null) {
                        await databaseServices.createTask(
                            titleController.text, descriptionController.text);
                      } else {
                        await databaseServices.updateTask(task!.id,
                            titleController.text, descriptionController.text);
                      }
                      Navigator.pop(context);
                    },
                    child: Text(
                      task == null ? "Add":"Update",
                      style: const TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
