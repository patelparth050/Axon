import 'package:axon/LoginPage.dart';
import 'package:axon/MyNavigationBar.dart';
import 'package:axon/config.dart';
import 'package:flutter/material.dart';

import 'Aaa.dart';
import 'ChangeProvider.dart';
import 'News.dart';
import 'OTPVerify.dart';
import 'SelectAppointmentDate.dart';
import 'Splash.dart';
import 'demo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RAD',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      home: Splash(),
      // Calendar(),
    );
  }
}
