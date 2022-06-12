import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

class IconRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final double iconSize;
  final double fontSize;
  final double width;
  final Color iconColor, fontColor;
  final FontWeight fontWeight;

  const IconRow(
    this.icon,
    this.text, {
    this.iconSize = 17,
    this.fontSize = 12,
    this.width = 4,
    this.fontColor,
    this.iconColor,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: iconSize.r,
          color: iconColor,
        ),
        SizedBox(width: width.w),
        CustomText(
          text,
          fontSize: fontSize,
          alignment: AlignmentDirectional.centerStart,
          fontColor: fontColor,
          fontWeight: fontWeight,
        ),
      ],
    );
  }
}
