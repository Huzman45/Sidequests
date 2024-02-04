import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sidequests/backend/tables/tasks.dart';
import 'package:sidequests/controller/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final model = controller.model;

    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => LinearProgressIndicator(
            value: model.completedTasks.length /
                (model.completedTasks.length + model.pendingTasks.length),
          ),
        ),
        leading: Obx(
          () => Center(child: Text(model.completedTasks.length.toString())),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.addTask,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Center(
          child: CustomScrollView(
            slivers: [
              TaskTile(taskList: model.pendingTasks),
              TaskTile(taskList: model.completedTasks),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskTile extends GetView<HomeController> {
  const TaskTile({
    required this.taskList,
    super.key,
  });

  final RxList<TaskRecord> taskList;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SliverList.builder(
        itemCount: taskList.length,
        itemBuilder: (context, index) => Dismissible(
          key: Key(taskList[index].description),
          onDismissed: (direction) => controller.deleteTask(taskList[index]),
          child: CheckboxListTile(
            title: Text(
              taskList[index].description,
            ),
            value: taskList[index].completed,
            onChanged: (val) => controller.checkTask(taskList[index], val!),
          ),
        ),
      ),
    );
  }
}
