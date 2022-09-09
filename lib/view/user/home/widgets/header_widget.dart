import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/apis/home_apis.dart';
import 'package:yacht_booking/apis/home_vendor_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/user/bottom_nav_bar_controller.dart';
import 'package:yacht_booking/controller/user/home_user_controller.dart';
import 'package:yacht_booking/services/firebase_chat_provider.dart';
import 'package:yacht_booking/view/user/filter/filter_screen.dart';
import 'package:yacht_booking/view/user/notification/notification_secreen.dart';
import 'package:yacht_booking/view/vendor/chat_screen_provider.dart';
import 'package:yacht_booking/view/widgets/cash_network_image_share.dart';
import 'package:yacht_booking/view/widgets/custom_avatar.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

class HeaderWidget extends StatelessWidget {
  final BottomNavBarController _bottomNavBarController = Get.find();
  HomeUserController homeUserController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        width: double.infinity,
        height: 220.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Assets.getImage('ship_3'),
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black26,
              BlendMode.darken,
            ),
          ),
        ),
        child: homeUserController.getProfileUserData.value.data == null
            ? Center(
                child: Container(),
              )
            : SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                              onTap: () {
                                _bottomNavBarController.changeSelectedIndex(3);
                              },
                              child: homeUserController.getProfileUserData.value
                                          .data.photo ==
                                      null
                                  ? CustomAvatar(28, 27, 'person')
                                  : Container(
                                      width: 62.r,
                                      height: 62.r,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Color(0xffFFE451),
                                          )),
                                      child: CachedNetworkImageShare(
                                          homeUserController.getProfileUserData
                                              .value.data.photo,
                                          62.r,
                                          62.r,
                                          0),
                                    )),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      '${homeUserController.getProfileUserData.value.data.name ?? ''}',
                                      fontColor: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            FireBaseHelperProvider
                                                .fireBaseHelperProvider
                                                .getAllMyChats(
                                              myId: homeUserController
                                                  .getProfileUserData
                                                  .value
                                                  .data
                                                  .id
                                                  .toString(),
                                            );
                                            Get.to(() => ChatScreenProvider());
                                          },
                                          child: Container(
                                            padding:
                                                EdgeInsetsDirectional.all(8.r),
                                            child: Stack(
                                              children: [
                                                SvgPicture.asset(
                                                  Assets.getIconSvg('messages'),
                                                  height: 20.r,
                                                  width: 20.r,
                                                ),
                                                // Container(
                                                //   height: 7.r,
                                                //   width: 7.r,
                                                //   decoration: BoxDecoration(
                                                //     borderRadius:
                                                //         BorderRadius.all(
                                                //             Radius.elliptical(
                                                //                 9999.0, 9999.0)),
                                                //     color:
                                                //         const Color(0xffff6464),
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 5.w),
                                        InkWell(
                                          onTap: () {
                                            HomeVendorApis.homeVendorApis
                                                .getNotifications();
                                            Get.to(() => NotificationScreen());
                                          },
                                          child: Container(
                                            padding:
                                                EdgeInsetsDirectional.all(8.r),
                                            child: Stack(
                                              children: [
                                                SvgPicture.asset(
                                                  Assets.getIconSvg(
                                                      'notifications'),
                                                  height: 20.r,
                                                  width: 20.r,
                                                ),
                                                // Container(
                                                //   height: 7.r,
                                                //   width: 7.r,
                                                //   decoration: BoxDecoration(
                                                //     borderRadius:
                                                //         BorderRadius.all(
                                                //             Radius.elliptical(
                                                //                 9999.0, 9999.0)),
                                                //     color:
                                                //         const Color(0xffff6464),
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      Assets.getIconSvg('call'),
                                      height: 15.r,
                                      width: 15.r,
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                    ),
                                    SizedBox(width: 5.w),
                                    CustomText(
                                      '${homeUserController.getProfileUserData.value.data.mobile ?? ''}',
                                      fontColor: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      textAlign: TextAlign.start,
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        HomeUserApis.homeUserApis.getServices();
                        Get.to(() => FilterScreen());
                      },
                      borderRadius: BorderRadius.circular(10.r),
                      child: Container(
                        width: double.infinity,
                        height: 45.h,
                        alignment: AlignmentDirectional.centerStart,
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 5.h),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: AppColors.secondaryColor,
                            border: Border.all(
                                color: Colors.grey[600], width: 1.5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search,
                                  color: AppColors.hintColor,
                                  size: 22.r,
                                ),
                                SizedBox(width: 15.w),
                                CustomText(
                                  'بحث',
                                  fontColor: AppColors.hintColor,
                                  height: 1,
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.all(5.r),
                              child: SvgPicture.asset(
                                Assets.getIconSvg('filter'),
                                width: 15.r,
                                height: 15.r,
                                fit: BoxFit.contain,
                                color: AppColors.hintColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      );
    });
  }
}
