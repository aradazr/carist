import 'package:carist/data/task_type.dart';
import 'package:flutter/material.dart';

class TaskTypeItemList extends StatelessWidget {
   final TaskType taskType;
  final int index;
  final int selectedItemList;

  const TaskTypeItemList({
    super.key,
    required this.taskType,
    required this.index,
    required this.selectedItemList,
  });
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5,top: 0,bottom: 0),
      
      width: size.width / 2.8,
      decoration: BoxDecoration(
        border: Border.all(
            color: (selectedItemList == index) ? Colors.blue : Colors.transparent, width: 4),
        color: Colors.white,
        borderRadius: BorderRadius.circular(23),
      ),
      child: Image.asset(
        taskType.image,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}