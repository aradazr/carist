import 'package:carist/Screens/add_task_screen.dart';
import 'package:carist/data/task.dart';
import 'package:carist/widgets/my_app_bar.dart';
import 'package:carist/widgets/my_drawer.dart';
import 'package:carist/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var taskBox = Hive.box<Task>('taskBox');
  bool isFabVisible = true;

  
  

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
          drawer: const MyDrawer(),
          
          appBar: const MyAppBar(),
          
          floatingActionButton: Visibility(
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
          // body: Center(
          //   child: Text(
          //     textAlign: TextAlign.center,
          //     'هنوز هیچ کاری اضافه\n !نکردی',
          //     style: TextStyle(
          //       height: 1.5,
          //       fontSize: 32,
          //       fontWeight: FontWeight.normal,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
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
