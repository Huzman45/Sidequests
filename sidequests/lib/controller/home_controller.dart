import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sidequests/backend/tables/table.dart';
import 'package:sidequests/backend/tables/tasks.dart';
import 'package:sidequests/main.dart';
import 'package:sidequests/model/home_model.dart';
import 'package:sidequests/view/task_input_dialog.dart';
import 'package:uuid/uuid.dart';

class HomeController extends GetxController {
  final model = HomeModel();

  final TextEditingController taskDescriptionController =
      TextEditingController();

  @override
  void onInit() {
    super.onInit();
    model.loadData();
  }

  void addTask() {
    taskDescriptionController.clear();
    Get.dialog(const TaskInputDialog());
  }

  TaskRecord _initTask(String descripion) {
    final task = TaskRecord({});
    task.description = descripion;

    DateTime now = DateTime.now();
    task.date = DateTime(now.year, now.month, now.day);

    task.completed = false;
    task.id = const Uuid().v4();

    return task;
  }

  void confirmAddTask() async {
    final task = _initTask(taskDescriptionController.text);
    model.pendingTasks.add(task);
    await db.insert(Tables.taskTable, task.data);
    Get.back();
  }

  void checkTask(TaskRecord task) async {
    task.completed = true;
    await db.update(Tables.taskTable, task.data,
        where: "id = ?", whereArgs: [task.id]);

    model.completedTasks.add(task);
    model.pendingTasks.remove(task);
  }

  void uncheckTask(TaskRecord task) async {
    task.completed = false;
    await db.update(Tables.taskTable, task.data,
        where: "id = ?", whereArgs: [task.id]);

    model.completedTasks.remove(task);
    model.pendingTasks.add(task);
  }

  void deleteTask(TaskRecord task) async {
    await db.delete(Tables.taskTable, where: 'id = ?', whereArgs: [task.id]);

    if (task.completed) {
      model.completedTasks.remove(task);
    } else {
      model.pendingTasks.remove(task);
    }
  }
}
