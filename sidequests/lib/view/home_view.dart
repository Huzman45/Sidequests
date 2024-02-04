import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sidequests/backend/tables/tasks.dart';
import 'package:sidequests/controller/home_controller.dart';
import 'package:sidequests/theme.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final model = controller.model;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: controller.addTask,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/background.jpg"), fit: BoxFit.cover),
          ),
          child: CustomScrollView(
            slivers: [
              Obx(
                () => SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            minHeight: 40,
                            value: model.completedTasks.length /
                                (model.totalTasks == 0 ? 1 : model.totalTasks),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(model.completedTasks.length.toString()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const TaskTile(),
              const TaskTile(completed: true),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskTile extends GetView<HomeController> {
  const TaskTile({
    this.completed = false,
    super.key,
  });

  final bool completed;

  @override
  Widget build(BuildContext context) {
    final taskList = completed
        ? controller.model.completedTasks
        : controller.model.pendingTasks;

    return Obx(
      () => SliverList.builder(
        itemCount: taskList.length,
        itemBuilder: (context, index) => Dismissible(
          key: Key(taskList[index].description),
          onDismissed: (direction) => controller.deleteTask(taskList[index]),
          child: Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/wood.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: CheckboxListTile(
              title: RichText(
                text: TextSpan(
                  text: taskList[index].description,
                  style: textTheme(context).bodyLarge!.copyWith(
                      color: Colors.white,
                      decoration:
                          completed ? TextDecoration.lineThrough : null),
                ),
              ),
              value: taskList[index].completed,
              onChanged: (val) => controller.checkTask(taskList[index], val!),
            ),
          ),
        ),
      ),
    );
  }
}
