import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../Utils/Singleton.dart';
import 'package:http/http.dart' as HTTP;
import '../Utils/app_url.dart';

String timeOutErrorMessage = "Request timeout, Please try again...";
String socketExtentionErrorMessage =
    "Socket Extention Error, Please try again...";

const int timeOutSecond = 60;

class HttpClient with ChangeNotifier {
  static final HttpClient _httpclient = HttpClient._internal();

  factory HttpClient() {
    return _httpclient;
  }

  HttpClient._internal();

  Future<Map<String, dynamic>> getReq(String endPoint) async {
    var result;
    HTTP.Response response;
    try {
      response = await HTTP.get(Uri.parse(AppUrl.baseURL + endPoint), headers: {
        "Accept": "application/json",
      }).timeout(const Duration(seconds: timeOutSecond), onTimeout: () {
        // Time has run out, do what you wanted to do.
        //// Request Timeout response status code
        return HTTP.Response(timeOutErrorMessage, 408);
      });
    } catch (e) {
      if (e is SocketException) {
        //treat SocketException
        print("Socket exception: ${e.toString()}");
        response = HTTP.Response(e.message, 409);
      } else if (e is TimeoutException) {
        //treat TimeoutException
        print("Timeout exception: ${e.toString()}");
        response = HTTP.Response(timeOutErrorMessage, 408);
      } else {
        print("Unhandled exception: ${e.toString()}");
      }
    }

    if (response.statusCode == 200) {
      result = json.decode(response.body);
      print("result = " + result.toString());
    }
    // else if (response.statusCode == 401) {
    //   result = {
    //     'success': 0,
    //     'message': 'Unauthorized',
    //     'statusCode': response.statusCode,
    //     'response': json.decode(response.body)
    //   };
    // }
    else if (response.statusCode == 408) {
      // Timeout Status
      result = {
        'success': 0,
        'message': timeOutErrorMessage,
        'statusCode': response.statusCode,
        'response': response.body,
      };
    } else if (response.statusCode == 409) {
      // SocketException
      result = {
        'success': 0,
        'message': response.body.toString(),
        'statusCode': response.statusCode,
        'response': response.body,
      };
    } else {
      var responseData = json.decode(response.body);
      result = {'success': 0, 'message': responseData['message']};
    }
    return result;
  }

  Future<Map<String, dynamic>> postReq(String endPoint, dynamic params) async {
    var result;
    Singleton().printMessage('endpoint =  ' + endPoint);
    HTTP.Response response;
    try {
      response = await HTTP.post(
        Uri.parse(AppUrl.baseURL + endPoint),
        body: params,
        headers: {
          "Accept": "application/json",
        },
      ).timeout(const Duration(seconds: timeOutSecond), onTimeout: () {
        // Time has run out, do what you wanted to do.        //// Request Timeout response status code
        return HTTP.Response(timeOutErrorMessage, 408);
      });
    } catch (e) {
      if (e is SocketException) {
        //treat SocketException
        print("Socket exception: ${e.toString()}");
        response = HTTP.Response(e.message, 409);
      } else if (e is TimeoutException) {
        //treat TimeoutException
        print("Timeout exception: ${e.toString()}");
        response = HTTP.Response(timeOutErrorMessage, 408);
      } else {
        print("Unhandled exception: ${e.toString()}");
      }
    }
    print(response);
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      notifyListeners();
      try {
        result = responseData;
      } catch (err) {
        Singleton().printMessage(err.runTimeType);
      }
    }
    // else if (response.statusCode == 401) {
    //   var jsonResponse = json.decode(response.body);
    //   result = {
    //     'success': 0,
    //     'message': jsonResponse['message'],
    //     'statusCode': response.statusCode,
    //     'response': json.decode(response.body)
    //   };
    // }
    else if (response.statusCode == 408) {
      // Timeout Status
      result = {
        'status': false,
        'message': timeOutErrorMessage,
        'statusCode': response.statusCode,
        'response': response.body,
      };
    } else if (response.statusCode == 409) {
      // SocketException
      result = {
        'status': false,
        'message': response.body.toString(),
        'statusCode': response.statusCode,
        'response': response.body,
      };
    } else {
      notifyListeners();
      // var responseData = json.decode(response.body);
      result = {
        'status': false,
        'message': json.decode(response.body)['message']
      };
    }
    return result;
  }
}
