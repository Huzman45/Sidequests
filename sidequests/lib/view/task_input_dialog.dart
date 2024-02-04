import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            ],
          ),
        ),
      ),
    );
  }
}
