import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class CustomText extends StatelessWidget {
  final String text;

  final double fontSize;

  final Color color;

  final FontWeight fontWeight;
  CustomText(
      {this.text = '',
      this.fontSize = 16,
      this.color = Colors.black,
      this.fontWeight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(text.tr,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.cairo(
            letterSpacing: 0.6,
            fontWeight: fontWeight,
            color: color,
            fontSize: fontSize,
          )),
    );
  }
}
