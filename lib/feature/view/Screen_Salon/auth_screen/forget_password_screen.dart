import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salon_provider/feature/view/Screen_Salon/auth_screen/verify_mobile_screen.dart';
import 'package:salon_provider/feature/view/Screen_Salon/auth_screen/widgets/top_auth.dart';
import 'package:salon_provider/feature/view/widgets/custom_button.dart';
import 'package:salon_provider/feature/view/widgets/custom_text_field.dart';

import '../../../values/colors.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/custom_phone.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  GlobalKey<FormState> forgetPassKey = GlobalKey<FormState>();
  TextEditingController phone = TextEditingController();

  String email;

  setEmail(String email) {
    this.email = email;
  }

  validationMobile(String data) {
    if (data == null || data == '') {
      return 'must be filled'.tr;
    } else if (!GetUtils.isPhoneNumber(data.toString())) {
      return 'Phone number is incorrect'.tr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 0.0,
        // toolbarHeight: 0.0, // H
        backgroundColor: AppColors.primary,
        // systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Form(
          key: forgetPassKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child: CustomLogo()),
              TopAuth(
                title: 'Forgot password'.tr,
                subTitle:
                    'Please type your email below and we will give you a OTP code'
                        .tr,
              ),
              SizedBox(
                height: 80.h,
              ),
              IntlPhoneField(
                onSaved: (newValue) {
                  if (newValue.number[0] == "0") {
                    phone.text =
                        newValue.countryCode + newValue.number.substring(1);
                  } else {
                    phone.text = newValue.countryCode + newValue.number;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Phone Number'.tr,
                  fillColor: Colors.white,
                ),
                initialCountryCode: 'AE',
                controller: phone,
                validator: (value) => validationMobile(value),
              ),

              SizedBox(
                height: 16.h,
              ),
              // GestureDetector(
              //   child: CustomText(
              //     text: 'Use phone number?'.tr,
              //     fontWeight: FontWeight.w400,
              //     fontSize: 16.sp,
              //     color: AppColors.primaryColor,
              //   ),
              // ),
              SizedBox(
                height: 83.h,
              ),
              CustomButton(
                text: 'Send Code'.tr,
                onPress: () {
                  if (forgetPassKey.currentState.validate()) {
                    Get.to(() => VerificationScreen());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
