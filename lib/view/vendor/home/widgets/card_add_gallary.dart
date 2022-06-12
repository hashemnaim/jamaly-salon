import 'package:cached_network_image/cached_network_image.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:yacht_booking/apis/home_vendor_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/vendor/home_vendor_controller.dart';
import 'package:yacht_booking/models/my_ship_model.dart';
import 'package:yacht_booking/view/widgets/custom_button.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

class CardAddImage extends StatefulWidget {
  @override
  State<CardAddImage> createState() => _CardAddImageState();
}

class _CardAddImageState extends State<CardAddImage> {
  HomeVendorController homeVendorController = Get.find();

  int shipId;

  setShipId(int value) {
    this.shipId = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        padding: EdgeInsets.all(10.w),
        height: 440.h,
        child: homeVendorController.getMyShipData.value.data == null
            ? Helper.loading()
            : homeVendorController.getMyShipData.value.data.isEmpty
                ? CustomText("No Ships")
                : Column(
                    children: [
                      CustomText(
                        "اختر العرض",
                        fontSize: 17,
                        fontColor: AppColors.fontPrimaryColor,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Container(
                        height: 130.h,
                        child: ListView.separated(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: homeVendorController
                              .getMyShipData.value.data.length,
                          scrollDirection: Axis.horizontal,
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              width: 15.w,
                            );
                          },
                          itemBuilder: (context, index) {
                            MyShipModelData myShipModelData =
                                homeVendorController
                                    .getMyShipData.value.data[index];
                            return InkWell(
                              onTap: () {
                                setShipId(myShipModelData.id);
                              },
                              child: Container(
                                height: 130.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                    border: shipId.toString() ==
                                            myShipModelData.id.toString()
                                        ? Border.all(
                                            color: AppColors.primaryColor)
                                        : null),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 100.h,
                                      width: 100.w,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.r),
                                        image: DecorationImage(
                                            image: myShipModelData.image == null
                                                ? CachedNetworkImageProvider(
                                                    "https://upload.wikimedia.org/wikipedia/commons/9/9a/Gull_portrait_ca_usa.jpg")
                                                : CachedNetworkImageProvider(
                                                    myShipModelData.image),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    CustomText(
                                      "${myShipModelData.title ?? ''}",
                                      fontSize: 13,
                                      fontColor: AppColors.fontPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      GetBuilder<HomeVendorController>(
                        init: HomeVendorController(),
                        id: "images",
                        builder: (controller) {
                          return Column(
                            children: [
                              CustomButton(
                                  text: "اختر صور",
                                  onTap: () {
                                    controller.addImage2();
                                    // return showCupertinoModalPopup<void>(
                                    //   context: context,
                                    //   builder: (BuildContext context) =>
                                    //       CupertinoActionSheet(
                                    //     actions: <CupertinoActionSheetAction>[
                                    //       CupertinoActionSheetAction(
                                    //         child: Text('الكاميرا'.tr),
                                    //         onPressed: () {
                                    //           controller.getImageProfile(
                                    //               ImageSource.camera);
                                    //           Navigator.pop(context);
                                    //         },
                                    //       ),
                                    //       CupertinoActionSheetAction(
                                    //         child: Text('الاستوديو'.tr),
                                    //         onPressed: () {
                                    //           controller.addImage2();

                                    //           Navigator.pop(context);
                                    //         },
                                    //       ),
                                    //     ],
                                    //     cancelButton:
                                    //         CupertinoActionSheetAction(
                                    //       child: CustomText(
                                    //         'Cancel',
                                    //         fontWeight: FontWeight.bold,
                                    //       ),
                                    //       isDefaultAction: true,
                                    //       onPressed: () {
                                    //         Navigator.pop(context);
                                    //       },
                                    //     ),
                                    //   ),
                                    // );
                                  }),
                              SizedBox(
                                height: 10.h,
                              ),
                              controller.resultListFinal.isEmpty
                                  ? SizedBox()
                                  : Container(
                                      height: 100.h,
                                      child: ListView.builder(
                                        itemCount:
                                            controller.resultListFinal.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Stack(
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.all(10.h),
                                                  height: 70.h,
                                                  width: 70.w,
                                                  child: AssetThumb(
                                                    asset: controller
                                                        .resultListFinal[index],
                                                    width: 100,
                                                    height: 100,
                                                  )),
                                              Container(
                                                margin: EdgeInsets.all(10.h),
                                                height: 70.h,
                                                width: 70.w,
                                                child: Align(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .topEnd,
                                                  child: InkWell(
                                                      onTap: () {
                                                        controller
                                                            .removeImage(index);
                                                      },
                                                      child: Icon(
                                                        Icons.close,
                                                        color: Colors.red,
                                                      )),
                                                ),
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                            ],
                          );
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomButton(
                          text: "اضافة",
                          onTap: () {
                            if (shipId != null) {
                              Get.back();
                              HomeVendorApis.homeVendorApis.storeImagesGallery(
                                  homeVendorController.resultListFinal,
                                  shipId.toString());
                            } else {
                              Helper.getSheetSucsses('قم باختيار العرض');
                            }
                          })
                    ],
                  ),
      );
    });
  }
}
