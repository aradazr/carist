import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:myket_iap/myket_iap.dart';
import 'package:myket_iap/util/iab_result.dart';

import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final List<bool> _isOpen = [false, false, false, false];
  final String rsaKey =
      'MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDAnnzcOL/YCxnB9Z1VxdYLPswV8LyWAnMKgIUBS8q2oxLZX4Aro0zAnr1wnU0G3q+7ME3qCl8uksYqSwKtGIaGSzS9TBSbJ51wtFL1INtiQFr20SdfqRqOPz7mmgl0gz7T0Vj8PwbU351MlaDsaLvmzivmnR8RHeCOtf2a8UjOpQIDAQAB';
  String selectDonate = "";



  //? دونیت انتخاب شده
  Future<bool> checkConnect() async {
    try {
      var iabResult =
          await MyketIAP.init(rsaKey: rsaKey, enableDebugLogging: true);
      if (iabResult!.mResponse == 0) {
        return iabResult.mResponse == 0 ? true : false;
      } else {
        showErrorMessage("بررسی کنید که آیا مایکت را نصب دارید.");
        return false;
      }
    } catch (e) {
      showErrorMessage("مشکلی در ارتباط با مایکت رخ داد");
      return false;
    }
  }

  Future<void> getDonate(String sku) async {
    try {
      if (await checkConnect()) {
        var result =
            await MyketIAP.launchPurchaseFlow(sku: sku, payload: "حمایت مالی");

        IabResult purchaseResult = result[MyketIAP.RESULT];
        await MyketIAP.consume(purchase: result[MyketIAP.PURCHASE]);
        if (purchaseResult.mResponse == 0) {
          successDialog(
              'پرداخت با موفقیت انجام شد'); // اینجا یه پیغام موفقیت نمایش میدی مثلا میگی از حمایت شما سپاس گزاریم یا از این چیزا
        } else {
          showErrorMessage("متاسفانه پرداخت انجام نشد.");
        }
      }
    } catch (e) {
      print(e.toString());
      if (e.toString() == "type 'Null' is not a subtype of type 'Purchase'") {
        showErrorMessage("پرداخت لغو شد");
      } else {
        showErrorMessage("خطایی در ارتباط با مایکت رخ داد.");
      }
    }
  }

  void successDialog(String text) {
    var snackBar = SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.end,
      ),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.fixed,
      duration: Duration(seconds: 2),
    );
    Navigator.of(context).pop(); // بسته شدن Drawer
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String text) {
    var snackBar = SnackBar(
      content: Text(
        text,
        textAlign: TextAlign.end,
      ),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.fixed,
      duration: Duration(seconds: 2),
    );
    Navigator.of(context).pop(); // بسته شدن Drawer
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _amountButton(Size size, String amount, String donate,StateSetter setState) {
    return InkWell(
      onTap: () {
        setState(() {
          selectDonate = donate;
        });
        
      },
      child: Container(
        alignment: Alignment.center,
        height: size.height / 21,
        width: size.width / 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: selectDonate == donate
              ? Colors.blue
              : Colors.black, // تغییر رنگ با توجه به انتخاب
        ),
        child: Text(
          amount,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  void onConfirm() {
    getDonate(selectDonate);
    Navigator.of(context).pop(); // بسته شدن Drawer

    // می‌توانید هر عمل دیگری که لازم است را اینجا انجام دهید.
  }

  @override
  void dispose() {
    MyketIAP.dispose();
    super.dispose();
  }

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
                              InkWell(
                                radius: 10,
                                onTap: () {
                                  // await getDonate();

                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return StatefulBuilder(

                                        builder: (context, setState) => BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 5, sigmaY: 5),
                                          child: Container(
                                            height: size.height / 3,
                                            width: size.width,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight: Radius.circular(20)),
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: size.height / 20,
                                                ),
                                                Text(
                                                  ':مبلغ مورد نظر خود را انتخاب کنید',
                                                  style: TextStyle(fontSize: 18),
                                                ),
                                                SizedBox(
                                                  height: size.height / 30,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    _amountButton(size, '20,000T',
                                                        "donate1",setState),
                                                    SizedBox(
                                                      width: size.width / 30,
                                                    ),
                                                    _amountButton(size, '40,000T',
                                                        "donate2",setState),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: size.height / 80,
                                                ),
                                                _amountButton(
                                                    size, '60,000T', "donate3",setState),
                                                SizedBox(
                                                  height: size.height / 40,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    onConfirm();
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: size.height / 17,
                                                    width: size.width / 2.5,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.blue,
                                                            width: 4),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                30),
                                                        color: Colors.black),
                                                    child: const Text(
                                                      'تایید',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: size.height / 21,
                                  width: size.width / 4,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white),
                                  child: const Text(
                                    'درگاه ایرانی',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  var snackBar = const SnackBar(
                                    content: Text(
                                      'این بخش فعال نمیباشد',
                                      textAlign: TextAlign.end,
                                    ),
                                    backgroundColor: Colors.red,
                                    behavior: SnackBarBehavior.fixed,
                                    duration: Duration(seconds: 2),
                                  );
                                  Navigator.of(context)
                                      .pop(); // بسته شدن Drawer
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar); // نمایش Snackbar
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: size.height / 21,
                                  width: size.width / 4,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white),
                                  child: const Text(
                                    'درگاه خارجی',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
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
                        body: InkWell(
                          onTap: () {
                            var snackBar = SnackBar(
                              content: Text(
                                '...به زودی',
                                textAlign: TextAlign.end,
                              ),
                              backgroundColor: Colors.blue,
                              behavior: SnackBarBehavior.fixed,
                              duration: Duration(seconds: 2),
                            );
                            Navigator.of(context).pop(); // بسته شدن Drawer
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          child: Container(
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
                        body: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () async {
                                  final Uri url =
                                      Uri.parse('https://t.me/aradazr');
                                  if (!await launchUrl(url)) {
                                    throw Exception('Could not launch');
                                  }
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    height: size.height / 21,
                                    width: size.width / 4,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/telegram.png',
                                          height: 20,
                                        ),
                                        SizedBox(width: size.width / 170),
                                        const Text(
                                          'Telegram',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )),
                              ),
                              InkWell(
                                onTap: () async {
                                  final Uri emailLaunchUri = Uri(
                                    scheme: 'mailto',
                                    path: 'aradazarpanah27@gmail.com',
                                    query:
                                        'subject=Your Subject Here&body=Your Message Here',
                                  );

                                  if (!await launchUrl(emailLaunchUri)) {
                                    throw 'Could not launch $emailLaunchUri';
                                  }
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    height: size.height / 21,
                                    width: size.width / 4,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/gmail.png',
                                          height: 20,
                                        ),
                                        SizedBox(width: size.width / 170),
                                        const Text(
                                          'Gmail',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
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
