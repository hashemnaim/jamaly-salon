import 'package:fancy_bottom_bar/fancy_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/controller/user/bottom_nav_bar_controller.dart';
import 'package:yacht_booking/view/user/favorite/favorite_screen.dart';
import 'package:yacht_booking/view/user/home/home_screen.dart';
import 'package:yacht_booking/view/user/map/map_screen.dart';
import 'package:yacht_booking/view/user/my_profile/my_profile_screen.dart';

import 'package:yacht_booking/view/widgets/custom_text.dart';

class BottomNavBarScreen extends StatelessWidget {
  final List<Widget> _buildScreens = [
    HomeScreen(),
    MapScreen(),
    FavoriteScreen(),
    MyProfileScreen(),
  ];
  final List _itemsTitle = [
    'الرئيسية',
    'بالقرب منك',
    'المفضلة',
    'حسابي',
  ];
  final List _itemsSvgIcon = [
    'assets/main_icons/home.svg',
    'assets/main_icons/location.svg',
    'assets/main_icons/heart.svg',
    'assets/main_icons/user.svg',
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomNavBarController>(
      builder: (controller) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: _buildScreens[controller.selectedIndex],
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
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(30.r),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(30.r),
              ),
              child: Container(
                height: 65,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      4,
                      (index) => InkWell(
                        onTap: () {
                          controller.changeSelectedIndex(index);
                        },
                        child: Container(
                          width: 65,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                _itemsSvgIcon[index],
                                alignment: AlignmentDirectional.center,
                                fit: BoxFit.contain,
                                height: 22.r,
                                width: 22.r,
                                color: controller.selectedIndex == index
                                    ? AppColors.primaryColor
                                    : Colors.black,
                              ),
                              SizedBox(height: 3.h),
                              CustomText(
                                _itemsTitle[index],
                                height: 1.4,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                fontColor: controller.selectedIndex == index
                                    ? AppColors.primaryColor
                                    : Colors.black,
                              ),
                              SizedBox(height: 5.h),
                              controller.selectedIndex == index
                                  ? Container(
                                      width: 6.r,
                                      height: 6.r,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(3.0),
                                        color: AppColors.primaryColor,
                                      ),
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    ),
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
