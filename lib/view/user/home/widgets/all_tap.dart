import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:yacht_booking/apis/home_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/user/home_user_controller.dart';
import 'package:yacht_booking/models/advertisment_model.dart';
import 'package:yacht_booking/models/categories_model.dart';
import 'package:yacht_booking/models/top_rat_offer_model.dart';
import 'package:yacht_booking/view/user/home/widgets/service_providers_service.dart';
import 'package:yacht_booking/view/user/reservation_confirmation/reservation_confirmation_screen.dart';
import 'package:yacht_booking/view/user/submit_request/submit_request_screen.dart';
import 'package:yacht_booking/view/widgets/cash_network_image_share.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

class AllTap extends StatelessWidget {
  AllTap({
    Key key,
  }) : super(key: key);
  final List<String> imageList = ['ship_1', 'ship_2', 'ship_3'];
  HomeUserController homeUserController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  'التصنيفات الرئيسية',
                  alignment: AlignmentDirectional.centerStart,
                  fontWeight: FontWeight.bold,
                ),
                // CustomText(
                //   'عرض الكل',
                //   alignment: AlignmentDirectional.centerStart,
                //   fontWeight: FontWeight.bold,
                //   fontSize: 11,
                // ),
              ],
            ),
            SizedBox(height: 5.h),
            Container(
              height: 90,
              child: homeUserController.getCategoriesData.value.data == null
                  ? SizedBox(
                      height: 70.h,
                      child: Center(
                          child: ListView.separated(
                              itemCount: 5,
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: 10.w),
                              itemBuilder: (context, index) => ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    "assets/images/loading.gif",
                                    width: 100,
                                  )))),
                    )
                  : homeUserController.getCategoriesData.value.data.isEmpty
                      ? SizedBox(
                          height: 100.h,
                          child: Center(
                            child: CustomText("لا يوجد تصنيفات"),
                          ),
                        )
                      : ListView.separated(
                          itemCount: homeUserController
                              .getCategoriesData.value.data.length,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 10.w),
                          itemBuilder: (context, index) {
                            CategoriesModelData categoriesModelData =
                                homeUserController
                                    .getCategoriesData.value.data[index];
                            return InkWell(
                              onTap: () {
                                HomeUserApis.homeUserApis
                                    .getOwnersServiceByCategoryId(
                                  categoriesModelData.id.toString(),
                                );
                                Get.to(() => ServiceProvidersService());
                              },
                              borderRadius: BorderRadius.circular(10.r),
                              child: Container(
                                width: 80.w,
                                height: 100.h,
                                margin: EdgeInsets.symmetric(vertical: 10.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9.0),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.07),
                                      offset: Offset(0, 3.0),
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: CachedNetworkImageShare(
                                          categoriesModelData.image, 48, 48, 1),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    CustomText(
                                      '${categoriesModelData.title}',
                                      fontSize: 12.0,
                                      fontColor: const Color(0xFF161617),
                                      fontWeight: FontWeight.w600,
                                      // height: 1.92,
                                      alignment: AlignmentDirectional.center,
                                    ),
                                    SizedBox(
                                      height: 7.h,
                                    ),
                                  ],
                                ),
                              ),
                              // child: Container(
                              //   width: 150.w,
                              //   height: 80.h,
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(10.r),
                              //     border: Border.all(
                              //       width: 1.2,
                              //       color: Colors.grey,
                              //     ),
                              //     image: DecorationImage(
                              //       image: categoriesModelData.image == null
                              //           ? AssetImage(Assets.getImage('bg'))
                              //           : CachedNetworkImageProvider(
                              //               categoriesModelData.image,
                              //             ),
                              //       fit: BoxFit.cover,
                              //     ),
                              //   ),
                              //   child: Padding(
                              //     padding: EdgeInsetsDirectional.all(5.r),
                              //     child: Column(
                              //       mainAxisAlignment:
                              //           MainAxisAlignment.spaceBetween,
                              //       children: [
                              //         CustomText(
                              //           '${categoriesModelData.title}',
                              //           fontColor: AppColors.primaryColor,
                              //           fontWeight: FontWeight.bold,
                              //           alignment:
                              //               AlignmentDirectional.centerStart,
                              //           fontSize: 16,
                              //         ),
                              //         // Row(
                              //         //   mainAxisAlignment:
                              //         //       MainAxisAlignment.end,
                              //         //   children: [
                              //         //     SmoothStarRating(
                              //         //       allowHalfRating: false,
                              //         //       onRated: (v) {},
                              //         //       starCount: 5,
                              //         //       rating: 4.5,
                              //         //       size: 15.r,
                              //         //       isReadOnly: true,
                              //         //       color: AppColors.yellow,
                              //         //       borderColor: AppColors.yellow,
                              //         //       spacing: 0.0,
                              //         //     ),
                              //         //     SizedBox(width: 5.w),
                              //         //     CustomText(
                              //         //       '5.0',
                              //         //       fontColor: Colors.white,
                              //         //       fontWeight: FontWeight.bold,
                              //         //       fontSize: 12,
                              //         //     ),
                              //         //   ],
                              //         // )
                              //       ],
                              //     ),
                              //   ),
                              // ),
                            );
                          },
                        ),
            ),
            SizedBox(height: 10.h),
            homeUserController.getAdvertismentsData.value.data == null
                ? SizedBox(
                    height: 115.h,
                    child: Center(
                        child: ListView.separated(
                            itemCount: 1,
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 10.w),
                            itemBuilder: (context, index) => ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  "assets/images/loading.gif",
                                  fit: BoxFit.fitWidth,
                                  width: 400,
                                  height: 115,
                                )))),
                  )
                : homeUserController.getAdvertismentsData.value.data.isEmpty
                    ? SizedBox(
                        height: 100.h,
                        child: Center(
                          child: CustomText("لا يوجد إعلانات"),
                        ),
                      )
                    : CarouselSlider(
                        items: List.generate(
                          homeUserController
                              .getAdvertismentsData.value.data.length,
                          (index) {
                            AdvertismentModelData advertismentModelData =
                                homeUserController
                                    .getAdvertismentsData.value.data[index];

                            return Padding(
                              padding: const EdgeInsetsDirectional.only(top: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(15.r),
                                ),
                                child: Stack(
                                  children: [
                                    CachedNetworkImageShare(
                                      advertismentModelData.image,
                                      115.h,
                                      312.w,
                                      15,
                                    ),
                                    PositionedDirectional(
                                      top: 10.w,
                                      child: Container(
                                        height: 35.h,
                                        width: 70.w,
                                        // decoration: BoxDecoration(
                                        //   color: AppColors.primaryColor,
                                        //   borderRadius:
                                        //       BorderRadiusDirectional.only(
                                        //     bottomEnd: Radius.circular(15.r),
                                        //     topEnd: Radius.circular(15.r),
                                        //   ),
                                        //   boxShadow: AppColors.boxShadow,
                                        // ),
                                        child: Stack(
                                          children: [
                                            SvgPicture.asset(
                                              Assets.getIconSvg('path1'),
                                              width: 70.w,
                                              height: 35.h,
                                              fit: BoxFit.contain,
                                            ),
                                            Positioned(
                                              top: 0,
                                              left: 35,
                                              right: 0,
                                              bottom: 0,
                                              child: Center(
                                                child: CustomText(
                                                  'اعلان',
                                                  fontWeight: FontWeight.w600,
                                                  fontColor: Colors.white,
                                                  fontSize: 13,
                                                  // height: 1.75,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        options: CarouselOptions(
                          height: 115.h,
                          aspectRatio: 15.w / 9.h,
                          viewportFraction: 0.8,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  'عروض مميزة',
                  alignment: AlignmentDirectional.centerStart,
                  fontWeight: FontWeight.bold,
                ),
                InkWell(
                  onTap: () {
                    homeUserController.tabController.animateTo(3);
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
            SizedBox(height: 10.h),
            Container(
              height: 110,
              child: homeUserController.getTopRatedOffersData.value.data == null
                  ? Center(
                      child: SizedBox(
                      height: 180.h,
                      child: Center(
                          child: ListView.separated(
                              itemCount: 3,
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: 10.w),
                              itemBuilder: (context, index) => ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    "assets/images/loading.gif",
                                  )))),
                    ))
                  : homeUserController.getTopRatedOffersData.value.data.isEmpty
                      ? SizedBox(
                          height: 100.h,
                          child: Center(
                            child: CustomText("لا يوجد عروض"),
                          ),
                        )
                      : ListView.separated(
                          itemCount: homeUserController
                              .getTopRatedOffersData.value.data.length,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 10.w),
                          itemBuilder: (context, index) {
                            TopRatOfferModelData topRatOfferModelData =
                                homeUserController
                                    .getTopRatedOffersData.value.data[index];
                            return InkWell(
                              onTap: () {
                                HomeUserApis.homeUserApis.getShipDetails(
                                    topRatOfferModelData.id.toString());
                                Get.to(ReservationConfirmationScreen(true));
                              },
                              borderRadius: BorderRadius.circular(10.r),
                              child: Container(
                                width: 180.w,
                                height: 60.h,
                                // padding: EdgeInsetsDirectional.all(5.r),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(10.r),
                                  image: DecorationImage(
                                    image: topRatOfferModelData.image == null
                                        ? AssetImage(Assets.getImage('ship_3'))
                                        : CachedNetworkImageProvider(
                                            topRatOfferModelData.image,
                                          ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 180.w,
                                      height: 100.h,
                                      // padding: EdgeInsetsDirectional.all(5.r),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadiusDirectional.circular(
                                                10.r),
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.black,
                                            Colors.black.withOpacity(0.4),
                                            Colors.black.withOpacity(0.3),
                                            Colors.black.withOpacity(0.2),
                                            Colors.black.withOpacity(0.1),
                                            Colors.black.withOpacity(0),
                                          ],
                                        ),
                                      ),
                                    ),
                                    PositionedDirectional(
                                      top: 7.w,
                                      child: Stack(
                                        children: [
                                          SvgPicture.asset(
                                            Assets.getIconSvg('path2'),
                                            // width: 90.w,
                                            height: 25.h,
                                            fit: BoxFit.contain,
                                          ),
                                          Positioned(
                                            top: 0,
                                            left: 0,
                                            right: 0,
                                            bottom: 0,
                                            child: Center(
                                              child: CustomText(
                                                Helper.limitString(
                                                    topRatOfferModelData.title,
                                                    15),
                                                fontWeight: FontWeight.bold,
                                                fontColor: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      // child: Container(
                                      //   height: 35.h,
                                      //   width: 70.w,
                                      //   decoration: BoxDecoration(
                                      //     color: AppColors.primaryColor,
                                      //     borderRadius:
                                      //         BorderRadiusDirectional.only(
                                      //       bottomEnd: Radius.circular(15.r),
                                      //       topEnd: Radius.circular(15.r),
                                      //     ),
                                      //     boxShadow: AppColors.boxShadow,
                                      //   ),
                                      //   child: CustomText(
                                      //     Helper.limitString(
                                      //         topRatOfferModelData.title, 15),
                                      //     fontWeight: FontWeight.bold,
                                      //     fontColor: Colors.white,
                                      //     fontSize: 12,
                                      //   ),
                                      // ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.r),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          // CustomText(
                                          //   '${topRatOfferModelData.title ?? ''}',
                                          //   fontColor: Colors.white,
                                          //   fontWeight: FontWeight.bold,
                                          //   alignment: AlignmentDirectional
                                          //       .centerStart,
                                          //   fontSize: 18,
                                          // ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              SmoothStarRating(
                                                  allowHalfRating: false,
                                                  onRated: (v) {},
                                                  starCount: 5,
                                                  rating: topRatOfferModelData
                                                              .rate ==
                                                          null
                                                      ? 0
                                                      : double.parse(
                                                              topRatOfferModelData
                                                                  .rate
                                                                  .toString()) ??
                                                          0,
                                                  size: 15,
                                                  isReadOnly: true,
                                                  color: AppColors.yellow,
                                                  borderColor: AppColors.yellow,
                                                  spacing: 0.0),
                                              SizedBox(width: 5.w),
                                              CustomText(
                                                '${topRatOfferModelData.rate ?? 0}',
                                                fontColor: Colors.white,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
            SizedBox(height: 15.h),
            InkWell(
              onTap: () {
                Get.to(() => SubmitRequestScreen());
              },
              borderRadius: BorderRadius.circular(15.r),
              child: Container(
                width: double.infinity,
                padding: EdgeInsetsDirectional.all(15.r),
                decoration: BoxDecoration(
                  color: Color(0xffF6F6F7),
                  boxShadow: AppColors.boxShadow,
                  borderRadius: BorderRadiusDirectional.circular(15.r),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          Assets.getIconSvg('order'),
                          fit: BoxFit.contain,
                          width: 30.r,
                          height: 30.r,
                        ),
                        SizedBox(width: 5.w),
                        CustomText(
                          'حجزك حسب ميزانيتك',
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.bold,
                          fontSize: 11.0,
                          fontColor: const Color(0xFF00A9CA),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    CustomText(
                      'اختر نوع الخدمه المناسبة لميزانيتك من خلال الضغط على حجزك الخدمه',
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      fontSize: 10.0,
                      fontColor: const Color(0xFF161617).withOpacity(0.6),
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
