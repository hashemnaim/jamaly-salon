import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/vendor/home_vendor_controller.dart';
import 'package:yacht_booking/models/review_vendor_model.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

class RattingTap extends StatelessWidget {
  HomeVendorController homeVendorController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: homeVendorController.getReviewData.value.data == null
            ? Container(
                height: 300.h,
                child: Center(
                  child: Helper.loading(),
                ),
              )
            : homeVendorController.getReviewData.value.data.isEmpty
                ? Container(
                    height: 300.h,
                    child: Center(
                      child: CustomText("لا يوجد تقييمات"),
                    ),
                  )
                : ListView.separated(
                    itemCount:
                        homeVendorController.getReviewData.value.data.length,
                    shrinkWrap: true,
                    primary: false,
                    padding: EdgeInsetsDirectional.zero,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 10.h),
                    itemBuilder: (context, index) {
                      ReviewVendorData reviewVendorData =
                          homeVendorController.getReviewData.value.data[index];
                      return Container(
                        width: double.infinity,
                        height: 65.h,
                        decoration: BoxDecoration(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 60.r,
                              height: 60.r,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                image: DecorationImage(
                                  image: reviewVendorData.user.photo == null
                                      ? AssetImage(Assets.getImage('person'))
                                      : CachedNetworkImageProvider(
                                          reviewVendorData.user.photo),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              flex: 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: CustomText(
                                          '${reviewVendorData.name ?? ""}',
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                        ),
                                      ),
                                      SmoothStarRating(
                                        allowHalfRating: false,
                                        onRated: (v) {},
                                        starCount: 5,
                                        rating: reviewVendorData.rate == null
                                            ? 0
                                            : double.parse(reviewVendorData.rate
                                                .toString()),
                                        size: 16.r,
                                        isReadOnly: true,
                                        color: AppColors.yellow,
                                        borderColor: AppColors.yellow,
                                        spacing: 0.0,
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: CustomText(
                                      '${reviewVendorData.review ?? ""}',
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      height: 1,
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
      );
    });
  }
}
