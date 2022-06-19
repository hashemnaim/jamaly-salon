import 'package:salon_provider/feature/server/helper/sp_helpar.dart';
import 'package:salon_provider/feature/server/service/server_auth.dart';
import 'package:salon_provider/feature/values/colors.dart';
import 'package:salon_provider/feature/view/widgets/custom_button.dart';
import 'package:salon_provider/feature/view/widgets/custom_phone.dart';
import 'package:salon_provider/feature/view/widgets/custom_text.dart';
import 'package:salon_provider/feature/view/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../widgets/custom_image.dart';
import 'forget_password_screen.dart';
import 'sign_up_screen.dart';
import 'widgets/top_auth.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  GlobalKey<FormState> signKey = GlobalKey<FormState>();

  TextEditingController password = TextEditingController();

  TextEditingController phone = TextEditingController();

  validationMobile(String data) {
    if (data == null || data == '') {
      return 'must be filled'.tr;
    } else if (!GetUtils.isPhoneNumber(data.toString())) {
      return 'Phone number is incorrect'.tr;
    }
  }

  validationNull(String data) {
    if (data == null || data == '') {
      return ' must be filled'.tr;
    }
  }

  validationString(String data) {
    if (data == null || data == '') {
      return ' must be filled'.tr;
    }
  }

  saveForm() async {
    if (signKey.currentState.validate()) {
      signKey.currentState.save();
      String fcmToken = SPHelper.spHelper.getFcmToken();
      await ServerAuth.instance.signIn(
        mobile: phone.text,
        password: password.text,
        fcmToken: fcmToken,
      );
      // } else {
      //   CustomDialougs.utils.showDialoug(
      //       messageKey: 'There is a problem with the internet'.tr,
      //       titleKey: 'alert'.tr);
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 0.0, // H
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: Form(
          key: signKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: CustomLogo()),
              TopAuth(),
              SizedBox(
                height: 40.h,
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
                height: 10.h,
              ),
              CustomTextFormField(
                password: true,
                hintText: 'Password'.tr,
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child: Icon(
                    Icons.lock,
                    size: 20.r,
                  ),
                ),
                textEditingController: password,
                validator: validationNull,
              ),
              SizedBox(
                height: 16.h,
              ),
              // GestureDetector(
              //   onTap: () => Get.to(() => ForgetPasswordScreen()),
              //   child: CustomText(
              //     text: 'Forgot password?',
              //     fontWeight: FontWeight.w400,
              //     fontSize: 16.sp,
              //     color: AppColors.primaryColor,
              //   ),
              // ),
              SizedBox(
                height: 50.h,
              ),
              Center(
                child: Container(
                  width: 300,
                  child: CustomButton(
                    text: 'Sign In'.tr,
                    onPress: () => saveForm(),
                    colortext: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Row(
                  children: [
                    Expanded(
                        child: Divider(
                      color: AppColors.grayText,
                      thickness: 1,
                    )),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CustomText(
                        text: 'or',
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        color: AppColors.grayText,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: AppColors.grayText,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: 'Don’t have an account?'.tr,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.grayText,
                  ),
                  GestureDetector(
                    onTap: () => Get.to(() => SignUpScreen()),
                    child: CustomText(
                      text: " " + 'Join Now'.tr,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
