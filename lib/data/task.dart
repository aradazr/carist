
import 'package:carist/data/task_type.dart';
import 'package:hive/hive.dart';
part 'task.g.dart';
@HiveType(typeId: 3)
class Task extends HiveObject {
  Task({required this.title, required this.subtitle, required this.date, required this.taskType, required this.tozihat});


  @HiveField(0)
  String title;


  @HiveField(1)
  String subtitle;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  TaskType taskType;

  @HiveField(4)
  String tozihat;

}
