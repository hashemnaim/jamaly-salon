import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/apis/home_vendor_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/vendor/home_vendor_controller.dart';
import 'package:yacht_booking/models/myOffer.dart';
import 'package:yacht_booking/view/vendor/add_new_offer/add_new_offer_screen.dart';
import 'package:yacht_booking/view/vendor/edit_offer/edit_offer_screen.dart';
import 'package:yacht_booking/view/vendor/services/widgets/header_vendor.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

class OfferVendorScreen extends StatelessWidget {
  HomeVendorController homeVendorController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            HeaderVendor(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                        'العروض المتاحة الآن:',
                        fontWeight: FontWeight.bold,
                        fontColor: AppColors.primaryColor,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => AddNewOfferScreen());
                        },
                        child: Container(
                          height: 35.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 5.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: Color(0xFFF2C409),
                          ),
                          child: CustomText(
                            'إضافة عرض',
                            fontColor: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  homeVendorController.getMyOfferData.value.data == null
                      ? Container(
                          height: 300.h,
                          child: Center(
                            child: Helper.loading(),
                          ),
                        )
                      : homeVendorController.getMyOfferData.value.data.isEmpty
                          ? Container(
                              height: 300.h,
                              child: Center(
                                  child: CustomText("لا يوجد عروض متاحة")),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              primary: false,
                              padding: EdgeInsets.zero,
                              itemCount: homeVendorController
                                  .getMyOfferData.value.data.length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 15.h),
                              itemBuilder: (context, index) {
                                MyOfferModelData myOfferModelData =
                                    homeVendorController
                                        .getMyOfferData.value.data[index];
                                return Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15.w, vertical: 15.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: AppColors.bg,
                                    border: Border.all(
                                        color: AppColors.borderColor),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                            'الخدمه المقدمة  :',
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                Assets.getIconSvg('logo'),
                                                height: 12.r,
                                                width: 12.r,
                                              ),
                                              SizedBox(width: 5.w),
                                              CustomText(
                                                'أعياد ميلاد',
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                fontColor:
                                                    AppColors.primaryColor,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.h),
                                      myOfferModelData.servicesShip.isEmpty
                                          ? CustomText("No Services")
                                          : SizedBox(
                                              height: 40.h,
                                              child: ListView.separated(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder:
                                                      (context, index2) =>
                                                          Container(
                                                            width: 100.w,
                                                            height: 35.h,
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  color: AppColors
                                                                      .primaryColor),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.r),
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                myOfferModelData.servicesShip[index2].services ==
                                                                            null ||
                                                                        myOfferModelData.servicesShip[index2].services.icon ==
                                                                            null
                                                                    ? SvgPicture
                                                                        .asset(
                                                                        Assets.getIconSvg(
                                                                            'logo'),
                                                                        height:
                                                                            12.r,
                                                                        width:
                                                                            12.r,
                                                                      )
                                                                    : Container(
                                                                        height:
                                                                            24.r,
                                                                        width:
                                                                            24.r,
                                                                        child: CachedNetworkImage(
                                                                            imageUrl:
                                                                                myOfferModelData.servicesShip[index2].services.icon),
                                                                      ),
                                                                SizedBox(
                                                                    width: 5.w),
                                                                CustomText(
                                                                  myOfferModelData
                                                                              .servicesShip[index2]
                                                                              .services ==
                                                                          null
                                                                      ? ""
                                                                      : '${myOfferModelData.servicesShip[index2].services.title ?? ""}',
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontColor:
                                                                      AppColors
                                                                          .primaryColor,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                  separatorBuilder:
                                                      (context, index2) =>
                                                          SizedBox(
                                                            width: 5.w,
                                                          ),
                                                  itemCount: myOfferModelData
                                                      .servicesShip.length),
                                            ),
                                      SizedBox(height: 10.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                            'التفاصيل:',
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          // Row(
                                          //   children: [
                                          //     CustomText(
                                          //       'التفاصيل',
                                          //       fontSize: 10,
                                          //       fontWeight: FontWeight.bold,
                                          //       fontColor:
                                          //           AppColors.primaryColor,
                                          //     ),
                                          //     SizedBox(width: 5.w),
                                          //     Icon(
                                          //       Icons.arrow_forward_ios,
                                          //       size: 12.r,
                                          //       color: AppColors.primaryColor,
                                          //     )
                                          //   ],
                                          // ),
                                        ],
                                      ),
                                      SizedBox(height: 10.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons
                                                    .miscellaneous_services_outlined,
                                                size: 22.r,
                                                color: AppColors.primaryColor,
                                              ),
                                              SizedBox(width: 5.w),
                                              CustomText(
                                                'اسم الخدمه',
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w,
                                                vertical: 2.h),
                                            decoration: BoxDecoration(
                                              color: AppColors.hintColor
                                                  .withOpacity(0.4),
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                            child: CustomText(
                                              '${myOfferModelData.title ?? ""}',
                                              fontSize: 10,
                                              fontColor:
                                                  AppColors.fontSecondaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.watch_later_outlined,
                                                size: 18.r,
                                                color: AppColors.primaryColor,
                                              ),
                                              SizedBox(width: 5.w),
                                              CustomText(
                                                'السعر',
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w,
                                                vertical: 2.h),
                                            decoration: BoxDecoration(
                                              color: AppColors.hintColor
                                                  .withOpacity(0.4),
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                            child: CustomText(
                                              '${myOfferModelData.price} درهم',
                                              fontSize: 10,
                                              fontColor:
                                                  AppColors.fontSecondaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                Assets.getIconSvg('dolar'),
                                                height: 15.r,
                                                width: 15.r,
                                              ),
                                              SizedBox(width: 5.w),
                                              CustomText(
                                                'مبلغ العربون',
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w,
                                                vertical: 2.h),
                                            decoration: BoxDecoration(
                                              color: AppColors.hintColor
                                                  .withOpacity(0.4),
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                            child: CustomText(
                                              '${myOfferModelData.prepaid ?? "0"} درهم',
                                              fontSize: 10,
                                              fontColor:
                                                  AppColors.fontSecondaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.location_on,
                                                size: 18.r,
                                                color: AppColors.primaryColor,
                                              ),
                                              SizedBox(width: 5.w),
                                              CustomText(
                                                'المدينة',
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w,
                                                vertical: 2.h),
                                            decoration: BoxDecoration(
                                              color: AppColors.hintColor
                                                  .withOpacity(0.4),
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                            child: CustomText(
                                              '${myOfferModelData.country ?? "0"}',
                                              fontSize: 10,
                                              fontColor:
                                                  AppColors.fontSecondaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.speaker_notes_rounded,
                                                size: 18.r,
                                                color: AppColors.primaryColor,
                                              ),
                                              SizedBox(width: 5.w),
                                              CustomText(
                                                'ملاحظات',
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w,
                                                vertical: 2.h),
                                            decoration: BoxDecoration(
                                              color: AppColors.hintColor
                                                  .withOpacity(0.4),
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                            child: CustomText(
                                              '${myOfferModelData.notes ?? "0"}',
                                              fontSize: 10,
                                              fontColor:
                                                  AppColors.fontSecondaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                Assets.getIconSvg('shape'),
                                                height: 15.r,
                                                width: 15.r,
                                              ),
                                              SizedBox(width: 5.w),
                                              CustomText(
                                                'عدد الاشخاص',
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.w,
                                                vertical: 2.h),
                                            decoration: BoxDecoration(
                                              color: AppColors.hintColor
                                                  .withOpacity(0.4),
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                            child: CustomText(
                                              '${myOfferModelData.number_of_persones ?? "0"}',
                                              fontSize: 10,
                                              fontColor:
                                                  AppColors.fontSecondaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.date_range_outlined,
                                                size: 18.r,
                                                color: AppColors.primaryColor,
                                              ),
                                              SizedBox(width: 5.w),
                                              CustomText(
                                                'التاريخ',
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w,
                                                    vertical: 2.h),
                                                decoration: BoxDecoration(
                                                  color: AppColors.hintColor
                                                      .withOpacity(0.4),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                ),
                                                child: CustomText(
                                                  'من ${myOfferModelData.start_date}',
                                                  fontSize: 10,
                                                  fontColor: AppColors
                                                      .fontSecondaryColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(width: 5.w),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w,
                                                    vertical: 2.h),
                                                decoration: BoxDecoration(
                                                  color: AppColors.hintColor
                                                      .withOpacity(0.4),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                ),
                                                child: CustomText(
                                                  'إلى ${myOfferModelData.end_date}',
                                                  fontSize: 10,
                                                  fontColor: AppColors
                                                      .fontSecondaryColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15.h),
                                      CustomText(
                                        'الصور ',
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      SizedBox(height: 10.h),
                                      SizedBox(
                                        height: 74.h,
                                        child: myOfferModelData
                                                .gallaryOwner.isEmpty
                                            ? Center(
                                                child:
                                                    CustomText("لا يوجد صور"),
                                              )
                                            : ListView.separated(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: myOfferModelData
                                                    .gallaryOwner.length,
                                                separatorBuilder:
                                                    (context, index3) =>
                                                        SizedBox(width: 10.w),
                                                itemBuilder: (context, index3) {
                                                  return Container(
                                                    height: 60.h,
                                                    width: 116.w,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.r),
                                                      image: DecorationImage(
                                                        image:
                                                            CachedNetworkImageProvider(
                                                                myOfferModelData
                                                                    .gallaryOwner[
                                                                        index3]
                                                                    .imageUrl),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                      ),
                                      SizedBox(height: 15.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.to(() => EditOfferScreen(
                                                    myOfferModelData:
                                                        myOfferModelData,
                                                  ));
                                            },
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 30.w,
                                                  height: 30.h,
                                                  padding: EdgeInsets.all(7.r),
                                                  alignment:
                                                      AlignmentDirectional
                                                          .center,
                                                  decoration: BoxDecoration(
                                                    color: AppColors
                                                        .primaryColor
                                                        .withOpacity(0.1),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Icon(
                                                    Icons.edit,
                                                    size: 18.r,
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                                ),
                                                SizedBox(width: 5.w),
                                                CustomText(
                                                  'تعديل',
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 12),
                                          InkWell(
                                            onTap: () {
                                              HomeVendorApis.homeVendorApis
                                                  .deleteShip(myOfferModelData
                                                      .id
                                                      .toString());
                                            },
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 30.w,
                                                  height: 30.h,
                                                  padding: EdgeInsets.all(7.r),
                                                  alignment:
                                                      AlignmentDirectional
                                                          .center,
                                                  decoration: BoxDecoration(
                                                    color: AppColors.red
                                                        .withOpacity(0.1),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Icon(
                                                    Icons.delete,
                                                    size: 18.r,
                                                    color: AppColors.red,
                                                  ),
                                                ),
                                                SizedBox(width: 5.w),
                                                CustomText(
                                                  'حذف',
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
