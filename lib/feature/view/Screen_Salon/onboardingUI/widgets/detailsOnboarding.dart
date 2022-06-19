import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salon_provider/feature/view/widgets/custom_text.dart';

// import 'package:localize_and_translate/localize_and_translate.dart';
class DetailsOnboarding extends StatelessWidget {
  final String image, subTitle, title;
  final double maxWidthTitle;

  DetailsOnboarding({
    this.image,
    this.subTitle,
    this.title,
    this.maxWidthTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Stack(
          children: [
            Container(
              height: Get.height,
              child: Image.asset('assets/images/$image.png', fit: BoxFit.cover),
            ),
            Container(
                height: Get.height,
                width: Get.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0),
                      Colors.black.withOpacity(0.21),
                      Colors.black.withOpacity(0.3),
                    ],
                    stops: [
                      0,
                      0.21,
                      1,
                    ],
                  ),
                )),
            Container(
              alignment: Alignment.bottomCenter,
              height: Get.height,
              padding: EdgeInsets.only(bottom: 219.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomText(
                  text:  title,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Container(
                    constraints:
                        BoxConstraints(maxWidth: maxWidthTitle ?? 250.w),
                    child: CustomText(
                     text: subTitle,
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      // fontFamily: 'NunitoSans',
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
