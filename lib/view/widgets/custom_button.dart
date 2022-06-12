import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onTap;
  final double height;
  final double width;
  final Widget icon;
  final Color background, fontColor;
  final bool isBorder;
  final double fontSize;
  final Color borderColor;

  CustomButton({
    @required this.text,
    @required this.onTap,
    this.height = 50,
    this.width = double.infinity,
    this.icon,
    this.background = AppColors.primaryColor,
    this.fontColor = Colors.white,
    this.isBorder = false,
    this.fontSize = 14.0,
    this.borderColor = AppColors.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => print('kkk'),
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        width: width.w,
        height: height.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: background,
          border: isBorder
              ? Border.all(color: borderColor, width: 1.w)
              : null,
        ),
        child: icon != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  icon,
                  SizedBox(width: 8.w),
                  CustomText(
                    text,
                    fontSize: fontSize,
                    fontColor: fontColor,
                    fontWeight: FontWeight.w700,
                    height: 1.8,
                  ),
                ],
              )
            : Center(
                child: CustomText(
                  text,
                  fontSize: fontSize,
                  fontColor: fontColor,
                  fontWeight: FontWeight.w600,
                  height: 1.06,
                ),
              ),
      ),
    );
  }
}
