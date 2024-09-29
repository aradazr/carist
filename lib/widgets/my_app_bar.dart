import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey? appBarKey;  // دریافت کلید برای دکمه دراور
  const MyAppBar({
    super.key,  this.appBarKey,
  });
   

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
