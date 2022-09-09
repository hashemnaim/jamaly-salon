import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/apis/home_vendor_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/vendor/home_vendor_controller.dart';
import 'package:yacht_booking/controller/vendor/main_vendor_controller.dart';
import 'package:yacht_booking/models/my_ship_model.dart';
import 'package:yacht_booking/view/vendor/upgrade_account/upgrade_account_screen.dart';
import 'package:yacht_booking/view/widgets/custom_button.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

class StatisticsScreen extends StatelessWidget {
  HomeVendorController homeVendorController = Get.find();
  MainVendorController mainVendorController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            homeVendorController.homeStatsticData.value.data == null
                ? Container(
                    height: 300.h,
                    child: Center(
                      child: Helper.loading(),
                    ),
                  )
                : Column(
                    children: [
                      Container(
                        padding: EdgeInsetsDirectional.all(15.r),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: AppColors.boxShadow,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(Assets.getIconSvg('blue')),
                                SizedBox(width: 10.w),
                                CustomText(
                                  'مدة الاشتراك',
                                  alignment: AlignmentDirectional.centerStart,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ],
                            ),
                            SizedBox(width: 35.w),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        'يوم',
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      CustomText(
                                        '${homeVendorController.homeStatsticData.value.data.remainDays ?? ''}',
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        'شهر',
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      CustomText(
                                        '${homeVendorController.homeStatsticData.value.data.remainMonths ?? ''}',
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        'سنة',
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      CustomText(
                                        '${homeVendorController.homeStatsticData.value.data.remainYears ?? ''}',
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Container(
                        padding: EdgeInsetsDirectional.all(16.r),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: AppColors.boxShadow,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(Assets.getIconSvg('red')),
                                SizedBox(width: 10.w),
                                CustomText(
                                  'الترقية / الباقات',
                                  alignment: AlignmentDirectional.centerStart,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ],
                            ),
                            CustomButton(
                                text: "اشتراك",
                                height: 32.h,
                                width: 75.w,
                                fontSize: 14,
                                onTap: () {
                                  HomeVendorApis.homeVendorApis.getPlans();
                                  Get.to(() => UpgradeAccountScreen());
                                })
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 35.h,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            'خدماتي',
                            alignment: AlignmentDirectional.centerStart,
                            fontWeight: FontWeight.bold,
                          ),
                          InkWell(
                            onTap: () {
                              mainVendorController.changePageIndex(1);
                            },
                            child: CustomText(
                              'عرض الكل',
                              alignment: AlignmentDirectional.centerStart,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Container(
                        height: 90,
                        child: homeVendorController.getMyShipData.value.data ==
                                null
                            ? SizedBox(
                                height: 100.h,
                                child: Center(
                                  child: Helper.loading(),
                                ),
                              )
                            : homeVendorController
                                    .getMyShipData.value.data.isEmpty
                                ? SizedBox(
                                    height: 100.h,
                                    child: Center(
                                      child: CustomText("لا يوجد خدمات"),
                                    ),
                                  )
                                : ListView.separated(
                                    itemCount: homeVendorController
                                        .getMyShipData.value.data.length,
                                    scrollDirection: Axis.horizontal,
                                    separatorBuilder: (context, index) =>
                                        SizedBox(width: 10.w),
                                    itemBuilder: (context, index) {
                                      MyShipModelData myShipModelData =
                                          homeVendorController
                                              .getMyShipData.value.data[index];
                                      return InkWell(
                                        onTap: () {
                                          mainVendorController
                                              .changePageIndex(1);
                                        },
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        child: Container(
                                          width: 150.w,
                                          height: 80.h,
                                          padding:
                                              EdgeInsets.symmetric(vertical: 0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(10.r),
                                            image: DecorationImage(
                                              image: myShipModelData.image ==
                                                      null
                                                  ? AssetImage(
                                                      Assets.getImage('bg'))
                                                  : CachedNetworkImageProvider(
                                                      myShipModelData.image,
                                                    ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: 25.h,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadiusDirectional
                                                          .only(
                                                              topStart: Radius
                                                                  .circular(
                                                                      10.r),
                                                              topEnd: Radius
                                                                  .circular(
                                                                      10.r)),
                                                  color: Colors.transparent
                                                      .withOpacity(0.5),
                                                ),
                                                child: Center(
                                                  child: CustomText(
                                                    '${myShipModelData.title}',
                                                    fontColor: Colors.white,
                                                    textAlign: TextAlign.center,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),

                                              // Padding(
                                              //   padding: const EdgeInsets.only(
                                              //       top: 8),
                                              //   child: Stack(
                                              //     children: [
                                              //       Align(
                                              //         alignment:
                                              //             Alignment.topRight,
                                              //         child: SvgPicture.asset(
                                              //           Assets.getIconSvg(
                                              //               'path2'),
                                              //           width: 20.w,
                                              //           height: 25.h,
                                              //           color: AppColors
                                              //               .primaryColor
                                              //               .withOpacity(0.6),
                                              //           fit: BoxFit.cover,
                                              //         ),
                                              //       ),
                                              //       Positioned(
                                              //         right: 10,
                                              //         top: 5,
                                              //         child: Center(
                                              //           child: CustomText(
                                              //             '${myShipModelData.title}',
                                              //             fontColor:
                                              //                 Colors.white,
                                              //             textAlign:
                                              //                 TextAlign.center,
                                              //             fontWeight:
                                              //                 FontWeight.bold,
                                              //             fontSize: 13,
                                              //           ),
                                              //         ),
                                              //       ),

                                              //       //             ),
                                              //       //           ],
                                              //       //         ),
                                              //       //       ),
                                              //       //     ),
                                              //       //   ],
                                              //       // ),
                                              //     ],
                                              //   ),
                                              // ),

                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  RatingBar.builder(
                                                    initialRating:
                                                        myShipModelData.rate ==
                                                                null
                                                            ? 0
                                                            : double.parse(
                                                                myShipModelData
                                                                    .rate
                                                                    .toString()),
                                                    direction: Axis.horizontal,
                                                    tapOnlyMode: true,
                                                    ignoreGestures: true,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemSize: 16,
                                                    itemPadding:
                                                        const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 1.0),
                                                    itemBuilder: (context, _) =>
                                                        const Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                      size: 1,
                                                    ),
                                                    onRatingUpdate: (rating) =>
                                                        null,
                                                  ),
                                                  SizedBox(width: 5.w),
                                                  CustomText(
                                                    '5.0',
                                                    fontColor: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            'العروض الخاصة بي',
                            alignment: AlignmentDirectional.centerStart,
                            fontWeight: FontWeight.bold,
                          ),
                          InkWell(
                            onTap: () {
                              mainVendorController.changePageIndex(3);
                            },
                            child: CustomText(
                              'عرض الكل',
                              alignment: AlignmentDirectional.centerStart,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Container(
                        height: 90,
                        child: homeVendorController.getMyOfferData.value.data ==
                                null
                            ? SizedBox(
                                height: 100.h,
                                child: Center(
                                  child: Helper.loading(),
                                ),
                              )
                            : homeVendorController
                                    .getMyOfferData.value.data.isEmpty
                                ? SizedBox(
                                    height: 100.h,
                                    child: Center(
                                      child: CustomText("لا يوجد عروض"),
                                    ),
                                  )
                                : ListView.separated(
                                    itemCount: homeVendorController
                                        .getMyOfferData.value.data.length,
                                    scrollDirection: Axis.horizontal,
                                    separatorBuilder: (context, index) =>
                                        SizedBox(width: 10.w),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          mainVendorController
                                              .changePageIndex(3);
                                        },
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        child: Container(
                                          width: 150.w,
                                          height: 80.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(10.r),
                                            image: DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                homeVendorController
                                                    .getMyOfferData
                                                    .value
                                                    .data[index]
                                                    .image,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: 25.h,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadiusDirectional
                                                          .only(
                                                              topStart: Radius
                                                                  .circular(
                                                                      10.r),
                                                              topEnd: Radius
                                                                  .circular(
                                                                      10.r)),
                                                  color: Colors.transparent
                                                      .withOpacity(0.5),
                                                ),
                                                child: Center(
                                                  child: CustomText(
                                                    '${homeVendorController.getMyOfferData.value.data[index].title}',
                                                    fontColor: Colors.white,
                                                    textAlign: TextAlign.center,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),

                                              // Padding(
                                              //   padding: const EdgeInsets.only(
                                              //       top: 8),
                                              //   child: Stack(
                                              //     children: [
                                              //       Align(
                                              //         alignment:
                                              //             Alignment.topRight,
                                              //         child: SvgPicture.asset(
                                              //           Assets.getIconSvg(
                                              //               'path2'),
                                              //           width: 20.w,
                                              //           height: 25.h,
                                              //           color: AppColors
                                              //               .primaryColor
                                              //               .withOpacity(0.6),
                                              //           fit: BoxFit.cover,
                                              //         ),
                                              //       ),
                                              //       Positioned(
                                              //         right: 10,
                                              //         top: 5,
                                              //         child: Center(
                                              //           child: CustomText(
                                              //             '${homeVendorController.getMyOfferData.value.data[index].title}',
                                              //             fontColor:
                                              //                 Colors.white,
                                              //             textAlign:
                                              //                 TextAlign.center,
                                              //             fontWeight:
                                              //                 FontWeight.bold,
                                              //             fontSize: 13,
                                              //           ),
                                              //         ),
                                              //       ),
                                              //     ],
                                              //   ),
                                              // ),

                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  RatingBar.builder(
                                                    initialRating: homeVendorController
                                                                .getMyOfferData
                                                                .value
                                                                .data[index]
                                                                .rate ==
                                                            null
                                                        ? 0
                                                        : double.parse(
                                                            homeVendorController
                                                                .getMyOfferData
                                                                .value
                                                                .data[index]
                                                                .rate
                                                                .toString()),
                                                    direction: Axis.horizontal,
                                                    tapOnlyMode: true,
                                                    ignoreGestures: true,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemSize: 16,
                                                    itemPadding:
                                                        const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 1.0),
                                                    itemBuilder: (context, _) =>
                                                        const Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                      size: 1,
                                                    ),
                                                    onRatingUpdate: (rating) =>
                                                        null,
                                                  ),
                                                  SizedBox(width: 5.w),
                                                  CustomText(
                                                    '5.0',
                                                    fontColor: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                      ),
                      SizedBox(
                        height: 35.h,
                      ),
                      // Container(
                      //   padding: EdgeInsetsDirectional.all(15.r),
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     boxShadow: AppColors.boxShadow,
                      //     borderRadius: BorderRadius.circular(10.r),
                      //   ),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Row(
                      //             children: [
                      //               SvgPicture.asset(Assets.getIconSvg('red')),
                      //               SizedBox(width: 10.w),
                      //               CustomText(
                      //                 'اجمالي الحجوزات',
                      //                 alignment: AlignmentDirectional.centerStart,
                      //                 fontWeight: FontWeight.bold,
                      //                 fontSize: 12,
                      //               ),
                      //             ],
                      //           ),
                      //           SizedBox(height: 5.h),
                      //           Row(
                      //             children: [
                      //               Row(
                      //                 children: [
                      //                   Container(
                      //                     width: 8.r,
                      //                     height: 8.r,
                      //                     margin: EdgeInsetsDirectional.only(start: 3.w),
                      //                     decoration: BoxDecoration(
                      //                       shape: BoxShape.circle,
                      //                       color: Color(0xff00CA0D),
                      //                     ),
                      //                   ),
                      //                   SizedBox(width: 5.w),
                      //                   CustomText('الحجوزات الجديدة: ${homeVendorController.homeStatsticData.value.data.newOrders}',fontSize: 10),
                      //                 ],
                      //               ),
                      //               SizedBox(width: 10.w),
                      //               Row(
                      //                 children: [
                      //                   Container(
                      //                     width: 8.r,
                      //                     height: 8.r,
                      //                     decoration: BoxDecoration(
                      //                       shape: BoxShape.circle,
                      //                       color: Color(0xffED7B62),
                      //                     ),
                      //                   ),
                      //                   SizedBox(width: 5.w),
                      //                   CustomText('الحجوزات المنتهية: ${homeVendorController.homeStatsticData.value.data.finishedOrders}',fontSize: 10),
                      //                 ],
                      //               ),
                      //             ],
                      //           ),
                      //         ],
                      //       ),
                      //       CircularPercentIndicator(
                      //         radius: 60.0,
                      //         lineWidth: 5.0,
                      //         percent: 1.0,
                      //         center: Text("${homeVendorController.homeStatsticData.value.data.ordersRatio}%"),
                      //         progressColor: Color(0xffED7B62),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(height: 15.h),
                      // Container(
                      //   padding: EdgeInsetsDirectional.all(15.r),
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     boxShadow: AppColors.boxShadow,
                      //     borderRadius: BorderRadius.circular(10.r),
                      //   ),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Row(
                      //             children: [
                      //               SvgPicture.asset(Assets.getIconSvg('red')),
                      //               SizedBox(width: 10.w),
                      //               CustomText(
                      //                 'اجمالي الحجوزات',
                      //                 alignment: AlignmentDirectional.centerStart,
                      //                 fontWeight: FontWeight.bold,
                      //                 fontSize: 12,
                      //               ),
                      //             ],
                      //           ),
                      //           SizedBox(height: 5.h),
                      //           Row(
                      //             children: [
                      //               Row(
                      //                 children: [
                      //                   Container(
                      //                     width: 8.r,
                      //                     height: 8.r,
                      //                     margin: EdgeInsetsDirectional.only(start: 3.w),
                      //                     decoration: BoxDecoration(
                      //                       shape: BoxShape.circle,
                      //                       color: Color(0xff00A9CA),
                      //                     ),
                      //                   ),
                      //                   SizedBox(width: 5.w),
                      //                   CustomText('${homeVendorController.homeStatsticData.value.data.ordersIncom} درهم',fontSize: 10),
                      //                 ],
                      //               ),
                      //             ],
                      //           ),
                      //         ],
                      //       ),
                      //       // CircularPercentIndicator(
                      //       //   radius: 60.0,
                      //       //   lineWidth: 5.0,
                      //       //   percent: 1.0,
                      //       //   center: Text("100%"),
                      //       //   progressColor: Color(0xff00A9CA),
                      //       // )
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(height: 15.h),
                      // Container(
                      //   padding: EdgeInsetsDirectional.all(15.r),
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     boxShadow: AppColors.boxShadow,
                      //     borderRadius: BorderRadius.circular(10.r),
                      //   ),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Row(
                      //             children: [
                      //               SvgPicture.asset(Assets.getIconSvg('red'),color: Color(0xffA80AD8),),
                      //               SizedBox(width: 10.w),
                      //               CustomText(
                      //                 'أكثر المناطق طلباً',
                      //                 alignment: AlignmentDirectional.centerStart,
                      //                 fontWeight: FontWeight.bold,
                      //                 fontSize: 12,
                      //               ),
                      //             ],
                      //           ),
                      //           SizedBox(height: 5.h),
                      //           Row(
                      //             children: [
                      //               Container(
                      //                 width: 8.r,
                      //                 height: 8.r,
                      //                 margin: EdgeInsetsDirectional.only(start: 3.w),
                      //                 decoration: BoxDecoration(
                      //                   shape: BoxShape.circle,
                      //                   color: Color(0xffA80AD8),
                      //                 ),
                      //               ),
                      //               SizedBox(width: 5.w),
                      //               CustomText('${homeVendorController.homeStatsticData.value.data.topArea}',fontSize: 10),
                      //             ],
                      //           ),
                      //         ],
                      //       ),
                      //       CircularPercentIndicator(
                      //         radius: 60.0,
                      //         lineWidth: 5.0,
                      //         percent: 1.0,
                      //         center: Text("${homeVendorController.homeStatsticData.value.data.topAreaOrders}"),
                      //         progressColor: Color(0xffA80AD8),
                      //       )
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
          ],
        ),
      );
    });
  }
}
