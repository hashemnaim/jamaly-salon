import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/models/notification_model.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';
import 'package:yacht_booking/view/widgets/icon_row.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModelData notificationModelData;

  const NotificationCard({this.notificationModelData});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          Assets.getIconSvg('notification'),
          fit: BoxFit.contain,
          width: 52.r,
          height: 52.r,
        ),
        SizedBox(width: 5.w),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 4.w),
                    child: CustomText(
                      '${notificationModelData.notification??""}',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconRow(Icons.person,  '${notificationModelData.user.name??""}',),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    'تاريخ الحجز',
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                     '${notificationModelData.createdAt.toString().split("T").first??""}',
                    fontSize: 10,
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
