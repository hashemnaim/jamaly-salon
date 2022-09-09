import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/apis/home_vendor_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/user/home_user_controller.dart';
import 'package:yacht_booking/controller/vendor/home_vendor_controller.dart';
import 'package:yacht_booking/view/vendor/chat_details_provider_screen.dart';
import 'package:yacht_booking/view/widgets/custom_app_bar.dart';
import 'package:yacht_booking/view/widgets/custom_avatar.dart';
import 'package:yacht_booking/view/widgets/custom_button.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';
import 'package:yacht_booking/view/widgets/custom_text_form_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yacht_booking/view/widgets/svg_row.dart';

class ReservationDetailsScreen extends StatelessWidget {
  final String type;

  ReservationDetailsScreen(this.type);

  HomeVendorController homeVendorController = Get.find();
  GlobalKey<FormState> cancelOrderFormKey = GlobalKey<FormState>();
  String resonsCancel;
  HomeUserController homeUserController = Get.find();

  setResoneCancel(String value) {
    this.resonsCancel = value;
  }

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
              ? Helper.loading()
              : SingleChildScrollView(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      type == "confirm"
                          ? SizedBox()
                          : CustomText(
                              'لا يمكنك إدارة هذا الحجز لأنه منتهي',
                              fontColor: AppColors.red,
                            ),
                      SizedBox(height: 15.h),
                      Container(
                        padding: EdgeInsetsDirectional.all(10.r),
                        decoration: BoxDecoration(
                          color: AppColors.bg,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomText(
                                    '${homeVendorController.orderDetailsVendorData.value.data.user.name}',
                                    alignment: AlignmentDirectional.centerStart,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SvgRow(
                                        'call',
                                        '${homeVendorController.orderDetailsVendorData.value.data.user.mobile}',
                                        svgColor: AppColors.fontPrimaryColor,
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
                      ),
                      SizedBox(height: 15.h),
                      CustomText(
                        'تفاصيل الحجز:',
                        alignment: AlignmentDirectional.centerStart,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 10.h),
                      Container(
                        padding: EdgeInsetsDirectional.all(10.r),
                        decoration: BoxDecoration(
                          color: AppColors.bg,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Column(
                          children: [
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
                                  '${homeVendorController.orderDetailsVendorData.value.data.date}',
                                  alignment: AlignmentDirectional.centerStart,
                                  fontWeight: FontWeight.bold,
                                  fontColor: AppColors.hintColor,
                                  fontSize: 12,
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
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
                            Divider(),
                            CustomText(
                              'طريقة الدفع:',
                              alignment: AlignmentDirectional.centerStart,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            SizedBox(height: 3.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 24.r,
                                      height: 24.r,
                                      child: Checkbox(
                                        value: true,
                                        fillColor: MaterialStateProperty.all(
                                            AppColors.hintColor),
                                        onChanged: (val) {},
                                      ),
                                    ),
                                    SizedBox(width: 5.w),
                                    CustomText(
                                      '${homeVendorController.orderDetailsVendorData.value.data.paymentMethod}',
                                      fontSize: 12,
                                    ),
                                  ],
                                ),
                                CustomText(
                                  '${homeVendorController.orderDetailsVendorData.value.data.price} درهم',
                                  fontColor: AppColors.fontSecondaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.h),
                      CustomText(
                        'مراجعة الخدمات المقدمة  :',
                        alignment: AlignmentDirectional.centerStart,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 24.r,
                            height: 24.r,
                            child: Checkbox(
                              value: true,
                              fillColor: MaterialStateProperty.all(
                                  AppColors.hintColor),
                              onChanged: (val) {},
                            ),
                          ),
                          SizedBox(width: 5.w),
                          CustomText(
                            '3 غرف نوم مجهزة بأكمل وجه',
                            fontSize: 12,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 24.r,
                            height: 24.r,
                            child: Checkbox(
                              value: true,
                              fillColor: MaterialStateProperty.all(
                                  AppColors.hintColor),
                              onChanged: (val) {},
                            ),
                          ),
                          SizedBox(width: 5.w),
                          CustomText(
                            'مطبخ كامل بكل الادوات',
                            fontSize: 12,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 24.r,
                            height: 24.r,
                            child: Checkbox(
                              value: true,
                              fillColor: MaterialStateProperty.all(
                                  AppColors.hintColor),
                              onChanged: (val) {},
                            ),
                          ),
                          SizedBox(width: 5.w),
                          CustomText(
                            'مطبخ كامل بكل الادوات',
                            fontSize: 12,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 24.r,
                            height: 24.r,
                            child: Checkbox(
                              value: true,
                              fillColor: MaterialStateProperty.all(
                                  AppColors.hintColor),
                              onChanged: (val) {},
                            ),
                          ),
                          SizedBox(width: 5.w),
                          CustomText(
                            '3 غرف نوم مجهزة بأكمل وجه',
                            fontSize: 12,
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      CustomTextFormField(
                        hintText:
                            '${homeVendorController.orderDetailsVendorData.value.data.notes}',
                        maxLines: 3,
                        isBoxShadow: false,
                        isBorderSide: false,
                        fillColor: AppColors.bg,
                        enabled: false,
                      ),
                      SizedBox(height: 10.h),
                      type == "finshed"
                          ? SizedBox()
                          : CustomButton(
                              text: 'إلغاء الحجز',
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    backgroundColor: AppColors.secondaryColor,
                                    contentPadding: EdgeInsetsDirectional.only(
                                      top: 0,
                                      start: 20.w,
                                      end: 20.w,
                                      bottom: 20.h,
                                    ),
                                    title: Align(
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                      child: InkWell(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                          child: Icon(
                                            Icons.close,
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SvgPicture.asset(
                                          Assets.getIconSvg('error'),
                                          width: 120.r,
                                          height: 120.r,
                                        ),
                                        SizedBox(height: 15.h),
                                        CustomText(
                                          'هل انت متأكد من إلغاء الحجز ',
                                          fontWeight: FontWeight.bold,
                                        ),
                                        SizedBox(height: 10.h),
                                        Form(
                                          key: cancelOrderFormKey,
                                          child: CustomTextFormField(
                                            hintText: 'كتابة سبب الإلغاء',
                                            maxLines: 3,
                                            fillColor: Colors.white,
                                            isBorderSide: false,
                                            isBoxShadow: false,
                                            onSaved: setResoneCancel,
                                            validator: Helper.validationNull,
                                          ),
                                        )
                                      ],
                                    ),
                                    actions: [
                                      CustomButton(
                                        text: 'نعم متأكد',
                                        onTap: () {
                                          if (cancelOrderFormKey.currentState
                                              .validate()) {
                                            cancelOrderFormKey.currentState
                                                .save();
                                            Get.back();
                                            Get.back();
                                            HomeVendorApis.homeVendorApis
                                                .cancelOrder(
                                                    homeVendorController
                                                        .orderDetailsVendorData
                                                        .value
                                                        .data
                                                        .id
                                                        .toString(),
                                                    resonsCancel);
                                          }
                                          // showDialog(
                                          //   context: context,
                                          //   builder: (BuildContext context) => AlertDialog(
                                          //     backgroundColor: AppColors.secondaryColor,
                                          //     contentPadding: EdgeInsetsDirectional.only(
                                          //       top: 0,
                                          //       start: 20.w,
                                          //       end: 20.w,
                                          //       bottom: 20.h,
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
                                          //           Assets.getIconSvg('request_success'),
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
                                          //     actions: [
                                          //       CustomButton(
                                          //           text: 'الذهاب الى الرئيسية',
                                          //           onTap: () {
                                          //             Get.back();
                                          //           },
                                          //       )
                                          //     ],
                                          //   ),
                                          // );
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                              background: Colors.white,
                              isBorder: true,
                              fontColor: AppColors.red,
                              borderColor: AppColors.red,
                            ),
                    ],
                  ),
                ),
        ),
      );
    });
  }
}
