import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SPHelper {
  SPHelper._();
  static SPHelper spHelper = SPHelper._();

  SharedPreferences sharedPreferences;

  Future<SharedPreferences> initSharedPrefrences() async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
      return sharedPreferences;
    } else {
      return sharedPreferences;
    }
  }

  setLanguage(String value) async {
    sharedPreferences.setString('language', value);
  }

  getLanguage() async {
    String x = sharedPreferences.getString('language');
    return x;
  }

  setToken(String value) async {
    sharedPreferences.setString('accessToken', value);
  }

  Future<String> getRegisterationCode() async {
    String x = sharedPreferences.getString('registerCode');
    return x;
  }

  setRegisterationCode(String value) async {
    sharedPreferences.setString('registerCode', value);
  }

  Future<String> getIsOnBording() async {
    String x = sharedPreferences.getString('isOnbording');
    return x;
  }

  setIsOnBording(String value) async {
    sharedPreferences.setString('isOnbording', value);
  }

  Future<String> getToken() async {
    String x = sharedPreferences.getString('accessToken');

    return x;
  }

  isSeenLangSet(bool value) async {
    sharedPreferences.setBool('lang', value);
  }

  Future<bool> isSeenLang() async {
    bool x = sharedPreferences.getBool('lang');
    return x;
  }

  setTokenDelivery(String value) async {
    sharedPreferences.setString('accessTokenDelivery', value);
  }

  Future<String> getTokenDelivery() async {
    String x = sharedPreferences.getString('accessTokenDelivery');
    return x;
  }

  setUser(String value) async {
    sharedPreferences.setString('userId', value);
  }

  String getUser() {
    String x = sharedPreferences.getString('userId');
    log('getUserType $x');
    return x;
  }
}
