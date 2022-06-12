import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/user/home_user_controller.dart';
import 'package:yacht_booking/models/order_details_model.dart';
import 'package:yacht_booking/view/widgets/cash_network_image_share.dart';
import 'package:yacht_booking/view/widgets/custom_avatar.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';
import 'package:yacht_booking/view/widgets/icon_row.dart';

class CompanyRattingTap extends StatelessWidget {
  HomeUserController homeUserController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return homeUserController.getOwnerDetalsData.value.data.reviews==null?
      Center(
        child: Helper.loading(),
      ):
      homeUserController.getOwnerDetalsData.value.data.reviews.isEmpty?
      Center(
        child: CustomText("لا يوجد تقييمات"),
      ):
      SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Container(
            //   width: double.infinity,
            //   padding: EdgeInsetsDirectional.all(15.r),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10.r),
            //     color: const Color(0xfffafafa),
            //     boxShadow: AppColors.boxShadow,
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           IconRow(
            //             Icons.star,
            //             '${homeUserController.getOwnerDetalsData.value.data.rate??"0"}',
            //             fontSize: 30,
            //             iconSize: 38,
            //             iconColor: AppColors.yellow,
            //             fontWeight: FontWeight.bold,
            //           ),
            //           // CustomText(
            //           //   'نتائج 1200 تقييم',
            //           //   fontWeight: FontWeight.bold,
            //           // ),
            //         ],
            //       ),
            //       Column(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         crossAxisAlignment: CrossAxisAlignment.end,
            //         children: List.generate(
            //           5,
            //           (index) => SizedBox(
            //             height: 20.h,
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               crossAxisAlignment: CrossAxisAlignment.center,
            //               children: [
            //                 CustomText(
            //                   '500',
            //                   fontSize: 12,
            //                   height: 1.6,
            //                 ),
            //                 SizedBox(width: 5.w),
            //                 SmoothStarRating(
            //                   allowHalfRating: false,
            //                   onRated: (v) {},
            //                   starCount: 5,
            //                   rating: 5.0,
            //                   size: 14.r,
            //                   isReadOnly: true,
            //                   color: AppColors.yellow,
            //                   borderColor: AppColors.yellow,
            //                   spacing: 0.0,
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(height: 25.h),

            ListView.separated(
              itemCount: homeUserController.getOwnerDetalsData.value.data.reviews.length,
              shrinkWrap: true,
              primary: false,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsetsDirectional.zero,
              separatorBuilder: (context, index) => SizedBox(height: 15.h),
              itemBuilder: (context, index) {
                Reviews reviews =  homeUserController.getOwnerDetalsData.value.data.reviews[index];
                return Container(
                width: double.infinity,
                padding: EdgeInsetsDirectional.all(15.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: const Color(0xfffafafa),
                  boxShadow: AppColors.boxShadow,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 34.r,
                      width: 34.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xffFFE451)
                        )
                      ),
                      child: homeUserController.getProfileUserData.value.data.photo==null
                      ?CustomAvatar(50, 49, 'person'):
                      CachedNetworkImageShare(
                        homeUserController.getProfileUserData.value.data.photo,
                         34.r, 34.r, 0),
                    ),
                    // CustomAvatar(25, 24, 'person'),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomText(
                                '${reviews.name??""}',
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                              SmoothStarRating(
                                allowHalfRating: false,
                                onRated: (v) {},
                                starCount: 5,
                                rating:reviews.rate==null?0: double.parse(reviews.rate.toString()),
                                size: 14.r,
                                isReadOnly: true,
                                color: AppColors.yellow,
                                borderColor: AppColors.yellow,
                                spacing: 0.0,
                              ),
                            ],
                          ),
                          CustomText(
                            '${reviews.createdAt.toString().split('T').first??""}',
                            fontSize: 12,
                            fontColor: AppColors.fontSecondaryColor,
                            alignment: AlignmentDirectional.centerStart,
                          ),
                          CustomText(
                            '${reviews.review??""}',
                            fontSize: 12,
                            alignment: AlignmentDirectional.centerStart,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
              },
            ),
          ],
        ),
      ),
    );
    })
    ;
  }
}
