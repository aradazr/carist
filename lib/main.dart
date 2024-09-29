import 'package:carist/Screens/welcom_page.dart';

import 'package:carist/Screens/home_page.dart';  // فرض اینکه HomePage وجود دارد
import 'package:carist/data/task.dart';
import 'package:carist/data/task_type.dart';
import 'package:carist/data/type_enum.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // مقداردهی اولیه Hive
  await Hive.initFlutter();

  // ثبت آداپتورها
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TaskTypeAdapter());
  Hive.registerAdapter(TaskTypeEnumAdapter());

  // باز کردن جعبه برای Task
  await Hive.openBox<Task>('taskBox');

  // باز کردن جعبه تنظیمات
  var settingsBox = await Hive.openBox('settingsBox');

  // بررسی وضعیت مشاهده صفحه خوشامدگویی
  bool hasSeenIntro = settingsBox.get('hasSeenIntro', defaultValue: false);

  runApp(MyApp(hasSeenIntro: hasSeenIntro));
}

class MyApp extends StatelessWidget {
  final bool hasSeenIntro;

  const MyApp({super.key, required this.hasSeenIntro});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Carist',
      theme: ThemeData(
        fontFamily: 'vazir',
        useMaterial3: true,
      ),
      home: hasSeenIntro ? const HomePage() : const WelcomePage(),
      
    );
  }
}
