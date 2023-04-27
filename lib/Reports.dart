import 'dart:io';

import 'package:axon/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'MyNavigationBar.dart';
import 'Settings.dart';
import 'Widgets.dart/OverlayDialogWarning.dart';

class Reports extends StatefulWidget {
  const Reports({Key key}) : super(key: key);

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  int selectedIndex = 3;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  whatsapp() async {
    var contact = "+916353335967";
    var androidUrl = "whatsapp://send?phone=$contact&text=";
    var iosUrl = "https://wa.me/$contact?text=${Uri.parse('')}";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception {
      showDialog(
          context: context,
          builder: (_) => OverlayDialogWarning(
              message: "WhatsApp is not installed",
              showButton: true,
              dialogType: DialogType.Warning));
      // EasyLoading.showError('WhatsApp is not installed.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          elevation: 0,
          backgroundColor: Color(0xffffffff),
          title: Padding(
            padding: EdgeInsets.only(
              top: 5.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 69,
                  width: MediaQuery.of(context).size.width * 0.10,
                  child: Image.asset('images/axon-icon.png'),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.46,
                  child: Text(
                    "  Recent Precription",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.34,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          whatsapp();
                        },
                        child: Container(
                          margin: EdgeInsets.all(8),
                          height: 27,
                          child: Image.asset('images/whatsapp.png'),
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.all(8),
                          height: 27,
                          child: Image.asset('images/rupee.png'),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Settings()));
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(8, 8, 0, 8),
                          height: 27,
                          child: Image.asset('images/settings.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('showModalBottomSheet'),
          onPressed: () {
            showModalBottomSheet<void>(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return DialogStatefull();
              },
            );
          },
        ),
      ),
    );
  }
}

class DialogStatefull extends StatefulWidget {
  const DialogStatefull({Key key}) : super(key: key);

  @override
  State<DialogStatefull> createState() => _DialogStatefullState();
}

class _DialogStatefullState extends State<DialogStatefull> {
  int selected = 0;
  String genderValue;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, state) {
      return Container(
        height: 660,
        color: Colors.amber,
        child: Center(
          child: Column(
            children: [
              customRadio("helo", 0),
              customRadio("helo", 1),
              customRadio("helo", 2),
              Radio(
                value: 'Cunsultation',
                activeColor: Color(0xFFFD5722),
                groupValue: genderValue,
                onChanged: (value) {
                  setState(() {
                    genderValue = value;
                  });
                },
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget customRadio(String text, int index) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          selected = index;
          print(index);
          print(selected);
        });
      },
      child: Text(
        '',
        style:
            TextStyle(color: (selected == index) ? Colors.white : Colors.grey),
      ),
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        primary: Colors.white,
        backgroundColor: (selected == index) ? Colors.deepOrange : Colors.white,
      ),
      // style: OutlinedButton.styleFrom(
      //   primary: Colors.white,
      //   backgroundColor: (selected == index) ? Colors.deepOrange : Colors.white,
      // ),
    );
  }
}
      // body: RefreshIndicator(
      //   color: Colors.black,
      //   backgroundColor: Colors.white,
      //   strokeWidth: 2.0,
      //   onRefresh: () async {
      //     Navigator.pushReplacement(
      //       context,
      //       PageRouteBuilder(
      //         pageBuilder: (a, b, c) => MyNavigationBar(selectedIndex),
      //         transitionDuration: Duration(seconds: 2),
      //       ),
      //       // MaterialPageRoute(
      //       //   builder: (context) => Events(),
      //       // ),
      //     );
      //     // return Future.value(false);
      //     await Future.delayed(Duration(seconds: 3));
      //   },
      //   child: Stack(
      //     children: [
      //       SingleChildScrollView(
      //         physics: const AlwaysScrollableScrollPhysics(),
      //         child: Padding(
      //           padding: EdgeInsets.all(15),
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             children: [
      //               SizedBox(
      //                 height: 10,
      //               ),
      //               Center(
      //                 child: Text(
      //                   'Swipe down to refresh page',
      //                   textAlign: TextAlign.center,
      //                   style: TextStyle(
      //                     fontSize: 20,
      //                     color: Color(0XFF545454),
      //                     fontWeight: FontWeight.w600,
      //                   ),
      //                 ),
      //               ),
      //               SizedBox(
      //                 height: 120,
      //               ),
      //               Center(
      //                 child: Image.asset(
      //                   'images/axon.jpg',
      //                   height: 90,
      //                   width: 90,
      //                 ),
      //               ),
      //               SizedBox(
      //                 height: 20,
      //               ),
      //               Center(
      //                 child: Text(
      //                   'You  don\'t have any recent prescriptions',
      //                   textAlign: TextAlign.center,
      //                   style: TextStyle(
      //                       fontSize: 20,
      //                       color: Color(0XFF545454),
      //                       fontWeight: FontWeight.w600),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
