import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yacht_booking/common/app_colors.dart';

import 'custom_text.dart';

class CustomDropDown extends StatelessWidget {
  final value;
  final List<String> itemsList;
  final Color dropdownColor;
  final String hint;
  final Function(dynamic value) onChanged;
  final double height;
  final double fontSize;
  final Color backgroundColor, fontColor,borderColor,iconColor;

  const CustomDropDown({
    @required this.value,
    @required this.itemsList,
    this.hint ,
    this.dropdownColor,
    @required this.onChanged,
    this.height = 40,
    this.fontSize = 10,
    this.backgroundColor = AppColors.secondaryColor,
    this.fontColor = AppColors.fontSecondaryColor,
    this.borderColor = AppColors.secondaryColor,
    this.iconColor = AppColors.fontSecondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 3.h, bottom: 3.h),
      child: Container(
        height: height.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: backgroundColor,
          border: Border.all(color: borderColor
          ),
          // boxShadow: AppColors.boxShadow,
        ),
        child: DropdownButtonHideUnderline(
          child: Padding(
            padding: EdgeInsetsDirectional.only(start: 8.r, end: 8.r),
            child: DropdownButton(
              isExpanded: true,
              iconSize: 25.r,
              hint: Container(
                child: CustomText(
                  hint,
                  fontColor: Colors.grey[400],
                  fontWeight: FontWeight.bold,
                  alignment: AlignmentDirectional.centerStart,
                  
                ),
              ),
              
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: iconColor,
                size: 22.r,
              ),
              dropdownColor: dropdownColor,
              value: value,

      
              items: itemsList
                  .map(
                    (String item) => DropdownMenuItem<String>(
                      value: item,
                      child: CustomText(
                        item,
                        fontColor: fontColor,
                        alignment: AlignmentDirectional.centerStart,
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold
                        
                        
                        
                        
                        ,
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) => onChanged(value),
            ),
          ),
        ),
      ),
    );
  }
}