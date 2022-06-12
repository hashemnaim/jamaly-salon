import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/apis/home_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/user/bottom_nav_bar_controller.dart';
import 'package:yacht_booking/controller/user/home_user_controller.dart';
import 'package:yacht_booking/models/vendor_service.dart';
import 'package:yacht_booking/view/user/company_details/company_details_screen.dart';
import 'package:yacht_booking/view/vendor/chat_details_provider_screen.dart';
import 'package:yacht_booking/view/widgets/cash_network_image_share.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';
import 'package:yacht_booking/view/widgets/icon_row.dart';
import 'package:yacht_booking/view/widgets/svg_row.dart';

import '../../../../common/assets.dart';
import 'header_widget.dart';

class ServiceProvidersService extends StatefulWidget {
  @override
  _ServiceProvidersServiceState createState() =>
      _ServiceProvidersServiceState();
}

class _ServiceProvidersServiceState extends State<ServiceProvidersService> {
  HomeUserController homeUserController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    Assets.getImage('ship_3'),
                  ),
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                    Colors.black26,
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                child: Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: 35.r,
                        color: Colors.white,
                      )),
                ),
              ),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: CustomText(
                          "مزودين الخدمه",
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          // textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  homeUserController
                              .getVendorsByCategoryIdServiceData.value.data ==
                          null
                      ? SizedBox(
                          height: 300.h,
                          child: Center(
                            child: Helper.loading(),
                          ),
                        )
                      : homeUserController.getVendorsByCategoryIdServiceData
                              .value.data.isEmpty
                          ? SizedBox(
                              height: 300.h,
                              child: Center(
                                child: CustomText("لا يوجد مزودين خدمات "),
                              ),
                            )
                          : ListView.separated(
                              itemCount: homeUserController
                                  .getVendorsByCategoryIdServiceData
                                  .value
                                  .data
                                  .length,
                              shrinkWrap: true,
                              primary: false,
                              padding: EdgeInsetsDirectional.zero,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 10.h),
                              itemBuilder: (context, index) {
                                VendorsServiceData ownersModelData =
                                    homeUserController
                                        .getVendorsByCategoryIdServiceData
                                        .value
                                        .data[index];
                                return InkWell(
                                  onTap: () {
                                    HomeUserApis.homeUserApis.getOwnerDetails(
                                        ownersModelData.id.toString());
                                    Get.to(CompanyDetailsScreen());
                                  },
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: Container(
                                    width: 335.w,
                                    height: 110.h,
                                    padding: EdgeInsetsDirectional.all(8.r),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      color: Colors.white,
                                      border: Border.all(
                                          width: 2.w,
                                          color: const Color(0xffe9e9ec)),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 85.w,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: ownersModelData.photo == null
                                                ? AppColors.hintColor
                                                : null,
                                            borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(15.r),
                                            // image: DecorationImage(
                                            //   image: AssetImage(Assets.getImage('bg')),
                                            //   fit: BoxFit.cover,
                                            // ),
                                          ),
                                          child: ownersModelData.photo == null
                                              ? SizedBox()
                                              : CachedNetworkImageShare(
                                                  ownersModelData.photo,
                                                  110.h,
                                                  85.w,
                                                  15),
                                        ),
                                        SizedBox(width: 5.w),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  IconRow(
                                                    Icons.person,
                                                    '${ownersModelData.name ?? ''}',
                                                  ),
                                                  IconRow(
                                                    Icons.star,
                                                    '${ownersModelData.rate ?? '0'}',
                                                    iconColor: AppColors.yellow,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ],
                                              ),
                                              IconRow(Icons.location_on,
                                                  '${ownersModelData.location ?? ''}'),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(2.r),
                                                    child: Icon(
                                                      Icons.phone,
                                                      size: 17.r,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  CustomText(
                                                    '${ownersModelData.mobile}',
                                                    fontColor: Colors.black,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 12,
                                                    textAlign: TextAlign.start,
                                                    alignment:
                                                        AlignmentDirectional
                                                            .centerStart,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(2.r),
                                                        child: Icon(
                                                          Icons.email_rounded,
                                                          size: 17.r,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      CustomText(
                                                        '${ownersModelData.email}',
                                                        fontColor: Colors.black,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 12,
                                                        textAlign:
                                                            TextAlign.start,
                                                        alignment:
                                                            AlignmentDirectional
                                                                .centerStart,
                                                      ),
                                                    ],
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Get.to(
                                                        Get.to(
                                                          ChatDetailsScreenProvider(
                                                            myId: homeUserController
                                                                .getProfileUserData
                                                                .value
                                                                .data
                                                                .id
                                                                .toString(),
                                                            imagename:
                                                                ownersModelData
                                                                    .photo,
                                                            otherId:
                                                                ownersModelData
                                                                    .id
                                                                    .toString(),
                                                            username:
                                                                ownersModelData
                                                                    .name,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: SvgRow(
                                                      'messages',
                                                      'مراسلة فورية',
                                                      fontColor: AppColors
                                                          .primaryColor,
                                                      svgColor: AppColors
                                                          .primaryColor,
                                                      svgWidth: 14,
                                                      svgHeight: 14,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
