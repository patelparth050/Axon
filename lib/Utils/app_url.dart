class AppUrl {
  static const String localBaseURL = "https://www.axonweb.in/api/";

// OTP Verify
  static const String baseURL = localBaseURL;

  static const String verifyotp = "BookAppointment/ValidateOTP";
  static const String sendotp = "BookAppointment/GenerateOTP";

  //Get Customer Token
  static const String getcustomertokenbyappcode =
      "BookAppointment/GetCustomerTokenByAppCode";

  //Get Notice Board List by Token
  static const String getnoticebytoken = "NewsFeed/NoticeBoard";

  //Get News Details
  static const String getnewsdetails = "NewsFeed/GetNewsDetails";

  //Get Customer Details
  static const String getcustomerdetails = "BookAppointment/GetCustomer";

  //Get Doctor
  static const String getdoctordetails = "BookAppointment/GetCustomerDoctor";

  //Get Appointmentstimeslot
  static const String getAppointmentstimeslot =
      "BookAppointment/GetAppointmentsInIntervals";

  //Book Appointment
  static const String bookappointment = "BookAppointment/BookAppointment";

  //Get Appointment History
  static const String getappointmenthistory =
      "BookAppointment/GetAppointmentHistory";

  //Cancel Appointment
  static const String cancelappointment = "BookAppointment/CancelAppointment";

  //Get Rx Visit History
  static const String getrxvisithistory = "BookAppointment/GetRxVisitHistory";

  //Get Patient By MobileNo
  static const String getpatienthistory =
      "BookAppointment/GetPatientByMobileNo";

  //Get Patient By Caseno
  static const String getpatientbyid = "BookAppointment/GetPatientByCaseno";
}
