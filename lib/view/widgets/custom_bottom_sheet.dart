import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

customBottomSheet({
  Widget widget,
}) {
  Get.bottomSheet(
    SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsetsDirectional.only(
        start: 20.w,
        end: 20.w,
        bottom: 30.h,
        top: 8.h,
      ),
      child: Padding(
        padding: Get.context.mediaQueryViewInsets,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50.w,
              height: 2.5.h,
              decoration: BoxDecoration(
                color: Color(0xffA1A1A1),
                borderRadius: BorderRadius.circular(15.r),
              ),
            ),
            SizedBox(height: 20.h),
            Container(child: widget),
          ],
        ),
      ),
    ),
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft:  Radius.circular(25.r),
        topRight:  Radius.circular(25.r),
      ),
    ),
  );
}
