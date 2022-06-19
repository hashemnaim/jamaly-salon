import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../server/getx/app_get_salon.dart';
import '../../values/colors.dart';

class DialogLoading {
  AppGet appController = Get.find();
  DialogLoading._();
  static DialogLoading pr = DialogLoading._();
  void show() {
    appController.dialog.show(
        message: 'Loading'.tr + '...',
        indicatorColor: AppColors.primary,
        textStyle: TextStyle(color: Colors.black));
  }

  void hide() {
    appController.dialog.hide();
  }
}
