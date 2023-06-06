// import 'dart:async';

// import 'package:another_flushbar/flushbar.dart';
// import 'package:axon/MyNavigationBar.dart';
// import 'package:axon/Utils/app_url.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// import 'OTPVerify.dart';
// import 'Providers/HttpClient.dart';
// import 'Widgets.dart/OverlayDialogWarning.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({Key key}) : super(key: key);

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   int group1Value;

//   final formKey = GlobalKey<FormState>();
//   final formKey1 = GlobalKey<FormState>();
//   final FocusNode _nodeName = FocusNode();
//   final FocusNode _nodeBirthDate = FocusNode();
//   final FocusNode _nodeMobileNo = FocusNode();
//   TextEditingController strName = TextEditingController();
//   TextEditingController strBirthDate = TextEditingController();
//   TextEditingController strMobileNo = TextEditingController();
//   bool _enableBtn = false;
//   bool isLoading = false;

// // Calling Send OTP Method
//   _sendOTP() async {
//     var objsendotp = {"phone": strMobileNo.text};

//     print('>>>>>>>>>>');
//     print(objsendotp);
//     final Future<Map<String, dynamic>> successfulMessage =
//         HttpClient().postReq(AppUrl.sendotp, objsendotp);

//     await successfulMessage.then((response) {
//       print('>>>>>>>>>> Send OTP <<<<<<<<');
//       print(response);
//       setState(() {
//         isLoading = false;
//       });
//       if (response['status'] == true) {
//         Flushbar(
//           message: 'Otp Sent Successfully',
//           duration: Duration(seconds: 5),
//         ).show(context);
//         // formKey.currentState.reset();

