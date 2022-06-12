import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/apis/home_vendor_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/models/recieved_order.dart';
import 'package:yacht_booking/view/vendor/request_details/request_details_screen2.dart';
import 'package:yacht_booking/view/widgets/cash_network_image_share.dart';
import 'package:yacht_booking/view/widgets/custom_avatar.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';
import 'package:yacht_booking/view/widgets/svg_row.dart';

class CardRequestOrder extends StatelessWidget {
  final RecevedOrderData recevedOrderData;

  const CardRequestOrder({this.recevedOrderData});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        HomeVendorApis.homeVendorApis
            .getRequestDetails(recevedOrderData.id.toString());
        Get.to(RequestDetailsScreen2());
      },
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        decoration: BoxDecoration(
            color: AppColors.bg,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: AppColors.borderColor,
            )),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                recevedOrderData.user.photo == null
                    ? CustomAvatar(
                        25,
                        23,
                        'person',
                        isBoxShadow: false,
                      )
                    : Container(
                        height: 62.r,
                        width: 62.r,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.orange),
                            shape: BoxShape.circle),
                        child: CachedNetworkImageShare(
                            recevedOrderData.user.photo, 62.r, 62.r, 0),
                      ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                        '${recevedOrderData.user.name ?? ""}',
                        alignment: AlignmentDirectional.centerStart,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgRow(
                            'call',
                            '${recevedOrderData.mobile ?? ""}',
                            svgColor: AppColors.fontPrimaryColor,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.r),
                            decoration: BoxDecoration(
                              color: Color(0xff00A9CA),
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: CustomText(
                              'التفاصيل',
                              fontColor: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 25.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  'تاريخ الحجز:',
                  alignment: AlignmentDirectional.centerStart,
                  fontWeight: FontWeight.bold,
                  fontColor: AppColors.primaryColor,
                ),
                CustomText(
                  '${recevedOrderData.date ?? ""}',
                  alignment: AlignmentDirectional.centerStart,
                  fontWeight: FontWeight.bold,
                  fontColor: AppColors.hintColor,
                  fontSize: 12,
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Visibility(
              visible: recevedOrderData.status != null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    'حالة الحجز:',
                    alignment: AlignmentDirectional.centerStart,
                    fontWeight: FontWeight.bold,
                    fontColor: AppColors.primaryColor,
                  ),
                  CustomText(
                    '${recevedOrderData.status == '0' ? "جديد" : recevedOrderData.status == '1' ? 'مؤكد' : recevedOrderData.status == '2' ? 'منتهي' : ''}',
                    alignment: AlignmentDirectional.centerStart,
                    fontWeight: FontWeight.bold,
                    fontColor: AppColors.hintColor,
                    fontSize: 12,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: SvgRow(
                    'time',
                    'المدة الزمنية للحجز',
                    svgColor: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.borderColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: CustomText(
                      'ساعة - 30 دقيقة',
                      fontColor: AppColors.fontSecondaryColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              children: [
                Expanded(
                  child: SvgRow(
                    'time',
                    'توقيت الحجز',
                    svgColor: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.borderColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: CustomText(
                      '${recevedOrderData.from ?? ""} - ${recevedOrderData.to ?? ""}',
                      fontColor: AppColors.fontSecondaryColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SvgRow(
                    'circle_user',
                    'عدد الأشخاص',
                    svgColor: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.borderColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: CustomText(
                      '${recevedOrderData.numberOfPersones ?? ""}',
                      fontColor: AppColors.fontSecondaryColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
