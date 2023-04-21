// class Config {
//   static const String localBaseURL =
//       "https://www.axonweb.in/api/BookAppointment/";

//   static const String apiURL = localBaseURL;
//   static const String otpLoginAPI = "GenerateOTP";
//   static const String otpVerifyAPI = "ValidateOTP";
// }

import 'package:axon/Aaa.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

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
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => VerifyOTPScreen1()),
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
