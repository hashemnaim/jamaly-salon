import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/view/widgets/custom_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yacht_booking/view/widgets/custom_button.dart';

import 'widgets/coming_card.dart';
import 'widgets/past_card.dart';

class MeReservationScreen extends StatefulWidget {
  const MeReservationScreen({Key key}) : super(key: key);

  @override
  _MeReservationScreenState createState() => _MeReservationScreenState();
}

class _MeReservationScreenState extends State<MeReservationScreen> {
  bool isPast = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'حجوزاتي',
        backFun: () => Get.back(),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomButton(
                  text: 'قادمة',
                  width: 108,
                  height: 40,
                  isBorder: true,
                  background: isPast ? Colors.white : AppColors.primaryColor,
                  fontColor: isPast ? AppColors.primaryColor : Colors.white,
                  onTap: () {
                    setState(() {
                      isPast = false;
                    });
                  },
                ),
                SizedBox(width: 5.w),
                CustomButton(
                  text: 'فائته',
                  width: 108,
                  height: 40,
                  background: isPast ? AppColors.primaryColor : Colors.white,
                  fontColor: isPast ? Colors.white : AppColors.primaryColor,
                  isBorder: true,
                  onTap: () {
                    setState(() {
                      isPast = true;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 10.h),
            isPast ? PastCard() : ComingCard(),
          ],
        ),
      ),
    );
  }
}
