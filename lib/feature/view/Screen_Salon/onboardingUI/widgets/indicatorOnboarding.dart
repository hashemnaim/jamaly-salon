import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';

import 'package:salon_provider/feature/values/colors.dart';

class IndicatorOnboarding extends StatelessWidget {
  final int numPages, currentPage;
  final double factorChange;

  IndicatorOnboarding({this.numPages, this.currentPage, this.factorChange});

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < numPages; i++) {
      list.add(i == currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 2.0.w),
      // height: ScreenUtil().setHeight(10),
      // width: ScreenUtil().setWidth(10),
      height: 8.h,
      width: !isActive
          ? 8.w
          : factorChange == 1
              ? 30.w
              : lerpDouble(30, 8, factorChange).w,
      decoration: BoxDecoration(
        // color: isActive
        //     ? ColorTween(begin: AppColors.orange, end: Colors.white)
        //         .transform(factorChange)
        //     : Colors.white,
        color: !isActive
            ? Colors.white
            : factorChange == 1
                ? AppColors.primaryColor
                : ColorTween(begin: AppColors.primaryColor, end: Colors.white)
                    .transform(factorChange),
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildPageIndicator(),
    );
  }
}
