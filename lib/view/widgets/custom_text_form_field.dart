import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yacht_booking/common/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  @required
  final String text;
  final Widget prefixIcon;
  final bool obscureText;
  final TextInputType textInputType;
  final String hintText;
  final int maxLines;
  final String textInitialValue;
  final TextEditingController textEditingController;
  final double hintStyleSize;
  final double textStyleSize;
  final Color colorIcon;
  final bool enabled;
  final Widget suffixIcon;
  final bool textExit;
  final Function onSaved, validator;
  final String labelText;
  final Color fillColor;
  final bool isBoxShadow;
  final bool isBorderRadius;
  final double height;
  final bool isBorderSide;

  const CustomTextFormField({
    this.text,
    this.textEditingController,
    this.textExit = true,
    this.suffixIcon,
    this.prefixIcon,
    this.textInitialValue,
    this.obscureText = false,
    this.textInputType,
    this.hintText,
    this.maxLines = 1,
    this.hintStyleSize = 12,
    this.textStyleSize = 14,
    this.colorIcon = AppColors.primaryColor,
    this.enabled = true,
    this.onSaved,
    this.validator,
    this.labelText,
    this.fillColor = AppColors.secondaryColor,
    this.isBoxShadow = true,
    this.isBorderRadius = true,
    this.height = 55,
    this.isBorderSide = true,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: widget.height.h??,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: widget.isBoxShadow ? AppColors.boxShadow : null,
      ),
      child: TextFormField(
        controller: widget.textEditingController,
        validator: (value) => widget.validator(value),
        onSaved: (newValue) => widget.onSaved(newValue),
        onChanged: (value) {
          widget.onSaved(value);
        },
        enabled: widget.enabled,
        maxLines: widget.maxLines,
        initialValue: widget.textInitialValue,
        keyboardType: widget.textInputType,
        obscureText: widget.obscureText ? _obscureText : false,
        obscuringCharacter: '*',
        style: TextStyle(
            fontSize: widget.textStyleSize.sp,
            color: AppColors.fontPrimaryColor,
            fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          hintText: widget.hintText,
          labelText: widget.labelText,
          hintStyle: TextStyle(
              fontSize: widget.hintStyleSize.sp,
              color: Colors.grey[400],
              fontWeight: FontWeight.bold),
          labelStyle: TextStyle(
            fontSize: widget.hintStyleSize,
            //color: AppColors.fontSecondaryColor,
          ),
          filled: true,
          fillColor: widget.fillColor,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.hintColor,
                      size: 22.r),
                  onPressed: _toggle,
                )
              : widget.suffixIcon,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 12.h,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: widget.isBorderRadius
                ? BorderRadius.circular(10.r)
                : BorderRadius.zero,
            borderSide: widget.isBorderSide
                ? BorderSide(color: Colors.grey[300])
                : BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: widget.isBorderRadius
                ? BorderRadius.circular(10.r)
                : BorderRadius.zero,
            borderSide: widget.isBorderSide
                ? BorderSide(color: Colors.grey[300])
                : BorderSide.none,
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: widget.isBorderRadius
                ? BorderRadius.circular(10.r)
                : BorderRadius.zero,
            borderSide: widget.isBorderSide
                ? BorderSide(color: Colors.grey[300])
                : BorderSide.none,
          ),
        ),
      ),
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
