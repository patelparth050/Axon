// import 'package:flutter/material.dart';

// class SelectAppointmentDate extends StatefulWidget {
//   const SelectAppointmentDate({Key key}) : super(key: key);

//   @override
//   State<SelectAppointmentDate> createState() => _SelectAppointmentDateState();
// }

// class _SelectAppointmentDateState extends State<SelectAppointmentDate> {
//   DateTime selectedDate = DateTime.now(); // TO tracking date

//   int currentDateSelectedIndex = 0; //For Horizontal Date
//   int currentDateSelectedIndex1 = 0; //For Horizontal Date
//   ScrollController scrollController =
//       ScrollController(); //Scroll Controller for ListView
//   ScrollController scrollController1 =
//       ScrollController(); //Scroll Controller for ListView

//   List<String> listOfMonths = [
//     "Jan",
//     "Feb",
//     "Mar",
//     "Apr",
//     "May",
//     "Jun",
//     "Jul",
//     "Aug",
//     "Sep",
//     "Oct",
//     "Nov",
//     "Dec"
//   ]; //List Of Months

//   List<String> listOfDays = [
//     "Mon",
//     "Tue",
//     "Wed",
//     "Thu",
//     "Fri",
//     "Sat",
//     "Sun"
//   ]; //List of Days
//   List<String> listOftimeslot = [
//     "09:00 PM - 09:30 AM",
//     "09:30 PM - 10:00 AM",
//     "10:00 PM - 10:30 AM",
//     "10:30 PM - 11:00 AM",
//     "11:00 PM - 11:30 AM",
//     "11:30 PM - 12:00 PM",
//     "12:00 PM - 12:30 PM",
//     "12:30 PM - 01:00 PM",
//     "01:00 PM - 01:30 PM",
//     "01:30 PM - 02:00 PM",
//     "02:00 PM - 02:30 PM",
//     "02:30 PM - 03:00 PM"
//   ]; //List Of Months

//   List<String> listOfDays1 = [
//     "Mon",
//     "Tue",
//     "Wed",
//     "Thu",
//     "Fri",
//     "Sat",
//     "Sun"
//   ]; //List of Days
//   var time = DateTime.now();
//   @override
//   void initState() {
//     time;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         top: false,
//         child: Scaffold(
//           appBar: AppBar(
//             centerTitle: false,
//             elevation: 0,
//             backgroundColor: Colors.white,
//             automaticallyImplyLeading: false,
//             leading: Padding(
//               padding: EdgeInsets.only(top: 12),
//               child: IconButton(
//                 color: Colors.black,
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: Icon(Icons.arrow_back_rounded),
//               ),
//             ),
//             title: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 15),
//                 Text(
//                   'Choose Time',
//                   style: TextStyle(color: Colors.black),
//                 ),
//                 //Text Widget to Show Current Date
//                 Text(
//                   '$time',
//                   style: TextStyle(color: Colors.black, fontSize: 15),
//                 ),

