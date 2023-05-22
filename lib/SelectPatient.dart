import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import 'Providers/HttpClient.dart';
import 'Utils/SharePreference.dart';
import 'Utils/app_url.dart';
import 'Widgets.dart/OverlayDialogWarning.dart';

enum ProductTypeEnum { Male, Female }

class SelectPatient extends StatefulWidget {
  const SelectPatient({Key key}) : super(key: key);

  @override
  State<SelectPatient> createState() => _SelectPatientState();
}

class _SelectPatientState extends State<SelectPatient> {
  UserPreferences userPreference = UserPreferences();
  String mobile;
  bool isLoading = false;
  String genderValue;
  String patientMobile;
  String patientBirth;
  String registeredpatientBirth;
  String CaseNo = "";
  String PatType;
  List patientData = [];
  List patientById = [];
  final formKey = GlobalKey<FormState>();
  final FocusNode _nodeName = FocusNode();
  final FocusNode _nodeBirth = FocusNode();
  final FocusNode _nodePatientId = FocusNode();
  TextEditingController strName = TextEditingController();
  TextEditingController strBirthDate = TextEditingController();
  TextEditingController strPatientId = TextEditingController();
  bool _enableBtn = false;

  @override
  void initState() {
    userPreference.getMobile().then((value1) {
      setState(() {
        mobile = value1;
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
    // var obj = {
    //   "customerToken": token,
    //   // "68cb311f-585a-4e86-8e89-06edf1814080": token,
    // };
    print('>>>>>>>>>>');
    // print(obj);

    final Future<Map<String, dynamic>> successfulMessage = HttpClient()
        .getReq(AppUrl.getpatienthistory + "?Mobile=" + "7567444375");

    await successfulMessage.then((response) {
      print('>>>>>>>>>> Get Data <<<<<<<<');
      print(response);

      setState(() {
        isLoading = false;
      });

      if (response['status'] == true) {
        setState(() {
          patientData = response['data'];
        });
        print(">>>>>>>>>>>>>>");
        print(patientData);
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

  _getPatientBYId() async {
    print("Call GetCustomerTokenByAppCode method");
    print('00000000000000000000000000000000000000000000');
    // print(mobile);
    print('0000000000000000000000000000000000000000000');
    FocusScope.of(context).unfocus(); // Used foe dismiss keyboard
    setState(() {
      isLoading = true;
    });
    // var obj = {
    //   "customerToken": token,
    //   // "68cb311f-585a-4e86-8e89-06edf1814080": token,
    // };
    print('>>>>>>>>>>');
    print(strPatientId.text);

    final Future<Map<String, dynamic>> successfulMessage = HttpClient()
        .getReq(AppUrl.getpatientbyid + "?caseno=" + strPatientId.text);

    await successfulMessage.then((response) {
      print('>>>>>>>>>> Get Data <<<<<<<<');
      print(response);

      setState(() {
        isLoading = false;
      });

      if (response['status'] == true) {
        setState(() {
          patientById = response['data'];
          patientMobile = patientById[0]['patient_mobile'];
          patientBirth = patientById[0]['patient_dob'];
          String date = patientById[0]['patient_dob'];
          DateTime parseDate =
              new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
          var inputDate = DateTime.parse(parseDate.toString());
          var outputFormat = DateFormat('E d-MMMM-yyyy');
          var outputFormat1 = DateFormat('E,yyyy');
          var outputFormat2 = DateFormat('d MMM');
          var outputFormat3 = DateFormat('hh:mm a');
          var outputFormat4 = DateFormat('d-MM-yyyy');
          // var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
          var outputDate = outputFormat.format(inputDate);
          var outputDate1 = outputFormat1.format(inputDate);
          var outputDate2 = outputFormat2.format(inputDate);
          var outputDate3 = outputFormat3.format(inputDate);
          var outputDate4 = outputFormat4.format(inputDate);
          patientBirth = outputDate4;
          print('|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||');
          print(outputDate);
          print(outputDate1);
          print(outputDate2);
          print(outputDate3);
          print(outputDate4);
          print(patientBirth);
          print(
              '|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||');
        });
        print(">>>>>>>>>>>>>>");
        print(patientById);
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

  createPatientListContainer(BuildContext context, int itemIndex) {
    // registeredpatientBirth = patientData[itemIndex]['patient_dob'];

    String date = patientData[itemIndex]['patient_dob'];

    DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('E d-MMMM-yyyy');
    var outputFormat1 = DateFormat('E,yyyy');
    var outputFormat2 = DateFormat('d MMM');
    var outputFormat3 = DateFormat('hh:mm a');
    var outputFormat4 = DateFormat('d-MM-yyyy');
    var outputFormat5 = DateFormat('d-MMM-yyyy');
    // var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    var outputDate1 = outputFormat1.format(inputDate);
    var outputDate2 = outputFormat2.format(inputDate);
    var outputDate3 = outputFormat3.format(inputDate);
    var outputDate4 = outputFormat4.format(inputDate);
    var outputDate5 = outputFormat5.format(inputDate);
    registeredpatientBirth = outputDate5;
    print('|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||');
    print(outputDate);
    print(outputDate1);
    print(outputDate2);
    print(outputDate3);
    print(outputDate4);
    print(outputDate5);
    // print(patientBirth);
    print('|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||');
    // final notificationObj = listOfColumns[itemIndex];
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context, [
              patientData[itemIndex]['patient_name'],
              registeredpatientBirth,
              patientData[itemIndex]['patient_gender'],
              patientData[itemIndex]['case_no'].toString(),
              PatType = "Old",
            ]);
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    width: 25.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(patientData[itemIndex]['case_no'].toString()),
                        Container(
                          child: Icon(Icons.person),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(patientData[itemIndex]['patient_name']),
                        SizedBox(
                          height: 10,
                        ),
                        Text(patientData[itemIndex]['patient_mobile']),
                        SizedBox(
                          height: 10,
                        ),
                        Text(registeredpatientBirth),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // SizedBox(
        //   height: 20,
        // ),
      ],
    );
  }

  // createPatientByIdContainer(BuildContext context, int itemIndex) {
  //   // final notificationObj = listOfColumns[itemIndex];
  //   return Column(
  //     children: [
  //       InkWell(
  //         onTap: () {
  //           //   Navigator.push(
  //           //       context,
  //           //       MaterialPageRoute(
  //           //           builder: (context) =>
  //           //               ReportDetails(reportData[itemIndex])));
  //         },
  //         child: Card(
  //           child: Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Row(
  //               children: [
  //                 Container(
  //                   width: 25.w,
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     children: [
  //                       Text(patientById[itemIndex]['case_no'].toString()),
  //                       Container(
  //                         child: Icon(Icons.person),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 Container(
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(patientById[itemIndex]['patient_name']),
  //                       SizedBox(
  //                         height: 10,
  //                       ),
  //                       Text(patientById[itemIndex]['patient_mobile']),
  //                       SizedBox(
  //                         height: 10,
  //                       ),
  //                       Text(patientById[itemIndex]['patient_dob']),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //       // SizedBox(
  //       //   height: 20,
  //       // ),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
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
                  "Change Patient",
                  style: TextStyle(
                    color: Colors.black,
                    // fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ),
          bottom: TabBar(
            indicatorColor: Color(0xFFFD5722),
            labelColor: Colors.black,
            tabs: [
              Tab(
                text: 'REGISTERED',
              ),
              Tab(
                text: 'UNREGISTERED',
              ),
              Tab(
                text: 'PATIENT ID',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        ListView.builder(
                            padding: EdgeInsets.only(bottom: 10),
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: patientData.length,
                            itemBuilder: (BuildContext context, int itemIndex) {
                              return createPatientListContainer(
                                  context, itemIndex);
                            }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        Center(
                          child: Text(
                            'Add new Patient',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0XFF545454),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Form(
                            key: formKey,
                            onChanged: () => setState(() =>
                                _enableBtn = formKey.currentState.validate()),
                            child: Column(
                              children: [
                                TextFormField(
                                  focusNode: _nodeName,
                                  controller: strName,
                                  keyboardType: TextInputType.text,
                                  validator: (value) => value.isEmpty
                                      ? "Please enter full name"
                                      : null,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    hintText: 'Full Name',
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  focusNode: _nodeBirth,
                                  controller: strBirthDate,
                                  keyboardType: TextInputType.text,
                                  // // validator: (value) => value.isEmpty
                                  //     ? "Please enter BirthDate"
                                  //     : null,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    hintText: 'Birthday(optional)',
                                  ),
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Radio(
                                            value: 'Male',
                                            activeColor: Color(0xFFFD5722),
                                            groupValue: genderValue,
                                            onChanged: (value) {
                                              setState(() {
                                                genderValue = value;
                                              });
                                            },
                                          ),
                                          Container(
                                            child: Text(
                                              "Male",
                                              style: const TextStyle(
                                                fontSize: 20.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Radio(
                                            value: 'Female',
                                            activeColor: Color(0xFFFD5722),
                                            groupValue: genderValue,
                                            onChanged: (value) {
                                              setState(() {
                                                genderValue = value;
                                              });
                                            },
                                          ),
                                          Container(
                                            child: Text(
                                              "Female",
                                              style: const TextStyle(
                                                fontSize: 20.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                  child: Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                    height: 36,
                                    width: 180,
                                    child: ElevatedButton(
                                      onPressed: _enableBtn
                                          ? () => Navigator.pop(context, [
                                                strName.text,
                                                strBirthDate.text,
                                                genderValue,
                                                CaseNo,
                                                PatType = "New",
                                              ])
                                          : null,
                                      child: Text(
                                        'SAVE',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: Color(0xFFFD5722),
                                        // shape: RoundedRectangleBorder(
                                        //   borderRadius: BorderRadius.circular(
                                        //       25), // <-- Radius
                                        // ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                            onFieldSubmitted: (value) {
                              setState(() {
                                strPatientId.text = value;
                                print('qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq');
                                print(value);
                                print(strPatientId.text);
                                print('qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq');
                                _getPatientBYId();
                              });
                            },
                            // onTap: () {
                            //   setState(() {
                            //     _getPatientBYId();
                            //   });
                            // },
                            // focusNode: _nodePatientId,
                            scrollPadding: EdgeInsets.only(bottom: 60),
                            keyboardType: TextInputType.text,
                            // validator: (value) =>
                            //     value.isEmpty ? "Please enter full name" : null,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              errorMaxLines: 10,
                              contentPadding: const EdgeInsets.all(10.0),
                              hintText: ' Unique ID',
                              prefixIconConstraints:
                                  BoxConstraints(maxHeight: 28, maxWidth: 28),
                              prefixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.black,
                                  )),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: patientById.isNotEmpty
                              ? InkWell(
                                  onTap: () {
                                    Navigator.pop(context, [
                                      patientById[0]['patient_name'],
                                      patientBirth,
                                      patientById[0]['patient_gender'],
                                      patientById[0]['case_no'].toString(),
                                      PatType = "Old",
                                    ]);
                                  },
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 25.w,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(patientById[0]['case_no']
                                                    .toString()),
                                                Container(
                                                  child: Icon(Icons.person),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(patientById[0]
                                                    ['patient_name']),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(patientMobile.replaceRange(
                                                    0, 10, 'xxxxxxxxxx')),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(patientBirth
                                                    // .replaceRange(
                                                    //     0, 10, 'xx-xx-xxxx')
                                                    ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 60.h,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.abc,
                                        size: 100,
                                      ),
                                      Text(
                                        'Please enter your Unique Id to search for Patients.',
                                        style: TextStyle(fontSize: 18.sp),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Stack(
//               children: [
//                 SingleChildScrollView(
//                   child: Padding(
//                     padding: EdgeInsets.all(15),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Center(
//                           child: Text(
//                             'Swipe down to refresh page',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 20,
//                               color: Color(0XFF545454),
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 120,
//                         ),
//                         Center(
//                           child: Image.asset(
//                             'images/orderbag.png',
//                             height: 90,
//                             width: 90,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         Center(
//                           child: Text(
//                             'Oops. You  haven\'t registered any Patient yet.',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 fontSize: 20,
//                                 color: Color(0XFF545454),
//                                 fontWeight: FontWeight.w600),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
