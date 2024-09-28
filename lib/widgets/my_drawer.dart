import 'dart:ui';

import 'package:flutter/material.dart';


import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final List<bool> _isOpen = [false, false, false, false];


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: SizedBox(
        width: size.width / 1.25,
        child: Drawer(
          child: Stack(
            children: [
              // Background gradient
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    stops: [
                      0.1,
                      0.55,
                    ],
                    tileMode: TileMode.clamp,
                    colors: [Color.fromARGB(255, 0, 133, 255), Colors.black],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
      
             
              
              ListView(
                padding: const EdgeInsets.only(top: 200),
                children: <Widget>[
                  
                  ExpansionPanelList(
                    dividerColor: Colors.transparent,
                    expandIconColor: Colors.transparent,
                    elevation: 0,
                    expandedHeaderPadding: EdgeInsets.zero,
                    expansionCallback: (panelIndex, isExpanded) {
                      setState(() {
                        _isOpen[panelIndex] = isExpanded;
                      });
                    },
                    children: [
                      //! ExpansionPanel for 'حمایت مالی'
                      ExpansionPanel(
                        canTapOnHeader: true,
                        backgroundColor: Colors.transparent,
                        headerBuilder: (context, isExpanded) {
                          return ListTile(
                            leading: Image.asset('assets/images/donate.png'),
                            title: const Text(
                              'حمایت مالی',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          );
                        },
                        body: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 45),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: size.height / 18,
                                width: size.width / 4.5,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white),
                                child: const Text(
                                  'درگاه ایرانی',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: size.height / 18,
                                width: size.width / 4.5,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white),
                                child: const Text(
                                  'درگاه خارجی',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        isExpanded: _isOpen[0],
                      ),
              
                      //! ExpansionPanel for دعوت از دوستان
                      ExpansionPanel(
                        canTapOnHeader: true,
                        backgroundColor: Colors.transparent,
                        headerBuilder: (context, isExpanded) {
                          return ListTile(
                            leading: Image.asset('assets/images/invite.png'),
                            title: const Text(
                              'دعوت از دوستان',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          );
                        },
                        body: Container(
                          alignment: Alignment.center,
                          height: size.height / 18,
                          width: size.width / 2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: const Text(
                            'ارسال لینک',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        isExpanded: _isOpen[1],
                      ),
              
                      //! ExpansionPanel for درباره ی برنامه
                      ExpansionPanel(
                        canTapOnHeader: true,
                        backgroundColor: Colors.transparent,
                        headerBuilder: (context, isExpanded) {
                          return ListTile(
                            leading: Image.asset('assets/images/about.png'),
                            title: const Text(
                              'درباره ی برنامه',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          );
                        },
                        body: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'کاریست ساخته شده که شما بتونید هر کاری برای ماشینتون انجام دادید رو به یاد داشته باشید و هیچوقت ماشینتون اسیب نبینه٬ خیلی خوشحال میشم اگر پیشنهاد یا انتقادی دارید از طریق بخش ارتباط با سازنده برام بفرستید',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        isExpanded: _isOpen[2],
                      ),
              
                      //! ExpansionPanel for ارتباط با سازنده
                      ExpansionPanel(
                        canTapOnHeader: true,
                        backgroundColor: Colors.transparent,
                        headerBuilder: (context, isExpanded) {
                          return ListTile(
                            leading:
                                Image.asset('assets/images/communicate.png'),
                            title: const Text(
                              'ارتباط با سازنده',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          );
                        },
                        body: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(width: size.width),
                            InkWell(
                              onTap: () async {
                                final Uri url =
                                    Uri.parse('https://t.me/aradazr');
                                if (!await launchUrl(url)) {
                                  throw Exception('Could not launch');
                                }
                              },
                              child: ListTile(
                                leading: Image.asset(
                                  'assets/images/telegram.png',
                                  height: 35,
                                ),
                                title: const Text(
                                  'Telegram',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                final Uri url =
                                    Uri.parse('https://mail.google.com/mail/u/0/#inbox');
                                if (!await launchUrl(url)) {
                                  throw Exception('Could not launch');
                                }
                              },
                              child: ListTile(
                                leading: Image.asset(
                                  'assets/images/gmail.png',
                                  height: 35,
                                ),
                                title: const Text(
                                  'Gmail',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        isExpanded: _isOpen[3],
                      ),
                    ],
                  ),
                  SizedBox(height: size.height / 20),
                  Image.asset('assets/images/drawerCar.png'),
                  SizedBox(height: size.height / 15),
                  const Divider(
                    endIndent: 32,
                    indent: 32,
                    height: 1,
                    color: Colors.white,
                    thickness: 1,
                  ),
                  SizedBox(height: size.height / 50),
                  const Text(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    'ساخته شده توسط\nآراد آذرپناه',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
