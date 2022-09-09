import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/vendor/home_vendor_controller.dart';
import 'package:yacht_booking/controller/vendor/main_vendor_controller.dart';
import 'package:yacht_booking/models/my_ship_model.dart';
import 'package:yacht_booking/view/vendor/add_new_service/add_new_service_screen.dart';
import 'package:yacht_booking/view/widgets/custom_app_bar.dart';
import 'package:yacht_booking/view/widgets/custom_button.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';
import 'package:yacht_booking/view/widgets/icon_row.dart';

class YachtsScreen extends StatelessWidget {
  HomeVendorController homeVendorController = Get.find();
  MainVendorController mainVendorController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: CustomAppBar(
          title: 'اليخوت',
          isBack: false,
        ),
        body: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                              child: CustomText("لا يوجد يخوت"),
                            ),
                          )
                        : ListView.separated(
                            itemCount: homeVendorController
                                .getMyShipData.value.data.length,
                            shrinkWrap: true,
                            primary: false,
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 10.h),
                            itemBuilder: (context, index) {
                              MyShipModelData myShipModelData =
                                  homeVendorController
                                      .getMyShipData.value.data[index];
                              return InkWell(
                                onTap: () {
                                  mainVendorController.changePageIndex(1);
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsetsDirectional.all(8.r),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Colors.white,
                                    border: Border.all(
                                        color: AppColors.borderColor),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 80.w,
                                        height: 80.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          image: DecorationImage(
                                            image: myShipModelData.image == null
                                                ? AssetImage(
                                                    Assets.getImage('bg'))
                                                : CachedNetworkImageProvider(
                                                    myShipModelData.image),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5.w),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                IconRow(
                                                  Icons.person,
                                                  '${myShipModelData.title ?? ""}',
                                                  iconColor:
                                                      AppColors.primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 11,
                                                ),
                                                // Row(
                                                //   children: [
                                                //     InkWell(
                                                //       onTap: (){
                                                //         Get.to(EditYachtScreen());
                                                //       },
                                                //       child: Container(
                                                //         width: 26.w,
                                                //         height: 26.h,
                                                //         padding: EdgeInsets.all(3.r),
                                                //         alignment: AlignmentDirectional.center,
                                                //         decoration: BoxDecoration(
                                                //           color: AppColors.primaryColor
                                                //               .withOpacity(0.1),
                                                //           shape: BoxShape.circle,
                                                //         ),
                                                //         child: Icon(
                                                //           Icons.edit,
                                                //           size: 15.r,
                                                //           color: AppColors.primaryColor,
                                                //         ),
                                                //       ),
                                                //     ),
                                                //     SizedBox(width:5.w),
                                                //     InkWell(
                                                //       onTap: (){},
                                                //       child: Container(
                                                //         width: 26.w,
                                                //         height: 26.h,
                                                //         padding: EdgeInsets.all(3.r),
                                                //         alignment: AlignmentDirectional.center,
                                                //         decoration: BoxDecoration(
                                                //           color: AppColors.red.withOpacity(0.1),
                                                //           shape: BoxShape.circle,
                                                //         ),
                                                //         child: Icon(
                                                //           Icons.delete,
                                                //           size: 15.r,
                                                //           color: AppColors.red,
                                                //         ),
                                                //       ),
                                                //     ),
                                                //   ],
                                                // ),
                                              ],
                                            ),
                                            IconRow(
                                              Icons.location_on,
                                              '${myShipModelData.country ?? ""}',
                                              iconColor: AppColors.primaryColor,
                                              fontSize: 11,
                                            ),
                                            IconRow(
                                              Icons.local_offer,
                                              '${myShipModelData.price ?? ""} درهم',
                                              iconColor: AppColors.primaryColor,
                                              fontSize: 11,
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
                SizedBox(height: 25.h),
                CustomButton(
                  text: 'اضافه خدمه جديده',
                  width: 220,
                  onTap: () {
                    Get.to(() => AddNewServiceScreen());
                  },
                  icon: Icon(
                    Icons.add_circle,
                    size: 25.r,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
