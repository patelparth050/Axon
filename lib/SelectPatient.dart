import 'package:axon/Settings.dart';
import 'package:flutter/material.dart';

enum ProductTypeEnum { Male, Female }

class SelectPatient extends StatefulWidget {
  const SelectPatient({Key key}) : super(key: key);

  @override
  State<SelectPatient> createState() => _SelectPatientState();
}

class _SelectPatientState extends State<SelectPatient> {
  String genderValue;
  String CaseNo = "New";

  final formKey = GlobalKey<FormState>();
  final FocusNode _nodeName = FocusNode();
  final FocusNode _nodeBirth = FocusNode();
  TextEditingController strName = TextEditingController();
  TextEditingController strBirthDate = TextEditingController();
  bool _enableBtn = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
                            'images/orderbag.png',
                            height: 90,
                            width: 90,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Text(
                            'Oops. You  haven\'t registered any Patient yet.',
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                            scrollPadding: EdgeInsets.only(bottom: 60),
                            keyboardType: TextInputType.text,
                            validator: (value) =>
                                value.isEmpty ? "Please enter full name" : null,
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
                          height: 150,
                        ),
                        Center(
                          child: Image.asset(
                            'images/orderbag.png',
                            height: 90,
                            width: 90,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Text(
                            'Please enter your Unique id to search for Patients.',
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
