import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/common/animate_do.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/user/auth_controller.dart';
import 'package:yacht_booking/controller/vendor/main_vendor_controller.dart';
import 'package:yacht_booking/services/progress_dialog_utils.dart';
import 'package:yacht_booking/services/sp_helper.dart';
import 'package:yacht_booking/view/user/bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'package:yacht_booking/view/vendor/main_vendor/main_vendor_screen.dart';

import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  MainVendorController mainVendorController = Get.find();
  @override
  void initState() {
    mainVendorController.getCurrentLocation();

    ProgressDialogUtils.hide();

    Future.delayed(
      Duration(seconds: 7),
      () async {
        String token = await SPHelper.spHelper.getToken();
        String type =   SPHelper.spHelper.getUser();

        if (token == null || token == '') {
          Helper.getMainDataWithOutToken();
          Get.off(() => WelcomeScreen());
        } else {
          if (type == "user") {
            Helper.getMainDataWithOutToken();
            Helper.getMainDataWithToken();
            Get.off(() => BottomNavBarScreen());
          } else {
            Helper.getMainVendorDataWithToken();

            Get.off(() => MainVendor());
          }
        }
      },
    );

    super.initState();
  }

  Alignment switchLogoPostion(String position) {
    switch (position) {
      case '0':
        return Alignment.center;
        break;
      case '1':
        return Alignment.topRight;
        break;
      case '2':
        return Alignment.topLeft;
        break;
      case '3':
        return Alignment.bottomRight;
        break;
      case '4':
        return Alignment.bottomLeft;
        break;

      default:
        return Alignment.center;
    }
  }

  AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => authController.settingAppData.value.status == null
            ? Helper.loading()
            : Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      Assets.getImage('splash'),
                    ),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.blue.withOpacity(0.25), BlendMode.darken),
                  ),
                ),
                child: FadeInRight(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Align(
                      alignment: switchLogoPostion(authController
                          .settingAppData.value.settingAppData[0].logoPosition
                          .toString()),
                      child: Image.network(
                        authController
                            .settingAppData.value.settingAppData[0].logo,
                        fit: BoxFit.contain,
                        width: 200.w,
                        height: 200.h,
                        color: Colors.white,
                        alignment: AlignmentDirectional.center,
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
