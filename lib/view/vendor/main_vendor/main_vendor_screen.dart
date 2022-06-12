import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/controller/vendor/main_vendor_controller.dart';
import 'package:yacht_booking/view/vendor/home/home_vendor_screen.dart';
import 'package:yacht_booking/view/vendor/offers_vendor/offers_vendor_screen.dart';
import 'package:yacht_booking/view/vendor/profile/vendor_profile_screen.dart';
import 'package:yacht_booking/view/vendor/services/services_screen.dart';
import 'package:yacht_booking/view/vendor/yachts/yachts_screen.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

class MainVendor extends StatelessWidget {
  MainVendorController mainVendorController = Get.find();
  final List pagesList = <Widget>[
    HomeVendorScreen(),
    ServicesScreen(),
    YachtsScreen(),
    OfferVendorScreen(),
    VendorProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainVendorController>(
      builder: (controller) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: pagesList[controller.pageIndex],
        bottomNavigationBar: SafeArea(
          child: Container(
            height: 65,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[300],
                  offset: Offset(0, -10),
                  blurRadius: 8,
                  spreadRadius: 1,
                  blurStyle: BlurStyle.normal,
                ),
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
              child: Container(
                height: 65,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          mainVendorController.setIsFirstScreen(true);
                          controller.changePageIndex(0);
                        },
                        child: Container(
                          width: 55.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/main_icons/bookmark.svg',
                                alignment: AlignmentDirectional.center,
                                fit: BoxFit.contain,
                                height: 22.r,
                                width: 22.r,
                                color: controller.pageIndex == 0
                                    ? AppColors.primaryColor
                                    : Colors.black,
                              ),
                              SizedBox(height: 5.h),
                              CustomText(
                                'الرئيسية',
                                height: 1.4,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                fontColor: controller.pageIndex == 0
                                    ? AppColors.primaryColor
                                    : Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Spacer(flex: 1),
                      InkWell(
                        onTap: () {
                          controller.changePageIndex(1);
                        },
                        child: Container(
                          width: 55.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/main_icons/offers.svg',
                                alignment: AlignmentDirectional.center,
                                fit: BoxFit.contain,
                                height: 22.r,
                                width: 22.r,
                                color: controller.pageIndex == 1
                                    ? AppColors.primaryColor
                                    : Colors.black,
                              ),
                              SizedBox(height: 5.h),
                              CustomText(
                                'الخدمات',
                                height: 1.4,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                fontColor: controller.pageIndex == 1
                                    ? AppColors.primaryColor
                                    : Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Spacer(flex: 1),
                      SizedBox(
                        height: 55.r,
                        width: 55.r,
                        child: FloatingActionButton(
                          elevation: 0.5,
                          backgroundColor: controller.pageIndex == 2
                              ? Color(0xffF2C409)
                              : AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.r),
                          ),
                          onPressed: () {
                            controller.changePageIndex(2);
                          },
                          tooltip: 'إنشاء',
                          child: Icon(
                            Icons.add_circle_outline,
                            size: 30.r,
                          ),
                        ),
                      ),
                      Spacer(flex: 1),
                      InkWell(
                        onTap: () {
                          controller.changePageIndex(3);
                        },
                        child: Container(
                          width: 55.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/main_icons/bookmark.svg',
                                alignment: AlignmentDirectional.center,
                                fit: BoxFit.contain,
                                height: 22.r,
                                width: 22.r,
                                color: controller.pageIndex == 3
                                    ? AppColors.primaryColor
                                    : Colors.black,
                              ),
                              SizedBox(height: 5.h),
                              CustomText(
                                'العروض',
                                height: 1.4,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                fontColor: controller.pageIndex == 3
                                    ? AppColors.primaryColor
                                    : Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Spacer(flex: 1),
                      InkWell(
                        onTap: () {
                          controller.changePageIndex(4);
                        },
                        child: Container(
                          width: 55.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/main_icons/user.svg',
                                alignment: AlignmentDirectional.center,
                                fit: BoxFit.contain,
                                height: 22.r,
                                width: 22.r,
                                color: controller.pageIndex == 4
                                    ? AppColors.primaryColor
                                    : Colors.black,
                              ),
                              SizedBox(height: 5.h),
                              CustomText(
                                'حسابي',
                                height: 1.4,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                fontColor: controller.pageIndex == 4
                                    ? AppColors.primaryColor
                                    : Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
