import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPreference {
  AuthPreference._();

  static final AuthPreference _instance = AuthPreference._();

  static AuthPreference get instance => _instance;

  void setUserLoggedIn(bool key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLoggedIn", key);
    // prefs.setString("userType", userType);
  }

  Future setFirstTime(bool key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isFirstTime", key);
    // prefs.setString("userType", userType);
  }
  Future getFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var log = prefs.getBool("isFirstTime") ?? true;
    return log;
  }


  Future<Map<String, dynamic>> getUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var log = prefs.getBool("isLoggedIn") ?? false;
    String userType=prefs.getString("userType") ?? "user";
    return {
      "isLoggedIn": log,
      "userType": userType,
    };
  }

  void saveUserDataToken({@required token}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("token", token);
  }

  Future getUserDataToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String result = pref.getString("token") ?? '';
    return result;
  }

  void saveUserData({@required data}) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("userData", data.toString());
  }

  Future getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String result = pref.getString("userData") ?? '';
    return result;
  }

}
