import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'MyNavigationBar.dart';
import 'Providers/HttpClient.dart';
import 'Utils/SharePreference.dart';
import 'Utils/app_url.dart';
import 'Widgets.dart/OverlayDialogWarning.dart';

class ChangeProvider extends StatefulWidget {
  const ChangeProvider({Key key}) : super(key: key);

  @override
  State<ChangeProvider> createState() => _ChangeProviderState();
}

class _ChangeProviderState extends State<ChangeProvider> {
  bool isLoading = false;
  UserPreferences userPreference = UserPreferences();

  final FocusNode _nodeAppcode = FocusNode();
  TextEditingController strAppcode = TextEditingController();
  int userid;
  int selectedIndex = 0;

  var data = [];

  _getCategory() async {
    print("Call GetCustomerTokenByAppCode method");
    FocusScope.of(context).unfocus(); // Used foe dismiss keyboard
    setState(() {
      isLoading = true;
    });
    var obj = {
      "Appcode": strAppcode.text,
    };
    print('>>>>>>>>>>');
    print(obj);

    final Future<Map<String, dynamic>> successfulMessage = HttpClient().getReq(
        AppUrl.getcustomertokenbyappcode +
            "?Appcode=" +
            strAppcode.text.toString());

    await successfulMessage.then((response) {
      print('>>>>>>>>>> Get Data <<<<<<<<');
      print(response);
      setState(() {
        isLoading = false;
      });
      if (response['status'] == true) {
        setState(() {
          //  data = [response['data']['token']];
          // Map<String, dynamic> user = response['data']['token'];
          userPreference.setToken((response["data"]["token"]));
        });
        Timer(
            Duration(seconds: 1),
            () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => MyNavigationBar(selectedIndex)),
                (route) => false));
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
                  "Change Provider",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
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
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Card(
                    elevation: 3,
                    // color: Colors.amber,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            height: 100,
                            child: Image(image: AssetImage('images/axon.jpg')),
                          ),
                          SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Select Hospital by: ',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          InkWell(
                            onTap: () {},
                            child: Row(
                              children: [
                                SizedBox(width: 10),
                                Container(
                                  height: 40,
                                  child: Image(
                                      image: AssetImage('images/axon.jpg')),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'SCANNING APP CODE',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                height: 1,
                                width: 132,
                                color: Colors.black,
                              ),
                              SizedBox(width: 5),
                              Text('or'),
                              SizedBox(width: 5),
                              Container(
                                height: 1,
                                width: 164,
                                color: Colors.black,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      child: AlertDialog(
                                        title: Text('Code'),
                                        content: TextField(
                                          focusNode: _nodeAppcode,
                                          controller: strAppcode,
                                          cursorColor: Color(0xFFFD5722),
                                          onChanged: (value) {},
                                          decoration: InputDecoration(
                                              hintText: 'Write App Code'),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'Cancel',
                                                style: TextStyle(
                                                    color: Color(0xFFFD5722)),
                                              )),
                                          TextButton(
                                              onPressed: () {
                                                _getCategory();
                                              },
                                              child: Text(
                                                'OK',
                                                style: TextStyle(
                                                    color: Color(0xFFFD5722)),
                                              ))
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: Row(
                              children: [
                                SizedBox(width: 10),
                                Container(
                                  height: 40,
                                  child: Image(
                                      image: AssetImage('images/axon.jpg')),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'WRITING CODE MANUALLY',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'OR',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {},
                    child: Card(
                      elevation: 3,
                      // shape: ,
                      child: Container(
                        color: Colors.white,
                        width: double.infinity,
                        height: 50,
                        child: Container(
                            padding: EdgeInsets.only(
                                left: 16, bottom: 10, top: 14, right: 16),
                            child: Text(
                              'Amate Hospital',
                              style: TextStyle(fontSize: 18),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
