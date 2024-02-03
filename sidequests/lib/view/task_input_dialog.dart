import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sidequests/controller/home_controller.dart';

class TaskInputDialog extends GetView<HomeController> {
  const TaskInputDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Task"),
      content: TextField(
        controller: controller.taskDescriptionController,
      ),
      actions: [
        ElevatedButton(onPressed: Get.back, child: const Text("Cancel")),
        ElevatedButton(
            onPressed: controller.confirmAddTask, child: const Text("Confirm"))
      ],
    );
  }
}
