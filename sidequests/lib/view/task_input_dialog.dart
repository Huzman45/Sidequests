import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sidequests/backend/tasks.dart';
import 'package:sidequests/controller/home_controller.dart';
import 'package:sidequests/theme.dart';

class TaskInputDialog extends GetView<HomeController> {
  const TaskInputDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: Get.back,
          ),
          title: Text(
            "Add Quest",
            style:
                textTheme(context).headlineLarge!.copyWith(color: Colors.white),
          ),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: controller.confirmAddTask,
          backgroundColor: ThemeConstants.neonGreen,
          child: const Icon(Icons.check),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
          child: Column(
            children: [
              SizedBox(
                height: 150,
                child: TextField(
                  controller: controller.taskDescriptionController,
                  expands: true,
                  maxLines: null,
                  textAlignVertical: TextAlignVertical.top,
                  cursorColor: Colors.white,
                  style: textTheme(context).bodyMedium!.copyWith(
                        color: Colors.white,
                        decorationColor: Colors.white,
                      ),
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "What is the difficulty rating of this quest?",
                style: textTheme(context).bodyLarge!.copyWith(
                      color: Colors.white,
                    ),
              ),
              const SizedBox(height: 6),
              const DifficultyTile(difficulty: TaskType.minorQuest),
              const DifficultyTile(difficulty: TaskType.sideQuest),
              const DifficultyTile(difficulty: TaskType.mainQuest),
            ],
          ),
        ),
      ),
    );
  }
}

class DifficultyTile extends GetView<HomeController> {
  const DifficultyTile({super.key, required this.difficulty});

  final TaskType difficulty;

  @override
  Widget build(BuildContext context) {
    final model = controller.model;

    String titleVal = switch (difficulty) {
      TaskType.minorQuest => "Minor Quest",
      TaskType.sideQuest => "Side Quest",
      TaskType.mainQuest => "Main Quest",
    };

    Color selectColour = switch (difficulty) {
      TaskType.minorQuest => ThemeConstants.commonBlue,
      TaskType.sideQuest => ThemeConstants.vibrantYellow,
      TaskType.mainQuest => ThemeConstants.rarePurple,
    };

    return Obx(
      () => RadioListTile<TaskType>(
        title: Text(
          titleVal,
          style: textTheme(context).labelLarge!.copyWith(
                color: Colors.white,
              ),
        ),
        activeColor: Colors.white,
        fillColor: MaterialStatePropertyAll(selectColour),
        value: difficulty,
        groupValue: model.taskDifficulty.value,
        onChanged: controller.selectDifficulty,
      ),
    );
  }
}
