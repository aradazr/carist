
import 'package:carist/data/task.dart';
import 'package:carist/widgets/my_app_bar.dart';
import 'package:carist/widgets/my_drawer.dart';
import 'package:carist/widgets/task_type_item.dart';
import 'package:carist/utility/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({super.key, required this.task});
  final Task task;
  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  FocusNode negahban1 = FocusNode();
  FocusNode negahban2 = FocusNode();
  FocusNode negahban3 = FocusNode();
  TextEditingController? controllerTaskTitle;
  TextEditingController? controllerTaskSubTitle;
  TextEditingController controllerTaskTozih = TextEditingController();
  final box = Hive.box<Task>('taskBox');
  Jalali? selectedDate;
  int _selectedTaskTypeItem = 0;
  @override
  void initState() {
    super.initState();

    controllerTaskTitle = TextEditingController(text: widget.task.title);
    controllerTaskSubTitle = TextEditingController(text: widget.task.subtitle);
    controllerTaskTozih = TextEditingController(text: widget.task.tozihat);

    negahban1.addListener(() {
      setState(() {});
    });

    negahban2.addListener(() {
      setState(() {});
    });

    negahban3.addListener(() {
      setState(() {});
    });

    var index = getTaskTypes().indexWhere((element) {
      return element.image == widget.task.taskType.image;
    });
    _selectedTaskTypeItem = index;
  }
  final GlobalKey appBarKey = GlobalKey(); 

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var keyboardSpace = MediaQuery.of(context).viewInsets.bottom; // فضای کیبورد

    return Scaffold(
      drawer: const MyDrawer(),
      appBar:  MyAppBar(appBarKey: appBarKey,icon: '',),
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: keyboardSpace),
        child: Container(
          height: size.height / 1.1,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.5, 1.0],
              colors: <Color>[
                Color.fromARGB(255, 17, 17, 17),
                Color.fromARGB(255, 30, 30, 30),
              ],
              tileMode: TileMode.mirror,
            ),
          ),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height / 70,
              ),
              Column(
                
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 33,
                    ),
                    child: Text(
                      ':ویرایش یادداشت',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 200,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 0,
                    ),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextField(
                        maxLength: 12,
                        onTapOutside: (event) {
                          negahban1.unfocus();
                        },
                        controller: controllerTaskTitle,
                        focusNode: negahban1,
                        decoration: InputDecoration(
                          counterText: '',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'برای مثال : تعویض روغن',
                          hintStyle: const TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(90, 0, 0, 0),
                            fontWeight: FontWeight.w700,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 17),
                          labelStyle: TextStyle(
                            fontSize: 20,
                            color: negahban1.hasFocus
                                ? const Color.fromARGB(255, 0, 133, 255)
                                : Colors.white,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(11)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 3.0),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(11)),
                            borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 0, 133, 255),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              //!--------------------------------------------------------------------------------------------------------
              SizedBox(
                height: size.height / 70,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 33,
                    ),
                    child: Text(
                      ':ویرایش کیلومتر',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 200,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextField(
                        maxLength: 10,
                        onTapOutside: (event) {
                          negahban2.unfocus();
                        },
                        controller: controllerTaskSubTitle,
                        focusNode: negahban2,
                        decoration: InputDecoration(
                          counterText: '',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'برای مثال : تعویض روغن',
                          hintStyle: const TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(90, 0, 0, 0),
                            fontWeight: FontWeight.w700,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 17),
                          labelStyle: TextStyle(
                            fontSize: 20,
                            color: negahban2.hasFocus
                                ? const Color.fromARGB(255, 0, 133, 255)
                                : Colors.white,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(11)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 3.0),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(11)),
                            borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 0, 133, 255),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height / 70,
              ),
              Container(
                height: size.height / 4.47,
                width: size.width / 1.17,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                        10,
                      )),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CupertinoButton(
                            child: const Text(
                              '',
                              style: TextStyle(
                                  fontFamily: 'vazir',
                                  fontSize: 14,
                                  color: Colors.blue),
                            ),
                            onPressed: () {},
                          ),
                          CupertinoButton(
                            child: const Text(
                              ':تاریخ خود را مشخص کنید',
                              style: TextStyle(
                                  fontSize: 13.5,
                                  fontFamily: 'vazir',
                                  color: Colors.blue),
                            ),
                            onPressed: () {
                              // اضافه کردن تاریخ
                            },
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 0,
                      thickness: 1,
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: PCupertinoDatePicker(
                          mode: PCupertinoDatePickerMode.date,
                          maximumYear: 1450,
                          minimumYear: 1390,
                          onDateTimeChanged: (Jalali dateTime) {
                            // print(dateTime.day);
                            selectedDate = dateTime;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height / 70,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 29,
                    ),
                    child: Text(
                      ':توضیحات اضافه ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 200,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextField(
                        maxLines: 2,
                        maxLength: 32,
                        onTapOutside: (event) {
                          negahban3.unfocus();
                        },
                        controller: controllerTaskTozih,
                        focusNode: negahban3,
                        decoration: InputDecoration(
                          counterText: '',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'برای مثال : توضیح بیشتر',
                          hintStyle: const TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(90, 0, 0, 0),
                            fontWeight: FontWeight.w700,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 17),
                          labelStyle: TextStyle(
                            fontSize: 20,
                            color: negahban3.hasFocus
                                ? const Color.fromARGB(255, 0, 133, 255)
                                : Colors.white,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(11)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 3.0),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(11)),
                            borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 0, 133, 255),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height / 70,
              ),
              SizedBox(
                height: size.height / 6.2,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: getTaskTypes().length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(23),
                      onTap: () {
                        setState(() {
                          _selectedTaskTypeItem = index;
                        });
                      },
                      child: TaskTypeItemList(
                        taskType: getTaskTypes()[index],
                        index: index,
                        selectedItemList: _selectedTaskTypeItem,
                      ),
                    );
                  },
                ),
              ),
              //!--------------------------------------------------------------------------------------------------------
             SizedBox(
                height: size.height/70,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: size.height / 16.5,
                        width: size.width / 2.80,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 0, 133, 255),
                                width: 3),
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white),
                        child: const Text('بازگشت',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            )),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        String taskTitle = controllerTaskTitle!.text;
                        String taskSubTitle = controllerTaskSubTitle!.text;
                        String tozih = controllerTaskTozih.text;
                        editTask(taskTitle, taskSubTitle, tozih);
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: size.height / 17.59,
                        width: size.width / 2.94,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white),
                        child: const Text('ویرایش',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            )),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  editTask(String taskTitle, String taskSubTitle, String tozih) {
    widget.task.title = taskTitle;
    widget.task.subtitle = taskSubTitle;
    widget.task.tozihat = tozih;
    widget.task.taskType = getTaskTypes()[_selectedTaskTypeItem];
    if (selectedDate != null) {
      widget.task.date = selectedDate!.toDateTime();
    }
    widget.task.save();
  }
}
