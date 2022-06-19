import 'package:salon_provider/feature/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;

  final Color color;
  final Color colortext;
  final double borderRadius;

  final Function onPress;

  CustomButton({
    @required this.onPress,
    this.text = '',
    this.color = AppColors.primaryColor,
    this.colortext = AppColors.primary20,
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 3,
                spreadRadius: 4,
                offset: Offset(0, 2))
          ]),
      child: FlatButton(
        splashColor: Colors.green,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(borderRadius),
        ),
        padding: EdgeInsets.all(10),
        onPressed: onPress,
        color: color,
        child: CustomText(
          text: text,
          fontSize: 20.sp,
          color: colortext,
        ),
      ),
    );
  }
}
