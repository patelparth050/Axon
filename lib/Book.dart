import 'dart:async';

import 'package:another_flushbar/flushbar.dart';
import 'package:axon/Appointment.dart';
import 'package:axon/Utils/Loader.dart';
import 'package:flutter/material.dart';
import 'Models/doctors_data.dart';
import 'Providers/HttpClient.dart';
import 'SelectAppointmentDate.dart';
import 'SelectPatient.dart';
import 'Settings.dart';
import 'Utils/SharePreference.dart';
import 'Utils/app_url.dart';
import 'Widgets.dart/OverlayDialogWarning.dart';

class Book extends StatefulWidget {
  const Book({Key key}) : super(key: key);

  @override
  State<Book> createState() => _BookState();
}

class _BookState extends State<Book> {
  UserPreferences userPreference = UserPreferences();
  String token;
  String mobile;
  bool isLoading = false;
  List doctorData = List();
  int doctorId;
  List _myJson = [];
  String displayDate = 'Select Appointment Date';
  String displayTimeSlot = '';
  String displayPatientName = 'Select Patient';
  String displayBirthDate;
  String displayGender;
  String displaytimingId;
  String selectedDocotrId;
  var appointmentData;

  // final _productSizesList = ["Dr. John Smith", "Dr. Demo Gynac"];
  String _selectedVal = "";
  List productSizesList = [];

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
        _getCategory();
      });
    });
    // super.initState();
    super.initState();
  }

  _getCategory() async {
    print("Call GetCustomerTokenByAppCode method");
    print('00000000000000000000000000000000000000000000');
    print(mobile);
    print('0000000000000000000000000000000000000000000');
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

    final Future<Map<String, dynamic>> successfulMessage = HttpClient()
        .getReq(AppUrl.getdoctordetails + "?CustomerToken=" + token.toString());

    await successfulMessage.then((response) {
      print('>>>>>>>>>> Get Data <<<<<<<<');
      print(response);
      // CustomerDoctorModel dmodel = CustomerDoctorModel.fromJson(response);
      // print('////////////');
      // print(dmodel.data[0].doctorName);
      // List doctordata = dmodel.data;
      // for (int i = 0; i < dmodel.data.length; i++) {
      //   print('mmmmmmmmmmmmmmmmmmm');
      //   print(dmodel.data[i].doctorName);
      //   print('mmmmmmmmmmmmmmmmmmm');

      //   productSizesList.add(dmodel.data[i].doctorName.toString());
      //   print('...........................');
      //   print(productSizesList);
      // }
      // _selectedVal = productSizesList[0];
      setState(() {
        isLoading = false;
      });

      if (response['status'] == true) {
        setState(() {
          doctorData = response['data'];
          _myJson = response['data'];

          doctorId = doctorData[0]['doctorId'];
        });
        print(">>>>>>>>>>>>>>");
        print(doctorData);
        print(doctorId);
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

  // Calling Send OTP Method
  _bookAppointment() async {
    setState(() {
      isLoading = true;
    });
    var objsendotp = {
      "CaseNo": "1",
      "Name": displayPatientName,
      "Mobile": mobile,
      "Email": "",
      "Gender": displayGender,
      "PatType": "New",
      "ApptDate": displayDate,
      "CustomerToken": token,
      "DelayMinute": "",
      "DeviceId": "DESKTOP",
      "DoctorId": selectedDocotrId,
      "TimingId": displaytimingId,
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
        HttpClient().postReq(AppUrl.bookappointment, objsendotp);

    await successfulMessage.then((response) {
      print('>>>>>>>>>> BOOK APPOINTMENT <<<<<<<<');
      print(response);
      setState(() {
        isLoading = false;
      });
      if (response['status'] == true) {
        setState(() {
          appointmentData = response['data'];
        });
        print('77777777777777777777777777777777777777777777777777');
        print(appointmentData);
        print('77777777777777777777777777777777777777777777777777');

        Flushbar(
          message: 'Appointment Book Successfully',
          duration: Duration(seconds: 5),
        ).show(context);
        // formKey.currentState.reset();

        Timer(
            Duration(seconds: 1),
            () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Appointment(appointmentData))));
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

  _MyFormState() {
    _selectedVal = productSizesList[0];
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
          title: Padding(
            padding: EdgeInsets.only(
              top: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Book Appointment",
                  style: TextStyle(
                    color: Colors.black,
                    // fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.settings_outlined),
                  color: Colors.black,
                  iconSize: 33,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Settings()));
                  },
                )
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(0),
              child: Column(
                children: [
                  Card(
                    child: Image.asset(
                      "images/c5.png",
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    margin: EdgeInsets.all(5),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Provider',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey.shade700),
                              ),
                              SizedBox(height: 30),
                              Container(
                                alignment: Alignment.centerLeft,
                                color: Colors.white,
                                child: DropdownButtonHideUnderline(
                                  child: ButtonTheme(
                                    alignedDropdown: true,
                                    child: DropdownButton<String>(
                                      isDense: true,
                                      hint: new Text(
                                        "Select Doctor",
                                        // _myJson[0]['doctorName'].toString(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black),
                                      ),
                                      value: selectedDocotrId,
                                      onChanged: (String newValue) {
                                        setState(() {
                                          selectedDocotrId = newValue;
                                        });

                                        print(selectedDocotrId);
                                      },
                                      items: _myJson.map((map) {
                                        return new DropdownMenuItem<String>(
                                          value: map["doctorId"].toString(),
                                          // value: _mySelection,
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                  // width: 249,
                                                  margin:
                                                      EdgeInsets.only(left: 10),
                                                  child: Text(
                                                    map["doctorName"],
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFFD5722),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8))),
                          height: 110,
                          width: 63,
                          child: Icon(
                            Icons.punch_clock,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        // isLoading ? Loader() : Container(),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      selectedDocotrId != null
                          ?
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) =>
                          //               SelectAppointmentDate(selectedDocotrId)));
                          _navigateDateAndTimeSelaction(context)
                          : showDialog(
                              context: context,
                              builder: (_) => OverlayDialogWarning(
                                  message: 'Please Select a Doctor',
                                  // message: response['message'].toString(),
                                  showButton: true,
                                  dialogType: DialogType.Warning));
                      ;
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      margin: EdgeInsets.all(5),
                      color: Colors.white,
                      // shadowColor: Colors.white,
                      // // shape: RoundedRectangleBorder(
                      // //     borderRadius: BorderRadius.all(Radius.circular(5))),
                      // elevation: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      displayDate,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      displayTimeSlot,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Color(0xFFFD5722),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8))),
                            height: 110,
                            width: 63,
                            child: Icon(
                              Icons.punch_clock,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => SelectPatient()));
                      _navigateNameAndGenderSelaction(context);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      margin: EdgeInsets.only(left: 5, right: 5, top: 5),
                      color: Colors.white,
                      shadowColor: Colors.white,
                      // shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.all(Radius.circular(5))),
                      elevation: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      // 'Select Patient',
                                      displayPatientName,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  //
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Color(0xFFFD5722),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8))),
                            height: 110,
                            width: 63,
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _bookAppointment();
                          },
                          child: Text(
                            'BOOK APPOINTMENT',
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFFD5722)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              displayDate = 'Select Appointment Date';
                              displayTimeSlot = '';
                              displaytimingId = '';
                              displayPatientName = 'Select Patient';
                              displayBirthDate = '';
                              displayGender = '';
                            });
                          },
                          child: Text('RESET'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFFD5722)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 180,
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

  _navigateDateAndTimeSelaction(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SelectAppointmentDate(selectedDocotrId)),
    );
    print(result[0]);
    print(result[1]);
    print(result[2]);

    if (result != null) {
      setState(() {
        displayDate = result[0];
        displayTimeSlot = result[1];
        displaytimingId = result[2];
      });
    }
  }

  _navigateNameAndGenderSelaction(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectPatient()),
    );
    print(result[0]);
    print(result[1]);
    print(result[2]);

    if (result != null) {
      setState(() {
        displayPatientName = result[0];
        displayBirthDate = result[1];
        displayGender = result[2];
      });
    }
  }
}
