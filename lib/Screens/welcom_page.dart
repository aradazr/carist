import 'package:carist/Screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: double.infinity,
              ),
              SizedBox(height: size.height / 4.5),
              Image.asset(
                'assets/images/welcome.png',
                fit: BoxFit.fill,
              ),
              const Text(
                'هر آنچه که\n !برای ماشینت نیاز داری',
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 1.8,
                  fontSize: 32,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: size.height / 70),
              const Text(
                textAlign: TextAlign.center,
                'اطلاعات ماشینت رو ذخیره کن و\nتعویض روغن یا قطعات و فیلترات و\n هرچیز دیگه ای رو هیچوقت فراموش نکن و\n .همه چیو ثبت کن',
                style: TextStyle(
                  color: Color.fromARGB(255, 161, 161, 161),
                  height: 1.6,
                ),
              ),
              SizedBox(height: size.height / 27),
              InkWell(
                borderRadius: BorderRadius.circular(38),
                onTap: () async {
                  var box = Hive.box('settingsBox');
                  await box.put('hasSeenIntro',
                      true); // ذخیره‌سازی اینکه کاربر صفحه خوشامدگویی را دیده است
                  await box.put('hasSeenShowCase',
                      false); // ذخیره‌سازی اینکه کاربر شو کیس‌ها را ندیده است

                  // اضافه کردن تاخیر قبل از تغییر صفحه
                  Future.delayed(Duration(milliseconds: 100), () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return HomePage(hasSeenShowCase: false);
                    }));
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: size.height / 12,
                  width: size.width / 2.40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(38),
                      color: Colors.white),
                  child: const Text(
                    '!شروع کنیم',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
