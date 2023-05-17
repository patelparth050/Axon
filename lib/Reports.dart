import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'MyNavigationBar.dart';
import 'PaymentHistory.dart';
import 'ReportDetails.dart';
import 'Settings.dart';
import 'Utils/SharePreference.dart';
import 'Utils/app_url.dart';
import 'Widgets.dart/OverlayDialogWarning.dart';
import 'Providers/HttpClient.dart';
import 'demo1.dart';

class Reports extends StatefulWidget {
  const Reports({Key key}) : super(key: key);

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  int selectedIndex = 3;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  UserPreferences userPreference = UserPreferences();
  String token;
  String mobile;
  bool isLoading = false;
  List reportData = [];
  List customerData = [];

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
        _getReportList();
      });
    });
    // super.initState();
    super.initState();
  }

  _getReportList() async {
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

    final Future<Map<String, dynamic>> successfulMessage =
        HttpClient().getReq(AppUrl.getrxvisithistory +
            "?CustomerToken=" +
            "2dda9fd0-55f7-11e9-9855-029527c1db28" +
            // token.toString() +
            "&Mobile=" +
            "8140629967");
    // 8140629967

    await successfulMessage.then((response) {
      print('>>>>>>>>>> Get Data <<<<<<<<');
      print(response);

      setState(() {
        isLoading = false;
      });

      if (response['status'] == true) {
        setState(() {
          reportData = response['data'];
        });
        print(">>>>>>>>>>>>>>");
        print(reportData);
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

  createNewsListContainer(BuildContext context, int itemIndex) {
    // final notificationObj = listOfColumns[itemIndex];
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ReportDetails(reportData[itemIndex])));
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Provider: ' + reportData[itemIndex]["providerName"],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Member: ' + reportData[itemIndex]["patientName"],
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Updated on: ' + reportData[itemIndex]['visitDate'],
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      InkWell(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => NewsDetails(
                          //             token,
                          //             newsData[itemIndex]['newsId'])));
                        },
                        child: Container(
                          child: Icon(Icons.info_outline),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        // SizedBox(
        //   height: 20,
        // ),
        // ElevatedButton(
        //   onPressed: () {
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: (context) => SearchBarScreen()));
        //   },
        //   child: Text('aaaaa'),
        // )
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
                    "  Recent Precription",
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentHistory()));
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
        onRefresh: () async {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (a, b, c) => MyNavigationBar(selectedIndex),
              transitionDuration: Duration(seconds: 2),
            ),
            // MaterialPageRoute(
            //   builder: (context) => Events(),
            // ),
          );
          // return Future.value(false);
          await Future.delayed(Duration(seconds: 3));
        },
        child: Stack(
          children: [
            SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 3,
                    ),
                    ListView.builder(
                        padding: EdgeInsets.only(bottom: 10),
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: reportData.length,
                        itemBuilder: (BuildContext context, int itemIndex) {
                          return createNewsListContainer(context, itemIndex);
                        }),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}


      // body: RefreshIndicator(
      //   color: Colors.black,
      //   backgroundColor: Colors.white,
      //   strokeWidth: 2.0,
      //   onRefresh: () async {
      //     Navigator.pushReplacement(
      //       context,
      //       PageRouteBuilder(
      //         pageBuilder: (a, b, c) => MyNavigationBar(selectedIndex),
      //         transitionDuration: Duration(seconds: 2),
      //       ),
      //       // MaterialPageRoute(
      //       //   builder: (context) => Events(),
      //       // ),
      //     );
      //     // return Future.value(false);
      //     await Future.delayed(Duration(seconds: 3));
      //   },
      //   child: Stack(
      //     children: [
      //       SingleChildScrollView(
      //         physics: const AlwaysScrollableScrollPhysics(),
      //         child: Padding(
      //           padding: EdgeInsets.all(15),
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             children: [
      //               SizedBox(
      //                 height: 10,
      //               ),
      //               Center(
      //                 child: Text(
      //                   'Swipe down to refresh page',
      //                   textAlign: TextAlign.center,
      //                   style: TextStyle(
      //                     fontSize: 20,
      //                     color: Color(0XFF545454),
      //                     fontWeight: FontWeight.w600,
      //                   ),
      //                 ),
      //               ),
      //               SizedBox(
      //                 height: 120,
      //               ),
      //               Center(
      //                 child: Image.asset(
      //                   'images/axon.jpg',
      //                   height: 90,
      //                   width: 90,
      //                 ),
      //               ),
      //               SizedBox(
      //                 height: 20,
      //               ),
      //               Center(
      //                 child: Text(
      //                   'You  don\'t have any recent prescriptions',
      //                   textAlign: TextAlign.center,
      //                   style: TextStyle(
      //                       fontSize: 20,
      //                       color: Color(0XFF545454),
      //                       fontWeight: FontWeight.w600),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
