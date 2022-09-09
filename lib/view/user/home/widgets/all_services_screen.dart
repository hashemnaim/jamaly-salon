// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:yacht_booking/apis/home_apis.dart';
// import 'package:yacht_booking/common/app_colors.dart';
// import 'package:yacht_booking/common/helper.dart';
// import 'package:yacht_booking/controller/user/bottom_nav_bar_controller.dart';
// import 'package:yacht_booking/controller/user/home_user_controller.dart';
// import 'package:yacht_booking/models/vendor_service.dart';
// import 'package:yacht_booking/view/user/company_details/company_details_screen.dart';
// import 'package:yacht_booking/view/vendor/chat_details_provider_screen.dart';
// import 'package:yacht_booking/view/widgets/cash_network_image_share.dart';
// import 'package:yacht_booking/view/widgets/custom_text.dart';
// import 'package:yacht_booking/view/widgets/icon_row.dart';
// import 'package:yacht_booking/view/widgets/svg_row.dart';

// class ServiceProvidersService2 extends StatefulWidget {
//   String servicesName;
//   ServiceProvidersService2(this.servicesName);
//   @override
//   _ServiceProvidersService2State createState() =>
//       _ServiceProvidersService2State();
// }

// class _ServiceProvidersService2State extends State<ServiceProvidersService2> {
//   BottomNavBarController bottomNavBarController = Get.find();
//   HomeUserController homeUserController = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return SingleChildScrollView(
//         padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 InkWell(
//                   onTap: () {
//                     homeUserController.showAllServices.value =
//                         !homeUserController.showAllServices.value;
//                   },
//                   child: Icon(
//                     Icons.arrow_back_ios,
//                     color: Colors.black,
//                     size: 20.r,
//                   ),
//                 ),
//                 SizedBox(
//                   width: 8.w,
//                 ),
//                 CustomText(
//                   widget.servicesName ?? '',
//                   fontSize: 15,
//                   fontWeight: FontWeight.normal,
//                 ),
//                 Container(
//                   width: 80,
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 10.h,
//             ),
//             homeUserController.getVendorsServiceData.value.data == null
//                 ? SizedBox(
//                     height: 300.h,
//                     child: Center(
//                       child: Helper.loading(),
//                     ),
//                   )
//                 : homeUserController.getVendorsServiceData.value.data.isEmpty
//                     ? SizedBox(
//                         height: 300.h,
//                         child: Center(
//                           child: CustomText("لا يوجد خدمات"),
//                         ),
//                       )
//                     : ListView.separated(
//                         itemCount: homeUserController
//                             .getVendorsServiceData.value.data.length,
//                         shrinkWrap: true,
//                         primary: false,
//                         padding: EdgeInsetsDirectional.zero,
//                         separatorBuilder: (context, index) =>
//                             SizedBox(height: 10.h),
//                         itemBuilder: (context, index) {
//                           VendorsServiceData ownersModelData =
//                               homeUserController
//                                   .getVendorsServiceData.value.data[index];
//                           return InkWell(
//                             onTap: () {
//                               HomeUserApis.homeUserApis.getOwnerDetails(
//                                   ownersModelData.id.toString());
//                               Get.to(() => CompanyDetailsScreen());
//                             },
//                             borderRadius: BorderRadius.circular(12.r),
//                             child: Container(
//                               width: 335.w,
//                               height: 110.h,
//                               padding: EdgeInsetsDirectional.all(8.r),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(12.r),
//                                 color: Colors.white,
//                                 border: Border.all(
//                                     width: 2.w, color: const Color(0xffe9e9ec)),
//                               ),
//                               child: Row(
//                                 children: [
//                                   Container(
//                                     width: 85.w,
//                                     height: double.infinity,
//                                     decoration: BoxDecoration(
//                                       color: ownersModelData.photo == null
//                                           ? AppColors.hintColor
//                                           : null,
//                                       borderRadius:
//                                           BorderRadiusDirectional.circular(
//                                               15.r),
//                                     ),
//                                     child: ownersModelData.photo == null
//                                         ? SizedBox()
//                                         : CachedNetworkImageShare(
//                                             ownersModelData.photo,
//                                             110.h,
//                                             85.w,
//                                             15),
//                                   ),
//                                   SizedBox(width: 5.w),
//                                   Expanded(
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             IconRow(
//                                               Icons.person,
//                                               '${ownersModelData.name ?? ''}',
//                                             ),
//                                             IconRow(
//                                               Icons.star,
//                                               '${ownersModelData.rate ?? '0'}',
//                                               iconColor: AppColors.yellow,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ],
//                                         ),
//                                         IconRow(Icons.location_on,
//                                             '${ownersModelData.location ?? ''}'),
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.center,
//                                           children: [
//                                             Padding(
//                                               padding: EdgeInsets.all(2.r),
//                                               child: Icon(
//                                                 Icons.phone,
//                                                 size: 17.r,
//                                                 color: Colors.black,
//                                               ),
//                                             ),
//                                             CustomText(
//                                               '${ownersModelData.mobile}',
//                                               fontColor: Colors.black,
//                                               fontWeight: FontWeight.normal,
//                                               fontSize: 12,
//                                               textAlign: TextAlign.start,
//                                               alignment: AlignmentDirectional
//                                                   .centerStart,
//                                             ),
//                                           ],
//                                         ),
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.start,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.center,
//                                               children: [
//                                                 Padding(
//                                                   padding: EdgeInsets.all(2.r),
//                                                   child: Icon(
//                                                     Icons.email_rounded,
//                                                     size: 17.r,
//                                                     color: Colors.black,
//                                                   ),
//                                                 ),
//                                                 CustomText(
//                                                   '${ownersModelData.email}',
//                                                   fontColor: Colors.black,
//                                                   fontWeight: FontWeight.normal,
//                                                   fontSize: 12,
//                                                   textAlign: TextAlign.start,
//                                                   alignment:
//                                                       AlignmentDirectional
//                                                           .centerStart,
//                                                 ),
//                                               ],
//                                             ),
//                                             InkWell(
//                                               onTap: () {
//                                                 Get.to(
//                                                   () =>
//                                                       ChatDetailsScreenProvider(
//                                                     myId: homeUserController
//                                                         .getProfileUserData
//                                                         .value
//                                                         .data
//                                                         .id
//                                                         .toString(),
//                                                     imagename:
//                                                         ownersModelData.photo,
//                                                     otherId: ownersModelData.id
//                                                         .toString(),
//                                                     username:
//                                                         ownersModelData.name,
//                                                   ),
//                                                 );
//                                               },
//                                               child: SvgRow(
//                                                 'messages',
//                                                 'مراسلة فورية',
//                                                 fontColor:
//                                                     AppColors.primaryColor,
//                                                 svgColor:
//                                                     AppColors.primaryColor,
//                                                 svgWidth: 14,
//                                                 svgHeight: 14,
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),

