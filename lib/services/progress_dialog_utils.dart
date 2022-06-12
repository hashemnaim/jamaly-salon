import 'package:flutter/material.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:yacht_booking/common/app_colors.dart';

class ProgressDialogUtils {
  static show() {
    SVProgressHUD.show();
    SVProgressHUD.setBackgroundColor(AppColors.primaryColor);
    SVProgressHUD.setBackgroundLayerColor(AppColors.primaryColor);
    SVProgressHUD.setBackgroundLayerColor(AppColors.primaryColor);
    SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.custom);

    SVProgressHUD.setForegroundColor(Colors.white);
    // SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black);
  }

  static hide() {
    SVProgressHUD.dismiss();
  }
}
