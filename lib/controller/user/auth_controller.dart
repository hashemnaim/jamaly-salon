import 'dart:io';

import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:yacht_booking/apis/auth_apis.dart';
import 'package:yacht_booking/models/setting_app_model.dart';

class AuthController extends GetxController {
  String name;
  String email;
  String password;
  String mobile;
  int typeUser;
  XFile imageProfile;
  String lat;
  String long;
  Rx<SettingAppModel> settingAppData = SettingAppModel().obs;

  setName(String value) {
    this.name = value;
  }

  setEmail(String value) {
    this.email = value;
  }

  setPAssword(String value) {
    this.password = value;
  }

  setMobail(String value) {
    this.mobile = value;
  }

  setTypeUser(int value) {
    this.typeUser = value;
  }

  ///validation
  validationEmail(String data) {
    if (data == null || data == '') {
      return 'حقل مطلوب';
    } else if (!GetUtils.isEmail(data)) {
      return 'الرجاء كتابة عنوان بريد إلكتروني صحيح';
    }
  }

  validationNull(String data) {
    if (data == null || data == '') {
      return 'حقل مطلوب';
    }
  }

  validationMobile(String data) {
    if (data == null || data == '') {
      return 'حقل مطلوب';
    } else if (data.length < 8) {
      return 'يجب ان يكون اكثر من 8 خانات';
    }
  }

  setImageProfile() async {
    XFile image = await ImagePicker().pickImage(source: ImageSource.gallery);
    imageProfile = image;
    update(['profile']);
    AuthApis.authApis.setImageProfileUser(imageProfile);
  }

  clearImageProfile() {
    imageProfile = null;
    update(['profile']);
  }

  //   getCurrentLocation() async {
  //   //Geo.Geolocator geolocator = Geo.Geolocator();
  //   Geo.Position position = await Geo.Geolocator.getCurrentPosition(
  //     desiredAccuracy: Geo.LocationAccuracy.high,
  //   );

  //   lat = position.latitude.toString();
  //   long = position.longitude.toString();
  // }

}
