import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/common/app_colors.dart';

class CustomText extends StatelessWidget {
  @required
  final String text;
  final AlignmentDirectional alignment;
  final Color fontColor;
  final double fontSize;
  final FontWeight fontWeight;
  final int maxLines;
  final double height;
  final TextAlign textAlign;
  final bool isShadow;
  final List<Shadow> shadows;
  final bool isUnderline;

  const CustomText(
    this.text, {
    this.alignment = AlignmentDirectional.center,
    this.fontColor = AppColors.fontPrimaryColor,
    this.fontSize = 14.0,
    this.fontWeight = FontWeight.normal,
    this.maxLines,
    this.height,
    this.textAlign = TextAlign.start,
    this.isShadow = false,
    this.shadows,
    this.isUnderline = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(
        text.tr,
        textAlign: textAlign,
        style: TextStyle(
          color: fontColor,
          fontSize: fontSize.sp,
          fontWeight: fontWeight,
          fontFamily: 'FlatRegular',
          height: height,
          shadows: isShadow ? shadows : null,
          decoration: isUnderline ? TextDecoration.underline : null,
        ),
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

// class CustomText extends StatelessWidget {
//   final String text;
//   final double fontSize;
//   final double height;
//   final double letterSpacing;
//   final TextAlign textAlign;
//   final Color color;
//   final bool underline;
//   final FontWeight fontWeight;
//   final int maxLines;
//   final List<Shadow> shadows;
//
//   CustomText(
//     this.text, {
//     this.fontSize = 20,
//     this.textAlign,
//     this.color,
//     this.fontWeight,
//     this.underline = false,
//     this.maxLines,
//     this.shadows,
//     this.height,
//     this.letterSpacing,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text.tr ?? '-',
//       textAlign: textAlign ?? TextAlign.start,
//       maxLines: maxLines,
//       overflow: maxLines != null ? TextOverflow.ellipsis : null,
//       style: GoogleFonts.cairo(
//         fontWeight: fontWeight ?? FontWeight.w500,
//         fontSize: fontSize.sp,
//         color: color ?? AppColors.fontPrimaryColor,
//         decoration: underline ? TextDecoration.underline : TextDecoration.none,
//         letterSpacing: letterSpacing,
//         shadows: shadows,
//         height: height,
//       ),
//     );
//   }
// }
