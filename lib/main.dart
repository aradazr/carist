
import 'package:carist/Screens/home_page.dart';
import 'package:carist/data/task.dart';
import 'package:carist/data/task_type.dart';
import 'package:carist/data/type_enum.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
 await Hive.initFlutter();
 Hive.registerAdapter(TaskAdapter());
 Hive.registerAdapter(TaskTypeAdapter());
 Hive.registerAdapter(TaskTypeEnumAdapter());
  await Hive.openBox<Task>('taskBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Carist',
      theme: ThemeData(
        
        fontFamily: 'vazir',
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}


