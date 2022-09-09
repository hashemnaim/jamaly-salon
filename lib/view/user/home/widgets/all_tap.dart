import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
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

import '../../../../controller/user/auth_controller.dart';

class AllTap extends StatelessWidget {
  AllTap({
    Key key,
  }) : super(key: key);
  final List<String> imageList = ['ship_1', 'ship_2', 'ship_3'];
  HomeUserController homeUserController = Get.find();
  AuthController authController = Get.find();

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
                                log("getOwnersServiceByCategoryId");
                                HomeUserApis.homeUserApis
                                    .getOwnersServiceByCategoryId(
                                  categoriesModelData.id.toString(),
                                );
                                Get.to(() => ServiceProvidersService());
                              },
                              borderRadius: BorderRadius.circular(10.r),
                              child: Container(
                                width: 78.w,
                                height: 100.h,
                                margin: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 1),
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
                                        categoriesModelData.image,
                                        50.h,
                                        50.w,
                                        1,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    CustomText(
                                      '${categoriesModelData.title}',
                                      fontSize: 12,
                                      fontColor: const Color(0xFF161617),
                                      fontWeight: FontWeight.w600,
                                      // height: 1.92,
                                      // alignment: AlignmentDirectional.center,
                                    ),
                                    SizedBox(
                                      height: 7.h,
                                    ),
                                  ],
                                ),
                              ),
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
                                Get.to(
                                    () => ReservationConfirmationScreen(true));
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
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.r),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              RatingBar.builder(
                                                initialRating:
                                                    topRatOfferModelData.rate ==
                                                            null
                                                        ? 0
                                                        : double.parse(
                                                            topRatOfferModelData
                                                                .rate
                                                                .toString()),
                                                direction: Axis.horizontal,
                                                tapOnlyMode: true,
                                                ignoreGestures: true,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemSize: 16,
                                                itemPadding:
                                                    const EdgeInsets.symmetric(
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
            SizedBox(height: 28.h),
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
                          'طلبك حسب ميزانيتك',
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          fontColor: const Color(0xFF00A9CA),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    CustomText(
                      authController.settingAppData.value.settingAppData == null
                          ? ""
                          : authController
                              .settingAppData.value.settingAppData[0].orderText,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      fontSize: 13,
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
