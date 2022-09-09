import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/user/order_user_controller.dart';
import 'package:yacht_booking/view/widgets/custom_app_bar.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

import 'widgets/budget_request_expanded_tile.dart';

class BudgetRequestScreen extends StatelessWidget {
  OrderUserController orderUserController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: CustomAppBar(
          title: 'طلبك حسب ميزانيتك',
          backFun: () {
            Get.back();
          },
        ),
        body: SizedBox(
          width: double.infinity,
          child: orderUserController.orderOffersData.value.data == null
              ? Center(
                  child: Helper.loading(),
                )
              : orderUserController.orderOffersData.value.data.isEmpty
                  ? Center(
                      child: CustomText("لا يوجد حجوزات"),
                    )
                  : ListView.separated(
                      itemCount:
                          orderUserController.orderOffersData.value.data.length,
                      padding: EdgeInsets.symmetric(
                          vertical: 15.h, horizontal: 15.w),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 15.h),
                      itemBuilder: (context, index) =>
                          BudgetRequestExpandedTile(
                        orderOfferModelData: orderUserController
                            .orderOffersData.value.data[index],
                      ),
                    ),
        ),
      );
    });
  }
}
