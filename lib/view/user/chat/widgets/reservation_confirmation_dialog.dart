import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<dynamic> reservationConfirmationDialog() {
  return Get.defaultDialog(
    title: 'تم  تأكيد الحجز بنجاح',
    radius: 10.r,
    // titlePadding: EdgeInsetsDirectional.only(top: 15.h, bottom: 4.h),
    titleStyle: TextStyle(
        fontSize: 15.sp,
        color: AppColors.fontPrimaryColor,
        fontWeight: FontWeight.bold),
    content: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          Assets.getIconSvg('request_success'),
          fit: BoxFit.contain,
          width: 150.r,
          height: 150.r,
        ),
      ],
    ),
  );
}