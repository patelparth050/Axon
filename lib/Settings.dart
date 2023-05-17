import 'package:axon/LoginPage.dart';

import 'package:flutter/material.dart';

import 'ChangeProvider.dart';
import 'Providers/HttpClient.dart';
import 'Utils/Loader.dart';
import 'Utils/SharePreference.dart';
import 'Utils/app_url.dart';
import 'Widgets.dart/OverlayDialogWarning.dart';

class Settings extends StatefulWidget {
  const Settings({Key key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  UserPreferences userPreference = UserPreferences();
  String mobile;
  bool isLoading = false;
  String token;
  List customerData = [];

  @override
  void initState() {
    userPreference.getMobile().then((value1) {
      setState(() {
        mobile = value1;
      });
    });

    userPreference.getToken().then((value) {
      setState(() {
        token = value;
      });

      setState(() {
        _getDoctorDetails();
      });
    });
    // super.initState();
    super.initState();
  }

  _getDoctorDetails() async {
    print("Call GetDoctorDetailsByToken method");

    FocusScope.of(context).unfocus(); // Used foe dismiss keyboard
    setState(() {
      isLoading = true;
    });
    var obj = {
      "customerToken": token,
      // "68cb311f-585a-4e86-8e89-06edf1814080": token,
    };
    print('>>>>>>>>>>');
    print(obj);

    final Future<Map<String, dynamic>> successfulMessage = HttpClient().getReq(
        AppUrl.getcustomerdetails + "?CustomerToken=" + token.toString());

    await successfulMessage.then((response) {
      print('>>>>>>>>>> Get Data <<<<<<<<');
      print(response);

      setState(() {
        isLoading = false;
      });

      if (response['status'] == true) {
        setState(() {
          customerData = response['data'];
          // _myJson = response['data'];

          // doctorId = doctorData[0]['doctorId'];
        });
        print(">>>>>>>>>>>>>>");
        print(customerData);
        // print(doctorId);
      } else {
        showDialog(
            context: context,
            builder: (_) => OverlayDialogWarning(
                message: response['message'].toString(),
                showButton: true,
                dialogType: DialogType.Warning));
      }
    });
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
      backgroundColor: Colors.grey.shade200,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          elevation: 0,
          backgroundColor: Color(0xffffffff),
          leading: Padding(
            padding: EdgeInsets.only(top: 5.0),
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
              top: 5.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Settings",
                  style: TextStyle(
                    color: Colors.black,
                    // fontWeight: FontWeight.bold,
                    fontSize: 22,
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
              child: isLoading
                  ? isLoading
                      ? Container()
                      : Container()
                  : Column(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      // width: MediaQuery.of(context).size.width * 0.68,
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                customerData[0]
                                                    ['customerLogo']),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            customerData[0]['customerName'],
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // SizedBox(
                                    //   width: 109,
                                    // ),
                                    //
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
                                        child: Text('CHANGE'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFFFD5722),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Text(
                                  customerData[0]['customerAddress'],
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
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
                                // Text(
                                //   'PARTH',
                                //   style: TextStyle(fontWeight: FontWeight.w500),
                                // ),
                                SizedBox(height: 5),
                                Text(
                                  mobile,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      // width: MediaQuery.of(context).size.width * 0.68,
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
          ),
          isLoading ? Loader() : Container(),
        ],
      ),
    );
  }
}
