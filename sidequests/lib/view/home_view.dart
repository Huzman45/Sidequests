import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sidequests/controller/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final model = controller.model;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: IconButton(
                  onPressed: controller.addTask,
                  icon: const Icon(Icons.add),
                ),
              ),
              Obx(
                () => SliverList.builder(
                  itemCount: model.pendingTasks.length,
                  itemBuilder: (context, index) => Dismissible(
                    key: Key(model.pendingTasks[index].description),
                    onDismissed: (direction) =>
                        controller.deleteTask(model.pendingTasks[index]),
                    child: CheckboxListTile(
                      title: Text(
                        model.pendingTasks[index].description,
                      ),
                      value: model.pendingTasks[index].completed,
                      onChanged: (val) =>
                          controller.checkTask(model.pendingTasks[index], val!),
                    ),
                  ),
                ),
              ),
              Obx(
                () => SliverList.builder(
                  itemCount: model.completedTasks.length,
                  itemBuilder: (context, index) => Dismissible(
                    key: Key(model.completedTasks[index].description),
                    onDismissed: (direction) =>
                        controller.deleteTask(model.completedTasks[index]),
                    child: CheckboxListTile(
                      title: Text(
                        model.completedTasks[index].description,
                      ),
                      value: model.completedTasks[index].completed,
                      onChanged: (val) => controller.checkTask(
                          model.completedTasks[index], val!),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
