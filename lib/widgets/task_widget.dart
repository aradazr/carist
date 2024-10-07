import 'dart:ui';

import 'package:carist/Screens/edit_task_screen.dart';
import 'package:carist/data/task.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';


class TaskWidget extends StatefulWidget {
  const TaskWidget({super.key, required this.task,});
  final Task task;
  
  
  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  
  @override
  Widget build(BuildContext context) {

    return getTaskItem();
  }

  getTaskItem() {
    var size = MediaQuery.of(context).size;
   Jalali? jalaliDate;

    // تبدیل تاریخ میلادی به تاریخ جلالی
    DateTime dateTime = widget.task.date;
    jalaliDate = Jalali.fromDateTime(dateTime);
      return Padding(
      padding: const EdgeInsets.only(top: 21, left: 20, right: 20),
      child: Container(
        width: 345,
        height: 133,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: size.width / 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditTaskScreen(
                          task: widget.task,
                        ),
                      ),
                    );
                  },
                  child: Image.asset('assets/images/edit.png',height: 18,),
                ),
                 const SizedBox(),
                InkWell(
                  onTap: () => _dialogBuilder(context, widget.task),
                  child: Image.asset('assets/images/trash.png',height: 24,),
                ),
              ],
            ),
            SizedBox(
              width: size.width / 6,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: size.width / 3.4,
                  height: size.height / 29.5,
                  child: Text(
                    
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      widget.task.title,
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      )),
                ),
                SizedBox(height: size.height / 500),
                Text(
                    textAlign: TextAlign.end,
                    textDirection: TextDirection.rtl,
                    overflow: TextOverflow.ellipsis,
                    widget.task.subtitle,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    )),
                SizedBox(height: size.height / 200),
                Text(
                  overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                    // ignore: unnecessary_null_comparison
                    jalaliDate != null ? formatJalaliDate(jalaliDate) : 'تاریخ نامشخص',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    )),
                SizedBox(height: size.height / 200),
                SizedBox(
                  width: size.width / 3.7,
                  child: Text(
                      maxLines: 2,
                      textAlign: TextAlign.end,
                      widget.task.tozihat,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      )),
                )
              ],
            ),
            Expanded(child: Image.asset(widget.task.taskType.image,)),
          ],
        ),
      ),
    );
  }
 // تابع کمکی برای فرمت تاریخ جلالی
  // تابع برای فرمت تاریخ جلالی به رشته
String formatJalaliDate(Jalali date) {
  return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
}

  Future<void> _dialogBuilder(BuildContext context, Task task) {
    var size = MediaQuery.of(context).size;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: AlertDialog(
            content: SizedBox(
              height: size.height / 200,
              width: 300,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(23),
              side: const BorderSide(
                color: Colors.blue,
                width: 4,
              ),
            ),
            backgroundColor: Colors.white,
            key: UniqueKey(),
            alignment: Alignment.center,
            actionsAlignment: MainAxisAlignment.center,
            title: const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'آیا از حذف یادداشت خود\n !مطمئن هستید؟',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 20,left: 18,right: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: size.height / 17.95,
                        width: size.width / 4.2,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 49, 181, 94),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Text(
                          'خیر',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        task.delete();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: size.height / 17.95,
                        width: size.width / 4.2,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 181, 49, 49),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Text(
                          'بله',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
            ],
          ),
        );
      },
    );
  }
}
