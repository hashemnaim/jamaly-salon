import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/vendor/home_vendor_controller.dart';
import 'package:yacht_booking/view/widgets/custom_app_bar.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

import 'widgets/notification_card.dart';

class NotificationScreen extends StatelessWidget {
  HomeVendorController homeVendorController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: CustomAppBar(
          title: 'الإشعارات',
          backFun: () => Get.back(),
        ),
        body: homeVendorController.getNotificationsData.value.data == null
            ? Center(
                child: Helper.loading(),
              )
            : homeVendorController.getNotificationsData.value.data.isEmpty
                ? Center(
                    child: CustomText("لا يوجد إشعارات"),
                  )
                : ListView.separated(
                    itemCount: homeVendorController
                        .getNotificationsData.value.data.length,
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 15.h,
                    ),
                    itemBuilder: (context, index) => NotificationCard(
                      notificationModelData: homeVendorController
                          .getNotificationsData.value.data[index],
                    ),
                  ),
      );
    });
  }
}
