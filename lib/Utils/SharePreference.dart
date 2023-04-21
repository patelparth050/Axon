import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("access_token");
  }

  void setToken(String args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("access_token", args);
  }

  Future<String> getMobile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("access_mobile");
  }

  void setMobile(String args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("access_mobile", args);
  }

  Future<String> getLoginInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("loginInfo");
  }

  Future<bool> isUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isUser") == null ? false : prefs.getBool("isUser");
  }

  Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLoggedIn") == null
        ? false
        : prefs.getBool("isLoggedIn");
  }

  void logoutProcess() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("isLoggedIn");
    prefs.remove("loginInfo");
    prefs.remove("access_mobile");
    prefs.remove("access_token");
  }
}
