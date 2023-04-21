import 'package:flutter/material.dart';

class AppointmentDetails extends StatefulWidget {
  String outputDate;
  String doctorName;
  String appointmentTime;
  String patientName;
  String status;

  AppointmentDetails(this.outputDate, this.doctorName, this.appointmentTime,
      this.patientName, this.status);

  @override
  _AppointmentDetailsState createState() => _AppointmentDetailsState(
      this.outputDate,
      this.doctorName,
      this.appointmentTime,
      this.patientName,
      this.status);
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  String outputDate;
  String doctorName;
  String appointmentTime;
  String patientName;
  String status;

  _AppointmentDetailsState(this.outputDate, this.doctorName,
      this.appointmentTime, this.patientName, this.status);
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
      body: Padding(
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
                      style: TextStyle(fontSize: 15, color: Colors.grey),
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
                          status,
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
