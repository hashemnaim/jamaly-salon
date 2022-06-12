import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

class CustomDrop extends StatefulWidget {
  final List<Map<String, dynamic>> dropList;
  int initValue;
  final Function onTap;

  CustomDrop({
    this.dropList,
    this.initValue,
    this.onTap,
  });

  @override
  _CustomDropState createState() => _CustomDropState();
}

class _CustomDropState extends State<CustomDrop> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0.h,
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(
          width: 1.0,
          color: Colors.grey[300],
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          dropdownColor: Colors.white,
          value: widget.initValue,
          focusColor: Colors.black,
          icon: Padding(
            padding: EdgeInsetsDirectional.only(end: 10.w),
            child: Icon(
              FontAwesomeIcons.chevronDown,
              color: Color(0xffA7A7A7),
              size: 15.r,
            ),
          ),
          isExpanded: true,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          style: TextStyle(
            fontFamily: 'FlatRegular',
            fontSize: 14.sp,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w300,
          ),
          items: widget.dropList.map((var item) {
            return DropdownMenuItem(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10.w,
                  ),
                  Icon(
                    FontAwesomeIcons.mapMarkerAlt,
                    color: Colors.grey[400],
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  CustomText(
                    item['name'],
                    fontSize: 14.0,
                    // fontColor: AppColors.primaryColor,
                    fontColor: Colors.black,
                    fontWeight: FontWeight.w300,
                  )
                ],
              ),
              value: item['id'],
            );
          }).toList(),
          onChanged: (value) {
            widget.initValue = value as int;
            var findItem = widget.dropList.firstWhere(
                (element) => element['id'].toString() == value.toString());
            widget.onTap(findItem);
          },
        ),
      ),
    );
  }
}
