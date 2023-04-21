// To parse this JSON data, do
//
//     final customerDoctorModel = customerDoctorModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

CustomerDoctorModel customerDoctorModelFromJson(String str) =>
    CustomerDoctorModel.fromJson(json.decode(str));

String customerDoctorModelToJson(CustomerDoctorModel data) =>
    json.encode(data.toJson());

class CustomerDoctorModel {
  CustomerDoctorModel({
    @required this.id,
    @required this.status,
    this.messageCode,
    this.displayMessage,
    @required this.data,
  });

  String id;
  bool status;
  dynamic messageCode;
  dynamic displayMessage;
  List<Datum> data;

  factory CustomerDoctorModel.fromJson(Map<String, dynamic> json) =>
      CustomerDoctorModel(
        id: json["\u0024id"],
        status: json["status"],
        messageCode: json["messageCode"],
        displayMessage: json["displayMessage"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "\u0024id": id,
        "status": status,
        "messageCode": messageCode,
        "displayMessage": displayMessage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    @required this.id,
    @required this.customerId,
    @required this.doctorId,
    @required this.doctorName,
    @required this.specialty,
    @required this.degree,
    @required this.regNo,
    @required this.customerDoctorId,
    @required this.email,
    @required this.bookAppointmentLink,
    @required this.isActive,
    @required this.department,
    @required this.notifyApptBooking,
    @required this.includeBlocktimeMsg,
  });

  String id;
  int customerId;
  int doctorId;
  String doctorName;
  String specialty;
  String degree;
  String regNo;
  int customerDoctorId;
  String email;
  String bookAppointmentLink;
  bool isActive;
  String department;
  bool notifyApptBooking;
  bool includeBlocktimeMsg;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["\u0024id"],
        customerId: json["customerId"],
        doctorId: json["doctorId"],
        doctorName: json["doctorName"],
        specialty: json["specialty"],
        degree: json["degree"],
        regNo: json["regNo"],
        customerDoctorId: json["customerDoctorId"],
        email: json["email"],
        bookAppointmentLink: json["bookAppointmentLink"],
        isActive: json["isActive"],
        department: json["department"],
        notifyApptBooking: json["notifyApptBooking"],
        includeBlocktimeMsg: json["includeBlocktimeMsg"],
      );

  Map<String, dynamic> toJson() => {
        "\u0024id": id,
        "customerId": customerId,
        "doctorId": doctorId,
        "doctorName": doctorName,
        "specialty": specialty,
        "degree": degree,
        "regNo": regNo,
        "customerDoctorId": customerDoctorId,
        "email": email,
        "bookAppointmentLink": bookAppointmentLink,
        "isActive": isActive,
        "department": department,
        "notifyApptBooking": notifyApptBooking,
        "includeBlocktimeMsg": includeBlocktimeMsg,
      };
}
