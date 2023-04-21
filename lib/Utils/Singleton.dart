import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'SharePreference.dart';

class Singleton {
  // ignore: close_sinks
  UserPreferences userPref = UserPreferences();
  final StreamController<int> streamController =
      StreamController<int>.broadcast();
  static final Singleton _singleton = Singleton._internal();
  UserPreferences userPreference = UserPreferences();
  BuildContext context;
  bool isLogin = false;
  String userName = "";

  factory Singleton() {
    return _singleton;
  }

  Singleton._internal();

  showAlert(context, title, message) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                // TextButton(
                //   onPressed: () => Navigator.pop(context, 'Cancel'),
                //   child: const Text('Cancel'),
                // ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ));
  }

  getUserFullName() async {
    String userInfoJson = await userPref.getLoginInfo();
    if (userInfoJson != null) {
      var jsonObject = jsonDecode(userInfoJson); //as Map<String, dynamic>;
      userName = jsonObject["fullName"];
    }
  }

  printMessage(Object message) {
    print(message);
  }
}
