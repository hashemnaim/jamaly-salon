import 'package:flutter/services.dart';
import 'package:salon_provider/feature/server/getx/auth_controller.dart';
import 'package:salon_provider/feature/server/service/server_auth.dart';
import 'package:salon_provider/feature/view/Screen_Salon/auth_screen/widgets/custom_verification.dart';
import 'package:salon_provider/feature/view/Screen_Salon/auth_screen/widgets/top_auth.dart';
import 'package:salon_provider/feature/view/widgets/custom_button.dart';
import 'package:salon_provider/feature/view/widgets/custom_dialoug.dart';
import 'package:salon_provider/feature/view/widgets/custom_text.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/custom_image.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationScreen extends StatefulWidget {
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  GlobalKey<FormState> signUpKey = GlobalKey<FormState>();

  String phone;

  String otp;

  setPhone(String phone) {
    this.phone = phone;
  }

  setOtp(String otp) {
    this.otp = otp;
  }

  validationMobile(String data) {
    if (data == null || data == '') {
      return 'must be filled';
    } else if (!GetUtils.isPhoneNumber(data.toString())) {
      return 'Phone number is incorrect';
    }
  }

  AuthController _appController = Get.find();

  saveForm() async {
    if (otp == _appController.otp.value.toString()) {
      // if (ConnectivityService.connectivityStatus !=
      //     ConnectivityStatus.Offline) {
      await ServerAuth.instance.verification(
        mobile: _appController.phoneNumber.value,
        otp: otp,
      );
    } else {
      CustomDialougs.utils.showDialoug(
          messageKey: 'There is a problem with the internet',
          titleKey: 'alert');
    }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 0.0, // H
        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: CustomLogo()),
            TopAuth(
              title: 'Mobile Verification,'.tr,
              subTitle: 'Please type OTP code that we give you'.tr,
            ),
            SizedBox(
              height: 112.h,
            ),
            CustomVerification(
              onDone: (text) {
                otp = text;
                setOtp(otp);
                setState(() {});
              },
            ),
            CustomText(text: _appController.otp.value.toString()),
            SizedBox(
              height: 83.h,
            ),
            CustomButton(text: 'Verify Mobile'.tr, onPress: saveForm),
          ],
        ),
      ),
    );
  }
}
