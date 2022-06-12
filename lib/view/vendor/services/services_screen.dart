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
import 'package:yacht_booking/models/my_ship_model.dart';
import 'package:yacht_booking/view/vendor/add_new_service/add_new_service_screen.dart';
import 'package:yacht_booking/view/vendor/edit_service/edit_service_screen.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

import 'widgets/header_vendor.dart';

class ServicesScreen extends StatelessWidget {
  HomeVendorController homeVendorController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        // physics: ScrollableScrollPhysics(),
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
                        'الخدمات المتاحة الآن:',
                        fontWeight: FontWeight.bold,
                        fontColor: AppColors.primaryColor,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => AddNewServiceScreen());
                        },
                        borderRadius: BorderRadius.circular(10.r),
                        child: Container(
                          height: 35.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 5.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: Color(0xFFF2C409),
                          ),
                          child: CustomText(
                            'اضافه خدمه جديده',
                            fontColor: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  homeVendorController.getMyShipData.value.data == null
                      ? SizedBox(
                          height: 300.h,
                          child: Center(
                            child: Helper.loading(),
                          ),
                        )
                      : homeVendorController.getMyShipData.value.data.isEmpty
                          ? SizedBox(
                              height: 300.h,
                              child: Center(
                                child: CustomText("لا يوجد خدمات متاحة"),
                              ),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              primary: false,
                              padding: EdgeInsets.zero,
                              itemCount: homeVendorController
                                  .getMyShipData.value.data.length,
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 15.h);
                              },
                              itemBuilder: (context, index) {
                                MyShipModelData myShipModelData =
                                    homeVendorController
                                        .getMyShipData.value.data[index];
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
                                      CustomText(
                                        'الخدمات المقدمة  :',
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                      ),
                                      SizedBox(height: 10.h),
                                      SizedBox(
                                        height: 40.h,
                                        child:
                                            myShipModelData.servicesShip.isEmpty
                                                ? Center(
                                                    child: CustomText(
                                                        "لا يوجد خدمات"),
                                                  )
                                                : ListView.separated(
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
                                                                  myShipModelData.servicesShip[index2].services ==
                                                                              null ||
                                                                          myShipModelData.servicesShip[index2].services.icon ==
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
                                                                          child:
                                                                              CachedNetworkImage(imageUrl: myShipModelData.servicesShip[index2].services.icon),
                                                                        ),
                                                                  SizedBox(
                                                                      width:
                                                                          5.w),
                                                                  CustomText(
                                                                    myShipModelData.servicesShip[index2].services ==
                                                                            null
                                                                        ? ""
                                                                        : '${myShipModelData.servicesShip[index2].services.title ?? ""}',
                                                                    fontSize:
                                                                        10,
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
                                                    itemCount: myShipModelData
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
                                        ],
                                      ),
                                      SizedBox(height: 10.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              // SvgPicture.asset(
                                              //   Assets.getIconSvg('shape'),
                                              //   height: 15.r,
                                              //   width: 15.r,
                                              // ),
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
                                              '${myShipModelData.title ?? ""}',
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
                                                Assets.getIconSvg('time'),
                                                height: 15.r,
                                                width: 15.r,
                                              ),
                                              SizedBox(width: 5.w),
                                              CustomText(
                                                'سعر الخدمه',
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
                                              '${myShipModelData.price ?? "0"} درهم',
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
                                              '${myShipModelData.prepaid ?? "0"} درهم',
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
                                              '${myShipModelData.numberOfPersones ?? "0"}',
                                              fontSize: 10,
                                              fontColor:
                                                  AppColors.fontSecondaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.h),
                                      CustomText(
                                        'صور اليخت:',
                                        alignment:
                                            AlignmentDirectional.centerStart,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      SizedBox(height: 10.h),
                                      SizedBox(
                                        height: 74.h,
                                        child: myShipModelData
                                                .gallaryOwner.isEmpty
                                            ? Center(
                                                child: CustomText(
                                                    "لا يوجد صور في المعرض الخاص بك"),
                                              )
                                            : ListView.separated(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: myShipModelData
                                                    .gallaryOwner.length,
                                                separatorBuilder:
                                                    (context, index3) =>
                                                        SizedBox(width: 10.w),
                                                itemBuilder:
                                                    (context, index3) =>
                                                        Container(
                                                  height: 60.h,
                                                  width: 116.w,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r),
                                                    image: DecorationImage(
                                                      image: myShipModelData
                                                                  .gallaryOwner[
                                                                      index3]
                                                                  .imageUrl ==
                                                              null
                                                          ? AssetImage(
                                                              Assets.getImage(
                                                                  'ship_1'))
                                                          : CachedNetworkImageProvider(
                                                              myShipModelData
                                                                  .gallaryOwner[
                                                                      index3]
                                                                  .imageUrl),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      ),
                                      SizedBox(height: 15.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.to(EditServiceScreen(
                                                myShipModelData:
                                                    myShipModelData,
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
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  HomeVendorApis.homeVendorApis
                                                      .deleteShip(
                                                          myShipModelData.id
                                                              .toString());
                                                },
                                                child: Container(
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
                                              ),
                                              SizedBox(width: 5.w),
                                              CustomText(
                                                'حذف',
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ],
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
