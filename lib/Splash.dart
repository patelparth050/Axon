import 'dart:async';
import 'package:axon/Aaa.dart';
import 'package:flutter/material.dart';

import 'LoginPage.dart';
import 'MyNavigationBar.dart';
import 'Utils/SharePreference.dart';
import 'Utils/Singleton.dart';

class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  UserPreferences userPreference = UserPreferences();
  bool isLogin = false;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Singleton().getUserFullName();
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () async {
      // isLogin =
      // Check Login Status Here
      isLogin = await userPreference.isLoggedIn();
      print(isLogin);
      if (isLogin) {
        // is Logged In
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => MyNavigationBar(selectedIndex)),
            (route) => false);
      } else {
        // Open Welcome Screen
        Singleton().isLogin = false;
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => LoginPageScreen()));
      }
    });

    return Scaffold(
        body: Stack(alignment: Alignment.bottomCenter, children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            // padding: EdgeInsets.all(32),
            //     decoration: BoxDecoration(
            //   color: Colors.white,
            //   image: DecorationImage(
            //       image: AssetImage(
            //         "images/axon.jpg",
            //       ),
            //       fit: BoxFit.cover),
            // )
            ),
      ),
    ]));
  }
}
