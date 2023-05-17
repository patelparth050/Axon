import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'Providers/HttpClient.dart';
import 'Utils/SharePreference.dart';
import 'Utils/app_url.dart';
import 'Widgets.dart/OverlayDialogWarning.dart';

class Appointment extends StatefulWidget {
  var appointmentData;
  Appointment(this.appointmentData);

  @override
  _AppointmentState createState() => _AppointmentState(this.appointmentData);
}

class _AppointmentState extends State<Appointment> {
  var appointmentData;
  _AppointmentState(this.appointmentData);
  UserPreferences userPreference = UserPreferences();
  String token;
  bool isLoading = false;
  var historyData;
  var title;

  @override
  void initState() {
    setState(() {
      print('8888888888888888888888888888888888888888888888888888');
      print(appointmentData);
      print('88888888888888888888888888888888888888888888888888888');
    });

    super.initState();
  }

  // _getAppointmentHistory() async {
  //   print("Call GetAppointmentHistoryByToken&DeviceId method");

  //   FocusScope.of(context).unfocus(); // Used foe dismiss keyboard
  //   setState(() {
  //     isLoading = true;
  //   });
  //   var obj = {
  //     "customerToken": token,
  //     // "68cb311f-585a-4e86-8e89-06edf1814080": token,
  //   };
  //   print('>>>>>>>>>>');
  //   print(obj);

  //   final Future<Map<String, dynamic>> successfulMessage = HttpClient().getReq(
  //       AppUrl.getappointmenthistory +
  //           "?DeviceId=" +
  //           "DESKTOP" +
  //           "&CustomerToken=" +
  //           token.toString());

  //   await successfulMessage.then((response) {
  //     print('>>>>>>>>>> Get Data <<<<<<<<');
  //     print(response);

  //     setState(() {
  //       isLoading = false;
  //     });

  //     if (response['status'] == true) {
  //       setState(() {
  //         historyData = response['data'];
  //         // title = response['data'][0]['doctorName'];
  //       });
  //       print(">>>>>>>>>>>>>>");
  //       print(historyData);
  //       print(title);
  //     } else {
  //       showDialog(
  //           context: context,
  //           builder: (_) => OverlayDialogWarning(
  //               message: response['message'].toString(),
  //               showButton: true,
  //               dialogType: DialogType.Warning));
  //     }
  //   });
  // }
  _cancelAppointmentDetails() async {
    setState(() {
      isLoading = true;
    });
    var objsendotp = {
      "customerToken": token,
      "appointmentId": appointmentData['appointmentId'],
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
    String date = appointmentData["apptDate"];
    DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('E d-MMMM-yyyy');
    var outputFormat1 = DateFormat('E,yyyy');
    var outputFormat2 = DateFormat('d MMM');
    var outputFormat3 = DateFormat('hh:mm a');
    // var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    var outputDate1 = outputFormat1.format(inputDate);
    var outputDate2 = outputFormat2.format(inputDate);
    var outputDate3 = outputFormat3.format(inputDate);
    print('|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||');
    print(outputDate);
    print('|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||');
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: EdgeInsets.only(top: 100, left: 8, right: 8),
        child: Column(
          children: [
            Text(
              'Booking Successful',
              style: TextStyle(
                fontSize: 33,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFD5722),
              ),
            ),
            SizedBox(height: 6),
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
                      appointmentData['doctorName'],
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Patient',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      appointmentData['name'],
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
                      'Remember to visit' + ' ' + appointmentData['doctorName'],
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
                          outputDate3,
                          style: TextStyle(
                            fontSize: 19,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.50,
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
                          width: MediaQuery.of(context).size.width * 0.72,
                          child: Text(
                            appointmentData['statusText'],
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
                          child: appointmentData['statusText'] == 'Booked'
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
    );
  }
}