//         Timer(
//             Duration(seconds: 1),
//             () => Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => OTPVerifyScreen(strMobileNo.text))));
//         Timer(Duration(seconds: 3), () {
//           // strName.clear();
//           // strBirthDate.clear();
//           // strMobileNo.clear();
//         });
//       } else {
//         showDialog(
//             context: context,
//             builder: (_) => OverlayDialogWarning(
//                 message: response['message'].toString(),
//                 showButton: true,
//                 dialogType: DialogType.Warning));
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.all(10),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 50,
//                   ),
//                   Container(
//                     height: 200,
//                     child: Image.asset(
//                       'images/axon.png',
//                     ),
//                   ),
//                   Card(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             height: 15,
//                           ),
//                           Text(
//                             'Login with your details',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 25,
//                               color: Colors.black,
//                               fontWeight: FontWeight.w400,
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           Form(
//                               key: formKey,
//                               onChanged: () => setState(() =>
//                                   _enableBtn = formKey.currentState.validate()),
//                               child: Column(
//                                 children: [
//                                   TextFormField(
//                                     focusNode: _nodeName,
//                                     controller: strName,
//                                     keyboardType: TextInputType.text,
//                                     validator: (value) => value.isEmpty
//                                         ? "Please enter full name"
//                                         : null,
//                                     autovalidateMode:
//                                         AutovalidateMode.onUserInteraction,
//                                     textInputAction: TextInputAction.next,
//                                     decoration: InputDecoration(
//                                       hintText: 'Full Name',
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 15,
//                                   ),
//                                   TextFormField(
//                                     focusNode: _nodeBirthDate,
//                                     controller: strBirthDate,
//                                     keyboardType: TextInputType.text,
//                                     validator: (value) => value.isEmpty
//                                         ? "Please enter BirthDate"
//                                         : null,
//                                     autovalidateMode:
//                                         AutovalidateMode.onUserInteraction,
//                                     textInputAction: TextInputAction.next,
//                                     decoration: InputDecoration(
//                                       hintText: 'Birthday(optional)',
//                                     ),
//                                     onTap: () async {
//                                       DateTime pickedDate =
//                                           await showDatePicker(
//                                         context: context,
//                                         initialDate: DateTime.now(),
//                                         firstDate: DateTime(2000),
//                                         lastDate: DateTime(2101),
//                                       );
//                                       if (pickedDate != null) {
//                                         String formattedDate =
//                                             DateFormat("yyyy-MM-dd")
//                                                 .format(pickedDate);
//                                         setState(() {
//                                           strBirthDate.text =
//                                               formattedDate.toString();
//                                         });
//                                       } else {
//                                         print('Not selected');
//                                       }
//                                     },
//                                   ),
//                                   SizedBox(height: 20),
//                                   Row(
//                                     children: [
//                                       Container(
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           children: [
//                                             Radio(
//                                               value: 0,
//                                               activeColor: Color(0xFFFD5722),
//                                               groupValue: group1Value,
//                                               onChanged: (value) {
//                                                 setState(() {
//                                                   group1Value = value;
//                                                 });
//                                               },
//                                             ),
//                                             Container(
//                                               child: Text(
//                                                 "Male",
//                                                 style: const TextStyle(
//                                                   fontSize: 20.0,
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 5,
//                                       ),
//                                       Container(
//                                         child: Row(
//                                           children: [
//                                             Radio(
//                                               value: 1,
//                                               activeColor: Colors.white,
//                                               groupValue: group1Value,
//                                               onChanged: (value) {
//                                                 setState(() {
//                                                   group1Value = value;
//                                                 });
//                                               },
//                                             ),
//                                             Container(
//                                               child: Text(
//                                                 "Female",
//                                                 style: const TextStyle(
//                                                   fontSize: 20.0,
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 63,
//                                       ),
//                                       TextButton(
//                                         onPressed: _enableBtn
//                                             ? () => MyNavigationBar()
//                                             : null,
//                                         child: Text(
//                                           'SAVE',
//                                           style: TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w600,
//                                               color: Color(0xFFFD5722)),
//                                         ),
//                                         style: TextButton.styleFrom(
//                                           elevation: 0,
//                                           backgroundColor: Color(0X00000000),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: 20,
//                                   ),
//                                 ],
//                               ))
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 30),
//                   Card(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             height: 15,
//                           ),
//                           Form(
//                               key: formKey1,
//                               onChanged: () => setState(() => _enableBtn =
//                                   formKey1.currentState.validate()),
//                               child: Column(
//                                 children: [
//                                   TextFormField(
//                                     focusNode: _nodeMobileNo,
//                                     controller: strMobileNo,
//                                     keyboardType: TextInputType.text,
//                                     validator: (value) => value.isEmpty
//                                         ? "Please enter MobileNo"
//                                         : null,
//                                     autovalidateMode:
//                                         AutovalidateMode.onUserInteraction,
//                                     textInputAction: TextInputAction.next,
//                                     decoration: InputDecoration(
//                                       hintText: 'Mobile Number(10 digit)',
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     height: 10,
//                                   ),
//                                   Row(
//                                     children: [
//                                       SizedBox(width: 220),
//                                       TextButton(
//                                         onPressed: _enableBtn
//                                             ? () => _sendOTP()
//                                             : null,
//                                         child: Text(
//                                           'Request OTP',
//                                           style: TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w600,
//                                               color: Color(0xFFFD5722)),
//                                         ),
//                                         style: TextButton.styleFrom(
//                                             elevation: 0,
//                                             primary: Color(0xFFFD5722)
//                                             // backgroundColor: Color(0X00000000),
//                                             ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ))
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:another_flushbar/flushbar.dart';
import 'package:axon/Utils/app_url.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'OTPVerify.dart';
import 'Providers/HttpClient.dart';
import 'Utils/SharePreference.dart';
import 'Widgets.dart/OverlayDialogWarning.dart';

class LoginPageScreen extends StatefulWidget {
  const LoginPageScreen({Key key}) : super(key: key);

  @override
  State<LoginPageScreen> createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPageScreen> {
  int group1Value;
  bool isUser = false;

  final formKey1 = GlobalKey<FormState>();
  UserPreferences userPreference = UserPreferences();

  final FocusNode _nodeMobileNo = FocusNode();
  TextEditingController strName = TextEditingController();
  TextEditingController strBirthDate = TextEditingController();
  TextEditingController strMobileNo = TextEditingController();
  bool _enableBtn = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    userPreference.isUser().then((value) {
      setState(() {
        isUser = value;
      });
    });
  }

// Calling Send OTP Method
  _sendOTP() async {
    var objsendotp = {"Mobile": strMobileNo.text};

    print('>>>>>>>>>>');
    print(objsendotp);
    var appSignatureID = await SmsAutoFill().getAppSignature;

    Map objsendotp1 = {
      "Mobile": strMobileNo.text,
      "app_signature_id": appSignatureID
    };
    print(objsendotp1);
    print('0000000000000000000000000000000000000000000000000000000000');
    print('>>>>>>>>>>');
    print(objsendotp);
    final Future<Map<String, dynamic>> successfulMessage =
        HttpClient().postReq(AppUrl.sendotp, objsendotp);

    await successfulMessage.then((response) {
      print('>>>>>>>>>> Send OTP <<<<<<<<');
      print(response);
      setState(() {
        isLoading = false;
      });
      if (response['status'] == true) {
        Flushbar(
          message: 'Otp Sent Successfully',
          duration: Duration(seconds: 5),
        ).show(context);
        // formKey.currentState.reset();

        Timer(
            Duration(seconds: 1),
            () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OTPVerifyScreen(strMobileNo.text))));
        Timer(Duration(seconds: 3), () {
          // strName.clear();
          // strBirthDate.clear();
          strMobileNo.clear();
        });
      } else {
        showDialog(
            context: context,
            builder: (_) => OverlayDialogWarning(
                message: response['displayMessage'].toString(),
                showButton: true,
                dialogType: DialogType.Warning));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 200,
                    child: Image.asset(
                      'images/axon.png',
                    ),
                  ),
                  SizedBox(height: 30),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Form(
                              key: formKey1,
                              onChanged: () => setState(
                                  () => formKey1.currentState.validate()),
                              child: Column(
                                children: [
                                  TextFormField(
                                    focusNode: _nodeMobileNo,
                                    controller: strMobileNo,
                                    keyboardType: TextInputType.number,
                                    validator: (value) => value.isEmpty
                                        ? "Please enter MobileNo"
                                        : null,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      hintText: 'Mobile Number(10 digit)',
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.58),
                                      TextButton(
                                        onPressed: () {
                                          _sendOTP();
                                        },
                                        child: Text(
                                          'Request OTP',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFFFD5722)),
                                        ),
                                        style: TextButton.styleFrom(
                                            elevation: 0,
                                            primary: Color(0xFFFD5722)
                                            // backgroundColor: Color(0X00000000),
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
