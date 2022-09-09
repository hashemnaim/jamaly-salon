import 'package:flutter/material.dart';
import 'package:yacht_booking/apis/home_vendor_apis.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/user/home_user_controller.dart';
import 'package:yacht_booking/controller/vendor/home_vendor_controller.dart';
import 'package:yacht_booking/view/vendor/chat_details_provider_screen.dart';
import 'package:yacht_booking/view/widgets/custom_app_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/view/widgets/custom_avatar.dart';
import 'package:yacht_booking/view/widgets/custom_button.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';
import 'package:yacht_booking/view/widgets/custom_text_form_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yacht_booking/view/widgets/icon_row.dart';
import 'package:yacht_booking/view/widgets/svg_row.dart';

class RequestDetailsScreen extends StatelessWidget {
  final bool isRequest;

  RequestDetailsScreen(this.isRequest);
  HomeVendorController homeVendorController = Get.find();
  HomeUserController homeUserController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: CustomAppBar(
          title: 'تفاصيل الحجز',
          backFun: () {
            Get.back();
          },
        ),
        body: SizedBox(
          width: double.infinity,
          child: homeVendorController.orderDetailsVendorData.value.data == null
              ? Center(
                  child: Helper.loading(),
                )
              : SingleChildScrollView(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsetsDirectional.all(10.r),
                        decoration: BoxDecoration(
                          color: AppColors.bg,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: AppColors.borderColor),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomAvatar(
                                  25,
                                  23,
                                  'person',
                                  isBoxShadow: false,
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        '${homeVendorController.orderDetailsVendorData.value.data.user.name ?? ''}',
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SvgRow(
                                            'call',
                                            '${homeVendorController.orderDetailsVendorData.value.data.user.mobile ?? ''}',
                                            svgColor:
                                                AppColors.fontPrimaryColor,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Get.to(
                                                () => ChatDetailsScreenProvider(
                                                  myId: homeUserController
                                                      .getProfileUserData
                                                      .value
                                                      .data
                                                      .id
                                                      .toString(),
                                                  imagename: homeVendorController
                                                      .orderDetailsVendorData
                                                      .value
                                                      .data
                                                      .user
                                                      .photo,
                                                  otherId: homeVendorController
                                                      .orderDetailsVendorData
                                                      .value
                                                      .data
                                                      .user
                                                      .id
                                                      .toString(),
                                                  username: homeVendorController
                                                      .orderDetailsVendorData
                                                      .value
                                                      .data
                                                      .user
                                                      .name,
                                                ),
                                              );
                                            },
                                            child: SvgRow(
                                              'messages',
                                              'مراسلة فورية',
                                              fontColor: AppColors.primaryColor,
                                              svgColor: AppColors.primaryColor,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 25.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  'تاريخ الحجز:',
                                  alignment: AlignmentDirectional.centerStart,
                                  fontWeight: FontWeight.bold,
                                  fontColor: AppColors.primaryColor,
                                ),
                                CustomText(
                                  ' ${homeVendorController.orderDetailsVendorData.value.data.date} ',
                                  alignment: AlignmentDirectional.centerStart,
                                  fontWeight: FontWeight.bold,
                                  fontColor: AppColors.hintColor,
                                  fontSize: 12,
                                ),
                              ],
                            ),
                            SizedBox(height: 25.h),
                            Row(
                              children: [
                                Expanded(
                                  child: SvgRow(
                                    'time',
                                    'المدة الزمنية للحجز',
                                    svgColor: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.borderColor,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: CustomText(
                                      '${homeVendorController.orderDetailsVendorData.value.data.duration}',
                                      fontColor: AppColors.fontSecondaryColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Expanded(
                                  child: SvgRow(
                                    'time',
                                    'توقيت الحجز',
                                    svgColor: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.borderColor,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: CustomText(
                                      '${homeVendorController.orderDetailsVendorData.value.data.from}-${homeVendorController.orderDetailsVendorData.value.data.to}',
                                      fontColor: AppColors.fontSecondaryColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Divider(),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: SvgRow(
                                    'circle_user',
                                    'عدد الأشخاص',
                                    svgColor: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.borderColor,
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: CustomText(
                                      '${homeVendorController.orderDetailsVendorData.value.data.numberOfPersones}',
                                      fontColor: AppColors.fontSecondaryColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Divider(height: 25.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconRow(
                                      Icons.location_on,
                                      'المدينة',
                                      iconColor: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomText(
                                      'مدينة دبي',
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      fontColor: AppColors.fontSecondaryColor,
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconRow(
                                      Icons.monetization_on,
                                      'الميزانية',
                                      iconColor: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomText(
                                      '${homeVendorController.orderDetailsVendorData.value.data.price}',
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      fontColor: AppColors.fontSecondaryColor,
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconRow(
                                      Icons.star,
                                      'التقييم',
                                      iconColor: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomText(
                                      '4.0',
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      fontColor: AppColors.fontSecondaryColor,
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Divider(height: 25.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  'نوع الخدمه:',
                                  fontWeight: FontWeight.bold,
                                  fontColor: AppColors.primaryColor,
                                ),
                                SizedBox(width: 8.w),
                                SvgPicture.asset(
                                  Assets.getIconSvg('logo'),
                                  width: 20.r,
                                  height: 20.r,
                                ),
                                SizedBox(width: 8.w),
                                CustomText(
                                  'أعياد ميلاد',
                                  fontSize: 12,
                                ),
                              ],
                            ),
                            SizedBox(height: 15.h),
                            CustomText(
                              'ملاحظات العميل:',
                              alignment: AlignmentDirectional.centerStart,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            SizedBox(height: 10.h),
                            CustomTextFormField(
                              hintText:
                                  '${homeVendorController.orderDetailsVendorData.value.data.notes}',
                              maxLines: 3,
                              isBoxShadow: false,
                              // isBorderSide: false,
                              fillColor: Colors.white,
                              enabled: false,
                            ),
                            SizedBox(height: 15.h),
                            CustomButton(
                              text: 'قبول الحجز',
                              onTap: () {
                                Get.back();
                                HomeVendorApis.homeVendorApis.confirmOrder(
                                    homeVendorController
                                        .orderDetailsVendorData.value.data.id
                                        .toString());
                                // showDialog(
                                //   context: context,
                                //   builder: (BuildContext context) => AlertDialog(
                                //     backgroundColor: AppColors.secondaryColor,
                                //     contentPadding: EdgeInsetsDirectional.only(
                                //       top: 0,
                                //       start: 20.w,
                                //       end: 20.w,
                                //       bottom: 35.h,
                                //     ),
                                //     title: Align(
                                //       alignment: AlignmentDirectional.centerStart,
                                //       child: InkWell(
                                //         onTap: () {
                                //           Get.back();

                                //         },
                                //         child: Container(
                                //           decoration: BoxDecoration(
                                //             shape: BoxShape.circle,
                                //             color: Colors.white,
                                //           ),
                                //           child: Icon(
                                //             Icons.close,
                                //             color: AppColors.primaryColor,
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //     content: Column(
                                //       mainAxisSize: MainAxisSize.min,
                                //       children: [
                                //         SvgPicture.asset(
                                //           Assets.getIconSvg('request'),
                                //           width: 120.r,
                                //           height: 120.r,
                                //         ),
                                //         SizedBox(height: 15.h),
                                //         CustomText(
                                //           'تم إلغاء الحجز بنجاح',
                                //           fontWeight: FontWeight.bold,
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // );
                              },
                              background: Color(0xff00CA80),
                              borderColor: Color(0xff00CA80),
                              isBorder: true,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.h),
                      isRequest
                          ? Column(
                              children: [
                                CustomText(
                                  'أو يمكنك تقديم عرضك الخاص للعميل:',
                                  alignment: AlignmentDirectional.centerStart,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                                SizedBox(height: 15.h),
                                CustomTextFormField(
                                  hintText: 'مبلغ الحجز كاملاً',
                                  fillColor: Colors.white,
                                  isBoxShadow: false,
                                  enabled: false,
                                  suffixIcon: Padding(
                                    padding:
                                        EdgeInsetsDirectional.only(end: 10.w),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          height: 30.h,
                                          child: VerticalDivider(thickness: 1),
                                        ),
                                        CustomText(
                                          'درهم',
                                          fontSize: 10,
                                          fontColor: AppColors.hintColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15.h),
                                CustomTextFormField(
                                  maxLines: 3,
                                  hintText: 'يمكنك إضافة ملاحظات اضافية',
                                  isBoxShadow: false,
                                  fillColor: Colors.white,
                                ),
                                SizedBox(height: 15.h),
                                CustomButton(
                                  text: 'ارسال عرض',
                                  onTap: () {},
                                ),
                              ],
                            )
                          : SizedBox()
                    ],
                  ),
                ),
        ),
      );
    });
  }
}
