import 'package:carist/data/task_type.dart';
import 'package:carist/data/type_enum.dart';

List<TaskType> getTaskTypes() {
  var list = [
    TaskType(
      image: 'assets/images/engine.png',
      taskTypeEnum: TaskTypeEnum.engine,
    ),

    TaskType(
      image: 'assets/images/wheel.png',
      taskTypeEnum: TaskTypeEnum.wheel,
    ),

    TaskType(
      image: 'assets/images/oil.png',
      taskTypeEnum: TaskTypeEnum.oil,
    ),

    TaskType(
      image: 'assets/images/gearbox.png',
      taskTypeEnum: TaskTypeEnum.gearbox,
    ),

    TaskType(
      image: 'assets/images/carpart1.png',
      taskTypeEnum: TaskTypeEnum.others,
    ),

    TaskType(
      image: 'assets/images/carpart2.png',
      taskTypeEnum: TaskTypeEnum.others,
    ),

    TaskType(
      image: 'assets/images/carpart3.png',
      taskTypeEnum: TaskTypeEnum.others,
    ),

    TaskType(
      image: 'assets/images/carpart4.png',
      taskTypeEnum: TaskTypeEnum.others,
    ),

    TaskType(
      image: 'assets/images/carpart5.png',
      taskTypeEnum: TaskTypeEnum.others,
    ),

    TaskType(
      image: 'assets/images/carpart6.png',
      taskTypeEnum: TaskTypeEnum.others,
    ),

    TaskType(
      image: 'assets/images/carpart7.png',
      taskTypeEnum: TaskTypeEnum.others,
    ),

    TaskType(
      image: 'assets/images/carpart8.png',
      taskTypeEnum: TaskTypeEnum.others,
    ),
  ];
  return list;
}
