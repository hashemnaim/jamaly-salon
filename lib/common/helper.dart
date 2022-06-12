import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yacht_booking/apis/home_apis.dart';
import 'package:yacht_booking/apis/home_vendor_apis.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

class Helper {
  static Widget loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  static String limitString(String text, int limit) {
    return text.toString().substring(0, min<int>(limit, text.length)) +
        (text.length > limit ? "..." : '');
  }

  static setToast(String msg) {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static Widget widgetNoItem(String title) {
    return Center(
      child: CustomText(
        title,
        fontSize: 20.0,
        fontColor: Colors.black,
        fontWeight: FontWeight.w700,
        height: 1.05,
      ),
    );
  }

  static double childAspectRatio(double ratio) {
    return MediaQuery.of(Get.context).size.width /
        (MediaQuery.of(Get.context).size.height / ratio);
  }

  static validationEmail(String data) {
    if (data == null || data == '') {
      return 'الحقل مطلوب'.tr;
    } else if (!GetUtils.isEmail(data)) {
      return 'The email is not appropriate'.tr;
    }
  }

  static String validationNull(String data) {
    if (data == null || data == '') {
      return 'الحقل مطلوب'.tr;
    }
  }

  static String validationnoo(String data) {}

  static validationString(String data) {
    if (data == null || data == '') {
      return 'الحقل مطلوب'.tr;
    } else if (data.length < 8) {
      return 'يجب ان يكون اكبر من 8 احرف'.tr;
    }
  }

  static getSheetError(String title) {
    return Get.snackbar(
      '',
      '',
      messageText: CustomText(
        title.tr,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        fontColor: Colors.red,
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
    );
  }

  static getSheetSucsses(String title) {
    return Get.snackbar(
      '',
      '',
      messageText: CustomText(
        title.tr,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        fontColor: Colors.green,
        textAlign: TextAlign.center,
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
    );
  }

  static openPicker(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);

    try {
      File croppedFile = await ImageCropper().cropImage(
          sourcePath: pickedFile.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          aspectRatioPresets: Platform.isAndroid
              ? [
                  CropAspectRatioPreset.square,
                  CropAspectRatioPreset.ratio3x2,
                  CropAspectRatioPreset.original,
                  CropAspectRatioPreset.ratio4x3,
                  CropAspectRatioPreset.ratio16x9
                ]
              : [
                  CropAspectRatioPreset.original,
                  CropAspectRatioPreset.square,
                  CropAspectRatioPreset.ratio3x2,
                  CropAspectRatioPreset.ratio4x3,
                  CropAspectRatioPreset.ratio5x3,
                  CropAspectRatioPreset.ratio5x4,
                  CropAspectRatioPreset.ratio7x5,
                  CropAspectRatioPreset.ratio16x9
                ],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Yacht Booking App',
              toolbarColor: Colors.blue,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          iosUiSettings: IOSUiSettings(
            title: 'Cropper',
          ));
      return croppedFile;
    } catch (e) {
      return null;
    }
  }

  static getMainDataWithToken() async {
    HomeUserApis.homeUserApis.getProfile();
    HomeUserApis.homeUserApis.getOffers();
    HomeUserApis.homeUserApis.getAdvertisments();
    HomeUserApis.homeUserApis.getTopRatedOffers();
    HomeUserApis.homeUserApis.getCategories();
    HomeUserApis.homeUserApis.getServices();
    HomeUserApis.homeUserApis.getAllOwners();
    HomeUserApis.homeUserApis.getFavoriteShip();
    HomeUserApis.homeUserApis.getFavoriteOffer();
    HomeUserApis.homeUserApis.getFavoriteVendor();
  }

  static getMainVendorDataWithToken() async {
    HomeUserApis.homeUserApis.getProfile();
    HomeVendorApis.homeVendorApis.getRecievedOrderVendor("all");
    HomeVendorApis.homeVendorApis.homeStatstic();
    HomeVendorApis.homeVendorApis.getGallery(isFirst: true);
    HomeVendorApis.homeVendorApis.getVendorReviews();
    HomeVendorApis.homeVendorApis.getMyShips();
    HomeVendorApis.homeVendorApis.getMyOffers();
    HomeVendorApis.homeVendorApis.getVendorServices();
    HomeVendorApis.homeVendorApis.getVendorSubServices("1");
    HomeVendorApis.homeVendorApis.getNotifications();
  }

  static getMainDataWithOutToken() async {}
}