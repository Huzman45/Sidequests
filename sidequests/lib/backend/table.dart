import 'package:sidequests/backend/tasks.dart';

class Tables {
  static const String taskTable = "tasks";
  static const String dayTable = "day";
}

abstract class Record {
  Map<String, Object?> data;
  Record(this.data);

  T? getAttr<T>(String attr) {
    final value = data[attr];

    switch (T) {
      case DateTime:
        return DateTime.tryParse(T as String) as T?;
      case TaskType:
        switch (value as String) {
          case "minor":
            return TaskType.minorQuest as T?;
          case "side":
            return TaskType.sideQuest as T?;
          case "main":
            return TaskType.mainQuest as T?;
          default:
            return null;
        }
      default:
        return value as T?;
    }
  }

  void setAttr<T>(String attr, T value) {
    switch (T) {
      case DateTime:
        data[attr] = (value as DateTime).toIso8601String();
      case bool:
        data[attr] = value as bool ? 1 : 0;
      case TaskType:
        switch (value as TaskType) {
          case TaskType.minorQuest:
            data[attr] = "minor";
          case TaskType.sideQuest:
            data[attr] = "side";
          case TaskType.mainQuest:
            data[attr] = "main";
          default:
            return null;
        }
      default:
        data[attr] = value;
    }
  }
}
