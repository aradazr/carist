import 'package:carist/data/type_enum.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'task_type.g.dart';
@HiveType(typeId: 4)
class TaskType {
  TaskType({required this.image, required this.taskTypeEnum});

  @HiveField(1)
  String image;

  @HiveField(2)
  TaskTypeEnum taskTypeEnum;
}
