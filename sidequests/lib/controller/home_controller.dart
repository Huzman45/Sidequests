import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sidequests/model/home_model.dart';
import 'package:sidequests/model/task.dart';
import 'package:sidequests/view/task_input_dialog.dart';

class HomeController extends GetxController {
  final model = HomeModel();

  final TextEditingController taskDescriptionController =
      TextEditingController();

  void addTask() {
    taskDescriptionController.clear();
    Get.dialog(const TaskInputDialog());
  }

  void confirmAddTask() {
    model.pendingTasks.add(Task(taskDescriptionController.text));
    Get.back();
  }

  void checkTask(Task task, bool value) {
    task.completed = value;
    if (value) {
      model.completedTasks.add(task);
      model.pendingTasks.remove(task);
    } else {
      model.pendingTasks.add(task);
      model.completedTasks.remove(task);
    }
  }

  void deleteTask(Task task) {
    if (task.completed) {
      model.completedTasks.remove(task);
    } else {
      model.pendingTasks.remove(task);
    }
  }
}
