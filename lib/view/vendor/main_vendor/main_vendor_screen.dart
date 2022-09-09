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
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey[200],
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
              height: 80.h,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 10.h),
                            SvgPicture.asset(
                              'assets/main_icons/bookmark.svg',
                              alignment: AlignmentDirectional.center,
                              fit: BoxFit.contain,
                              height: 20,
                              width: 20,
                              color: controller.pageIndex == 0
                                  ? AppColors.primaryColor
                                  : Colors.black,
                            ),
                            CustomText(
                              'الرئيسية',
                              height: 2,
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 10.h),
                            SvgPicture.asset(
                              'assets/main_icons/offers.svg',
                              alignment: AlignmentDirectional.center,
                              fit: BoxFit.contain,
                              height: 20,
                              width: 20,
                              color: controller.pageIndex == 1
                                  ? AppColors.primaryColor
                                  : Colors.black,
                            ),
                            CustomText(
                              'الخدمات',
                              height: 2,
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
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: SizedBox(
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
                    ),
                    Spacer(flex: 1),
                    InkWell(
                      onTap: () {
                        controller.changePageIndex(3);
                      },
                      child: Container(
                        width: 55.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 10.h),
                            SvgPicture.asset(
                              'assets/main_icons/bookmark.svg',
                              alignment: AlignmentDirectional.center,
                              fit: BoxFit.contain,
                              height: 20,
                              width: 20,
                              color: controller.pageIndex == 3
                                  ? AppColors.primaryColor
                                  : Colors.black,
                            ),
                            CustomText(
                              'العروض',
                              height: 2,
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 10.h),
                            SvgPicture.asset(
                              'assets/main_icons/user.svg',
                              alignment: AlignmentDirectional.center,
                              fit: BoxFit.contain,
                              height: 20,
                              width: 20,
                              color: controller.pageIndex == 4
                                  ? AppColors.primaryColor
                                  : Colors.black,
                            ),
                            CustomText(
                              'حسابي',
                              height: 2,
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
    );
  }
}
