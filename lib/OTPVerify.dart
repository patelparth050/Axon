import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:axon/ChangeProvider.dart';
import 'package:axon/MyNavigationBar.dart';
import 'package:axon/Utils/SharePreference.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'Providers/HttpClient.dart';
import 'Utils/Loader.dart';
import 'Utils/app_url.dart';
import 'Widgets.dart/OverlayDialogWarning.dart';

class OTPVerifyScreen extends StatefulWidget {
  String MobileNumber;
  OTPVerifyScreen(this.MobileNumber);
  @override
  // State<OTPVerifyScreen>
  State<OTPVerifyScreen> createState() =>
      _OTPVerifyScreenState(this.MobileNumber);
}

class _OTPVerifyScreenState extends State<OTPVerifyScreen> {
  String MobileNumber;
  _OTPVerifyScreenState(this.MobileNumber);

  bool isLoading = false;
  UserPreferences userPreference = UserPreferences();

  String otpText = "";
  final FocusNode _nodeOTP = FocusNode();

  final interval = const Duration(seconds: 1);

  final int timerMaxSeconds = 30;

  int currentSeconds = 0;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}:${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  startTimeout([int milliseconds]) {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      setState(() {
        print(timer.tick);
        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds) timer.cancel();
      });
    });
  }

  @override
  void initState() {
    startTimeout();
    super.initState();
  }

// Calling Verify OTP Method
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
          setState(() {
            userPreference.setMobile(MobileNumber);
          });
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
        body: Stack(
      children: [
        Theme(
          data: Theme.of(context).copyWith(
            disabledColor: Colors.grey,
            iconTheme: IconTheme.of(context).copyWith(
              color: Color(0xFFFD5722),
              size: 35,
            ),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 55),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // SizedBox(height: 10),
                        Text(
                          'Verification Code',
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 30),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'We have send you a verification ',
                                style:
                                    TextStyle(fontSize: 20, color: Colors.grey),
                              ),
                              TextSpan(
                                text: 'code on ',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                ),
                              ),
                              TextSpan(
                                text: MobileNumber,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 50),
                        PinCodeTextField(
                          errorTextSpace: 25,
                          validator: (value) {
                            if (value.length < 4) {
                              return "\nPlease enter valid OTP";
                            } else {
                              return null;
                            }
                          },
                          focusNode: _nodeOTP,
                          appContext: context,
                          enableActiveFill: false,
                          pastedTextStyle: TextStyle(
                            color: Color((0xFF989898)),
                            fontWeight: FontWeight.bold,
                          ),
                          length: 4,
                          animationType: AnimationType.scale,
                          pinTheme: PinTheme(
                            activeColor: Color((0xFF989898)),
                            activeFillColor: Colors.white,
                            inactiveColor:
                                Color((0xFF989898)).withOpacity(0.53),
                            inactiveFillColor:
                                Color((0xFF989898)).withOpacity(0.53),
                            selectedColor: Colors.green[300],
                            selectedFillColor: Colors.white,
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 60,
                            fieldWidth: 60,
                            // hasError ? Colors.blue : Colors.white,
                          ),
                          cursorColor: Colors.black,
                          animationDuration: Duration(milliseconds: 300),
                          // errorAnimationController: errorController,
                          // controller: textEditingController,
                          keyboardType: TextInputType.number,
                          boxShadows: [
                            BoxShadow(
                              offset: Offset(0, 1),
                              color: Colors.black12,
                              blurRadius: 30,
                            )
                          ],
                          onCompleted: (v) {},
                          onTap: () {},
                          onChanged: (value) {
                            setState(() {
                              otpText = value;
                            });
                          },
                          beforeTextPaste: (text) {
                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                            return true;
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Didn't receive a code?",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(timerText,
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300))
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                _resendOTP();
                              },
                              child: Text(
                                "Resend Code",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Color((0xFF989898)),
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                            height: 52,
                            width: 274,
                            child: ElevatedButton(
                              onPressed: () {
                                _verifyOTP();
                              },
                              child: Text(
                                'Verify OTP',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFFFD5722),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(25), // <-- Radius
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        isLoading ? Loader() : Container(),
      ],
    ));
  }
}
