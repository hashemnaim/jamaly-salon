import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yacht_booking/common/app_colors.dart';

import 'custom_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function backFun,actionFun;
  final bool isBack;
  final bool isText;
  final String text;
  final Color backgroundColor, iconBackColor;

  CustomAppBar({
    @required this.title,
    this.backFun,
    this.actionFun,
    this.isBack = true,
    this.isText = false,
    this.text = '',
    this.backgroundColor = Colors.white,
    this.iconBackColor = AppColors.fontPrimaryColor,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: CustomText(
        title,
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: backgroundColor,
      elevation: 0.0,
      leadingWidth: isText ? 85.w : null,
      leading: Padding(
        padding: const EdgeInsetsDirectional.all(8),
        child: isBack
            ? InkWell(
                onTap: backFun,
                borderRadius: BorderRadius.circular(10.0.r),
                child: Container(
                  margin: isText
                      ? EdgeInsetsDirectional.only(end: 35.w)
                      : null,
                  width: 40.r,
                  height: 40.r,
                  child: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: iconBackColor,
                    size: 23.r,
                  ),
                ),
              )
            : SizedBox(
                width: 40.r,
                height: 40.r,
              ),
      ),
      actions: [
        isText
            ? Padding(
                padding: EdgeInsetsDirectional.all(8.r),
                child: InkWell(
                  onTap: actionFun,
                  borderRadius: BorderRadius.circular(10.r),
                  child: Container(
                    width: 85.w,
                    height: 40.h,
                    child: CustomText(
                      text,
                      fontColor: AppColors.primaryColor,
                    ),
                  ),
                ),
              )
            : Padding(
                padding: EdgeInsetsDirectional.all(8.r),
                child: SizedBox(
                  width: 40.r,
                  height: 40.r,
                ),
              ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(double.infinity, 50.h);
}
