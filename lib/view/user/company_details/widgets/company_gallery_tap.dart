import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/apis/home_apis.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/user/home_user_controller.dart';
import 'package:yacht_booking/view/user/reservation_confirmation/reservation_confirmation_screen.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

class CompanyGalleryTap extends StatelessWidget {
  HomeUserController homeUserController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return homeUserController.getOwnerDetalsData.value.data.gallary == null
          ? Helper.loading()
          : homeUserController.getOwnerDetalsData.value.data.gallary.isEmpty
              ? Center(
                  child: CustomText("لا يوجد صور "),
                )
              : GridView.count(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.h,
                  crossAxisSpacing: 10.w,
                  childAspectRatio: 158.w / 100.h,
                  physics: BouncingScrollPhysics(),
                  children: List.generate(
                    homeUserController
                        .getOwnerDetalsData.value.data.gallary.length,
                    (index) => InkWell(
                      onTap: () {
                        log(homeUserController.getOwnerDetalsData.value.data
                            .gallary[index].ship_id
                            .toString());
                        HomeUserApis.homeUserApis.getShipDetails(
                            homeUserController.getOwnerDetalsData.value.data
                                .gallary[index].ship_id
                                .toString());
                        Get.to(() => ReservationConfirmationScreen(false));
                      },
                      borderRadius: BorderRadius.circular(10.r),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadiusDirectional.circular(10.r),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  homeUserController.getOwnerDetalsData.value
                                      .data.gallary[index].image),
                              fit: BoxFit.cover,
                            )),
                        child: Align(
                          alignment: AlignmentDirectional.bottomEnd,
                          child: Container(
                            width: 72.w,
                            height: 23.h,
                            alignment: AlignmentDirectional.center,
                            decoration: BoxDecoration(
                              color: Color(0xffFFCC00),
                              borderRadius: BorderRadiusDirectional.only(
                                bottomEnd: Radius.circular(10.r),
                                topStart: Radius.circular(10.r),
                              ),
                            ),
                            child: CustomText(
                              'احجز الآن',
                              fontColor: Colors.white,
                              textAlign: TextAlign.center,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
    });
  }
}
