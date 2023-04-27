// import 'dart:convert';

// import 'package:axon/NewsDetails.dart';
// import 'package:axon/Settings.dart';
// import 'package:flutter/material.dart';

// import 'Providers/HttpClient.dart';
// import 'Utils/SharePreference.dart';
// import 'Utils/app_url.dart';
// import 'Widgets.dart/OverlayDialogWarning.dart';

// class News extends StatefulWidget {
//   const News({Key key}) : super(key: key);

//   @override
//   State<News> createState() => _NewsState();
// }

// class _NewsState extends State<News> {
//   UserPreferences userPreference = UserPreferences();
//   String token;
//   bool isLoading = false;
//   var title = [];
//   var description = [];
//   var displayDate = [];

//   @override
//   void initState() {
//     userPreference.getToken().then((value) {
//       setState(() {
//         token = value;
//       });
//       setState(() {
//         _getCategory();
//       });
//     });
//     super.initState();
//     print('------------------------------------------------------');
//     print(token);
//   }

//   _getCategory() async {
//     print("Call GetCustomerTokenByAppCode method");
//     FocusScope.of(context).unfocus(); // Used foe dismiss keyboard
//     setState(() {
//       isLoading = true;
//     });
//     var obj = {
//       "CustomerToken": token,
//     };
//     print('>>>>>>>>>>');
//     print(obj);

//     final Future<Map<String, dynamic>> successfulMessage = HttpClient()
//         .getReq(AppUrl.getnoticebytoken + "?CustomerToken=" + token.toString());

//     await successfulMessage.then((response) {
//       print('>>>>>>>>>> Get Data <<<<<<<<');
//       print(response);
//       setState(() {
//         isLoading = false;
//       });
//       setState(() {
//         title = response['data'][0]['title'];
//         description = response['data'][0]['description'];
//         displayDate = response['data'][0]['displayDate'];
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     print('ooooooooooooooooooooooooooooooooooooooo');
// // -----------------------------------------------------------------------------------
//     print(token);
//     return Scaffold(
//       backgroundColor: Colors.grey.shade200,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(70.0),
//         child: AppBar(
//           automaticallyImplyLeading: false,
//           centerTitle: false,
//           elevation: 0,
//           backgroundColor: Color(0xffffffff),
//           title: Padding(
//             padding: EdgeInsets.only(
//               top: 16.0,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Notice Board",
//                   style: TextStyle(
//                     color: Colors.black,
//                     // fontWeight: FontWeight.bold,
//                     fontSize: 25,
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.settings_outlined),
//                   color: Colors.black,
//                   iconSize: 33,
//                   onPressed: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => Settings()));
//                   },
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: Stack(
//         children: <Widget>[
//           SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.all(1),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 10,
//                   ),
//                   newsCardWidget(),
//                   newsCardWidget(),
//                   newsCardWidget(),
//                   newsCardWidget(),
//                   newsCardWidget(),
//                   newsCardWidget(),
//                   newsCardWidget(),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class newsCardWidget extends StatelessWidget {
//   const newsCardWidget({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => NewsDetails()));
//       },
//       child: Card(
//         margin: EdgeInsets.all(5),
//         color: Colors.white,
//         shadowColor: Colors.white,
//         // shape: RoundedRectangleBorder(
//         //     borderRadius: BorderRadius.all(Radius.circular(5))),
//         elevation: 10,
//         child: Row(
//           children: [
//             Container(
//               height: 150,
//               width: 60,
//               color: Color(0xFFFD5722),
//               child: Icon(
//                 Icons.info,
//                 color: Colors.white,
//                 size: 30,
//               ),
//             ),
//             Container(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       child: Text(
//                         "title",
//                         // 'Why 100% PCR Testing Required?',
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.w500),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 50,
//                     ),
//                     Container(
//                       child: Text(
//                         'Now you can do teleconsultation with',
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.w400),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 13,
//                     ),
//                     Container(
//                       child: Row(
//                         children: [
//                           Container(
//                             child: Text(
//                               '20-Jul-2022, 10:34 AM',
//                               style: TextStyle(
//                                   fontSize: 16, fontWeight: FontWeight.w500),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 110,
//                           ),
//                           InkWell(
//                             onTap: () {},
//                             child: Icon(Icons.info_outline),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:io';

import 'package:axon/MyNavigationBar.dart';
import 'package:axon/NewsDetails.dart';
import 'package:axon/Settings.dart';
import 'package:flutter/material.dart';

