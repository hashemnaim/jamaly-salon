import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/apis/home_vendor_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/vendor/home_vendor_controller.dart';
import 'package:yacht_booking/view/vendor/home/widgets/card_confirm_order.dart';
import 'package:yacht_booking/view/vendor/home/widgets/card_finshed_order.dart';
import 'package:yacht_booking/view/vendor/home/widgets/card_oder.dart';
import 'package:yacht_booking/view/vendor/home/widgets/card_request_order.dart';
import 'package:yacht_booking/view/widgets/custom_bottom_sheet.dart';
import 'package:yacht_booking/view/widgets/custom_button.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';
import 'package:yacht_booking/view/widgets/custom_text_form_field.dart';

class ReservationsTap extends StatelessWidget {
  HomeVendorController homeVendorController = Get.find();
  final filterTitleList = [
    'جديدة',
    'مؤكدة',
    'منتهية',
    'خدمة / طلبك حسب ميزانيتك',
    'جميع الحجوزات',
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                customBottomSheet(
                  widget: StatefulBuilder(
                    builder: (context, setState) => Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          primary: false,
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: filterTitleList.length,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              homeVendorController.filterIndex.value = index;
                              setState(() {});
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CustomText(
                                      filterTitleList[index],
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      fontWeight: FontWeight.bold,
                                    ),

                                    SizedBox(width: 8.w),
                                    // Badge(
                                    //   badgeContent: CustomText(
                                    //     '3',
                                    //     fontColor: Colors.white,
                                    //     fontWeight: FontWeight.bold,
                                    //     fontSize: 12,
                                    //   ),
                                    //   badgeColor: AppColors.primaryColor,
                                    // ),
                                  ],
                                ),
                                homeVendorController.filterIndex.value == index
                                    ? Icon(
                                        Icons.check,
                                        color: AppColors.primaryColor,
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 15.h),
                        CustomButton(
                            text: 'عرض',
                            onTap: () {
                              if (homeVendorController.filterIndex.value == 0) {
                                Get.back();
                                HomeVendorApis.homeVendorApis
                                    .getRecievedOrderVendor("new_orders");
                              } else if (homeVendorController
                                      .filterIndex.value ==
                                  1) {
                                Get.back();
                                HomeVendorApis.homeVendorApis
                                    .getRecievedOrderVendor("confirmed_orders");
                              } else if (homeVendorController
                                      .filterIndex.value ==
                                  2) {
                                Get.back();
                                HomeVendorApis.homeVendorApis
                                    .getRecievedOrderVendor("finished_orders");
                              } else if (homeVendorController
                                      .filterIndex.value ==
                                  4) {
                                Get.back();

                                HomeVendorApis.homeVendorApis
                                    .getRecievedOrderVendor("all");
                              } else {
                                Get.back();
                                HomeVendorApis.homeVendorApis
                                    .getRecievedOrderVendor("order_requests");
                              }
                            }),
                      ],
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 45.h,
                      child: CustomTextFormField(
                        hintText: 'البحث',
                        prefixIcon: Icon(Icons.search),
                        isBoxShadow: false,
                        isBorderSide: false,
                        enabled: false,
                      ),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  CustomText(
                    'فرز الحجوزات',
                    fontColor: AppColors.fontSecondaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                  SizedBox(width: 10.w),
                  SvgPicture.asset(
                    Assets.getIconSvg('filter'),
                    color: AppColors.fontSecondaryColor,
                    width: 18.r,
                    height: 18.r,
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            homeVendorController.recevedOrderData.value.data == null
                ? SizedBox(
                    height: 300.h,
                    child: Center(
                      child: Helper.loading(),
                    ),
                  )
                : Column(
                    children: [
                      CustomText(
                        homeVendorController.filterIndex.value == 0
                            ? 'الحجوزات جديدة:'
                            : homeVendorController.filterIndex.value == 1
                                ? "الحجوزات مؤكدة:"
                                : homeVendorController.filterIndex.value == 2
                                    ? "الحجوزات منتهية"
                                    : homeVendorController.filterIndex.value ==
                                            3
                                        ? "خدمة / طلبك حسب ميزانيتك"
                                        : homeVendorController
                                                    .filterIndex.value ==
                                                4
                                            ? "جميع الحجوزات"
                                            : "",
                        alignment: AlignmentDirectional.centerStart,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 10),
                      homeVendorController.recevedOrderData.value.data.isEmpty
                          ? SizedBox(
                              height: 300.h,
                              child: Center(
                                child: CustomText("لا يوجد حجوزات"),
                              ),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              primary: false,
                              itemCount: homeVendorController
                                  .recevedOrderData.value.data.length,
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 10,
                                );
                              },
                              itemBuilder: (context, index) {
                                return homeVendorController.filterIndex.value ==
                                        0
                                    ? CardOrder(
                                        recevedOrderDatum: homeVendorController
                                            .recevedOrderData.value.data[index],
                                      )
                                    : homeVendorController.filterIndex.value ==
                                                1 ||
                                            homeVendorController
                                                    .recevedOrderData
                                                    .value
                                                    .data[index]
                                                    .status
                                                    .toString() ==
                                                '1'
                                        ? CardConfirmOrder(
                                            recevedOrderData:
                                                homeVendorController
                                                    .recevedOrderData
                                                    .value
                                                    .data[index],
                                          )
                                        : homeVendorController
                                                        .filterIndex.value ==
                                                    2 ||
                                                homeVendorController
                                                        .recevedOrderData
                                                        .value
                                                        .data[index]
                                                        .status
                                                        .toString() ==
                                                    '2'
                                            ? CardFinshedOrder(
                                                recevedOrderData:
                                                    homeVendorController
                                                        .recevedOrderData
                                                        .value
                                                        .data[index],
                                              )
                                            : CardRequestOrder(
                                                recevedOrderData:
                                                    homeVendorController
                                                        .recevedOrderData
                                                        .value
                                                        .data[index],
                                              );
                              },
                            ),
                    ],
                  ),
            SizedBox(height: 15),
          ],
        ),
      );
    });
  }
}