//                 SizedBox(height: 10),
//               ],
//             ),
//           ),
//           body: Column(
//             children: [
//               SizedBox(
//                 height: 10,
//               ),
//               //ListView Widget for the Calendar
//               Container(
//                   height: 80,
//                   child: Container(
//                       child: ListView.separated(
//                     separatorBuilder: (BuildContext context, int index) {
//                       return SizedBox(width: 0);
//                     },
//                     itemCount: 13,
//                     controller: scrollController,
//                     scrollDirection: Axis.horizontal,
//                     itemBuilder: (BuildContext context, int index) {
//                       return InkWell(
//                         onTap: () {
//                           setState(() {
//                             currentDateSelectedIndex = index;
//                             selectedDate =
//                                 DateTime.now().add(Duration(days: index));
//                           });
//                         },
//                         child: Container(
//                           height: 80,
//                           width: 80,
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                               color: currentDateSelectedIndex == index
//                                   ? Color(0xFFFD5722)
//                                   : Colors.white),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 listOfDays[DateTime.now()
//                                                 .add(Duration(days: index))
//                                                 .weekday -
//                                             1]
//                                         .toString() +
//                                     " - " +
//                                     listOfMonths[DateTime.now()
//                                                 .add(Duration(days: index))
//                                                 .month -
//                                             1]
//                                         .toString(),
//                                 style: TextStyle(
//                                     fontSize: 13,
//                                     color: currentDateSelectedIndex == index
//                                         ? Colors.white
//                                         : Colors.grey),
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Text(
//                                 DateTime.now()
//                                     .add(Duration(days: index))
//                                     .day
//                                     .toString(),
//                                 style: TextStyle(
//                                     fontSize: 22,
//                                     fontWeight: FontWeight.w700,
//                                     color: currentDateSelectedIndex == index
//                                         ? Colors.white
//                                         : Colors.grey),
//                               ),
//                               SizedBox(
//                                 height: 5,
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ))),
//               SizedBox(height: 10),
//               //-------------------------------------------------------------------------
//               Container(
//                   height: 562,
//                   child: Container(
//                       child: ListView.separated(
//                     separatorBuilder: (BuildContext context, int index) {
//                       return SizedBox(height: 12);
//                     },
//                     itemCount: listOftimeslot.length,
//                     controller: scrollController1,
//                     scrollDirection: Axis.vertical,
//                     itemBuilder: (BuildContext context, int index) {
//                       return InkWell(
//                         onTap: () {
//                           setState(() {
//                             currentDateSelectedIndex1 = index;
//                             // selectedDate =
//                             //     DateTime.now().add(Duration(days: index));
//                           });
//                         },
//                         child: Container(
//                           margin: EdgeInsets.only(left: 10, right: 10),
//                           padding: EdgeInsets.only(left: 10, right: 10),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(2),
//                               boxShadow: [
//                                 BoxShadow(
//                                     color: Colors.grey[400],
//                                     offset: Offset(3, 3),
//                                     blurRadius: 5)
//                               ],
//                               color: currentDateSelectedIndex1 == index
//                                   ? Colors.orange.shade100
//                                   : Colors.white),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(height: 10),
//                               Text(
//                                 listOftimeslot[index],
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.w500, fontSize: 18),
//                               ),
//                               SizedBox(height: 25),
//                               Row(
//                                 children: [
//                                   Container(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text('6 - Available'),
//                                         SizedBox(height: 5),
//                                         Container(
//                                           height: 3,
//                                           width: 325,
//                                           color: Colors.green,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   SizedBox(width: 7),
//                                   Container(
//                                     child: Icon(
//                                       Icons.turned_in_rounded,
//                                       color: currentDateSelectedIndex1 == index
//                                           ? Color(0xFFFD5722)
//                                           : Colors.grey.shade300,
//                                       size: 20,
//                                     ),
//                                   )
//                                 ],
//                               ),
//                               SizedBox(height: 5),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ))),
//             ],
//           ),
//         ));
//   }
// }
import 'package:axon/Book.dart';
import 'package:axon/Utils/app_url.dart';
import 'package:axon/Utils/colors_util.dart';
import 'package:flutter/material.dart';

import 'Providers/HttpClient.dart';
import 'Utils/Loader.dart';
import 'Widgets.dart/OverlayDialogWarning.dart';
import 'package:intl/intl.dart';

class SelectAppointmentDate extends StatefulWidget {
  String selectedDocotrId;
  SelectAppointmentDate(this.selectedDocotrId);

  @override
  _SelectAppointmentDateState createState() =>
      _SelectAppointmentDateState(this.selectedDocotrId);
}

class _SelectAppointmentDateState extends State<SelectAppointmentDate> {
  List appointmentData = List();
  bool isLoading = false;
  String token;
  String selectedDocotrId;
  _SelectAppointmentDateState(this.selectedDocotrId);
  bool isButtonActive = false;
  DateTime selectedDate = DateTime.now(); // TO tracking date
  DateTime defultDate = DateTime.now(); // TO tracking date
  String selectedTimeSlote;
  bool TimeSlotes = false;
  String datetime1;
  String defultDate1;
  int timingId;

  // var time = DateTime.now();

  int currentDateSelectedIndex = 0; //For Horizontal Date
  int currentDateSelectedIndex1; //For Horizontal Date
  ScrollController scrollController =
      ScrollController(); //Scroll Controller for ListView
  ScrollController scrollController1 =
      ScrollController(); //Scroll Controller for ListView

