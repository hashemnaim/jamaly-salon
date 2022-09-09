import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:yacht_booking/apis/home_vendor_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/vendor/home_vendor_controller.dart';
import 'package:yacht_booking/view/vendor/home/widgets/card_add_gallary.dart';
import 'package:yacht_booking/view/vendor/home/widgets/image_view.dart';
import 'package:yacht_booking/view/widgets/custom_button.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

class GalleryTap extends StatelessWidget {
  HomeVendorController homeVendorController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  'معرض الصور الخاص بي:',
                  fontWeight: FontWeight.bold,
                  fontColor: AppColors.primaryColor,
                ),
                InkWell(
                  onTap: () {
                    return showMaterialModalBottomSheet(
                      backgroundColor: Colors.white,
                      context: Get.context,
                      duration: Duration(milliseconds: 600),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.r),
                          topLeft: Radius.circular(20.r),
                        ),
                      ),
                      builder: (context) {
                        return CardAddImage();
                      },
                    );
                    // Get.to(AddNewOfferScreen());
                  },
                  borderRadius: BorderRadius.circular(10.r),
                  child: Container(
                    height: 35.h,
                    width: 80.w,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Color(0xFFF2C409),
                    ),
                    child: CustomText(
                      'إضافة',
                      fontColor: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            homeVendorController.getGallaryVendorData.value.data == null
                ? Container(
                    height: 300.h,
                    child: Center(
                      child: Helper.loading(),
                    ),
                  )
                : homeVendorController
                        .getGallaryVendorData.value.data.data.isEmpty
                    ? Container(
                        height: 300.h,
                        child: Center(
                          child: CustomText("لا يوجد صور في المعرض الخاص بك"),
                        ),
                      )
                    : LazyLoadScrollView(
                        onEndOfPage: () {
                          if (homeVendorController.getGallaryVendorData.value
                                  .data.currentPage ==
                              homeVendorController
                                  .getGallaryVendorData.value.data.lastPage) {
                          } else {
                            HomeVendorApis.homeVendorApis.getGallery(
                                page: (homeVendorController.getGallaryVendorData
                                            .value.data.currentPage +
                                        1)
                                    .toString(),
                                isFirst: false);
                          }
                        },
                        child: GridView.count(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          mainAxisSpacing: 10.h,
                          crossAxisSpacing: 10.w,
                          childAspectRatio: 158.w / 100.h,
                          physics: BouncingScrollPhysics(),
                          children: List.generate(
                            homeVendorController
                                .getGallaryVendorData.value.data.data.length,
                            (index) => InkWell(
                              onTap: () {
                                Get.to(() => ImgeView(
                                      imageFile: homeVendorController
                                          .getGallaryVendorData
                                          .value
                                          .data
                                          .data[index]
                                          .imageUrl,
                                    ));
                              },
                              borderRadius: BorderRadius.circular(10.r),
                              child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    image: DecorationImage(
                                      image: homeVendorController
                                                  .getGallaryVendorData
                                                  .value
                                                  .data
                                                  .data[index]
                                                  .imageUrl ==
                                              null
                                          ? AssetImage(
                                              Assets.getImage('bg'),
                                            )
                                          : CachedNetworkImageProvider(
                                              homeVendorController
                                                  .getGallaryVendorData
                                                  .value
                                                  .data
                                                  .data[index]
                                                  .imageUrl),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          return showMaterialModalBottomSheet(
                                            backgroundColor: Colors.white,
                                            context: Get.context,
                                            duration:
                                                Duration(milliseconds: 600),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(20.r),
                                                topLeft: Radius.circular(20.r),
                                              ),
                                            ),
                                            builder: (context) {
                                              return Container(
                                                padding: EdgeInsets.all(10.w),
                                                height: 150.h,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    CustomButton(
                                                      text: "تعديل",
                                                      onTap: () async {
                                                        dynamic file =
                                                            await Helper
                                                                .getImagePicker(
                                                                    ImageSource
                                                                        .gallery);
                                                        if (file != null) {
                                                          HomeVendorApis
                                                              .homeVendorApis
                                                              .updateGalleryImage(
                                                            file,
                                                            homeVendorController
                                                                .getGallaryVendorData
                                                                .value
                                                                .data
                                                                .data[index]
                                                                .id
                                                                .toString(),
                                                          );
                                                        } else {}
                                                      },
                                                    ),
                                                    CustomButton(
                                                      text: "حذف",
                                                      onTap: () {
                                                        HomeVendorApis
                                                            .homeVendorApis
                                                            .delateGalleryImage(
                                                                homeVendorController
                                                                    .getGallaryVendorData
                                                                    .value
                                                                    .data
                                                                    .data[index]
                                                                    .id
                                                                    .toString());
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 32.w,
                                              height: 23.h,
                                              alignment:
                                                  AlignmentDirectional.center,
                                              decoration: BoxDecoration(
                                                color: Color(0xffFFCC00),
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10.r),
                                                  topRight:
                                                      Radius.circular(10.r),
                                                ),
                                              ),
                                              child: Icon(
                                                Icons.more_vert,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      // Row(
                                      //   mainAxisAlignment:
                                      //       MainAxisAlignment.end,
                                      //   children: [
                                      //     Container(
                                      //       width: 72.w,
                                      //       height: 23.h,
                                      //       alignment:
                                      //           AlignmentDirectional.center,
                                      //       decoration: BoxDecoration(
                                      //         color: AppColors.fontPrimaryColor,
                                      //         borderRadius: BorderRadius.only(
                                      //           bottomLeft:
                                      //               Radius.circular(10.r),
                                      //           topRight: Radius.circular(10.r),
                                      //         ),
                                      //       ),
                                      //       child: CustomText(
                                      //         'تعديل',
                                      //         fontColor: Colors.white,
                                      //         textAlign: TextAlign.center,
                                      //         fontSize: 10,
                                      //         fontWeight: FontWeight.bold,
                                      //       ),
                                      //     )
                                      //   ],
                                      // ),
                                    ],
                                  )),
                            ),
                          ),
                        ),
                      )
          ],
        ),
      );
    });
  }
}