import 'PaymentHistory.dart';
import 'Providers/HttpClient.dart';
import 'Utils/Loader.dart';
import 'Utils/SharePreference.dart';
import 'Utils/app_url.dart';
import 'Widgets.dart/OverlayDialogWarning.dart';
import 'api_service.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class News extends StatefulWidget {
  const News({Key key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  UserPreferences userPreference = UserPreferences();
  String token;
  bool isLoading = false;
  List newsData = List();
  int newsId;
  int selectedIndex = 0;

  @override
  void initState() {
    userPreference.getToken().then((value) {
      setState(() {
        token = value;
      });
      setState(() {
        _getCategory();
      });
    });
    super.initState();
    print('------------------------------------------------------');
    print(token);
  }

  _getCategory() async {
    print("Call GetCustomerTokenByAppCode method");
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
        .getReq(AppUrl.getnoticebytoken + "?CustomerToken=" + token.toString());

    await successfulMessage.then((response) {
      print('>>>>>>>>>> Get Data <<<<<<<<');
      print(response);
      setState(() {
        isLoading = false;
      });

      if (response['status'] == true) {
        setState(() {
          newsData = response['data'];
          newsId = newsData[0]['newsId'];
        });
        print(">>>>>>>>>>>>>>");
        print(newsData);
        print(newsId);
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
                        NewsDetails(token, newsData[itemIndex]['newsId'])));
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
                  width: MediaQuery.of(context).size.width * 0.15,
                  color: Color(0xFFFD5722),
                  child: Icon(
                    Icons.info,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                Container(
                  // width: 291,
                  width: MediaQuery.of(context).size.width * 0.79,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.82,
                          // width: 280,
                          child: Text(
                            newsData[itemIndex]["title"],
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
                          height: 50,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          // width: 270,
                          // child: Html(
                          //   data: newsData[itemIndex]["description"],
                          // ),
                          child: Text(
                            newsData[itemIndex]["description"],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
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
                                width: MediaQuery.of(context).size.width * 0.67,
                                // width: 170,
                                child: Text(
                                  newsData[itemIndex]['displayDate'],
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NewsDetails(
                                              token,
                                              newsData[itemIndex]['newsId'])));
                                },
                                child: Container(
                                  child: Icon(Icons.info_outline),
                                ),
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
                  child: Image.asset('images/axon-icon.png'),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.46,
                  child: Text(
                    "  Notice Board",
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
                      GestureDetector(
                        onTap: () {
                          whatsapp();
                        },
                        child: Container(
                          margin: EdgeInsets.all(8),
                          height: 27,
                          child: Image.asset('images/whatsapp.png'),
                        ),
                      ),
                      GestureDetector(
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
                      GestureDetector(
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
          children: <Widget>[
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    SizedBox(
                      height: 3,
                    ),
                    ListView.builder(
                        padding: EdgeInsets.only(bottom: 10),
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: newsData.length,
                        itemBuilder: (BuildContext context, int itemIndex) {
                          return createNewsListContainer(context, itemIndex);
                        }),
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

// class newsCardWidget extends StatelessWidget {
//   const newsCardWidget({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => NewsDetails()));
//       },
//       child: Card(
//         margin: EdgeInsets.all(5),
//         color: Colors.white,
//         shadowColor: Colors.white,
//         // shape: RoundedRectangleBorder(
//         //     borderRadius: BorderRadius.all(Radius.circular(5))),
//         elevation: 10,
//         child: Row(
//           children: [
//             Container(
//               height: 150,
//               width: 60,
//               color: Color(0xFFFD5722),
//               child: Icon(
//                 Icons.info,
//                 color: Colors.white,
//                 size: 30,
//               ),
//             ),
//             Container(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       child: Text(
//                         "title",
//                         // 'Why 100% PCR Testing Required?',
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.w500),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 50,
//                     ),
//                     Container(
//                       child: Text(
//                         'Now you can do teleconsultation with',
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.w400),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 13,
//                     ),
//                     Container(
//                       child: Row(
//                         children: [
//                           Container(
//                             child: Text(
//                               '20-Jul-2022, 10:34 AM',
//                               style: TextStyle(
//                                   fontSize: 16, fontWeight: FontWeight.w500),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 110,
//                           ),
//                           InkWell(
//                             onTap: () {},
//                             child: Icon(Icons.info_outline),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
