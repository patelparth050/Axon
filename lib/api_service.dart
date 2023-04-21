import 'package:flutter/material.dart';

import 'Providers/HttpClient.dart';
import 'Utils/Loader.dart';
import 'Utils/SharePreference.dart';
import 'Utils/app_url.dart';
import 'Widgets.dart/OverlayDialogWarning.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _selected;
  List _myJson = [];
  // = [
  //   {"id": '1', "image": "images/c5.png", "name": "Affin Bank"},
  //   {"id": '2', "image": "images/c5.png", "name": "Ambank"},
  //   {"id": '3', "image": "images/c5.png", "name": "Bank Isalm"},
  //   {"id": '4', "image": "images/c5.png", "name": "Bank Rakyat"},
  //   {"id": '5', "image": "images/c5.png", "name": "Bank Simpanan Nasional"},
  //   {"id": '6', "image": "images/c5.png", "name": "CIMB Bank"},
  //   {"id": '7', "image": "images/c5.png", "name": "Hong Leong Bank"},
  //   {"id": '8', "image": "images/c5.png", "name": "HSBC"},
  //   {"id": '9', "image": "images/c5.png", "name": "MayBank2U"},
  //   {"id": '10', "image": "images/c5.png", "name": "Public Bank"},
  //   {"id": '11', "image": "images/c5.png", "name": "RHB NOW"},
  //   {"id": '12', "image": "images/c5.png", "name": "Standard Chartered"},
  //   {"id": '13', "image": "images/c5.png", "name": "United Oversea Bank"},
  //   {"id": '14', "image": "images/c5.png", "name": "OCBC Bank"},
  // ];
  String token;
  bool isLoading = false;
  List doctorData = List();
  int doctorId;

  // final _productSizesList = ["Dr. John Smith", "Dr. Demo Gynac"];
  // String _selectedVal = "";
  List productSizesList = [];
  UserPreferences userPreference = UserPreferences();

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
    // print('------------------------------------------------------');
    // print(token);
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

      if (response['status'] == true) {
        setState(() {
          doctorData = response['data'];
          _myJson = response['data'];
          doctorId = doctorData[0]['doctorId'];
        });
        setState(() {
          isLoading = false;
        });

        print(doctorData);

        print(">>>>>>>>>>>>>>");
        print(_myJson);
        print(">>>>>>>>>>>>>>");
        print(doctorId);
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
      appBar: AppBar(
        title: Text('Bank Demo App'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton<String>(
                      isDense: true,
                      hint: new Text("Select Bank"),
                      value: _selected,
                      onChanged: (String newValue) {
                        setState(() {
                          _selected = newValue;
                        });

                        print(_selected);
                      },
                      items: _myJson.map((map) {
                        return new DropdownMenuItem<String>(
                          value: map["doctorId"].toString(),
                          // value: _mySelection,

                          child: Row(
                            children: <Widget>[
                              // Image.asset(
                              //   map["image"],
                              //   width: 25,
                              // ),
                              Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(map["doctorName"])),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              isLoading ? Loader() : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   String _selected;
//   List<Map> _myJson = [
//     {"id": '1', "image": "images/c5.png", "name": "Affin Bank"},
//     {"id": '2', "image": "images/c5.png", "name": "Ambank"},
//     {"id": '3', "image": "images/c5.png", "name": "Bank Isalm"},
//     {"id": '4', "image": "images/c5.png", "name": "Bank Rakyat"},
//     {"id": '5', "image": "images/c5.png", "name": "Bank Simpanan Nasional"},
//     {"id": '6', "image": "images/c5.png", "name": "CIMB Bank"},
//     {"id": '7', "image": "images/c5.png", "name": "Hong Leong Bank"},
//     {"id": '8', "image": "images/c5.png", "name": "HSBC"},
//     {"id": '9', "image": "images/c5.png", "name": "MayBank2U"},
//     {"id": '10', "image": "images/c5.png", "name": "Public Bank"},
//     {"id": '11', "image": "images/c5.png", "name": "RHB NOW"},
//     {"id": '12', "image": "images/c5.png", "name": "Standard Chartered"},
//     {"id": '13', "image": "images/c5.png", "name": "United Oversea Bank"},
//     {"id": '14', "image": "images/c5.png", "name": "OCBC Bank"},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Bank Demo App'),
//       ),
//       body: Center(
//         child: Container(
//           padding: EdgeInsets.all(15),
//           decoration: BoxDecoration(
//               border: Border.all(width: 1, color: Colors.grey),
//               borderRadius: BorderRadius.circular(10)),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Expanded(
//                 child: DropdownButtonHideUnderline(
//                   child: ButtonTheme(
//                     alignedDropdown: true,
//                     child: DropdownButton<String>(
//                       isDense: true,
//                       hint: new Text("Select Bank"),
//                       value: _selected,
//                       onChanged: (String newValue) {
//                         setState(() {
//                           _selected = newValue;
//                         });

//                         print(_selected);
//                       },
//                       items: _myJson.map((Map map) {
//                         return new DropdownMenuItem<String>(
//                           value: map["id"].toString(),
//                           // value: _mySelection,
//                           child: Row(
//                             children: <Widget>[
//                               Image.asset(
//                                 map["image"],
//                                 width: 25,
//                               ),
//                               Container(
//                                   margin: EdgeInsets.only(left: 10),
//                                   child: Text(map["name"])),
//                             ],
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
