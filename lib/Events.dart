import 'dart:io';

import 'package:axon/MyNavigationBar.dart';
import 'package:axon/Utils/Loader.dart';
import 'package:axon/Utils/SharePreference.dart';
import 'package:axon/Utils/app_url.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'AppointmentDetails.dart';
import 'PaymentHistory.dart';
import 'Providers/HttpClient.dart';
import 'Settings.dart';
import 'Widgets.dart/OverlayDialogWarning.dart';

class Events extends StatefulWidget {
  const Events({Key key}) : super(key: key);

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  UserPreferences userPreference = UserPreferences();
  String token;
  bool isLoading = false;
  List historyData = [];
  int selectedIndex = 2;

  // var historyData;
  var title;

  @override
  void initState() {
    userPreference.getToken().then((value) {
      setState(() {
        token = value;
      });
      setState(() {
        _getAppointmentHistory();
      });
    });
    // super.initState();
    super.initState();
  }

  _getAppointmentHistory() async {
    print("Call GetAppointmentHistoryByToken&DeviceId method");

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
        AppUrl.getappointmenthistory +
            "?DeviceId=" +
            "DESKTOP" +
            "&CustomerToken=" +
            token.toString());

    await successfulMessage.then((response) {
      print('>>>>>>>>>> Get Data <<<<<<<<');
      print(response);

      setState(() {
        isLoading = false;
      });

      if (response['status'] == true) {
        setState(() {
          historyData = response['data'];
          // title = response['data'][0]['doctorName'];
        });
        print(">>>>>>>>>>>>>>");
        print(historyData);
        print(title);
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

  createAppointmentListContainer(BuildContext context, int itemIndex) {
    // final notificationObj = listOfColumns[itemIndex];
    // var str = historyData[itemIndex]["timeSlot"];
    // var parts = str.split('');
    // var prefix = parts[1].trim() +
    //     parts[2].trim() +
    //     parts[3].trim() +
    //     parts[4].trim() +
    //     parts[5].trim() +
    //     ' ' +
    //     parts[6].trim() +
    //     parts[7].trim();

    // var str1 = historyData[itemIndex]["apptDate"];
    // var parts1 = str1.split('');
    // var prefix1 = parts1[5].trim() +
    //     parts1[6].trim() +
    //     '-' +
    //     parts1[0].trim() +
    //     parts1[1].trim() +
    //     parts1[2].trim() +
    //     parts1[3].trim();

    String date = historyData[itemIndex]["apptDate"];
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
    String doctorName = historyData[itemIndex]["doctorName"];
    String patientName = historyData[itemIndex]["name"];
    String status = historyData[itemIndex]["statusText"];
    String appointmentId = historyData[itemIndex]["appointmentId"].toString();
    return Column(
      children: [
        InkWell(
          onTap: () {
            status == 'Booked'
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AppointmentDetails(
                            outputDate,
                            doctorName,
                            outputDate3,
                            patientName,
                            status,
                            appointmentId)))
                : null;
          },
          child: Card(
            margin: EdgeInsets.all(5),
            color: Colors.white,
            shadowColor: Colors.white,
            elevation: 10,
            child: Row(
              children: [
                Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width * 0.25,
                    color: status == 'Booked' ? Colors.green : Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            // historyData[itemIndex]['apptDate'],
                            outputDate1,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            outputDate2,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            outputDate3,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )),
                Container(
                  width: MediaQuery.of(context).size.width * 0.70,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.67,
                          child: Text(
                            'Provider  ' + historyData[itemIndex]["doctorName"],
                            // 'Why 100% PCR Testing Required?',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.67,
                          // child: Html(
                          //   data: newsData[itemIndex]["description"],
                          // ),
                          child: Text(
                            'Patient  ' + historyData[itemIndex]["name"],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.67,
                          child: Text(
                            'Mobile  ' + historyData[itemIndex]['mobile'],
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        Container(
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.58,
                                child: Text(
                                  'Ref No  -',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  status == 'Booked'
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AppointmentDetails(
                                                      outputDate,
                                                      doctorName,
                                                      outputDate3,
                                                      patientName,
                                                      status,
                                                      appointmentId)))
                                      : null;
                                },
                                child: Icon(Icons.info_outline),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // SizedBox(
        //   height: 20,
        // ),
      ],
    );
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
                  child: Image.asset('images/axon-icon.png'),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.46,
                  child: Text(
                    "  Events",
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
      body: RefreshIndicator(
        color: Colors.black,
        backgroundColor: Colors.white,
        strokeWidth: 2.0,
        onRefresh: () {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (a, b, c) => MyNavigationBar(selectedIndex),
              transitionDuration: Duration(seconds: 0),
            ),

            // MaterialPageRoute(
            //   builder: (context) => Events(),
            // ),
          );
          return Future.value(false);
        },
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(1),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    historyData.isNotEmpty
                        ? ListView.builder(
                            padding: EdgeInsets.only(bottom: 10),
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: historyData.length,
                            itemBuilder: (BuildContext context, int itemIndex) {
                              return createAppointmentListContainer(
                                  context, itemIndex);
                            })
                        : Padding(
                            padding: EdgeInsets.all(15),
                            child: Container(
                              height: 68.h,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: Text(
                                      'Swipe down to refresh page',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Color(0XFF545454),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 120,
                                  ),
                                  Center(
                                    child: Image.asset(
                                      'images/axon.jpg',
                                      height: 90,
                                      width: 90,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: Text(
                                      'You  don\'t have any bookings or upcoming events',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Color(0XFF545454),
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    // newsCardWidget(),
                  ],
                ),
              ),
            ),
            isLoading ? Loader() : Container(),
          ],
        ),
      ),
    );
  }
}

// child: Stack(
//           children: [
//             SingleChildScrollView(
//               child: Padding(
//                 padding: EdgeInsets.all(15),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Center(
//                       child: Text(
//                         'Swipe down to refresh page',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: Color(0XFF545454),
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 120,
//                     ),
//                     Center(
//                       child: Image.asset(
//                         'images/axon.jpg',
//                         height: 90,
//                         width: 90,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Center(
//                       child: Text(
//                         'You  don\'t have any bookings or upcoming events',
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                             fontSize: 20,
//                             color: Color(0XFF545454),
//                             fontWeight: FontWeight.w600),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),