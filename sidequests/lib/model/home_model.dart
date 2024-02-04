import 'package:get/get.dart';
import 'package:sidequests/backend/tables/table.dart';
import 'package:sidequests/backend/tables/tasks.dart';
import 'package:sidequests/main.dart';

class HomeModel {
  final RxList<TaskRecord> pendingTasks = <TaskRecord>[].obs;
  final RxList<TaskRecord> completedTasks = <TaskRecord>[].obs;

  int get totalTasks => pendingTasks.length + completedTasks.length;

  Future<void> loadData() async {
    DateTime now = DateTime.now();
    List<Map<String, Object?>> response = await db.query(Tables.taskTable,
        where: 'date = ?',
        whereArgs: [DateTime(now.year, now.month, now.day).toIso8601String()]);

    for (final record in response) {
      final task = TaskRecord(Map.from(record));
      if (task.completed) {
        completedTasks.add(task);
      } else {
        pendingTasks.add(task);
      }
    }
  }
}
