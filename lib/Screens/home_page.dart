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

var settingsBox = Hive.box('settingsBox'); // جعبه برای ذخیره تنظیمات
final GlobalKey add = GlobalKey();
 final GlobalKey appBarKey = GlobalKey(); // تعریف GlobalKey برای AppBar
  
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
    settingsBox.put('hasSeenShowCase', true);  // ذخیره کردن وضعیت نمایش ShowCase
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Container(
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
          drawer:  const MyDrawer(),
          
          appBar:  MyAppBar(appBarKey: appBarKey,),
          
          floatingActionButton: Showcase(
            
            onTargetClick: _endShowCase,
            disposeOnTap: true,
            key:add ,
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
                          color: Colors.black, spreadRadius: 0, blurRadius: 10),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset('assets/images/add.png'),
                ),
              ),
            ),
          ),
          
          body: Center(
            child: ValueListenableBuilder(
              valueListenable: taskBox.listenable(),
              builder: (context, value, child) {
                return NotificationListener<UserScrollNotification>(
                  onNotification: (notification) {
                    setState(() {
                      if (notification.direction == ScrollDirection.forward) {
                        isFabVisible = true;
                      }
                      if (notification.direction == ScrollDirection.reverse) {
                        isFabVisible = !isFabVisible;
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
                      : 
                        
                      
                          ListView.builder(
                              itemBuilder: (context, index) {
                                var task = taskBox.values.toList()[index];
                                return getListItem(task);
                              },
                              itemCount: taskBox.values.length,
                            
                      ),
                );
              },
            ),
          )),
    );
  }

  getListItem(Task task) {
    return TaskWidget(task: task);
  }
}
