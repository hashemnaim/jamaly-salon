import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/apis/home_vendor_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/models/recieved_order.dart';
import 'package:yacht_booking/view/vendor/reservation_details/reservation_details_screen.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

class CardFinshedOrder extends StatelessWidget {
  final RecevedOrderData recevedOrderData;

  const CardFinshedOrder({this.recevedOrderData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: AppColors.bg,
        border: Border.all(
          color: AppColors.borderColor,
        ),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        children: [
          Theme(
            data: ThemeData(
              dividerColor: Colors.transparent,
              // listTileTheme: ListTileThemeData(
              //     contentPadding: EdgeInsets.zero, dense: true),
            ),
            child: ExpansionTile(
              trailing: Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.fontSecondaryColor,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      CustomText(
                        'تاريخ الحجز:',
                        fontColor: AppColors.fontSecondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ],
                  ),
                  CustomText(
                    '${recevedOrderData.date ?? ""}',
                    fontColor: AppColors.fontSecondaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    alignment: AlignmentDirectional.centerEnd,
                  ),
                ],
              ),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomText(
                            'المدة الزمنية',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontColor: AppColors.fontSecondaryColor,
                          ),
                          Container(
                            width: 100.w,
                            height: 26.h,
                            decoration: BoxDecoration(
                              color: AppColors.secondaryColor,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: CustomText(
                              'ساعة - 30 دقيقة',
                              fontSize: 9,
                              fontColor: AppColors.fontSecondaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 5.w),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomText(
                            'توقيت الحجز',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontColor: AppColors.fontSecondaryColor,
                          ),
                          Container(
                            width: 100.w,
                            height: 26.h,
                            decoration: BoxDecoration(
                              color: AppColors.secondaryColor,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: CustomText(
                              '${recevedOrderData.from ?? ""} - ${recevedOrderData.to ?? ""}',
                              fontSize: 9,
                              fontColor: AppColors.fontSecondaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 5.w),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomText(
                            'عدد الأشخاص',
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontColor: AppColors.fontSecondaryColor,
                          ),
                          Container(
                            width: 100.w,
                            height: 26.h,
                            decoration: BoxDecoration(
                              color: AppColors.secondaryColor,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: CustomText(
                              '${recevedOrderData.numberOfPersones ?? ""}',
                              fontSize: 9,
                              fontColor: AppColors.fontSecondaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(bottom: 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomText(
                      'اسم العميل: ',
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    CustomText(
                      '${recevedOrderData.user.name ?? ""}',
                      fontSize: 12,
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 23.r,
                          width: 23.r,
                          child: Checkbox(
                            value: true,
                            onChanged: (val) {},
                            fillColor:
                                MaterialStateProperty.all(AppColors.hintColor),
                          ),
                        ),
                        SizedBox(width: 5.w),
                        CustomText(
                          'طريقة الدفع: ',
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          fontColor: AppColors.hintColor,
                        ),
                        CustomText(
                          '${recevedOrderData.paymentMethod ?? ""}',
                          fontSize: 12,
                          fontColor: AppColors.hintColor,
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        HomeVendorApis.homeVendorApis
                            .detailsOrder(recevedOrderData.id.toString());
                        Get.to(() => ReservationDetailsScreen("finshed"));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.r),
                        decoration: BoxDecoration(
                          color: AppColors.fontSecondaryColor,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: CustomText(
                          'التفاصيل',
                          fontColor: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
