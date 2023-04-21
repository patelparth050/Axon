import 'package:axon/LoginPage.dart';
import 'package:axon/News.dart';
import 'package:flutter/material.dart';

import 'ChangeProvider.dart';
import 'Utils/SharePreference.dart';

class Settings extends StatefulWidget {
  const Settings({Key key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  UserPreferences userPreference = UserPreferences();
  String mobile;

  @override
  void initState() {
    userPreference.getMobile().then((value1) {
      setState(() {
        mobile = value1;
      });
    });

    // super.initState();
    super.initState();
  }

  //Logout Alert
  showAlertDialog(BuildContext context) async {
    // set up the button
    Widget okButton = Column(
      children: [
        SizedBox(
          width: (MediaQuery.of(context).size.width * 0.90),
          height: 40,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFD5722),
              foregroundColor: Colors.white,
              textStyle: TextStyle(color: Color(0xFFFD5722), fontSize: 18),
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(25), // <-- Radius
              // ),
            ),
            child: Text("Confirm"),
            onPressed: () {
              userPreference.logoutProcess();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPageScreen()),
                  (route) => false);
            },
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );

    Widget cancelButton = Column(
      children: [
        SizedBox(
          width: (MediaQuery.of(context).size.width * 0.90),
          height: 40,
          child: OutlinedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              // foregroundColor: Colors.white,
              textStyle: TextStyle(color: Color(0xFFFD5722), fontSize: 18),
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.circular(25), // <-- Radius
              // ),
            ),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: Text(
              "Cancel",
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Logout",
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Text("Are you sure you want to logout?"),
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(30),
      // ),
      actions: [okButton, cancelButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          elevation: 0,
          backgroundColor: Color(0xffffffff),
          leading: Padding(
            padding: EdgeInsets.only(top: 20),
            child: IconButton(
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_rounded),
            ),
          ),
          title: Padding(
            padding: EdgeInsets.only(
              top: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Settings",
                  style: TextStyle(
                    color: Colors.black,
                    // fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Provider',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade600),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.67,
                                child: Row(
                                  children: [
                                    Icon(Icons.person),
                                    Text(
                                      'AMATE HOSPITAL',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // SizedBox(
                              //   width: 109,
                              // ),
                              Container(
                                height: 30,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChangeProvider()));
                                  },
                                  child: Text(
                                    'CHANGE',
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFFFD5722),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Text('Amate'),
                          Text(
                            'Hospital,Bhogawati,Tal-Karveer,dist',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your login as',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade600),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'PARTH',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 5),
                          Text(
                            mobile,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.67,
                                height: 2,
                              ),
                              Container(
                                height: 30,
                                child: ElevatedButton(
                                  onPressed: () {
                                    showAlertDialog(context);
                                  },
                                  child: Text(
                                    'LOGOUT',
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFFFD5722),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 3),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
