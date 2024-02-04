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
      default:
        data[attr] = value;
    }
  }
}
