import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:salon_provider/feature/values/colors.dart';
import 'package:salon_provider/feature/view/widgets/custom_text.dart';

class TopAuth extends StatelessWidget {
  final String title, subTitle;

  TopAuth({this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10.h,
        ),
        CustomText(
          text: subTitle ??
              'Glad to meet you again!, please login to use the app.',
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.gray50,
        ),
      ],
    );
  }
}
