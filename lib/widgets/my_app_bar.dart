import 'package:carist/data/task.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:showcaseview/showcaseview.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey? appBarKey;
  final GlobalKey? searchKey;
  final String icon; // دریافت کلید برای دکمه دراور
  final bool showSearchIcon;
  final Task? task;
  final VoidCallback?
      onSearchIconPressed; // پارامتر جدید برای فشردن آیکون جستجو// پارامتر جدید برای کنترل نمایش آیکون جستجو
  final bool isHomePage; // پارامتر جدید برای مشخص کردن صفحه اصلی
  const MyAppBar({
    super.key,
    this.appBarKey,
    required this.icon,
    this.showSearchIcon = false,
    this.onSearchIconPressed,
    this.task,
    this.isHomePage = false,
    this.searchKey, // مقدار پیش‌فرض false
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        if (showSearchIcon) // نمایش آیکون جستجو فقط در صورت true بودن
          Padding(
            padding: const EdgeInsets.only(right: 2),
            child: searchKey != null
                ? Showcase(
                    key: searchKey!,
                    description: 'از این بخش یادداشت هاتو جستجو کن',
                    child: InkWell(
                      onTap: onSearchIconPressed,
                      child: Image.asset(
                        icon,
                        height: 24,
                      ),
                    ),
                  )
                : InkWell(
                    onTap: onSearchIconPressed,
                    child: Image.asset(
                      icon,
                      height: 24,
                    ),
                  ),
          ),
        if (isHomePage)
          PopupMenuButton<String>(
            offset: Offset(0, 45),
            iconColor: Colors.white,
            iconSize: 30,
            color: Colors.white,
            onSelected: (String result) async {
              if (result == 'delete_all') {
                // حذف تمامی تسک‌های ذخیره شده در Hive
                var taskBox = Hive.box<Task>('taskBox');
                if (taskBox.isEmpty) {
                  // اگر جعبه خالی باشد، نمایش پیغام "یادداشتی وجود ندارد"
                  ScaffoldMessenger.of(context).showSnackBar(
                    snackBarAnimationStyle:
                        AnimationStyle(curve: Curves.bounceOut),
                    const SnackBar(
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.fixed,
                      content: Text(
                        'یادداشتی وجود ندارد',
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  );
                } else {
                  // پاک کردن تمامی تسک‌ها اگر جعبه خالی نباشد
                  await taskBox.clear();

                  // نمایش پیغام به کاربر
                  ScaffoldMessenger.of(context).showSnackBar(
                    snackBarAnimationStyle:
                        AnimationStyle(curve: Curves.bounceOut),
                    const SnackBar(
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.green,
                      content: Text(
                        'تمامی یادداشت‌ها حذف شدند',
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  );
                }
              }
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  height: 40,
                  value: 'delete_all',
                  child: const Text(
                    'حذف تمامی یادداشت ها',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ];
            },
          ),
      ],
      backgroundColor: const Color.fromARGB(255, 11, 11, 11),
      automaticallyImplyLeading: false,
      leading: appBarKey != null
          ? Showcase(
              key: appBarKey!,
              description: 'از اینجا با برنامه اشنا شو',
              child: InkWell(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Image.asset('assets/images/appbarMenu.png'),
              ),
            )
          : InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Image.asset('assets/images/appbarMenu.png'),
            ),
      title: Image.asset('assets/images/appbarLogo.png'),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
