import 'package:flutter/material.dart';
import 'package:salon_provider/feature/values/animate_do.dart';
import 'package:get/get.dart';
import 'feature/server/helper/sp_helpar.dart';
import 'feature/server/service/server_salon.dart';

import 'feature/values/colors.dart';
import 'feature/view/Screen_Salon/auth_screen/sign_in_screen.dart';
import 'feature/view/Screen_Salon/onboardingUI/screens/onboarding.dart';
import 'main_screen.dart';
import 'feature/view/widgets/custom_image.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // if (onBoarding == false) {
    //   Future.delayed(delay, () {
    //     Get.off(() => Onboarding());
    //   });
    // } else {
    String token = SPHelper.spHelper.getToken();

    if (token == null) {
      Future.delayed(Duration(milliseconds: 2), () async {
        Get.off(() => SignInScreen());
      });
    } else {
      Future.delayed(Duration(milliseconds: 2), () async {
        await ServerProvider.instance.getAllVaraibles();
        Get.off(() => MainScreen());
      });
    }
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.gray20,
        body: Container(
          alignment: Alignment.center,
          child: ZoomIn(
              animate: true,
              child: BounceInDown(
                  duration: Duration(milliseconds: 400),
                  child: Container(child: CustomLogo()))),
        ));
  }
}
