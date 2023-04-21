import 'package:flutter/material.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime selectedDate = DateTime.now(); // TO tracking date

  int currentDateSelectedIndex = 0; //For Horizontal Date
  int currentDateSelectedIndex1 = 0; //For Horizontal Date
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
  List<String> listOftimeslot = [
    "09:00 PM - 09:30 AM",
    "09:30 PM - 10:00 AM",
    "10:00 PM - 10:30 AM",
    "10:30 PM - 11:00 AM",
    "11:00 PM - 11:30 AM",
    "11:30 PM - 12:00 PM",
    "12:00 PM - 12:30 PM",
    "12:30 PM - 01:00 PM",
    "01:00 PM - 01:30 PM",
    "01:30 PM - 02:00 PM",
    "02:00 PM - 02:30 PM",
    "02:30 PM - 03:00 PM"
  ]; //List Of Months

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
    time;
    super.initState();
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
                // Container(
                //   height: 30,
                //   margin: EdgeInsets.only(left: 10),
                //   alignment: Alignment.centerLeft,
                //   child: Text(
                //     selectedDate.day.toString() +
                //         '-' +
                //         listOfMonths[selectedDate.month - 1] +
                //         '-' +
                //         selectedDate.year.toString(),
                //     style: TextStyle(
                //         fontSize: 18,
                //         // fontWeight: FontWeight.w800,
                //         color: Colors.grey),
                //   ),
                // ),
                SizedBox(height: 10),

                // //ListView Widget for the Calendar
                // Container(
                //   height: 80,
                //   child: Container(
                //     child: ListView.separated(
                //       separatorBuilder: (BuildContext context, int index) {
                //         return SizedBox(width: 0);
                //       },
                //       itemCount: 13,
                //       controller: scrollController,
                //       scrollDirection: Axis.horizontal,
                //       itemBuilder: (BuildContext context, int index) {
                //         return InkWell(
                //           onTap: () {
                //             setState(() {
                //               currentDateSelectedIndex = index;
                //               selectedDate =
                //                   DateTime.now().add(Duration(days: index));
                //             });
                //           },
                //           child: Container(
                //             height: 80,
                //             width: 80,
                //             alignment: Alignment.center,
                //             decoration: BoxDecoration(
                //                 // borderRadius: BorderRadius.circular(8),
                //                 // boxShadow: [
                //                 //   BoxShadow(
                //                 //       color: Colors.grey[400],
                //                 //       offset: Offset(3, 3),
                //                 //       blurRadius: 5)
                //                 // ],
                //                 color: currentDateSelectedIndex == index
                //                     ? Color(0xFFFD5722)
                //                     : Colors.white),
                //             child: Column(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: [
                //                 Text(
                //                   listOfDays[DateTime.now()
                //                                   .add(Duration(days: index))
                //                                   .weekday -
                //                               1]
                //                           .toString() +
                //                       " - " +
                //                       listOfMonths[DateTime.now()
                //                                   .add(Duration(days: index))
                //                                   .month -
                //                               1]
                //                           .toString(),
                //                   style: TextStyle(
                //                       fontSize: 13,
                //                       color: currentDateSelectedIndex == index
                //                           ? Colors.white
                //                           : Colors.grey),
                //                 ),
                //                 SizedBox(
                //                   height: 10,
                //                 ),
                //                 Text(
                //                   DateTime.now()
                //                       .add(Duration(days: index))
                //                       .day
                //                       .toString(),
                //                   style: TextStyle(
                //                       fontSize: 22,
                //                       fontWeight: FontWeight.w700,
                //                       color: currentDateSelectedIndex == index
                //                           ? Colors.white
                //                           : Colors.grey),
                //                 ),
                //                 SizedBox(
                //                   height: 5,
                //                 ),
                //                 // Text(
                //                 //   listOfDays[DateTime.now()
                //                 //               .add(Duration(days: index))
                //                 //               .weekday -
                //                 //           1]
                //                 //       .toString(),
                //                 //   style: TextStyle(
                //                 //       fontSize: 16,
                //                 //       color: currentDateSelectedIndex == index
                //                 //           ? Colors.white
                //                 //           : Colors.grey),
                //                 // ),
                //               ],
                //             ),
                //           ),
                //         );
                //       },
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          body: Column(
            children: [
              SizedBox(
                height: 10,
              ),
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
                          });
                        },
                        child: Container(
                          height: 80,
                          width: 80,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(8),
                              // boxShadow: [
                              //   BoxShadow(
                              //       color: Colors.grey[400],
                              //       offset: Offset(3, 3),
                              //       blurRadius: 5)
                              // ],
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
                              // Text(
                              //   listOfDays[DateTime.now()
                              //               .add(Duration(days: index))
                              //               .weekday -
                              //           1]
                              //       .toString(),
                              //   style: TextStyle(
                              //       fontSize: 16,
                              //       color: currentDateSelectedIndex == index
                              //           ? Colors.white
                              //           : Colors.grey),
                              // ),
                            ],
                          ),
                        ),
                      );
                    },
                  ))),
              SizedBox(height: 10),
              //-------------------------------------------------------------------------
              Container(
                  height: 562,
                  child: Container(
                      child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 12);
                    },
                    itemCount: listOftimeslot.length,
                    controller: scrollController1,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            currentDateSelectedIndex1 = index;
                            // selectedDate =
                            //     DateTime.now().add(Duration(days: index));
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
                              color: currentDateSelectedIndex1 == index
                                  ? Colors.orange.shade100
                                  : Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10),
                              Text(
                                listOftimeslot[index],
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 18),
                              ),
                              SizedBox(height: 25),
                              Row(
                                children: [
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('6 - Available'),
                                        SizedBox(height: 5),
                                        Container(
                                          height: 3,
                                          width: 325,
                                          color: Colors.green,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 7),
                                  Container(
                                    child: Icon(
                                      Icons.turned_in_rounded,
                                      color: currentDateSelectedIndex1 == index
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
                      );
                    },
                  ))),
            ],
          ),
        ));
  }
}
