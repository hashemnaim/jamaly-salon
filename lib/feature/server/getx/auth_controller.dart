import 'package:get/get.dart';

class AuthController extends GetxController {
  var acceptTerms = false.obs;
  RxString name = "".obs;
  RxInt otp = 0.obs;
  RxString phoneNumber = "".obs;
  RxString password = "".obs;
  RxString authCode = "".obs;
  RxString language = "en".obs;

  var listChats = <Map<dynamic, dynamic>>[].obs;

  savePhaoneNumber(String mobileNumber) {
    this.phoneNumber.value = mobileNumber;
  }

  saveFirstName(String value) {
    this.name.value = value;
  }

  savePassword(String value) {
    this.password.value = value;
  }

  changeAcceptTerms(bool value) {
    this.acceptTerms.value = value;
  }
}
