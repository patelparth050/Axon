import 'package:axon/Splash.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'ChangeProvider.dart';
import 'Utils/colors_util.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, DeviceType) {
      return MaterialApp(
        title: 'Axon',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: AppPrimaryColor,
        ),
        home: ChangeProvider(),
        // Calendar(),
      );
    });
  }
}
