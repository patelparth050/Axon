import 'package:axon/Utils/Loader.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
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
                          'Wed 19-April-2023----------',
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
                          '6:30 PM---------',
                          style: TextStyle(
                            fontSize: 19,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 207,
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
                        Text(
                          appointmentData['statusText'],
                          // 'aaaa',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFFFD5722),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Text(
                              'CANCEL',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFFFD5722),
                              ),
                            ))
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
