import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:salon_provider/feature/values/shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'colors.dart';

DateTime currentBackPressTime;

Future<bool> onWillPop() {
  DateTime now = DateTime.now();
  if (currentBackPressTime == null ||
      now.difference(currentBackPressTime) > Duration(seconds: 2)) {
    currentBackPressTime = now;
    Fluttertoast.showToast(msg: 'انقر مرة أخرى للمغادرة');
    return Future.value(false);
  }
  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  return Future.value(true);
}

setH(double height, BuildContext context) {
  return (height * MediaQuery.of(context).size.height) / 812;
}

setW(double width, BuildContext context) {
  return (width * MediaQuery.of(context).size.width) / 375;
}

setToast(
  String msg,
  Color color,
) {
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.primaryColor,
      textColor: Colors.white,
      fontSize: 16.0);
}

BoxDecoration customDecoration1 = BoxDecoration(
  color: AppColors.primaryColor,
  boxShadow: sShadow2,
  borderRadius: BorderRadius.circular(10),
  border: Border.all(
    color: Color(0xffEFE0E4),
  ),
);

BoxDecoration customDecoration2 = BoxDecoration(
  color: Colors.white,
  boxShadow: sShadow2,
  borderRadius: BorderRadius.circular(10),
  border: Border.all(
    color: Color(0xffEFE0E4),
  ),
);
kNavigatorPush(BuildContext context, Widget route) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => route,
      ));
}

kNavigatorPushReplacement(BuildContext context, Widget route) {
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => route,
      ));
}

kNavigatorPushAndRemoveUntil(BuildContext context, Widget route) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => route,
      ),
      (route) => false);
}

Future<CroppedFile> corpMetod(String logo, {int crop = 1}) async {
  if (logo != null) {
    CroppedFile croppedFile2 = await ImageCropper().cropImage(
        sourcePath: logo,
        compressFormat: ImageCompressFormat.png,
        compressQuality: 50,
        cropStyle: crop == 1 ? CropStyle.rectangle : CropStyle.circle,
        aspectRatio: crop == 1
            ? CropAspectRatio(ratioX: 6, ratioY: 10)
            : CropAspectRatio(ratioX: 0.5, ratioY: 0.5),
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
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
        ]);

    return croppedFile2;
  }
}
