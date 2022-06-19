import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salon_provider/feature/values/colors.dart';
import 'package:salon_provider/feature/view/widgets/custom_text.dart';

import 'customCircle.dart';

class CustomAppBar extends StatelessWidget {
  final String title;

  CustomAppBar({
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
      leading: Container(),
      title: CustomText(
        text: title ?? 'المفضلة',
        fontSize: 18.sp,
        color: AppColors.primary,
      ),
      actions: [
        CustomCircle(
          radius: 46 / 2,
          color: Colors.white,
          child: IconButton(
            onPressed: () => Get.back(),
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
        SizedBox(
          width: 24.w,
        ),
      ],
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }
}
