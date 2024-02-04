import 'package:sidequests/backend/tables/table.dart';

class DayRecord extends Record {
  DayRecord(super.data);

  DateTime get date => getAttr('date');
  set date(DateTime date) =>
      data['date'] = date.toIso8601String(); //setAttr<DateTime>('date', date);

  int get score => getAttr('score');
  set score(int score) => data['score'] = score;

  double get completion => getAttr('completion');
  set completion(double completion) => data['completion'] = completion;
}