  List<String> listOfMonths = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ]; //List Of Months

  List<String> listOfDays = [
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun"
  ]; //List of Days
  // List<String> listOftimeslot = [
  //   "09:00 PM - 09:30 AM",
  //   "09:30 PM - 10:00 AM",
  //   "10:00 PM - 10:30 AM",
  //   "10:30 PM - 11:00 AM",
  //   "11:00 PM - 11:30 AM",
  //   "11:30 PM - 12:00 PM",
  //   "12:00 PM - 12:30 PM",
  //   "12:30 PM - 01:00 PM",
  //   "01:00 PM - 01:30 PM",
  //   "01:30 PM - 02:00 PM",
  //   "02:00 PM - 02:30 PM",
  //   "02:30 PM - 03:00 PM"
  // ]; //List Of Months

  List<String> listOfDays1 = [
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun"
  ]; //List of Days
  var time = DateTime.now();
  @override
  void initState() {
    setState(() {
      time;
      _getCategory();
      defultDate = DateTime.now();
      defultDate1 = DateFormat("yyyy-MM-dd").format(defultDate);
      print('......................................................');
      print(datetime1);
      print('.......................................................');
      print(defultDate1);
    });

    super.initState();
  }

  _getCategory() async {
    var selectedDate = DateTime.now();
    print('>>>>>>>>>>');
    print(selectedDocotrId);
    print('>>>>>>>>>>');
    print("Call GetCustomerTokenByAppCode method");
    print('>>>>>>>>>>');
    print(selectedDate);

    // DateTime.now();
    datetime1 = DateFormat("yyyy-MM-dd").format(selectedDate);
    print(datetime1);
    // FocusScope.of(context).unfocus(); // Used foe dismiss keyboard
    setState(() {
      isLoading = true;
    });
    // var obj = {
    //   "customerToken": token,
    // };

    final Future<Map<String, dynamic>> successfulMessage = HttpClient().getReq(
        AppUrl.getAppointmentstimeslot +
            "?DoctorId=" +
            selectedDocotrId +
            "&ApptDate=" +
            datetime1.toString());

    await successfulMessage.then((response) {
      print('>>>>>>>>>> Get Data <<<<<<<<');
      print(response);

      if (response['status'] == true) {
        setState(() {
          appointmentData = response['data'];
          // newsId = newsData[0]['newsId'];
        });
        setState(() {
          isLoading = false;
        });
        print(">>>>>>>>>>>>>>");
        print(appointmentData);
        // print(newsId);
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

  _getCategory1() async {
    print('>>>>>>>>>>');
    print(selectedDocotrId);
    print('>>>>>>>>>>');
    print("Call GetCustomerTokenByAppCode method");
    // selectedDate = DateTime.now();
    print('>>>>>>>>>>');
    print(selectedDate);

    // DateTime.now();
    datetime1 = DateFormat("yyyy-MM-dd").format(selectedDate);
    print(datetime1);
    // FocusScope.of(context).unfocus(); // Used foe dismiss keyboard
    setState(() {
      isLoading = true;
    });
    // var obj = {
    //   "customerToken": token,
    // };

    final Future<Map<String, dynamic>> successfulMessage = HttpClient().getReq(
        AppUrl.getAppointmentstimeslot +
            "?DoctorId=" +
            selectedDocotrId +
            "&ApptDate=" +
            datetime1.toString());

    await successfulMessage.then((response) {
      print('>>>>>>>>>> Get Data <<<<<<<<');
      print(response);

      if (response['status'] == true) {
        setState(() {
          appointmentData = response['data'];
          // newsId = newsData[0]['newsId'];
        });
        setState(() {
          isLoading = false;
        });
        print(">>>>>>>>>>>>>>");
        print(appointmentData);
        // print(newsId);
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
    var str = appointmentData[itemIndex]["displayTime"];
    var str1 = appointmentData[itemIndex]["displayTime"];
    // datetime1 == defultDate1 ? str : str1;
    //  "displayTime": "4/21/2023 9:30:00 AM - 4/21/2023 10:00:00 AM",
    var pte = datetime1 != defultDate1 ? str : str1;
    print('object');
    print(pte);
    print('object');
    print(timingId);
    var parts = pte.split(' ');
    var prefix = parts[1].trim();
    // + parts[2].trim()
    // + parts[3].trim() + parts[5].trim()
    // parts[6].trim()
    // var prefix = parts[11].trim() +
    //     parts[12].trim() +
    //     parts[13].trim() +
    //     parts[14].trim() +
    //     parts[19].trim() +
    //     parts[20].trim();
    int capacity = appointmentData[itemIndex]["capacity"];
    int count = appointmentData[itemIndex]["count"];

    var total = capacity - count;
    // int varr = total;
    print('========================================');
    print(total);
    print('==========================================');
    return Column(
      children: [
        TimeSlotes == appointmentData[itemIndex]["isBlocked"]
            ? InkWell(
                onTap: () {
                  setState(() {
                    currentDateSelectedIndex1 = itemIndex;
                    selectedTimeSlote =
                        appointmentData[itemIndex]["displayTime"];
                    print('selectedTimeSlote');
                    print(selectedTimeSlote);
                    print('selectedTimeSlote');
                    timingId = appointmentData[itemIndex]["timingId"];
                    isButtonActive = true;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  padding: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[400],
                            offset: Offset(3, 3),
                            blurRadius: 5)
                      ],
                      color: currentDateSelectedIndex1 == itemIndex
                          ? Colors.orange.shade100
                          : Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        datetime1 == defultDate1 ? str : prefix,

                        // appointmentData[itemIndex]["displayTime"],
                        // listOftimeslot[itemIndex],
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                      SizedBox(height: 25),
                      Row(
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(total.toString() + " - Available"),
                                SizedBox(height: 5),
                                Container(
                                  height: 3,
                                  width: 290,
                                  color: Colors.green,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 7),
                          Container(
                            child: Icon(
                              Icons.turned_in_rounded,
                              color: currentDateSelectedIndex1 == itemIndex
                                  ? Color(0xFFFD5722)
                                  : Colors.grey.shade300,
                              size: 20,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
              )
            : Container(
                height: 80,
                width: 450,
                margin: EdgeInsets.only(left: 10, right: 10),
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      // offset: Offset(3, 3),
                      // blurRadius: 5,
                    )
                  ],
                  color: Colors.grey.shade400,
                  // color: currentDateSelectedIndex1 == itemIndex
                  //     ? Colors.orange.shade100
                  //     : Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      datetime1 == defultDate1 ? str : prefix,

                      // datetime1 == defultDate1
                      //     ? appointmentData[itemIndex]["displayTime"]
                      //     : prefix,
                      // appointmentData[itemIndex]["displayTime"],
                      // listOftimeslot[itemIndex],
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.grey.shade700),
                    ),
                    SizedBox(height: 25),
                    SizedBox(height: 5),
                  ],
                ),
              ),
        SizedBox(
          height: 15,
        ),
        isLoading ? Loader() : Container(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: EdgeInsets.only(top: 12),
            child: IconButton(
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_rounded),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Text(
                'Choose Time',
                style: TextStyle(color: Colors.black),
              ),
              //Text Widget to Show Current Date
              Text(
                '$time',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),

              SizedBox(height: 10),
            ],
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  // SizedBox(
                  //   height: 10,
                  // ),
                  //ListView Widget for the Calendar
                  Container(
                      height: 80,
                      child: Container(
                          child: ListView.separated(
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(width: 0);
                        },
                        itemCount: 13,
                        controller: scrollController,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                currentDateSelectedIndex = index;
                                selectedDate =
                                    DateTime.now().add(Duration(days: index));
                                datetime1 = DateFormat("yyyy-MM-dd")
                                    .format(selectedDate);
                                print(datetime1);

                                _getCategory1();
                              });
                              print(selectedDate);
                            },
                            child: Container(
                              height: 80,
                              width: 80,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: currentDateSelectedIndex == index
                                      ? Color(0xFFFD5722)
                                      : Colors.white),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    listOfDays[DateTime.now()
                                                    .add(Duration(days: index))
                                                    .weekday -
                                                1]
                                            .toString() +
                                        " - " +
                                        listOfMonths[DateTime.now()
                                                    .add(Duration(days: index))
                                                    .month -
                                                1]
                                            .toString(),
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: currentDateSelectedIndex == index
                                            ? Colors.white
                                            : Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    DateTime.now()
                                        .add(Duration(days: index))
                                        .day
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700,
                                        color: currentDateSelectedIndex == index
                                            ? Colors.white
                                            : Colors.grey),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ))),
                  SizedBox(height: 10),
                  //-------------------------------------------------------------------------
                  Container(
                    child: ListView.builder(
                        padding: EdgeInsets.only(bottom: 10),
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: appointmentData.length,
                        itemBuilder: (BuildContext context, int itemIndex) {
                          return createNewsListContainer(context, itemIndex);
                        }),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  isLoading ? Loader() : Container(),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: isButtonActive ? Colors.green : Colors.grey,
          onPressed: isButtonActive
              ? () => Navigator.pop(
                  context, [datetime1, selectedTimeSlote, timingId.toString()])
              : null,
          child: Icon(Icons.check),
        ),
      ),
    );
  }
}
