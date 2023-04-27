import 'package:flutter/material.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({Key key}) : super(key: key);

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  final scaffoldState = GlobalKey<ScaffoldState>();
  String genderValue;
  final formKey = GlobalKey<FormState>();
  bool _enableBtn = false;
  bool agree = false;

  final FocusNode _nodeAmount = FocusNode();
  final FocusNode _nodeEmail = FocusNode();
  TextEditingController strAmount = TextEditingController();
  TextEditingController strEmail = TextEditingController();
  // void _showSheet() {
  //   // Show BottomSheet here using the Scaffold state instead ot«f the Scaffold context
  //   scaffoldState.currentState
  //       .showBottomSheet((context) => Container(color: Colors.red));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          elevation: 0,
          backgroundColor: Color(0xffffffff),
          leading: Padding(
            padding: EdgeInsets.only(top: 5.0),
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
              top: 5.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Payment History",
                  style: TextStyle(
                    color: Colors.black,
                    // fontWeight: FontWeight.bold,
                    fontSize: 22,
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
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(15),
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
                    height: 70,
                  ),
                  Center(
                    child: Text(
                      'You  don\'t have any Payment History',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 23,
                          color: Color(0XFF545454),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // FloatingActionButton(
          //   onPressed: () {
          //     _showSheet();
          //   },
          //   backgroundColor: Colors.green,
          //   child: Icon(Icons.add),
          // )
        ],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<void>(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              context: context,
              builder: (BuildContext context) {
                return PaymentSheet();
              });
          // showModalBottomSheet(
          //     context: context,
          //     builder: (c) {
          //       return StatefulBuilder(
          //         builder: (context, setStateSB) => DraggableScrollableSheet(
          //           builder: (context, scrollController) {},
          //         ),
          //       );
          //     });
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
      ),
    );
  }

  // Widget buildSheet() {
  //   return DraggableScrollableSheet(
  //       initialChildSize: 0.87,
  //       maxChildSize: 0.87,
  //       minChildSize: 0.87,
  //       // builder: (_, controller) {
  //       builder: (BuildContext context, ScrollController scrollController) {
  //         return Container(
  //           margin: EdgeInsets.only(
  //             left: 4,
  //             right: 4,
  //             bottom: 4,
  //           ),
  //           padding: EdgeInsets.all(8),
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(10),
  //             color: Colors.white,
  //           ),
  //           child: ListView(
  //             controller: scrollController,
  //             children: [
  //               Form(
  //                 key: formKey,
  //                 onChanged: () => setState(
  //                     () => _enableBtn = formKey.currentState.validate()),
  //                 child: Column(
  //                   children: [
  //                     Container(
  //                       height: MediaQuery.of(context).size.height * 0.57,
  //                       child: Column(
  //                         children: [
  //                           Row(
  //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                             children: [
  //                               Text(
  //                                 'Select Payment Reason',
  //                                 style: TextStyle(
  //                                     fontSize: 23,
  //                                     fontWeight: FontWeight.w600),
  //                               ),
  //                               TextButton(
  //                                 onPressed: () {
  //                                   Navigator.pop(context);
  //                                 },
  //                                 child: Icon(
  //                                   Icons.close,
  //                                   color: Colors.black,
  //                                 ),
  //                               )
  //                             ],
  //                           ),
  //                           SizedBox(
  //                             height: MediaQuery.of(context).size.height * 0.02,
  //                           ),
  //                           Container(
  //                             child: Row(
  //                               mainAxisAlignment:
  //                                   MainAxisAlignment.spaceBetween,
  //                               children: [
  //                                 Container(
  //                                   child: Text(
  //                                     "Cunsultation",
  //                                     style: const TextStyle(
  //                                       fontSize: 20.0,
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 Radio(
  //                                   value: 'Cunsultation',
  //                                   activeColor: Color(0xFFFD5722),
  //                                   groupValue: genderValue,
  //                                   onChanged: (value) {
  //                                     setState(() {
  //                                       genderValue = value;
  //                                     });
  //                                   },
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                           Container(
  //                             height: 1,
  //                             color: Colors.grey,
  //                           ),
  //                           Container(
  //                             child: Row(
  //                               mainAxisAlignment:
  //                                   MainAxisAlignment.spaceBetween,
  //                               children: [
  //                                 Container(
  //                                   child: Text(
  //                                     "Tele-Cunsultation",
  //                                     style: const TextStyle(
  //                                       fontSize: 20.0,
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 Radio(
  //                                   value: 'Tele-Cunsultation',
  //                                   activeColor: Color(0xFFFD5722),
  //                                   groupValue: genderValue,
  //                                   onChanged: (value) {
  //                                     setState(() {
  //                                       genderValue = value;
  //                                     });
  //                                   },
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                           Container(
  //                             height: 1,
  //                             color: Colors.grey,
  //                           ),
  //                           Container(
  //                             child: Row(
  //                               mainAxisAlignment:
  //                                   MainAxisAlignment.spaceBetween,
  //                               children: [
  //                                 Container(
  //                                   child: Text(
  //                                     "Vaccination",
  //                                     style: const TextStyle(
  //                                       fontSize: 20.0,
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 Radio(
  //                                   value: 'Vaccination',
  //                                   activeColor: Color(0xFFFD5722),
  //                                   groupValue: genderValue,
  //                                   onChanged: (value) {
  //                                     setState(() {
  //                                       genderValue = value;
  //                                     });
  //                                   },
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                           Container(
  //                             height: 1,
  //                             color: Colors.grey,
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     Container(
  //                       child: Column(
  //                         children: [
  //                           TextFormField(
  //                             focusNode: _nodeAmount,
  //                             controller: strAmount,
  //                             keyboardType: TextInputType.number,
  //                             validator: (value) =>
  //                                 value.isEmpty ? "Please enter Amount" : null,
  //                             autovalidateMode:
  //                                 AutovalidateMode.onUserInteraction,
  //                             textInputAction: TextInputAction.next,
  //                             decoration: InputDecoration(
  //                               hintText: 'Amount',
  //                             ),
  //                           ),
  //                           TextFormField(
  //                             focusNode: _nodeEmail,
  //                             controller: strEmail,
  //                             keyboardType: TextInputType.text,
  //                             validator: (value) =>
  //                                 value.isEmpty ? "Please enter email" : null,
  //                             autovalidateMode:
  //                                 AutovalidateMode.onUserInteraction,
  //                             textInputAction: TextInputAction.next,
  //                             decoration: InputDecoration(
  //                               hintText: 'Email Id',
  //                             ),
  //                           ),
  //                           Row(
  //                             children: [
  //                               Checkbox(
  //                                 value: agree,
  //                                 onChanged: (value) {
  //                                   setState(() {
  //                                     agree = value ?? false;
  //                                   });
  //                                 },
  //                               ),
  //                               Text(
  //                                 'I accept  ',
  //                                 style: TextStyle(
  //                                     color: Colors.black, fontSize: 17),
  //                               ),
  //                               GestureDetector(
  //                                 onTap: () {},
  //                                 child: Text(
  //                                   'terms and conditions',
  //                                   style: TextStyle(
  //                                     color: Color(0xFFFD5722),
  //                                     fontSize: 20,
  //                                   ),
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                           Row(
  //                             children: [
  //                               Container(
  //                                 width:
  //                                     MediaQuery.of(context).size.width * 0.56,
  //                               ),
  //                               Container(
  //                                 // padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
  //                                 height: 36,
  //                                 width:
  //                                     MediaQuery.of(context).size.width * 0.35,
  //                                 child: ElevatedButton(
  //                                   onPressed: () {},
  //                                   child: Text(
  //                                     'START PAYMENT',
  //                                     style: TextStyle(
  //                                         fontSize: 16,
  //                                         fontWeight: FontWeight.w600,
  //                                         color: Colors.white),
  //                                   ),
  //                                   style: ElevatedButton.styleFrom(
  //                                     primary: Color(0xFFFD5722),
  //                                   ),
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }
}

class PaymentSheet extends StatefulWidget {
  const PaymentSheet({Key key}) : super(key: key);

  @override
  State<PaymentSheet> createState() => _PaymentSheetState();
}

class _PaymentSheetState extends State<PaymentSheet> {
  String genderValue;
  final formKey = GlobalKey<FormState>();
  bool _enableBtn = false;
  bool agree = false;
  final FocusNode _nodeAmount = FocusNode();
  final FocusNode _nodeEmail = FocusNode();
  TextEditingController strAmount = TextEditingController();
  TextEditingController strEmail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, state) {
      return DraggableScrollableSheet(
          initialChildSize: 0.87,
          maxChildSize: 0.87,
          minChildSize: 0.87,
          // builder: (_, controller) {
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              margin: EdgeInsets.only(
                left: 4,
                right: 4,
                bottom: 4,
              ),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: ListView(
                controller: scrollController,
                children: [
                  Form(
                    key: formKey,
                    onChanged: () => setState(
                        () => _enableBtn = formKey.currentState.validate()),
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.57,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Select Payment Reason',
                                    style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        "Cunsultation",
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                        ),
                                      ),
                                    ),
                                    Radio(
                                      value: 'Cunsultation',
                                      activeColor: Color(0xFFFD5722),
                                      groupValue: genderValue,
                                      onChanged: (value) {
                                        setState(() {
                                          genderValue = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 1,
                                color: Colors.grey,
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        "Tele-Cunsultation",
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                        ),
                                      ),
                                    ),
                                    Radio(
                                      value: 'Tele-Cunsultation',
                                      activeColor: Color(0xFFFD5722),
                                      groupValue: genderValue,
                                      onChanged: (value) {
                                        setState(() {
                                          genderValue = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 1,
                                color: Colors.grey,
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Text(
                                        "Vaccination",
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                        ),
                                      ),
                                    ),
                                    Radio(
                                      value: 'Vaccination',
                                      activeColor: Color(0xFFFD5722),
                                      groupValue: genderValue,
                                      onChanged: (value) {
                                        setState(() {
                                          genderValue = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 1,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              TextFormField(
                                focusNode: _nodeAmount,
                                controller: strAmount,
                                keyboardType: TextInputType.number,
                                validator: (value) => value.isEmpty
                                    ? "Please enter Amount"
                                    : null,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  hintText: 'Amount',
                                ),
                              ),
                              TextFormField(
                                focusNode: _nodeEmail,
                                controller: strEmail,
                                keyboardType: TextInputType.text,
                                validator: (value) =>
                                    value.isEmpty ? "Please enter email" : null,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  hintText: 'Email Id',
                                ),
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: agree,
                                    onChanged: (value) {
                                      setState(() {
                                        agree = value ?? false;
                                      });
                                    },
                                  ),
                                  Text(
                                    'I accept  ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 17),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      'terms and conditions',
                                      style: TextStyle(
                                        color: Color(0xFFFD5722),
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.56,
                                  ),
                                  Container(
                                    // padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                    height: 36,
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: Text(
                                        'START PAYMENT',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: Color(0xFFFD5722),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
    });
  }
}


// showModalBottomSheet(
//     context: context,
//     builder: (context) {
//       return StatefulBuilder(
//           builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
//         return Container(
//           height: heightOfModalBottomSheet,
//           child: RaisedButton(onPressed: () {
//             setState(() {
//               heightOfModalBottomSheet += 10;
//             });
//           }),
//         );
//       });
// });