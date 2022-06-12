import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:yacht_booking/apis/home_apis.dart';
import 'package:yacht_booking/apis/home_vendor_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/user/home_user_controller.dart';
import 'package:yacht_booking/models/services_model.dart';
import 'package:yacht_booking/services/firebase_chat_provider.dart';
import 'package:yacht_booking/view/user/notification/notification_secreen.dart';
import 'package:yacht_booking/view/vendor/chat_screen_provider.dart';
import 'package:yacht_booking/view/widgets/cash_network_image_share.dart';
import 'package:yacht_booking/view/widgets/custom_avatar.dart';
import 'package:yacht_booking/view/widgets/custom_button.dart';
import 'package:yacht_booking/view/widgets/custom_drop_down.dart';
import 'package:yacht_booking/view/widgets/custom_drop_down_net.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';
import 'package:yacht_booking/view/widgets/custom_text_form_field.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  SfRangeValues _values = SfRangeValues(40.0, 400.0);
  HomeUserController homeUserController = Get.find();

  ServicesModelData service;
  String serviceId;

  String price;
  String rate;
  String country;

  List<String> listPrice = [
    "100",
    "200",
    "300",
    "400",
    "500",
    "500",
    "600",
    "700",
    "800",
    "900",
    "1000",
  ];
  List<String> listCountry = [
    "الامارات",
    "دبي",
    "السعودية",
    "فلسطين",
    "مصر",
  ];
  List<String> listRate = [
    "1",
    "2",
    "3",
    "4",
    "5",
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 155.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    Assets.getImage('bg'),
                  ),
                  fit: BoxFit.cover,
                  colorFilter:
                      ColorFilter.mode(Colors.black26, BlendMode.darken),
                ),
              ),
              child: homeUserController.getProfileUserData.value.data == null
                  ? Center(child: Helper.loading())
                  : SafeArea(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          homeUserController
                                      .getProfileUserData.value.data.photo ==
                                  null
                              ? CustomAvatar(28, 27, 'person')
                              : Container(
                                  width: 62.r,
                                  height: 62.r,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Color(0xffFFE451),
                                      )),
                                  child: CachedNetworkImageShare(
                                      homeUserController
                                          .getProfileUserData.value.data.photo,
                                      62.r,
                                      62.r,
                                      0),
                                ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      '${homeUserController.getProfileUserData.value.data.name ?? ""}',
                                      fontColor: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                    // SizedBox(width: 85.w),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            FireBaseHelperProvider
                                                .fireBaseHelperProvider
                                                .getAllMyChats(
                                              myId: homeUserController
                                                  .getProfileUserData
                                                  .value
                                                  .data
                                                  .id
                                                  .toString(),
                                            );
                                            Get.to(ChatScreenProvider());
                                          },
                                          child: Container(
                                            padding:
                                                EdgeInsetsDirectional.all(8.r),
                                            child: Stack(
                                              children: [
                                                SvgPicture.asset(
                                                  Assets.getIconSvg('messages'),
                                                  height: 20.r,
                                                  width: 20.r,
                                                ),
                                                // Container(
                                                //   height: 7.r,
                                                //   width: 7.r,
                                                //   decoration: BoxDecoration(
                                                //     borderRadius:
                                                //         BorderRadius.all(
                                                //             Radius.elliptical(
                                                //                 9999.0,
                                                //                 9999.0)),
                                                //     color:
                                                //         const Color(0xffff6464),
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 5.w),
                                        InkWell(
                                          onTap: () {
                                            HomeVendorApis.homeVendorApis
                                                .getNotifications();
                                            Get.to(NotificationScreen());
                                          },
                                          child: Container(
                                            padding:
                                                EdgeInsetsDirectional.all(8.r),
                                            child: Stack(
                                              children: [
                                                SvgPicture.asset(
                                                  Assets.getIconSvg(
                                                      'notifications'),
                                                  height: 20.r,
                                                  width: 20.r,
                                                ),
                                                // Container(
                                                //   height: 7.r,
                                                //   width: 7.r,
                                                //   decoration: BoxDecoration(
                                                //     borderRadius:
                                                //         BorderRadius.all(
                                                //             Radius.elliptical(
                                                //                 9999.0,
                                                //                 9999.0)),
                                                //     color:
                                                //         const Color(0xffff6464),
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        //  SizedBox(width: 5.w),
                                        // InkWell(
                                        //   onTap: () {
                                        //     Get.back();
                                        //   },
                                        //   child: Container(
                                        //     padding: EdgeInsetsDirectional.all(8.r),
                                        //     child: Stack(
                                        //       children: [
                                        //         Icon(Icons.arrow_forward,color:Colors.white,),

                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      Assets.getIconSvg('call'),
                                      height: 15.r,
                                      width: 15.r,
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                    ),
                                    SizedBox(width: 5.w),
                                    CustomText(
                                      '${homeUserController.getProfileUserData.value.data.mobile ?? ""}',
                                      fontColor: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      textAlign: TextAlign.start,
                                      alignment:
                                          AlignmentDirectional.centerStart,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                physics: BouncingScrollPhysics(),
                children: [
                  CustomTextFormField(
                    hintText: 'البحث عن مزود خدمه',
                    prefixIcon: Icon(Icons.search),
                    isBorderSide: false,
                    isBoxShadow: false,
                  ),
                  SizedBox(height: 60.h),
                  Container(
                    width: double.infinity,
                    height: 296.h,
                    padding: EdgeInsetsDirectional.all(10.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: const Color(0xfff8f8f8),
                      border: Border.all(color: Colors.grey[300]),
                      boxShadow: AppColors.boxShadow,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomDropDown(
                          value: country,
                          itemsList: listCountry,
                          hint: "المدينة",
                          height: 50,
                          fontSize: 13,
                          backgroundColor: Colors.white,
                          fontColor: AppColors.fontPrimaryColor,
                          onChanged: (val) {
                            country = val;
                            setState(() {});
                          },
                        ),
                        SizedBox(height: 10.h),
                        homeUserController.getServicesData.value.data == null
                            ? Helper.loading()
                            : CustomDropDownNet(
                                value: service,
                                itemsList: homeUserController
                                    .getServicesData.value.data,
                                hint: 'الخدمات',
                                height: 50,
                                fontSize: 13,
                                backgroundColor: Colors.white,
                                fontColor: AppColors.fontPrimaryColor,
                                onChanged: (val) {
                              
                                  service = val;
                                  setState(() {});
                                },
                              ),
                        SizedBox(height: 10.h),
                        CustomDropDown(
                          value: price,
                          itemsList: listPrice,
                          hint: "السعر",
                          height: 50,
                          fontSize: 13,
                          backgroundColor: Colors.white,
                          fontColor: AppColors.fontPrimaryColor,
                          onChanged: (val) {
                            price = val;
                            setState(() {});
                          },
                        ),
                        SizedBox(height: 10.h),
                        // CustomDropDown(
                        //   value: rate,
                        //   hint: 'التقييم',
                        //   itemsList: listRate,
                        //   height: 50,
                        //   fontSize: 13,
                        //   backgroundColor: Colors.white,
                        //   fontColor: AppColors.fontPrimaryColor,
                        //   onChanged: (val) {
                        //     rate = val;
                        //     setState(() {

                        //     });
                        //   },
                        // ),
                        // SizedBox(height: 30.h),
                        // SfRangeSlider(
                        //   min: 0.0,
                        //   max: 500.0,
                        //   values: _values,
                        //   interval: 50,
                        //   showTicks: false,
                        //   showLabels: false,
                        //   enableTooltip: false,
                        //   minorTicksPerInterval: 1,
                        //   activeColor: AppColors.primaryColor,
                        //   onChanged: (dynamic value) {
                        //     setState(() {
                        //       _values = value;
                        //     });
                        //   },
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                  CustomButton(
                    text: 'بحث',
                    onTap: () {
                      if (service == null) {
                        Helper.getSheetError('الرجاء اختيار الخدمة');
                      } else {
                        HomeUserApis.homeUserApis
                            .searchShips(service.id.toString(), price, rate);
                        homeUserController.tabController.animateTo(2);
                        Get.back();
                      }
                    },
                  ),
                  SizedBox(height: 10.h),
                  CustomButton(
                    text: 'الرجوع للرئيسية',
                    background: AppColors.borderColor,
                    fontColor: Colors.black,
                    onTap: () {
                      Get.back();
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
