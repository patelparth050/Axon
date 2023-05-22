import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:printing/printing.dart';
import 'package:url_launcher/url_launcher.dart';
import 'PaymentHistory.dart';
import 'Settings.dart';
import 'Widgets.dart/OverlayDialogWarning.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class ReportDetails extends StatefulWidget {
  var reportData;

  ReportDetails(this.reportData);

  @override
  State<ReportDetails> createState() => _ReportDetailsState(this.reportData);
}

class _ReportDetailsState extends State<ReportDetails> {
  var reportData;
  _ReportDetailsState(this.reportData);
  bool isLoading = false;

  // Future<void> printDoc() async {
  //   final image = await imageFromAssetBundle(
  //     "assets/Images/image.png",
  //   );
  //   final doc = pw.Document();
  //   doc.addPage(pw.Page(
  //       pageFormat: PdfPageFormat.a4,
  //       build: (pw.Context context) {
  //         return buildPrintableData(image);
  //       }));
  //   await Printing.layoutPdf(
  //       onLayout: (PdfPageFormat format) async => doc.save());
  // }

  Future<void> printDoc1() async {
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => await Printing.convertHtml(
              format: format,
              html: reportData['treatment'],
            ));
  }

  Future<void> printDoc2() async {
    final doc = pw.Document();

    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text('Hello World'),
          ); // Center
        }));
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }

  @override
  Widget build(BuildContext context) {
    print('objectobjectobjectobjectobjectobject');
    print(reportData);
    print('objectobjectobjectobjectobjectobject');
    return Scaffold(
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
                  "Your Report Details",
                  style: TextStyle(
                    color: Colors.black,
                    // fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                InkWell(
                  onTap: () {
                    printDoc1();
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
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Provider:' + reportData['providerName']),
                          SizedBox(
                            height: 5,
                          ),
                          Text('Member: ' + reportData['patientName']),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Updated on: 21-Feb-2023, 12:30:07 PM'),
                              InkWell(
                                // onTap: () {
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) =>
                                //               ReportDetails()));
                                // },
                                child: Container(
                                    // child: Icon(
                                    //   Icons.info_outline,
                                    // ),
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Html(
                            data: reportData['treatment'],
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
    );
  }
}
