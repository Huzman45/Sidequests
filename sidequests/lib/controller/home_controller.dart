import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sidequests/backend/generate.dart';
import 'package:sidequests/backend/table.dart';
import 'package:sidequests/backend/tasks.dart';
import 'package:sidequests/main.dart';
import 'package:sidequests/model/home_model.dart';
import 'package:sidequests/view/task_input_dialog.dart';
import 'package:uuid/uuid.dart';

class HomeController extends GetxController {
  final model = HomeModel();

  final PageController pageController = PageController(initialPage: 1);
  final TextEditingController taskDescriptionController =
      TextEditingController();

  @override
  void onInit() {
    super.onInit();
    model.loadData();
  }

  void updatePageIndex(int index) {
    model.pageIndex = index;
  }

  void addTask() {
    taskDescriptionController.clear();
    model.taskDifficulty.value = TaskType.minorQuest;
    Get.dialog(const TaskInputDialog());
  }

  TaskRecord _initTask() {
    final task = TaskRecord({});
    task.description = taskDescriptionController.text;
    task.difficulty = model.taskDifficulty.value;

    DateTime now = DateTime.now();
    task.date = DateTime(now.year, now.month, now.day);

    task.completed = false;
    task.id = const Uuid().v4();

    return task;
  }

  void confirmAddTask() async {
    final task = _initTask();
    model.pendingTasks.add(task);
    model.totalCoins.value += (model.getCoins(task.difficulty));

    await db.insert(Tables.taskTable, task.data);
    Get.back();
  }

  void checkTask(TaskRecord task) async {
    task.completed = true;
    await db.update(Tables.taskTable, task.data,
        where: "id = ?", whereArgs: [task.id]);

    model.completedTasks.add(task);
    model.pendingTasks.remove(task);

    model.coins.value += model.getCoins(task.difficulty);
    model.storylines.add(
      await storylineGen(
          task.description,
          model.storylines.isEmpty
              ? "I, the adventurer, wake up in my bed"
              : model.storylines.last),
    );
  }

  void uncheckTask(TaskRecord task) async {
    task.completed = false;
    await db.update(Tables.taskTable, task.data,
        where: "id = ?", whereArgs: [task.id]);

    model.completedTasks.remove(task);
    model.pendingTasks.add(task);

    model.coins.value -= model.getCoins(task.difficulty);
    //model.storylines.remove("temp");
  }

  void deleteTask(TaskRecord task) async {
    await db.delete(Tables.taskTable, where: 'id = ?', whereArgs: [task.id]);
    model.totalCoins.value -= (model.getCoins(task.difficulty));

    if (task.completed) {
      model.completedTasks.remove(task);
    } else {
      model.pendingTasks.remove(task);
    }
  }

  void selectDifficulty(TaskType? type) {
    if (type != null) {
      model.taskDifficulty.value = type;
    }
  }
}
