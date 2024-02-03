import 'package:get/get.dart';
import 'package:sidequests/model/task.dart';

class HomeModel {
  final RxList<Task> pendingTasks = <Task>[].obs;
  final RxList<Task> completedTasks = <Task>[].obs;
}