//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//           ],
//         ),
//       );
//     });
//   }
// }

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/apis/home_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/user/home_user_controller.dart';
import 'package:yacht_booking/models/offers_model.dart';
import 'package:yacht_booking/view/user/reservation_confirmation/reservation_confirmation_screen.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

import '../../../../models/search_ship_model.dart';

class ServiceProvidersService2 extends StatefulWidget {
  String servicesName;
  ServiceProvidersService2(this.servicesName);
  @override
  State<ServiceProvidersService2> createState() =>
      _ServiceProvidersService2State();
}

class _ServiceProvidersService2State extends State<ServiceProvidersService2> {
  HomeUserController homeUserController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 15.h),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            InkWell(
              onTap: () {
                homeUserController.showAllServices.value =
                    !homeUserController.showAllServices.value;
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 2.h),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: 20.r,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    CustomText(
                      widget.servicesName ?? '',
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Obx(() {
              return homeUserController.searchShipsModel.value == null
                  ? Center(
                      child: Helper.loading(),
                    )
                  : homeUserController.searchShipsModel.value.data.isEmpty
                      ? Center(child: CustomText("No Service"))
                      : GridView.count(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 15.h),
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          mainAxisSpacing: 8.h,
                          crossAxisSpacing: 8.w,
                          childAspectRatio: 140.w / 95.h,
                          children: List.generate(
                            homeUserController
                                .searchShipsModel.value.data.length,
                            (index) {
                              SearchShipsModel searchShipsModel =
                                  homeUserController.searchShipsModel.value;
                              return InkWell(
                                onTap: () {
                                  HomeUserApis.homeUserApis.getShipDetails(
                                      searchShipsModel.data[index].id
                                          .toString());
                                  Get.to(() =>
                                      ReservationConfirmationScreen(true));
                                },
                                child: Container(
                                  padding: EdgeInsetsDirectional.all(5.r),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: AppColors.boxShadow,
                                    borderRadius:
                                        BorderRadiusDirectional.circular(10.r),
                                    image: DecorationImage(
                                      image: searchShipsModel
                                                  .data[index].image ==
                                              null
                                          ? AssetImage(Assets.getImage('bg'))
                                          : CachedNetworkImageProvider(
                                              searchShipsModel
                                                  .data[index].image),
                                      fit: BoxFit.cover,
                                      colorFilter: ColorFilter.mode(
                                          Colors.black26, BlendMode.darken),
                                    ),
                                  ),
                                  child: Center(
                                    child: CustomText(
                                      '${searchShipsModel.data[index].title ?? ''}',
                                      fontColor: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
            }),
          ],
        ),
      ),
    );
  }
}
