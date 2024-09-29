import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 11, 11, 11),
      automaticallyImplyLeading: false,
      leading: InkWell(
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
