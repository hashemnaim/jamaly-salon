import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/apis/home_vendor_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/vendor/home_vendor_controller.dart';
import 'package:yacht_booking/models/myOffer.dart';
import 'package:yacht_booking/view/widgets/custom_app_bar.dart';
import 'package:yacht_booking/view/widgets/custom_button.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';
import 'package:yacht_booking/view/widgets/custom_text_form_field.dart';

import '../../widgets/cash_network_image_share.dart';

class EditOfferScreen extends StatefulWidget {
  final MyOfferModelData myOfferModelData;

  const EditOfferScreen({this.myOfferModelData});

  @override
  State<EditOfferScreen> createState() => _EditOfferScreenState();
}

class _EditOfferScreenState extends State<EditOfferScreen> {
  String selectedIndex;
  HomeVendorController homeVendorController = Get.find();
  GlobalKey<FormState> editOffersFormKey = GlobalKey<FormState>();

  String hourPrice, prePrice, totalPrice, test;

  setHourPrice(String value) {
    this.hourPrice = value;
  }

  setTest(String value) {
    this.test = value;
  }

  setPrePrice(String value) {
    this.prePrice = value;
  }

  setTotalPrice(String value) {
    this.totalPrice = value;
  }

  bool isCompleat = false;
  bool isCompleat2 = true;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: CustomAppBar(
          title: 'تعديل العرض ',
          backFun: () {
            Get.back();
          },
        ),
        body: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: Form(
              key: editOffersFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsetsDirectional.all(10.r),
                    decoration: BoxDecoration(
                      color: AppColors.bg,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: AppColors.borderColor),
                    ),
                    child: Column(
                      children: [
                        CustomText(
                          'الخدمات المتوفرة:',
                          alignment: AlignmentDirectional.centerStart,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          height: 93.r,
                          child: homeVendorController
                                      .getVendorServicesData.value.data ==
                                  null
                              ? Center(
                                  child: Helper.loading(),
                                )
                              : homeVendorController
                                      .getVendorServicesData.value.data.isEmpty
                                  ? Center(
                                      child: CustomText("No Service"),
                                    )
                                  : ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      padding: EdgeInsetsDirectional.only(
                                        top: 3.h,
                                        bottom: 3.h,
                                        end: 12.w,
                                      ),
                                      itemCount: homeVendorController
                                          .getVendorServicesData
                                          .value
                                          .data
                                          .length,
                                      separatorBuilder: (context, index) =>
                                          SizedBox(width: 5.w),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedIndex =
                                                  homeVendorController
                                                      .getVendorServicesData
                                                      .value
                                                      .data[index]
                                                      .id
                                                      .toString();
                                            });
                                          },
                                          child: Container(
                                            width: 120.r,
                                            height: 88.r,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5.w),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: AppColors.boxShadow,
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                              border: selectedIndex ==
                                                      homeVendorController
                                                          .getVendorServicesData
                                                          .value
                                                          .data[index]
                                                          .id
                                                          .toString()
                                                  ? Border.all(
                                                      color: AppColors
                                                          .primaryColor)
                                                  : null,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                selectedIndex ==
                                                        homeVendorController
                                                            .getVendorServicesData
                                                            .value
                                                            .data[index]
                                                            .id
                                                            .toString()
                                                    ? Align(
                                                        alignment:
                                                            AlignmentDirectional
                                                                .centerEnd,
                                                        child: Container(
                                                          width: 10.r,
                                                          height: 10.r,
                                                          alignment:
                                                              AlignmentDirectional
                                                                  .center,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Colors.white,
                                                            boxShadow: AppColors
                                                                .boxShadow,
                                                          ),
                                                          child: Container(
                                                            width: 8.r,
                                                            height: 8.r,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: AppColors
                                                                  .primaryColor,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : SizedBox(),
                                                CustomText(
                                                  '${homeVendorController.getVendorServicesData.value.data[index].title}',
                                                  fontSize: 10,
                                                  height: 1,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                homeVendorController
                                                            .getVendorServicesData
                                                            .value
                                                            .data[index]
                                                            .icon ==
                                                        null
                                                    ? SvgPicture.asset(
                                                        Assets.getIconSvg(
                                                            'logo'),
                                                        width: 25.r,
                                                        height: 25.r,
                                                        fit: BoxFit.contain,
                                                        color: AppColors
                                                            .primaryColor,
                                                      )
                                                    : CachedNetworkImageShare(
                                                        homeVendorController
                                                            .getVendorServicesData
                                                            .value
                                                            .data[index]
                                                            .icon,
                                                        25.r,
                                                        25.r,
                                                        1)
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                        ),
                        SizedBox(height: 10.h),
                        // CustomText(
                        //   'الرجاء تحديد الأسعار الآتية:',
                        //   alignment: AlignmentDirectional.centerStart,
                        //   fontWeight: FontWeight.bold,
                        // ),
                        SizedBox(height: 10.h),
                        CustomTextFormField(
                          hintText: 'سعر الساعة:',
                          fillColor: Colors.white,
                          isBoxShadow: false,
                          onSaved: setHourPrice,
                          textInputType: TextInputType.number,
                          isComplate: true,
                          onFieldSubmitted: () {
                            FocusScope.of(context).unfocus();
                          },
                          validator: Helper.validationNull,
                          textInitialValue:
                              widget.myOfferModelData.dayPrice.toString(),
                          prefixIcon: Icon(
                            Icons.monetization_on,
                            size: 22.r,
                            color: AppColors.primaryColor,
                          ),
                          suffixIcon: Padding(
                            padding: EdgeInsetsDirectional.only(end: 10.w),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 30.h,
                                  child: VerticalDivider(thickness: 1),
                                ),
                                CustomText(
                                  'درهم',
                                  fontSize: 10,
                                  fontColor: AppColors.hintColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        CustomTextFormField(
                          hintText: 'مبلغ الحجز كاملاً',
                          fillColor: Colors.white,
                          isBoxShadow: false,
                          onSaved: setTotalPrice,
                          textInputType: TextInputType.number,
                          isComplate: true,
                          onFieldSubmitted: () {
                            FocusScope.of(context).unfocus();
                          },
                          textInitialValue:
                              widget.myOfferModelData.price.toString(),
                          validator: Helper.validationNull,
                          prefixIcon: Icon(
                            Icons.monetization_on,
                            size: 22.r,
                            color: AppColors.primaryColor,
                          ),
                          suffixIcon: Padding(
                            padding: EdgeInsetsDirectional.only(end: 10.w),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 30.h,
                                  child: VerticalDivider(thickness: 1),
                                ),
                                CustomText(
                                  'درهم',
                                  fontSize: 10,
                                  fontColor: AppColors.hintColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        SizedBox(height: 10.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 24.w,
                              height: 24.h,
                              child: Checkbox(
                                  value: isCompleat,
                                  onChanged: (val) {
                                    isCompleat2 = false;
                                    isCompleat = true;
                                    setState(() {});
                                  }),
                            ),
                            SizedBox(width: 3.w),
                            CustomText(
                              'دفع عربون فقط',
                              alignment: AlignmentDirectional.centerStart,
                              fontSize: 10,
                            ),
                            SizedBox(width: 15.w),
                            SizedBox(
                              width: 24.w,
                              height: 24.h,
                              child: Checkbox(
                                  value: isCompleat2,
                                  onChanged: (val) {
                                    isCompleat2 = true;
                                    isCompleat = false;

                                    setState(() {});
                                  }),
                            ),
                            SizedBox(width: 3.w),
                            CustomText(
                              'دفع مبلغ الحجز كاملاً',
                              alignment: AlignmentDirectional.centerStart,
                              fontSize: 10,
                            ),
                          ],
                        ),

                        isCompleat2
                            ? Container()
                            : CustomTextFormField(
                                hintText: 'مبلغ العربون',
                                fillColor: Colors.white,
                                textInputType: TextInputType.number,
                                isBoxShadow: false,
                                isComplate: true,
                                onFieldSubmitted: () {
                                  FocusScope.of(context).unfocus();
                                },
                                onSaved: setPrePrice,
                                validator: Helper.validationNull,
                                textInitialValue: widget
                                        .myOfferModelData.prepaid
                                        .toString() ??
                                    "",
                                prefixIcon: Icon(
                                  Icons.monetization_on,
                                  size: 22.r,
                                  color: AppColors.primaryColor,
                                ),
                                suffixIcon: Padding(
                                  padding:
                                      EdgeInsetsDirectional.only(end: 10.w),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 30.h,
                                        child: VerticalDivider(thickness: 1),
                                      ),
                                      CustomText(
                                        'درهم',
                                        fontSize: 10,
                                        fontColor: AppColors.hintColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        SizedBox(height: 10.h),
                        CustomText(
                          'الصور المضافة:',
                          alignment: AlignmentDirectional.centerStart,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(height: 10.h),
                        InkWell(
                          onTap: () {
                            homeVendorController.selectImage();
                          },
                          child: CustomTextFormField(
                            hintText: 'اضافة صور ',
                            fillColor: Colors.white,
                            isBoxShadow: false,
                            enabled: false,
                            onSaved: setTest,
                            isComplate: true,
                            onFieldSubmitted: () {
                              FocusScope.of(context).unfocus();
                            },
                            validator: Helper.validationnoo,
                            prefixIcon: Icon(
                              Icons.image_rounded,
                              size: 22.r,
                              color: AppColors.primaryColor,
                            ),
                            suffixIcon: Padding(
                              padding: EdgeInsetsDirectional.only(end: 10.w),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.add_circle,
                                    size: 18.r,
                                    color: AppColors.primaryColor,
                                  ),
                                  SizedBox(width: 5.w),
                                  CustomText(
                                    'اضافة',
                                    fontSize: 10,
                                    fontColor: AppColors.hintColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        GetBuilder<HomeVendorController>(
                          id: "imagesOffers",
                          init: HomeVendorController(),
                          builder: (controller) {
                            return controller.imageList.isEmpty
                                ? SizedBox()
                                : Container(
                                    height: 75.h,
                                    width: double.infinity,
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: controller.imageList.length,
                                      separatorBuilder: (context, index) =>
                                          SizedBox(width: 5.w),
                                      itemBuilder: (context, index) =>
                                          Container(
                                        width: 120.w,
                                        height: 60.h,
                                        padding: EdgeInsetsDirectional.all(5.r),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                          // image: DecorationImage(
                                          //   image: AssetThumbImageProvider(
                                          //       controller
                                          //           .resultOffersPhoto[index],
                                          //       width: 100,
                                          //       height: 75),
                                          //   //  AssetImage(
                                          //   //   Assets.getImage('bg'),
                                          //   // ),
                                          //   fit: BoxFit.cover,
                                          // ),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            controller.removeImage(index);
                                          },
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional.topStart,
                                            child: Container(
                                              height: 20.r,
                                              width: 20.r,
                                              alignment:
                                                  AlignmentDirectional.center,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                Icons.close,
                                                size: 18.r,
                                                color: AppColors.primaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                          },
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h),
                  CustomButton(
                      text: 'حفظ التعديلات',
                      onTap: () {
                        editOffersFormKey.currentState.save();
                        Get.back();
                        HomeVendorApis.homeVendorApis.updateShipOffers(
                            homeVendorController.imageList,
                            selectedIndex,
                            hourPrice,
                            isCompleat2 ? "" : prePrice,
                            hourPrice,
                            "1",
                            widget.myOfferModelData.id.toString());
                      }),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
