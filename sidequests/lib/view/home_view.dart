import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sidequests/backend/tasks.dart';
import 'package:sidequests/controller/home_controller.dart';
import 'package:sidequests/theme.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final model = controller.model;

    return PageView(
      controller: controller.pageController,
      onPageChanged: controller.updatePageIndex,
      children: [
        Scaffold(
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/background.jpg"),
                    fit: BoxFit.cover),
              ),
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/scroll.png"),
                      fit: BoxFit.cover),
                ),
                child: CustomScrollView(
                  slivers: [
                    const SliverAppBar(
                      title: Text("The story thus far..."),
                      backgroundColor: Colors.transparent,
                      floating: true,
                      pinned: true,
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 20),
                    ),
                    Obx(
                      () => SliverList.builder(
                        itemCount: model.completedTasks.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                          child: Obx(
                            () => Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              child: model.completedTasks[index].story == null
                                  ? const SpinKitPulse(color: Colors.white)
                                  : Text(
                                      model.completedTasks[index].story!,
                                      style: textTheme(context)
                                          .bodyLarge!
                                          .copyWith(
                                            color: Colors.white,
                                          ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: controller.addTask,
            child: const Icon(Icons.add),
          ),
          body: SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/background.jpg"),
                    fit: BoxFit.cover),
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
                              child: Stack(
                                alignment: const Alignment(0, 0.5),
                                clipBehavior: Clip.none,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(40, 0, 20, 0),
                                    child: LinearProgressIndicator(
                                      minHeight: 40,
                                      value: model.coins.value /
                                          (model.totalCoins.value == 0
                                              ? 1
                                              : model.totalCoins.value),
                                    ),
                                  ),
                                  Image.asset(
                                    "assets/progress_overlay.png",
                                    fit: BoxFit.fill,
                                    width: Get.width,
                                    height: 80,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
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
                                    model.coins.value.toString(),
                                    style:
                                        textTheme(context).labelLarge!.copyWith(
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
                  const SliverToBoxAdapter(child: SizedBox(height: 80)),
                  Obx(
                    () => SliverToBoxAdapter(
                      child: Visibility(
                        visible: model.completedTasks.isNotEmpty,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "Conquered Quests",
                            style: textTheme(context).headlineLarge!.copyWith(
                                  color: ThemeConstants.vibrantYellow,
                                  shadows: [const Shadow(offset: Offset(2, 2))],
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const TaskTiles(completed: true),
                ],
              ),
            ),
          ),
        ),
      ],
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
        itemBuilder: (context, index) {
          final imagePath = switch (taskList[index].difficulty) {
            TaskType.minorQuest => "assets/wood_blue.png",
            TaskType.sideQuest => "assets/wood_yellow.png",
            TaskType.mainQuest => "assets/wood_purple.png",
          };

          final decorationColour = switch (taskList[index].difficulty) {
            TaskType.minorQuest => ThemeConstants.commonBlue,
            TaskType.sideQuest => ThemeConstants.vibrantYellow,
            TaskType.mainQuest => ThemeConstants.rarePurple,
          };

          return Dismissible(
            key: Key(taskList[index].description),
            onDismissed: (direction) => controller.deleteTask(taskList[index]),
            child: Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.fill,
                ),
              ),
              child: ListTile(
                title: RichText(
                  text: TextSpan(
                    text: taskList[index].description,
                    style: textTheme(context).bodyLarge!.copyWith(
                        color: Colors.white,
                        decorationColor: decorationColour,
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
          );
        },
      ),
    );
  }
}
