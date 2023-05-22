import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'Providers/HttpClient.dart';
import 'Utils/SharePreference.dart';
import 'Utils/app_url.dart';
import 'Widgets.dart/OverlayDialogWarning.dart';

class AppointmentDetails extends StatefulWidget {
  String outputDate;
  String doctorName;
  String appointmentTime;
  String patientName;
  String status;
  String appointmentId;

  AppointmentDetails(this.outputDate, this.doctorName, this.appointmentTime,
      this.patientName, this.status, this.appointmentId);

  @override
  _AppointmentDetailsState createState() => _AppointmentDetailsState(
        this.outputDate,
        this.doctorName,
        this.appointmentTime,
        this.patientName,
        this.status,
        this.appointmentId,
      );
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  String outputDate;
  String doctorName;
  String appointmentTime;
  String patientName;
  String status;
  String appointmentId;
  String token;

  _AppointmentDetailsState(this.outputDate, this.doctorName,
      this.appointmentTime, this.patientName, this.status, this.appointmentId);
  UserPreferences userPreference = UserPreferences();

  bool isLoading = false;
  @override
  void initState() {
    userPreference.getToken().then((value) {
      setState(() {
        token = value;
      });
      setState(() {
        // _cancelAppointmentDetails();
      });
    });
    // super.initState();
    super.initState();
  }

// Calling Send OTP Method
  _cancelAppointmentDetails() async {
    setState(() {
      isLoading = true;
    });
    var objsendotp = {
      "customerToken": token,
      "appointmentId": appointmentId,
    };

    // print('>>>>>>>>>>');
    // print(objsendotp);
    // var appSignatureID = await SmsAutoFill().getAppSignature;

    // Map objsendotp = {
    //   "Mobile": strMobileNo.text,
    //   "app_signature_id": appSignatureID
    // };
    print('>>>>>>>>>>');
    print(objsendotp);
    final Future<Map<String, dynamic>> successfulMessage =
        HttpClient().postReq(AppUrl.cancelappointment, objsendotp);

    await successfulMessage.then((response) {
      print('>>>>>>>>>> BOOK APPOINTMENT <<<<<<<<');
      print(response);
      setState(() {
        isLoading = false;
      });
      if (response['status'] == false) {
        setState(() {
          // appointmentData = response['data'];
        });
        print('77777777777777777777777777777777777777777777777777');
        // print(appointmentData);
        print('77777777777777777777777777777777777777777777777777');

        // Flushbar(
        //   message: 'Appointment Book Successfully',
        //   duration: Duration(seconds: 5),
        // ).show(context);
        // // formKey.currentState.reset();

        // Timer(
        //     Duration(seconds: 1),
        //     () => Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => Appointment(appointmentData))));
        // Timer(Duration(seconds: 3), () {
        //   // strName.clear();
        //   // strBirthDate.clear();
        //   // strMobileNo.clear();
        // });
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

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "Cancel",
        style: TextStyle(
          fontSize: 15,
          color: Color(0xFFFD5722),
        ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "Continue",
        style: TextStyle(
          fontSize: 15,
          color: Color(0xFFFD5722),
        ),
      ),
      onPressed: () {
        showAlert(context);
        _cancelAppointmentDetails();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirm"),
      content: Text("Are you sure want to cancel Appointment?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlert(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: TextStyle(
          fontSize: 15,
          color: Color(0xFFFD5722),
        ),
      ),
      onPressed: () {
        Navigator.of(context)
          ..pop()
          ..pop();
        status = 'canceled';
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("Appointment cancelled"),
      actions: [
        okButton,
      ],
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
                  "Appointment",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        color: Colors.black,
        backgroundColor: Colors.white,
        strokeWidth: 2.0,
        onRefresh: () async {
          print('object');
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (a, b, c) => AppointmentDetails(
                  outputDate,
                  doctorName,
                  appointmentTime,
                  patientName,
                  status,
                  appointmentId),
              transitionDuration: Duration(seconds: 0),
            ),
            // MaterialPageRoute(
            //   builder: (context) => Events(),
            // ),
          );

          return Future.value(false);
          // await Future.delayed(Duration(seconds: 3));
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                child: Column(
                  children: [
                    Card(
                      // margin: EdgeInsets.all(3),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 400,
                              height: 5,
                            ),
                            Text(
                              'Your Appointment is booked for:',
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Provider',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              doctorName,
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Patient',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              patientName,
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 400,
                              height: 5,
                            ),
                            Text(
                              'Remember to visit' + ' ' + doctorName,
                              // + historyData['doctorName'],
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.perm_contact_calendar),
                                Text(
                                  outputDate,
                                  // 'Wed 19-April-2023',
                                  style: TextStyle(
                                    fontSize: 19,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.punch_clock),
                                Text(
                                  appointmentTime,
                                  style: TextStyle(
                                    fontSize: 19,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 52.w,
                                ),
                                TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "SAVE TO CALENDER",
                                      style: TextStyle(
                                        color: Color(0xFFFD5722),
                                      ),
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 400,
                              // height: 10,
                            ),
                            Text(
                              'Your Appointment Status:',
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 71.w,
                                  child: Text(
                                    status,
                                    // 'aaaa',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xFFFD5722),
                                    ),
                                  ),
                                ),
                                // SizedBox(
                                //   width: MediaQuery.of(context).size.width * 0.60,
                                // ),
                                TextButton(
                                  onPressed: () {
                                    showAlertDialog(context);
                                  },
                                  child: status == 'Booked'
                                      ? Text(
                                          'CANCEL',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Color(0xFFFD5722),
                                          ),
                                        )
                                      : Container(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 40,
                      width: 170,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFFFD5722),
                        ),
                        child: Text(
                          'RETURN TO HOME',
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
