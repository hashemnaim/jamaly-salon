import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/apis/home_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yacht_booking/models/owners_model.dart';
import 'package:yacht_booking/view/user/company_details/company_details_screen.dart';
import 'package:yacht_booking/view/widgets/cash_network_image_share.dart';
import 'package:yacht_booking/view/widgets/custom_avatar.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';
import 'package:yacht_booking/view/widgets/icon_row.dart';

class MapCard extends StatelessWidget {
  final OwnersModelData ownersModelData;

  const MapCard({this.ownersModelData});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        HomeUserApis.homeUserApis
            .getOwnerDetails(ownersModelData.id.toString());
        Get.to(() => CompanyDetailsScreen());
      },
      borderRadius: BorderRadius.circular(15.r),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            width: 150.w,
            padding: EdgeInsetsDirectional.only(top: 10.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadiusDirectional.circular(15.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                    alignment: AlignmentDirectional.center,
                    child: ownersModelData.photo == null
                        ? CustomAvatar(
                            25,
                            25,
                            'person',
                            isBoxShadow: false,
                          )
                        : CachedNetworkImageShare(
                            ownersModelData.photo, 42.r, 42.r, 0)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5.h),
                      IconRow(
                        Icons.person,
                        '${ownersModelData.name ?? ""}',
                        fontSize: 11,
                        iconSize: 15,
                      ),
                      IconRow(
                        Icons.location_on,
                        '${ownersModelData.location ?? ""}',
                        fontSize: 11,
                        iconSize: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(2.r),
                            child: Icon(
                              Icons.phone,
                              size: 17.r,
                              color: Colors.black,
                            ),
                          ),
                          CustomText(
                            '${ownersModelData.mobile}',
                            fontColor: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            textAlign: TextAlign.start,
                            alignment: AlignmentDirectional.centerStart,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(2.r),
                              child: Icon(
                                Icons.email_rounded,
                                size: 17.r,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          CustomText(
                            '${ownersModelData.email}',
                            fontColor: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            textAlign: TextAlign.start,
                            alignment: AlignmentDirectional.centerStart,
                          ),
                        ],
                      ),
                      SizedBox(height: 5.w),
                      RatingBar.builder(
                        initialRating: ownersModelData.rate == null
                            ? 0
                            : double.parse(ownersModelData.rate.toString()),
                        direction: Axis.horizontal,
                        tapOnlyMode: true,
                        ignoreGestures: true,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 16,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 1.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 1,
                        ),
                        onRatingUpdate: (rating) => null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          PositionedDirectional(
            bottom: 0,
            end: 0,
            child: InkWell(
              onTap: () {
                HomeUserApis.homeUserApis
                    .getOwnerDetails(ownersModelData.id.toString());
                Get.to(() => CompanyDetailsScreen());
              },
              child: Container(
                width: 90.w,
                padding: EdgeInsetsDirectional.all(2.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15.r),
                    bottomLeft: Radius.circular(15.r),
                  ),
                  color: AppColors.primaryColor,
                ),
                child: CustomText(
                  'التفاصيل',
                  fontColor: Colors.white,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
