// class Config {
//   static const String localBaseURL =
//       "https://www.axonweb.in/api/BookAppointment/";

//   static const String apiURL = localBaseURL;
//   static const String otpLoginAPI = "GenerateOTP";
//   static const String otpVerifyAPI = "ValidateOTP";
// }

import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:axon/Aaa.dart';
import 'package:axon/Utils/app_url.dart';
import 'package:axon/Widgets.dart/OverlayDialogWarning.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

import 'Providers/HttpClient.dart';

class SendOTPScreen1 extends StatefulWidget {
  SendOTPScreen1({Key key}) : super(key: key);

  @override
  State<SendOTPScreen1> createState() => _SendOTPScreen1State();
}

class _SendOTPScreen1State extends State<SendOTPScreen1> {
  TextEditingController mobileNumber = TextEditingController();

  void submit() async {
    if (mobileNumber.text == "") return;

    var appSignatureID = await SmsAutoFill().getAppSignature;
    Map sendOtpData = {
      "mobile_number": mobileNumber.text,
      "app_signature_id": appSignatureID
    };
    print(sendOtpData);

    var objsendotp = {"Mobile": mobileNumber.text};

    print('>>>>>>>>>>');
    print(objsendotp);
    // var appSignatureID = await SmsAutoFill().getAppSignature;

    // Map objsendotp = {
    //   "Mobile": strMobileNo.text,
    //   "app_signature_id": appSignatureID
    // };
    print('>>>>>>>>>>');
    print(objsendotp);
    final Future<Map<String, dynamic>> successfulMessage =
        HttpClient().postReq(AppUrl.sendotp, objsendotp);

    await successfulMessage.then((response) {
      print('>>>>>>>>>> Send OTP <<<<<<<<');
      print(response);
      setState(() {
        var isLoading = false;
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
                    builder: (context) =>
                        VerifyOTPScreen1(mobileNumber.text))));
        Timer(Duration(seconds: 3), () {
          // strName.clear();
          // strBirthDate.clear();
          // strMobileNo.clear();
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
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => VerifyOTPScreen1([sendOtpData].toString())),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xFFC2C0C0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: mobileNumber,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Mobile Number",
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: submit,
                child: const Text("Submit"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
