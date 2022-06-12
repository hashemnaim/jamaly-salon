import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/view/user/change_password_success/change_password_success_screen.dart';
import 'package:yacht_booking/view/widgets/custom_app_bar.dart';
import 'package:yacht_booking/view/widgets/custom_button.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';
import 'package:yacht_booking/view/widgets/custom_text_form_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SingleChildScrollView(
              child: Container(
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
                        'تغيير كلمة المرور',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 3.h),
                      CustomText(
                        'الرجاء ادخال كلمة المرور الجديدة الخاصة بك',
                        fontSize: 13,
                      ),
                      SizedBox(height: 40.h),
                      CustomTextFormField(
                        hintText: 'كلمة المرور',
                        prefixIcon: Icon(Icons.lock, size: 22.r,color: AppColors.hintColor,),
                        isBoxShadow: false,
                        fillColor: Colors.white,
                        obscureText: true,
                      ),
                      SizedBox(height: 15.h),
                      CustomTextFormField(
                        hintText: 'تأكيد كلمة المرور',
                        prefixIcon: Icon(Icons.lock, size: 22.r,color: AppColors.hintColor,),
                        isBoxShadow: false,
                        fillColor: Colors.white,
                        obscureText: true,
                      ),
                      SizedBox(height: 25.h),
                      CustomButton(
                        text: 'استمرار',
                        onTap: () {
                          Get.offAll(() => ChangePasswordSuccessScreen());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
