import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/apis/home_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/user/bottom_nav_bar_controller.dart';
import 'package:yacht_booking/controller/user/home_user_controller.dart';
import 'package:yacht_booking/models/owners_model.dart';
import 'package:yacht_booking/view/user/company_details/company_details_screen.dart';
import 'package:yacht_booking/view/vendor/chat_details_provider_screen.dart';
import 'package:yacht_booking/view/widgets/cash_network_image_share.dart';
import 'package:yacht_booking/view/widgets/custom_bottom_sheet.dart';
import 'package:yacht_booking/view/widgets/custom_button.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';
import 'package:yacht_booking/view/widgets/icon_row.dart';
import 'package:yacht_booking/view/widgets/svg_row.dart';

import '../../../../apis/home_vendor_apis.dart';

class ServiceProvidersTap extends StatefulWidget {
  ServiceProvidersTap({
    Key key,
  }) : super(key: key);

  @override
  _ServiceProvidersTapState createState() => _ServiceProvidersTapState();
}

class _ServiceProvidersTapState extends State<ServiceProvidersTap> {
  final BottomNavBarController _bottomNavBarController = Get.find();
  HomeUserController homeUserController = Get.find();

  final List<String> checkboxListTile = [
    'رائج في الجوار أولاً',
    'المسافة من مكان الاهتمام',
    'تصنيف النجوم (الأعلى أولاً)',
    'تصنيف النجوم (الأقل أولاً)',
    'السعر (الأكثر أولاُ)',
    'السعر (الأقل أولاُ)',
  ];

  List<bool> valueCheck = [
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  setValueCh(int index) {
    for (var i = 0; i < valueCheck.length; i++) {
      valueCheck.setAll(i, i == index ? [true] : [false]);
      setState(() {});
    }
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    'متاح الآن',
                    fontWeight: FontWeight.bold,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        width: 79.w,
                        height: 30.h,
                        text: 'الفرز',
                        background: Colors.transparent,
                        fontColor: AppColors.primaryColor,
                        icon: SvgPicture.asset(Assets.getIconSvg('sort')),
                        isBorder: true,
                        fontSize: 12,
                        onTap: () {
                          customBottomSheet(
                            widget: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CheckboxListTile(
                                    value: valueCheck[0],
                                    contentPadding: EdgeInsets.all(0),
                                    title: CustomText(
                                      checkboxListTile[0],
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                    ),
                                    onChanged: (val) {
                                      setValueCh(0);
                                      homeUserController
                                          .getAllOwnersData.value.data
                                          .sort((a, b) =>
                                              double.parse(a.rate.toString())
                                                  .compareTo(double.parse(
                                                      b.rate.toString())));
                                    },
                                  ),
                                  CheckboxListTile(
                                    value: valueCheck[1],
                                    contentPadding: EdgeInsets.all(0),
                                    title: CustomText(
                                      checkboxListTile[1],
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                    ),
                                    onChanged: (val) {
                                      setValueCh(1);
                                    },
                                  ),
                                  CheckboxListTile(
                                    value: valueCheck[2],
                                    contentPadding: EdgeInsets.all(0),
                                    title: CustomText(
                                      checkboxListTile[2],
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                    ),
                                    onChanged: (val) {
                                      setValueCh(2);
                                    },
                                  ),
                                  CheckboxListTile(
                                    value: valueCheck[3],
                                    contentPadding: EdgeInsets.all(0),
                                    title: CustomText(
                                      checkboxListTile[3],
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                    ),
                                    onChanged: (val) {
                                      setValueCh(3);
                                    },
                                  ),
                                  CheckboxListTile(
                                    value: valueCheck[4],
                                    contentPadding: EdgeInsets.all(0),
                                    title: CustomText(
                                      checkboxListTile[4],
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                    ),
                                    onChanged: (val) {
                                      setValueCh(4);
                                    },
                                  ),
                                  CheckboxListTile(
                                    value: valueCheck[5],
                                    contentPadding: EdgeInsets.all(0),
                                    title: CustomText(
                                      checkboxListTile[5],
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                    ),
                                    onChanged: (val) {
                                      setValueCh(5);
                                    },
                                  ),
                                ]),
                          );
                        },
                      ),
                      SizedBox(width: 5.w),
                      CustomButton(
                        width: 79.w,
                        height: 30.h,
                        text: 'الخريطة',
                        icon: SvgPicture.asset(Assets.getIconSvg('maps')),
                        fontSize: 12,
                        onTap: () {
                          _bottomNavBarController.changeSelectedIndex(1);
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              homeUserController.getAllOwnersData.value.data == null
                  ? SizedBox(
                      height: 300.h,
                      child: Center(
                        child: Helper.loading(),
                      ),
                    )
                  : homeUserController.getAllOwnersData.value.data.isEmpty
                      ? SizedBox(
                          height: 300.h,
                          child: Center(
                            child: CustomText("لا يوجد مزودين"),
                          ),
                        )
                      : Container(
                          child: ListView.separated(
                            itemCount: homeUserController
                                .getAllOwnersData.value.data.length,
                            shrinkWrap: true,
                            primary: false,
                            padding: EdgeInsetsDirectional.zero,
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 10.h),
                            itemBuilder: (context, index) {
                              OwnersModelData ownersModelData =
                                  homeUserController
                                      .getAllOwnersData.value.data[index];
                              return InkWell(
                                onTap: () {
                                  HomeUserApis.homeUserApis.getOwnerDetails(
                                      ownersModelData.id.toString());
                                  Get.to(() => CompanyDetailsScreen());
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
                                              BorderRadiusDirectional.circular(
                                                  15.r),
                                        ),
                                        child: CachedNetworkImageShare(
                                          ownersModelData.photo,
                                          110.h,
                                          85.w,
                                          15,
                                        ),
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
                                                  padding: EdgeInsets.all(2.r),
                                                  child: Icon(
                                                    Icons.phone,
                                                    size: 17.r,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                CustomText(
                                                  '${ownersModelData.mobile}',
                                                  fontColor: Colors.black,
                                                  fontWeight: FontWeight.normal,
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
                                                      CrossAxisAlignment.center,
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
                                                      () =>
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
                                                        otherId: ownersModelData
                                                            .id
                                                            .toString(),
                                                        username:
                                                            ownersModelData
                                                                .name,
                                                      ),
                                                    );
                                                  },
                                                  child: SvgRow(
                                                    'messages',
                                                    'مراسلة فورية',
                                                    fontColor:
                                                        AppColors.primaryColor,
                                                    svgColor:
                                                        AppColors.primaryColor,
                                                    svgWidth: 14,
                                                    svgHeight: 14,
                                                  ),
                                                )
                                              ],
                                            ),
                                            // Row(
                                            //   mainAxisAlignment:
                                            //       MainAxisAlignment.spaceBetween,
                                            //   children: [
                                            //     // SvgRow('discount', 'خصم 20%'),
                                            //     Container(),
                                            //     ,
                                            //   ],
                                            // ),
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
            ],
          ),
        ),
      );
    });
  }
}
