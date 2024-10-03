import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey? appBarKey; 
  final String icon; // دریافت کلید برای دکمه دراور
   final bool showSearchIcon; 
   final VoidCallback? onSearchIconPressed; // پارامتر جدید برای فشردن آیکون جستجو// پارامتر جدید برای کنترل نمایش آیکون جستجو
  const MyAppBar({
    super.key,  this.appBarKey,  required this.icon, this.showSearchIcon = false, this.onSearchIconPressed,
  });
   

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
         if (showSearchIcon) // نمایش آیکون جستجو فقط در صورت true بودن
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: InkWell(
            onTap: onSearchIconPressed,
            child: Image.asset(icon,height: 25,),),
        ),
      ],
      backgroundColor: const Color.fromARGB(255, 11, 11, 11),
      automaticallyImplyLeading: false,
      leading: appBarKey != null ? Showcase(
        key: appBarKey!,
        description: 'از اینجا با برنامه اشنا شو',
        child: InkWell(
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          child: Image.asset('assets/images/appbarMenu.png'),
        ),
      ): InkWell(
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
