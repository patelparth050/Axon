// import 'package:flutter/material.dart';
// import 'package:sms_autofill/sms_autofill.dart';

// class VerifyOTPScreen1 extends StatefulWidget {
//   const VerifyOTPScreen1({Key key}) : super(key: key);

//   @override
//   State<VerifyOTPScreen1> createState() => _VerifyOTPScreen1State();
// }

// class _VerifyOTPScreen1State extends State<VerifyOTPScreen1> with CodeAutoFill {
//   String codeValue = "";
//   @override
//   void codeUpdated() {
//     print("Update code $code");
//     setState(() {
//       print("codeUpdated");
//     });
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     listenOtp();
//   }

//   void listenOtp() async {
//     await SmsAutoFill().unregisterListener();
//     listenForCode();
//     await SmsAutoFill().listenForCode;
//     print("OTP listen Called");
//   }

//   @override
//   void dispose() {
//     SmsAutoFill().unregisterListener();
//     print("unregisterListener");
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Padding(
//         padding: const EdgeInsets.all(30.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Center(
//               child: PinFieldAutoFill(
//                 currentCode: codeValue,
//                 codeLength: 4,
//                 onCodeChanged: (code) {
//                   print("onCodeChanged $code");
//                   setState(() {
//                     codeValue = code.toString();
//                   });
//                 },
//                 onCodeSubmitted: (val) {
//                   print("onCodeSubmitted $val");
//                 },
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   print(codeValue);
//                 },
//                 child: const Text("Verify OTP")),
//             ElevatedButton(onPressed: listenOtp, child: const Text("Resend"))
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:axon/ChangeProvider.dart';
import 'package:axon/Utils/Loader.dart';
import 'package:axon/Utils/app_url.dart';
import 'package:axon/Widgets.dart/OverlayDialogWarning.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'Providers/HttpClient.dart';

class VerifyOTPScreen1 extends StatefulWidget {
  String MobileNumber;
  VerifyOTPScreen1(this.MobileNumber);

  @override
  State<VerifyOTPScreen1> createState() =>
      _VerifyOTPScreen1State(this.MobileNumber);
}

class _VerifyOTPScreen1State extends State<VerifyOTPScreen1> with CodeAutoFill {
  String MobileNumber;
  _VerifyOTPScreen1State(this.MobileNumber);

  String codeValue = "";
  String otpText = "";

  bool isLoading = false;
  @override
  void codeUpdated() {
    print("Update code $code");
    setState(() {
      print("codeUpdated");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listenOtp();
  }

  void listenOtp() async {
    await SmsAutoFill().unregisterListener();
    listenForCode();
    await SmsAutoFill().listenForCode;
    print("OTP listen Called");
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    print("unregisterListener");
    super.dispose();
  }

  _verifyOTP() async {
    FocusScope.of(context).unfocus(); // Used foe dismiss keyboard

    if (otpText == '') {
      showDialog(
          context: context,
          builder: (_) => OverlayDialogWarning(
              message: "Enter OTP",
              showButton: true,
              dialogType: DialogType.Warning));
    } else {
      setState(() {
        isLoading = true;
      });
      var objverifyotp = {"Mobile": MobileNumber, "OTP": otpText};

      print('>>>>>>>>>>');
      print(objverifyotp);
      final Future<Map<String, dynamic>> successfulMessage =
          HttpClient().postReq(AppUrl.verifyotp, objverifyotp);

      await successfulMessage.then((response) {
        print('>>>>>>>>>> Send OTP <<<<<<<<');
        print(response);
        setState(() {
          isLoading = false;
        });
        if (response['status'] == true) {
          Flushbar(
            message: response['displayMessage'].toString(),
            duration: Duration(seconds: 5),
          ).show(context);
          // Navigator.pop(context);

          Timer(
              Duration(seconds: 1),
              () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChangeProvider())));
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
  }

// Calling Resend OTP Method
  _resendOTP() async {
    FocusScope.of(context).unfocus(); // Used foe dismiss keyboard
    setState(() {
      isLoading = true;
    });
    var objsendotp = {"Mobile": MobileNumber};

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: PinFieldAutoFill(
                currentCode: codeValue,
                codeLength: 4,
                onCodeChanged: (code) {
                  print("onCodeChanged $code");
                  setState(() {
                    codeValue = code.toString();
                  });
                },
                onCodeSubmitted: (val) {
                  print("onCodeSubmitted $val");
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  print("codeValue");
                  print(codeValue);
                  print("codeValue");
                  _verifyOTP();
                },
                child: const Text("Verify OTP")),
            ElevatedButton(
              onPressed: listenOtp,
              child: const Text("Resend"),
            ),
            isLoading ? Loader() : Container(),
          ],
        ),
      ),
    );
  }
}
