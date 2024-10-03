import 'package:carist/Screens/add_task_screen.dart';
import 'package:carist/data/task.dart';
import 'package:carist/widgets/my_app_bar.dart';
import 'package:carist/widgets/my_drawer.dart';
import 'package:carist/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:showcaseview/showcaseview.dart';

class HomePage extends StatefulWidget {
  final bool hasSeenShowCase;
  const HomePage({super.key, required this.hasSeenShowCase});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var taskBox = Hive.box<Task>('taskBox');
  bool isFabVisible = true;
  bool isSearchVisible = false;
  String searchQuery = ""; // متغیر برای ذخیره متن جستجو

  var settingsBox = Hive.box('settingsBox');
  final GlobalKey add = GlobalKey();
  final GlobalKey appBarKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!widget.hasSeenShowCase) {
        Future.delayed(const Duration(milliseconds: 100), () {
          setState(() {
            ShowCaseWidget.of(context).startShowCase([add, appBarKey]);
            Hive.box('settingsBox').put('hasSeenShowCase', true);
          });
        });
      }
    });
  }

  void _endShowCase() {
    settingsBox.put('hasSeenShowCase', true);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // پایین آوردن کیبورد
      },
      child: Container(
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
        child: Scaffold(
          backgroundColor: Colors.transparent,
          drawer: const MyDrawer(),
          appBar: MyAppBar(
            appBarKey: appBarKey,
            icon: 'assets/images/search.png',
            showSearchIcon: true,
            onSearchIconPressed: () {
              setState(() {
                isSearchVisible = !isSearchVisible; // تغییر وضعیت نمایش جستجو
              });
            },
          ),
          floatingActionButton: Showcase(
            onTargetClick: _endShowCase,
            disposeOnTap: true,
            key: add,
            description: 'از اینجا میتونی یادداشت جدید اضافه کنی',
            child: Visibility(
              visible: isFabVisible,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddTaskScreen(),
                    ),
                  );
                },
                child: Container(
                  height: size.height / 13.61,
                  width: size.width / 6.29,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        spreadRadius: 0,
                        blurRadius: 10,
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset('assets/images/add.png'),
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              // نمایش TextField برای جستجو
              if (isSearchVisible)
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 12),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextField(
                      maxLength: 20,
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: 'جستجو...',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value; // به‌روزرسانی متن جستجو
                        });
                      },
                    ),
                  ),
                ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: taskBox.listenable(),
                  builder: (context, value, child) {
                    return NotificationListener<UserScrollNotification>(
                      onNotification: (notification) {
                        setState(() {
                          if (notification.direction ==
                              ScrollDirection.forward) {
                            isFabVisible = true;
                          }
                          if (notification.direction ==
                              ScrollDirection.reverse) {
                            isFabVisible = !isFabVisible;
                          }
                          if (notification.direction ==
                              ScrollDirection.reverse) {
                            // وقتی کاربر صفحه را به بالا یا پایین می‌کشد، کیبورد را پایین می‌بریم
                            FocusScope.of(context).unfocus();
                          }
                          if (notification.direction ==
                              ScrollDirection.forward) {
                            // وقتی کاربر صفحه را به بالا یا پایین می‌کشد، کیبورد را پایین می‌بریم
                            FocusScope.of(context).unfocus();
                          }
                        });
                        return true;
                      },
                      child: taskBox.values.isEmpty
                          ? const Center(
                              child: Text(
                                textAlign: TextAlign.center,
                                'هنوز هیچ کاری اضافه\n !نکردی',
                                style: TextStyle(
                                  height: 1.5,
                                  fontSize: 32,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemBuilder: (context, index) {
                                var task = taskBox.values.toList()[index];
                                // بررسی اینکه آیا عنوان تسک شامل متن جستجو می‌شود یا خیر
                                if (task.title
                                    .toLowerCase()
                                    .contains(searchQuery.toLowerCase())) {
                                  return getListItem(task);
                                }
                                return Container(); // بازگشت یک Container خالی اگر تسک شامل متن جستجو نبود
                              },
                              itemCount: taskBox.values.length,
                            ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getListItem(Task task) {
    return TaskWidget(task: task);
  }
}
