import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';

class CustomAvatar extends StatelessWidget {
  final double circleAvatarOneRadius;
  final double circleAvatarTwoRadius;
  final String assetImage;
  final Color backgroundColor;
  final bool isBoxShadow;

  const CustomAvatar(
    this.circleAvatarOneRadius,
    this.circleAvatarTwoRadius,
    this.assetImage, {
    this.backgroundColor = AppColors.yellow,
    this.isBoxShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.r),
        boxShadow: isBoxShadow ? AppColors.boxShadow : null,
      ),
      child: CircleAvatar(
        radius: circleAvatarOneRadius.r,
        backgroundColor: backgroundColor,
        child: CircleAvatar(
          radius: circleAvatarTwoRadius.r,
          backgroundColor: Colors.white,
          backgroundImage: AssetImage(Assets.getImage(assetImage)),
        ),
      ),
    );
  }
}
