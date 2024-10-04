import 'package:carist/data/task.dart';

import 'package:carist/widgets/my_app_bar.dart';
import 'package:carist/widgets/my_drawer.dart';
import 'package:carist/widgets/task_type_item.dart';
import 'package:carist/utility/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  //! سه عدد فوکوس برای کنترل تکست فیلد ها
  FocusNode negahban1 = FocusNode();
  FocusNode negahban2 = FocusNode();
  FocusNode negahban3 = FocusNode();

  //! این سه برای ارسال نوشته درون فیلد ها
  final TextEditingController controllerTaskTitle = TextEditingController();
  final TextEditingController controllerTaskSubTitle = TextEditingController();
  final TextEditingController controllerTaskTozih = TextEditingController();
  final box = Hive.box<Task>('taskBox');
  Jalali? selectedDate;
  int _selectedTaskTypeItem = 0;

  @override
  //! برای اپدیت شدن صفحه
  void initState() {
    super.initState();
    negahban1.addListener(() {
      setState(() {});
    });

    negahban2.addListener(() {
      setState(() {});
    });

    negahban3.addListener(() {
      setState(() {});
    });
  }
final GlobalKey appBarKey = GlobalKey(); 
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var keyboardSpace = MediaQuery.of(context).viewInsets.bottom; // فضای کیبورد

    return Scaffold(
      //! دارور
      drawer: const MyDrawer(),
      //! اپ بار
      appBar:  MyAppBar(appBarKey: appBarKey,icon: '',),
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      //! شروع صفحه
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.only(bottom: keyboardSpace),
        //! برای رنگ بک گراند
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height / 70,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  //! فیلد نام یادداشت
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 33,
                    ),
                    child: Text(
                      ':نام یادداشت',
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
                        cursorColor: Colors.blue,
                        cursorErrorColor: Colors.blue,

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
              //! فیلد تعداد کیلومتر
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 33,
                    ),
                    child: Text(
                      ':تعداد کیلومتر',
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
                          hintText: 'برای مثال :  273465',
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
              //! انتخاب تاریخ
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
              //! فیلد توضیحات
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
              //! انتخاب عکس
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
              )
              //!--------------------------------------------------------------------------------------------------------
              ,
              SizedBox(
                height: size.height / 70,
              ),
              //! دکمه تایید و بازگشت
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
                        child: const Text(
                          'بازگشت',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        String taskTitle = controllerTaskTitle.text;
                        String taskSubTitle = controllerTaskSubTitle.text;
                        String tozih = controllerTaskTozih.text;
                        addTask(taskTitle, taskSubTitle, selectedDate, tozih);
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: size.height / 17.59,
                        width: size.width / 2.94,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white),
                        child: const Text('تایید',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
//! برای اضافه شدن و ذخیره ی تسک جدید
  addTask(String taskTitle, String taskSubTitle, Jalali? selectedDate,
      String tozih) {
    
    // اگر تاریخ انتخاب نشده باشد، تاریخ جاری استفاده شود
    DateTime date =
        selectedDate != null ? selectedDate.toDateTime() : DateTime.now();

    var task = Task(
      taskType: getTaskTypes()[_selectedTaskTypeItem],
      title: taskTitle,
      subtitle: taskSubTitle,
      date: date,
      tozihat: tozih,
    );
    box.add(task);
  }
}
