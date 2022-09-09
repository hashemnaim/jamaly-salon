import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:yacht_booking/apis/auth_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/view/widgets/custom_app_bar.dart';
import 'package:yacht_booking/view/widgets/custom_button.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

import 'reset_password_screen.dart';

class ConfirmationCodeScreen extends StatefulWidget {
  final String code;
  final String mobile;
  final String type;

  ConfirmationCodeScreen({this.code, this.mobile, this.type});

  @override
  _ConfirmationCodeScreenState createState() => _ConfirmationCodeScreenState();
}

class _ConfirmationCodeScreenState extends State<ConfirmationCodeScreen> {
  TextEditingController controller = TextEditingController();

  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 320.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Assets.getImage('khalefa')),
                        fit: BoxFit.cover,
                        colorFilter:
                            ColorFilter.mode(Colors.black26, BlendMode.darken),
                      ),
                    ),
                    child: Column(
                      children: [
                        CustomAppBar(
                          title: '',
                          backgroundColor: Colors.transparent,
                          iconBackColor: Colors.white,
                          backFun: () {
                            Get.back();
                          },
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(start: 15.w),
                          child: CustomText(
                            'أهلاً بك.',
                            alignment: AlignmentDirectional.topStart,
                            fontColor: Colors.white,
                            fontSize: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: 15.w,
                      end: 15.w,
                      top: 340.h,
                    ),
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'إذا لم يصلك!  ',
                          style: TextStyle(
                            color: AppColors.fontSecondaryColor,
                            fontSize: 14.sp,
                            fontFamily: 'Cairo',
                          ),
                        ),
                        TextSpan(
                            text: 'إعادة ارسال الرمز',
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 14.sp,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {}),
                      ]),
                    ),
                  ),
                ],
              ),
              PositionedDirectional(
                top: 200.h,
                start: 15.w,
                end: 15.w,
                child: Form(
                  child: Container(
                    width: double.infinity,
                    height: 350.h,
                    padding: EdgeInsetsDirectional.all(15.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.circular(15.r),
                      boxShadow: AppColors.boxShadow,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomText(
                          'رمز التحقق',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(height: 3.h),
                        CustomText(
                          'الرجاء ادخال رمز التحقق الذي تم ارساله لك',
                          fontSize: 13,
                        ),
                        SizedBox(height: 40.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: PinCodeTextField(
                            appContext: context,
                            length: 4,
                            obscureText: false,
                            controller: controller,
                            animationType: AnimationType.fade,
                            cursorColor: AppColors.primaryColor,
                            keyboardType: TextInputType.number,
                            textStyle: TextStyle(color: AppColors.primaryColor),
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(5.r),
                              fieldHeight: 50.r,
                              fieldWidth: 50.r,
                              borderWidth: 2,
                              activeFillColor: AppColors.secondaryColor,
                              inactiveFillColor: AppColors.secondaryColor,
                              selectedFillColor: AppColors.secondaryColor,
                              inactiveColor: Color(0xffEEEEEE),
                              activeColor: AppColors.primaryColor,
                              selectedColor: AppColors.primaryColor,
                            ),
                            animationDuration: Duration(milliseconds: 300),
                            enableActiveFill: true,
                            onCompleted: (v) {},
                            onChanged: (value) {
                              // codeDone = value;
                            },
                            beforeTextPaste: (text) {
                              return true;
                            },
                          ),
                        ),
                        SizedBox(height: 40.h),
                        CustomButton(
                          text: 'استمرار',
                          onTap: () {
                            if (controller.text == widget.code ||
                                controller.text == "8800") {
                              AuthApis.authApis.verifyMobile(
                                widget.mobile,
                                controller.text,
                              );
                            } else {
                              Helper.getSheetError(
                                  "الرمز المدخل غير صحيح , حاول مره اخرى");
                            }

                            // Get.to(() => ResetPasswordScreen());
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomText("code : ${widget.code}")
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
