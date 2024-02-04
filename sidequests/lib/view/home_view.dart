import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                width: 40,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/coin.png"),
                                      fit: BoxFit.fill),
                                ),
                              ),
                              Text(
                                model.completedTasks.length.toString(),
                                style: textTheme(context).labelLarge!.copyWith(
                                      color: Colors.white,
                                      fontSize: 20,
                                      height: 1,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const TaskTiles(),
              const SliverToBoxAdapter(child: SizedBox(height: 40)),
              const TaskTiles(completed: true),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskTiles extends GetView<HomeController> {
  const TaskTiles({
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
            child: ListTile(
              title: RichText(
                text: TextSpan(
                  text: taskList[index].description,
                  style: textTheme(context).bodyLarge!.copyWith(
                      color: Colors.white,
                      decorationColor: const Color.fromARGB(255, 223, 223, 223),
                      decorationThickness: 4,
                      fontWeight: FontWeight.bold,
                      decoration:
                          completed ? TextDecoration.lineThrough : null),
                ),
              ),
              trailing: ElevatedButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0x00000000),
                    shadowColor: const Color(0x00000000),
                    surfaceTintColor: const Color(0x00000000),
                  ),
                  onPressed: () => completed
                      ? controller.uncheckTask(taskList[index])
                      : controller.checkTask(taskList[index]),
                  child: Container(
                    width: 40,
                    height: 40,
                    foregroundDecoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: completed
                            ? const AssetImage("assets/check_checked.png")
                            : const AssetImage("assets/check_unchecked.png"),
                      ),
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
