import 'package:sidequests/backend/tables/table.dart';

class TaskRecord extends Record {
  TaskRecord(super.data);

  DateTime get date => getAttr('date');
  set date(DateTime time) => setAttr('date', time);

  String get id => getAttr('id');
  set id(String id) => data['id'] = id;

  String get description => getAttr('description');
  set description(String description) => data['description'] = description;

  bool get completed => getAttr('completed') == 1;
  set completed(bool completed) => setAttr('completed', completed);
}
