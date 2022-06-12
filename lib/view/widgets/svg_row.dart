import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

class SvgRow extends StatelessWidget {
  final String svgIcon;
  final String text;
  final double svgWidth;
  final double svgHeight;
  final double fontSize;
  final double width;
  final Color svgColor, fontColor;
  final FontWeight fontWeight;

  const SvgRow(
    this.svgIcon,
    this.text, {
    this.svgWidth = 16,
    this.svgHeight = 16,
    this.fontSize = 12,
    this.width = 4,
    this.fontColor,
    this.svgColor,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(2.r),
          child: SvgPicture.asset(
            Assets.getIconSvg(svgIcon),
            alignment: AlignmentDirectional.center,
            color: svgColor,
            height: svgHeight.r,
            width: svgWidth.r,
            fit: BoxFit.contain,
          ),
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
