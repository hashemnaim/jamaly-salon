import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomCircle extends StatelessWidget {
  final Color color;

  final double radius;
  final Widget child ;
  CustomCircle({this.color, this.radius = 50, this.child});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: color ?? Color(0xffF6DFFF).withOpacity(0.15),
      radius: radius.r,
      child: child,
    );
  }
}