import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/apis/home_vendor_apis.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/user/home_user_controller.dart';
import 'package:yacht_booking/controller/vendor/main_vendor_controller.dart';
import 'package:yacht_booking/services/firebase_chat_provider.dart';
import 'package:yacht_booking/view/user/notification/notification_secreen.dart';
import 'package:yacht_booking/view/vendor/chat_screen_provider.dart';
import 'package:yacht_booking/view/widgets/cash_network_image_share.dart';
import 'package:yacht_booking/view/widgets/custom_avatar.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

class HeaderVendor extends StatelessWidget {
  final MainVendorController _mainVendorController = Get.find();
  HomeUserController homeUserController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        width: double.infinity,
        height: 155.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Assets.getImage('bg'),
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
          ),
        ),
        child: homeUserController.getProfileUserData.value.data == null
            ? Center(
                child: Helper.loading(),
              )
            : SafeArea(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                        onTap: () {
                          _mainVendorController.changePageIndex(3);
                        },
                        child: homeUserController
                                    .getProfileUserData.value.data.photo ==
                                null
                            ? CustomAvatar(30, 29, 'person')
                            : Container(
                                height: 62.r,
                                width: 62.r,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.orange)),
                                child: CachedNetworkImageShare(
                                    homeUserController
                                        .getProfileUserData.value.data.photo,
                                    62.r,
                                    62.r,
                                    0),
                              )),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              CustomText(
                                '${homeUserController.getProfileUserData.value.data.name ?? ""}',
                                fontColor: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                alignment: AlignmentDirectional.topStart,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomText(
                                '${homeUserController.getProfileUserData.value.data.location ?? ""}',
                                fontColor: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                alignment: AlignmentDirectional.topStart,
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  FireBaseHelperProvider.fireBaseHelperProvider
                                      .getAllMyChats(
                                    myId: homeUserController
                                        .getProfileUserData.value.data.id
                                        .toString(),
                                  );
                                  Get.to(ChatScreenProvider());
                                },
                                child: Container(
                                  padding: EdgeInsetsDirectional.all(8.r),
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
                                      //     borderRadius: BorderRadius.all(
                                      //         Radius.elliptical(
                                      //             9999.r, 9999.r)),
                                      //     color: const Color(0xffff6464),
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
                                  Get.to(NotificationScreen());
                                },
                                child: Container(
                                  padding: EdgeInsetsDirectional.all(8.r),
                                  child: Stack(
                                    children: [
                                      SvgPicture.asset(
                                        Assets.getIconSvg('notifications'),
                                        height: 20.r,
                                        width: 20.r,
                                      ),
                                      // Container(
                                      //   height: 7.r,
                                      //   width: 7.r,
                                      //   decoration: BoxDecoration(
                                      //     borderRadius: BorderRadius.all(
                                      //         Radius.elliptical(
                                      //             9999.r, 9999.r)),
                                      //     color: const Color(0xffff6464),
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
                    ),
                  ],
                ),
              ),
      );
    });
  }
}
