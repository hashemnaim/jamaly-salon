import 'package:salon_provider/feature/view/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  final String date, title;
  NotificationItem({
    this.title,
    this.date,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Row(
            children: [
           
              SizedBox(
                width: 12.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: title,
                    ),
                    CustomText(
                      text: date,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 65.w),
          child: Divider(
            color: Color(0xffB8B6B6),
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
