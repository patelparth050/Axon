import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:another_flushbar/flushbar.dart';
import 'package:axon/Appointment.dart';
import 'package:axon/Utils/Loader.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'PaymentHistory.dart';
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
  List doctorData = [];
  List customerData = [];

  int doctorId;
  List _myJson = [];
  String displayDate = 'Select Appointment Date';
  String displayTimeSlot = '';
  String displayPatientName = 'Select Patient';
  String displayBirthDate;
  String displayGender;
  String CaseNo = "";
  String PatType = "";
  String displaytimingId;
  String selectedDocotrId;
  var appointmentData;
  String number;

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
        _getDoctorList();
      });
      setState(() {
        _getDoctorDetails();
      });
    });
    // super.initState();
    super.initState();
  }

  _getDoctorList() async {
    print("Call GetDoctorList By Token method");
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
          print(_myJson);
          selectedDocotrId = _myJson[0]['doctorId'].toString();
          print(selectedDocotrId);
          doctorId = doctorData[0]['doctorId'];
          number = customerData[0]['customerContact'];
        });
        print(">>>>>>>>>>>>>>");
        print(doctorData);
        print(doctorId);
        print(
            'TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT');
        print(selectedDocotrId);
        print(
            'TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT');
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

  _getDoctorDetails() async {
    print("Call GetDoctorDetailsByToken method");

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

    final Future<Map<String, dynamic>> successfulMessage = HttpClient().getReq(
        AppUrl.getcustomerdetails + "?CustomerToken=" + token.toString());

    await successfulMessage.then((response) {
      print('>>>>>>>>>> Get Data <<<<<<<<');
      print(response);

      setState(() {
        isLoading = false;
      });

      if (response['status'] == true) {
        setState(() {
          customerData = response['data'];
          // _myJson = response['data'];

          // doctorId = doctorData[0]['doctorId'];
        });
        print(">>>>>>>>>>>>>>");
        print(customerData);
        // print(doctorId);
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
      "CaseNo": CaseNo,
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

  whatsapp() async {
    var contact = "+916353335967";
    var androidUrl = "whatsapp://send?phone=$contact&text=";
    var iosUrl = "https://wa.me/$contact?text=${Uri.parse('')}";

    try {
      if (Platform.isIOS) {
        await launchUrl(Uri.parse(iosUrl));
      } else {
        await launchUrl(Uri.parse(androidUrl));
      }
    } on Exception {
      showDialog(
          context: context,
          builder: (_) => OverlayDialogWarning(
              message: "WhatsApp is not installed",
              showButton: true,
              dialogType: DialogType.Warning));
      // EasyLoading.showError('WhatsApp is not installed.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          elevation: 0,
          backgroundColor: Color(0xffffffff),
          title: Padding(
            padding: EdgeInsets.only(
              top: 5.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 69,
                  width: MediaQuery.of(context).size.width * 0.10,
                  // child: Image.asset('images/axon-icon.png'),
                  child: Image.asset('images/axon-icon.png'),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.46,
                  child: Text(
                    "  Book Appointment",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.34,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          whatsapp();
                        },
                        child: Container(
                          margin: EdgeInsets.all(8),
                          height: 27,
                          child: Image.asset('images/whatsapp.png'),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => PaymentHistory()));
                        },
                        child: Container(
                          margin: EdgeInsets.all(8),
                          height: 27,
                          child: Image.asset('images/rupee.png'),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Settings()));
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(8, 8, 0, 8),
                          height: 27,
                          child: Image.asset('images/settings.png'),
                        ),
                      ),
                    ],
                  ),
                ),
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
              child: isLoading
                  ? isLoading
                      ? Container()
                      : Container()
                  : Column(
                      children: [
                        Container(
                            height: 25.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: MemoryImage(
                                  base64Decode(customerData[0]['logoImageURL']),
                                ),
                                onError: (exception, stackTrace) {
                                  return Icon(Icons.error);
                                },
                                // image: NetworkImage(
                                //   customerData[0]['logoImageURL'],
                                // ),
                                // image: AssetImage('images/c5.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 80.w,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          customerData[0]['customerName'],
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          customerData[0]['customerAddress'],
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      number == null
                                          ? null
                                          : launch('tel://$number');
                                    },
                                    child: Container(
                                      height: 40,
                                      child: Image.asset(
                                        "images/phone-call.png",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                            hint: Text(
                                              // "Select Doctor",
                                              _myJson[0]['doctorName']
                                                  .toString(),
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
                                              return new DropdownMenuItem<
                                                  String>(
                                                value:
                                                    map["doctorId"].toString(),
                                                // value: _mySelection,
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                        // width: 249,
                                                        margin: EdgeInsets.only(
                                                            left: 10),
                                                        child: Text(
                                                          map["doctorName"],
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 77.w,
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            // 'Select Patient',
                                            displayPatientName,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
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
                                  width: 16.w,
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
                          height: 7.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 5.h,
                                child: ElevatedButton(
                                  onPressed: () {
                                    _bookAppointment();
                                  },
                                  child: Text(
                                    'BOOK APPOINTMENT',
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0xFFFD5722)),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 5.h,
                                child: ElevatedButton(
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
    print(result[3]);
    print(result[4]);

    if (result != null) {
      setState(() {
        displayPatientName = result[0];
        displayBirthDate = result[1];
        displayGender = result[2];
        CaseNo = result[3];
        PatType = result[4];
      });
    }
  }
}
