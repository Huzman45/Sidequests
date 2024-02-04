import 'package:get/get.dart';
import 'package:sidequests/backend/table.dart';
import 'package:sidequests/backend/tasks.dart';
import 'package:sidequests/main.dart';

class HomeModel {
  static int minorCoins = 2;
  static int sideCoins = 5;
  static int mainCoins = 10;

  final RxList<TaskRecord> pendingTasks = <TaskRecord>[].obs;
  final RxList<TaskRecord> completedTasks = <TaskRecord>[].obs;

  int pageIndex = 1;

  var taskDifficulty = TaskType.minorQuest.obs;
  var coins = 0.obs;
  var totalCoins = 0.obs;

  Future<void> loadData() async {
    DateTime now = DateTime.now();
    List<Map<String, Object?>> response = await db.query(Tables.taskTable,
        where: 'date = ?',
        whereArgs: [DateTime(now.year, now.month, now.day).toIso8601String()]);

    for (final record in response) {
      final task = TaskRecord(Map.from(record));
      if (task.completed) {
        completedTasks.add(task);
        coins.value += getCoins(task.difficulty);
      } else {
        pendingTasks.add(task);
      }

      totalCoins.value += getCoins(task.difficulty);
    }
  }

  int getCoins(TaskType type) {
    switch (type) {
      case TaskType.minorQuest:
        return minorCoins;
      case TaskType.sideQuest:
        return sideCoins;
      case TaskType.mainQuest:
        return mainCoins;
    }
  }
}
