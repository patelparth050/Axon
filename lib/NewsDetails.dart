import 'package:axon/SelectAppointmentDate.dart';
import 'package:axon/Utils/Loader.dart';
import 'package:axon/Utils/app_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'Providers/HttpClient.dart';
import 'Widgets.dart/OverlayDialogWarning.dart';

class NewsDetails extends StatefulWidget {
  String token;
  int newsId;
  NewsDetails(this.token, this.newsId);
  @override
  _NewsDetailsState createState() => _NewsDetailsState(this.token, this.newsId);
}

//----------------------------------------------------------------------////
class _NewsDetailsState extends State<NewsDetails> {
  int newsId;
  String token;
  bool isLoading = false;
  var newsDetailsData;
  var title;

  _NewsDetailsState(this.token, this.newsId);

  @override
  void initState() {
    _getNewsDetails();
    super.initState();
  }

  _getNewsDetails() async {
    print(token);
    print(newsId);
    print("Call GetCustomerTokenByAppCode method");
    // FocusScope.of(context).unfocus(); // Used foe dismiss keyboard
    setState(() {
      isLoading = true;
    });
    var customertoken = {
      "CustomerToken": token,
    };
    var newsdata = {
      "newsid": newsId,
    };
    print('>>>>>>>>>>');
    print(customertoken);
    print(newsdata);

    final Future<Map<String, dynamic>> successfulMessage = HttpClient().getReq(
        AppUrl.getnewsdetails +
            "?CustomerToken=" +
            token.toString() +
            "&newsid=" +
            newsId.toString());

    await successfulMessage.then((response) {
      print('>>>>>>>>>> Get Data <<<<<<<<');
      print(
          "objectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobjectobject");
      print(response);

      setState(() {
        isLoading = false;
      });
      if (response['status'] == true) {
        setState(() {
          newsDetailsData = response['data'];
          title = response['data']['title'];
          newsId = newsDetailsData['newsId'];
        });
        print(">>>>>>>>>>>>>>");
        print(newsDetailsData);
        print(response['data']['newsId']);
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
                  "News Details",
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
        children: <Widget>[
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 28, right: 8, bottom: 8, top: 8),
                    // alignment: Alignment.center,
                    child: Text(
                      // newsDetailsData["title"],
                      newsDetailsData["title"],
                      // title,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  SizedBox(height: 10),
                  Text(newsDetailsData["displayDate"]),
                  SizedBox(height: 20),
                  Card(
                    // color: Colors.amber,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Html(
                        data: newsDetailsData["description"],
                      ),
                      // Text(
                      //   newsDetailsData["description"],
                      //   style: TextStyle(
                      //     fontSize: 15,
                      //     fontWeight: FontWeight.normal,
                      //   ),
                      // ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          isLoading ? Loader() : Container(),
        ],
      ),
    );
  }
}
