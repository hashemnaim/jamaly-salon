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

  setToken(String value) {
    sharedPreferences.setString('access_token', value);
  }

  removeToken() {
    sharedPreferences.remove(
      'access_token',
    );
  }

  setFcmToken(String value) {
    sharedPreferences.setString('fcmToken', value);
  }

  String getToken() {
    String x = sharedPreferences.getString('access_token');
    return x;
  }

  String getFcmToken() {
    String x = sharedPreferences.getString('fcmToken');
    return x;
  }

  setOnBoarding(bool value) {
    sharedPreferences.setBool('OnBoarding', value);
  }

  bool getOnBoarding() {
    return sharedPreferences.getBool('OnBoarding');
  }

  Future<void> setLanguge(String token) {
    return sharedPreferences.setString("Lang", token);
  }

  String getLanguge() {
    return sharedPreferences.getString("Lang");
  }

  addNew(String key, String value) async {
    sharedPreferences = await initSharedPrefrences();
    sharedPreferences.setString(key, value);
  }

  Future<String> getValue(String key) async {
    sharedPreferences = await initSharedPrefrences();
    String x = sharedPreferences.getString(key);
    return x;
  }

  clearSp() async {
    sharedPreferences = await initSharedPrefrences();
    sharedPreferences.clear();
  }

  setCountNotification(int value) async {
    sharedPreferences = await initSharedPrefrences();
    sharedPreferences.setInt('countNotifi', value);
  }

  Future<int> getCountNotification() async {
    sharedPreferences = await initSharedPrefrences();
    int x = sharedPreferences.getInt('countNotifi');
    return x;
  }
}
