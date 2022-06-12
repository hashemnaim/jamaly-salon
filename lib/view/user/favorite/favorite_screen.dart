import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/apis/home_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/user/home_user_controller.dart';
import 'package:yacht_booking/models/favorite_model.dart';
import 'package:yacht_booking/view/user/favorite/widgets/favorite_card_vendor.dart';
import 'package:yacht_booking/view/widgets/custom_app_bar.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

import 'widgets/favorite_card.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  HomeUserController homeUserController = Get.find();
  int selectedTab = 1;

  setSelectedTab(int value) {
    this.selectedTab = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: CustomAppBar(
          title: 'المفضلة',
          isBack: false,
        ),
        body: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  children: [
                    // Expanded(
                    //     child: InkWell(
                    //   onTap: () {
                    //     setSelectedTab(0);
                    //   },
                    //   child: Container(
                    //     height: 40.h,
                    //     decoration: BoxDecoration(
                    //         border: selectedTab == 0
                    //             ? Border(
                    //                 bottom: BorderSide(
                    //                     color: AppColors.primaryColor,
                    //                     width: 2))
                    //             : null),
                    //     child: Center(
                    //       child: CustomText(
                    //         "الخدمات",
                    //         fontWeight: FontWeight.w700,
                    //         fontColor: selectedTab == 0
                    //             ? AppColors.primaryColor
                    //             : AppColors.fontPrimaryColor,
                    //       ),
                    //     ),
                    //   ),
                    // )),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        setSelectedTab(1);
                      },
                      child: Container(
                        height: 40.h,
                        decoration: BoxDecoration(
                            border: selectedTab == 1
                                ? Border(
                                    bottom: BorderSide(
                                        color: AppColors.primaryColor,
                                        width: 2))
                                : null),
                        child: Center(
                          child: CustomText(
                            "العروض",
                            fontWeight: FontWeight.w700,
                            fontColor: selectedTab == 1
                                ? AppColors.primaryColor
                                : AppColors.fontPrimaryColor,
                          ),
                        ),
                      ),
                    )),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        setSelectedTab(2);
                      },
                      child: Container(
                        height: 40.h,
                        decoration: BoxDecoration(
                            border: selectedTab == 2
                                ? Border(
                                    bottom: BorderSide(
                                        color: AppColors.primaryColor,
                                        width: 2))
                                : null),
                        child: Center(
                          child: CustomText(
                            "مزودين الخدمه",
                            fontWeight: FontWeight.w700,
                            fontColor: selectedTab == 2
                                ? AppColors.primaryColor
                                : AppColors.fontPrimaryColor,
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                selectedTab == 0
                    ? Container(
                        child: homeUserController
                                    .getFavouritesShipsData.value.data ==
                                null
                            ? Center(
                                child: Helper.loading(),
                              )
                            : homeUserController
                                    .getFavouritesShipsData.value.data.isEmpty
                                ? Container(
                                    height: 300.h,
                                    child: Center(
                                      child:
                                          CustomText("لا يوجد عناصر بالمفضلة"),
                                    ),
                                  )
                                : SingleChildScrollView(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.w, vertical: 15.h),
                                    physics: BouncingScrollPhysics(),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ListView.separated(
                                          itemCount: homeUserController
                                              .getFavouritesShipsData
                                              .value
                                              .data
                                              .length,
                                          shrinkWrap: true,
                                          primary: false,
                                          physics: BouncingScrollPhysics(),
                                          padding: EdgeInsetsDirectional.zero,
                                          separatorBuilder: (context, index) =>
                                              SizedBox(height: 10.h),
                                          itemBuilder: (context, index) {
                                            FavoriteModelData
                                                favoriteModelData =
                                                homeUserController
                                                    .getFavouritesShipsData
                                                    .value
                                                    .data[index];
                                            return Dismissible(
                                              key: UniqueKey(),
                                              onDismissed:
                                                  (DismissDirection direction) {
                                                HomeUserApis.homeUserApis
                                                    .deleteFavoriteShip(
                                                        favoriteModelData
                                                            .ships.id
                                                            .toString(),
                                                        "1");
                                              },
                                              background: Container(
                                                width: 48.r,
                                                height: 48.r,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.r),
                                                  color: Color(0xffffe6e6),
                                                ),
                                                child: Row(
                                                  children: [
                                                    SizedBox(width: 15.w),
                                                    Icon(
                                                      Icons.delete_outline,
                                                      size: 35.r,
                                                      color: Colors.red
                                                          .withOpacity(0.8),
                                                    ),
                                                    Spacer(),
                                                  ],
                                                ),
                                              ),
                                              child: FavoriteCard(
                                                favoriteModelData:
                                                    favoriteModelData,
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                      )
                    : selectedTab == 1
                        ? Container(
                            child: homeUserController
                                        .getFavouritesOfferData.value.data ==
                                    null
                                ? Center(
                                    child: Helper.loading(),
                                  )
                                : homeUserController.getFavouritesOfferData
                                        .value.data.isEmpty
                                    ? Container(
                                        height: 300.h,
                                        child: Center(
                                          child: CustomText(
                                              "لا يوجد عناصر بالمفضلة"),
                                        ),
                                      )
                                    : SingleChildScrollView(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15.w, vertical: 15.h),
                                        physics: BouncingScrollPhysics(),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ListView.separated(
                                              itemCount: homeUserController
                                                  .getFavouritesOfferData
                                                  .value
                                                  .data
                                                  .length,
                                              shrinkWrap: true,
                                              primary: false,
                                              physics: BouncingScrollPhysics(),
                                              padding:
                                                  EdgeInsetsDirectional.zero,
                                              separatorBuilder:
                                                  (context, index) =>
                                                      SizedBox(height: 10.h),
                                              itemBuilder: (context, index) {
                                                FavoriteModelData
                                                    favoriteModelData =
                                                    homeUserController
                                                        .getFavouritesOfferData
                                                        .value
                                                        .data[index];
                                                return Dismissible(
                                                  key: UniqueKey(),
                                                  onDismissed: (DismissDirection
                                                      direction) {
                                                    HomeUserApis.homeUserApis
                                                        .deleteFavoriteShip(
                                                            favoriteModelData
                                                                .ships.id
                                                                .toString(),
                                                            "2");
                                                  },
                                                  background: Container(
                                                    width: 48.r,
                                                    height: 48.r,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12.r),
                                                      color: Color(0xffffe6e6),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(width: 15.w),
                                                        Icon(
                                                          Icons.delete_outline,
                                                          size: 35.r,
                                                          color: Colors.red
                                                              .withOpacity(0.8),
                                                        ),
                                                        Spacer(),
                                                      ],
                                                    ),
                                                  ),
                                                  child: FavoriteCard(
                                                    favoriteModelData:
                                                        favoriteModelData,
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                          )
                        : selectedTab == 2
                            ? Container(
                                child: homeUserController
                                            .getFavouritesVendorData
                                            .value
                                            .data ==
                                        null
                                    ? Center(
                                        child: Helper.loading(),
                                      )
                                    : homeUserController.getFavouritesVendorData
                                            .value.data.isEmpty
                                        ? Container(
                                            height: 300.h,
                                            child: Center(
                                              child: CustomText(
                                                  "لا يوجد عناصر بالمفضلة"),
                                            ),
                                          )
                                        : SingleChildScrollView(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15.w,
                                                vertical: 15.h),
                                            physics: BouncingScrollPhysics(),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                ListView.separated(
                                                  itemCount: homeUserController
                                                      .getFavouritesVendorData
                                                      .value
                                                      .data
                                                      .length,
                                                  shrinkWrap: true,
                                                  primary: false,
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  padding: EdgeInsetsDirectional
                                                      .zero,
                                                  separatorBuilder: (context,
                                                          index) =>
                                                      SizedBox(height: 10.h),
                                                  itemBuilder:
                                                      (context, index) {
                                                    FavoriteModelData
                                                        favoriteModelData =
                                                        homeUserController
                                                            .getFavouritesVendorData
                                                            .value
                                                            .data[index];
                                                    return Dismissible(
                                                      key: UniqueKey(),
                                                      onDismissed:
                                                          (DismissDirection
                                                              direction) {
                                                        HomeUserApis
                                                            .homeUserApis
                                                            .deleteFavoriteShip(
                                                                favoriteModelData
                                                                    .vendors.id
                                                                    .toString(),
                                                                "3");
                                                      },
                                                      background: Container(
                                                        width: 48.r,
                                                        height: 48.r,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12.r),
                                                          color:
                                                              Color(0xffffe6e6),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                                width: 15.w),
                                                            Icon(
                                                              Icons
                                                                  .delete_outline,
                                                              size: 35.r,
                                                              color: Colors.red
                                                                  .withOpacity(
                                                                      0.8),
                                                            ),
                                                            Spacer(),
                                                          ],
                                                        ),
                                                      ),
                                                      child: FavoriteCardVendor(
                                                        favoriteModelData:
                                                            favoriteModelData,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                              )
                            : SizedBox()
              ],
            )),
      );
    });
  }
}
