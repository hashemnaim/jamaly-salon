import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/controller/vendor/main_vendor_controller.dart';
import 'package:yacht_booking/view/user/auth/login_screen.dart';
import 'package:yacht_booking/view/user/bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'package:yacht_booking/view/widgets/custom_button.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

class WelcomeScreen extends StatelessWidget {
  final MainVendorController _mainVendorController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
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
                  padding: EdgeInsetsDirectional.only(start: 15.w, top: 90.h),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Assets.getImage('khalefa')),
                      fit: BoxFit.cover,
                      colorFilter:
                          ColorFilter.mode(Colors.black26, BlendMode.darken),
                    ),
                  ),
                  child: CustomText(
                    'أهلاً بك.',
                    alignment: AlignmentDirectional.topStart,
                    fontColor: Colors.white,
                    fontSize: 40,
                  ),
                ),
                // Padding(
                //   padding: EdgeInsetsDirectional.only(
                //     start: 15.w,
                //     end: 15.w,
                //     top: 340.h,
                //   ),
                //   child: CustomButton(
                //     text: 'الدخول كــ /  زائر',
                //     onTap: () {
                //       Get.offAll(() => BottomNavBarScreen());
                //     },
                //   ),
                // ),
              ],
            ),
            PositionedDirectional(
              top: 250.h,
              start: 15.w,
              end: 15.w,
              child: Stack(
                alignment: AlignmentDirectional.center,
                clipBehavior: Clip.none,
                children: [
                  Container(
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
                        SizedBox(height: 40.h),
                        CustomText(
                          'اختر نوع الحساب',
                          fontSize: 20,
                        ),
                        SizedBox(height: 40.h),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  _mainVendorController.changeType(false);
                                  Get.to(() => LoginScreen());
                                },
                                borderRadius: BorderRadius.circular(5.r),
                                child: Container(
                                  width: 120.r,
                                  height: 120.r,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.r),
                                    color: const Color(0xfffafafa),
                                    boxShadow: AppColors.boxShadow,
                                    border: Border.all(
                                        color: Colors.white, width: 3.w),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        Assets.getIconSvg('user'),
                                        fit: BoxFit.cover,
                                        height: 30.r,
                                        width: 30.r,
                                      ),
                                      CustomText(
                                        'شخصي',
                                        fontColor: AppColors.primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  _mainVendorController.changeType(true);
                                  Get.to(() => LoginScreen());
                                },
                                child: Container(
                                  width: 120.r,
                                  height: 120.r,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.r),
                                    color: const Color(0xfffafafa),
                                    boxShadow: AppColors.boxShadow,
                                    border: Border.all(
                                        color: Colors.white, width: 3.w),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        Assets.getIconSvg('logo'),
                                        fit: BoxFit.cover,
                                        height: 30.r,
                                        width: 30.r,
                                      ),
                                      CustomText(
                                        'مزود خدمه',
                                        fontColor: AppColors.primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            PositionedDirectional(
              bottom: 0,
              start: 0,
              end: 0,
              child: SvgPicture.asset(
                Assets.getIconSvg('lines'),
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
