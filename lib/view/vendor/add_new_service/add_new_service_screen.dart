import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:yacht_booking/apis/home_vendor_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/vendor/home_vendor_controller.dart';
import 'package:yacht_booking/models/sub_services_vendor.dart';
import 'package:yacht_booking/view/widgets/cash_network_image_share.dart';
import 'package:yacht_booking/view/widgets/custom_app_bar.dart';
import 'package:yacht_booking/view/widgets/custom_button.dart';
import 'package:yacht_booking/view/widgets/custom_drop_down.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';
import 'package:yacht_booking/view/widgets/custom_text_form_field.dart';

class AddNewServiceScreen extends StatefulWidget {
  const AddNewServiceScreen({Key key}) : super(key: key);

  @override
  State<AddNewServiceScreen> createState() => _AddNewServiceScreenState();
}

class _AddNewServiceScreenState extends State<AddNewServiceScreen> {
  String selectedIndex;
  HomeVendorController homeVendorController = Get.find();
  GlobalKey<FormState> addOrderFormKey = GlobalKey<FormState>();
  bool isCompleat = false;
  bool isCompleat2 = true;
  List<dynamic> selectedSub = [];
  List<String> selectedSubId = [];

  String hourPrice, prePrice, totalPrice, note, noPerson, test, timeTo, name;
  String selectedSubService;
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

  setNote(String value) {
    this.note = value;
  }

  setNoPerson(String value) {
    this.noPerson = value;
  }

  setName(String value) {
    this.name = value;
  }

  List<String> listNoPerson = [
    "اقل من 5",
    "من 5 الى 10",
    "اكثر من 10",
  ];
  List<String> listTimeTo = [
    "30 دقيقة",
    "1 ساعة",
    "2 ساعة",
    "3 ساعات",
    "4 ساعات",
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: CustomAppBar(
          title: 'اضافة خدمه جديده',
          backFun: () {
            Get.back();
          },
        ),
        body: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: Form(
              key: addOrderFormKey,
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
                          'اختر خدمه',
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
                                            HomeVendorApis.homeVendorApis
                                                .getVendorSubServices(
                                                    homeVendorController
                                                        .getVendorServicesData
                                                        .value
                                                        .data[index]
                                                        .id
                                                        .toString());
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
                        //   'الرجاء تعبئة الحقول الآتية:',
                        //   alignment: AlignmentDirectional.centerStart,
                        //   fontWeight: FontWeight.bold,
                        // ),
                        SizedBox(height: 10.h),
                        CustomTextFormField(
                          hintText: 'اسم الخدمه',
                          fillColor: Colors.white,
                          isBoxShadow: false,
                          onSaved: setName,
                          validator: Helper.validationNull,
                          prefixIcon: Icon(
                            Icons.miscellaneous_services_outlined,
                            size: 22.r,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        CustomTextFormField(
                          hintText: 'سعر الخدمه',
                          fillColor: Colors.white,
                          isBoxShadow: false,
                          onSaved: setHourPrice,
                          textInputType: TextInputType.number,
                          validator: Helper.validationNull,
                          prefixIcon: Icon(
                            Icons.monetization_on,
                            size: 22.r,
                            color: AppColors.primaryColor,
                          ),
                          suffixIcon: Container(
                            padding: EdgeInsetsDirectional.only(end: 3.w),
                            width: 100.w,
                            child: CustomDropDown(
                              value: timeTo,
                              hint: "المدة",
                              onChanged: (val) {
                                setState(() {
                                  timeTo = val;
                                });
                              },
                              itemsList: listTimeTo,
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        CustomTextFormField(
                          hintText: 'عدد الاشخاص',
                          textInputType: TextInputType.number,
                          fillColor: Colors.white,
                          isBoxShadow: false,
                          onSaved: setNoPerson,
                          validator: Helper.validationNull,
                          prefixIcon: Icon(
                            Icons.group,
                            size: 22.r,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        // CustomDropDown(
                        //   value: noPerson,
                        //   hint: "عدد الاشخاص",
                        //   itemsList: listNoPerson,
                        //   onChanged: (val) {
                        //     setState(() {
                        //       noPerson = val;
                        //     });
                        //   },
                        //   backgroundColor: Colors.white,
                        //   fontColor: AppColors.hintColor,
                        //   borderColor: AppColors.borderColor,
                        //   iconColor: AppColors.hintColor,
                        //   fontSize: 12,
                        //   height: 55,
                        // ),
                        SizedBox(height: 10.h),
                        homeVendorController
                                    .getVendorSubServicesData.value.data ==
                                null
                            ? Helper.loading()
                            : Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.grey[300]),
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 12.w,
                                        ),
                                        SvgPicture.asset(
                                          Assets.getIconSvg('service'),
                                        ),
                                        Expanded(
                                          child: MultiSelectBottomSheetField(
                                            initialChildSize: 0.4,
                                            listType: MultiSelectListType.CHIP,
                                            backgroundColor: Colors.white,
                                            buttonIcon: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Colors.grey[400],
                                            ),
                                            cancelText: Text(
                                              "إلغاء",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            confirmText: Text(
                                              "تأكيد",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: AppColors.primaryColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            searchable: false,
                                            decoration: BoxDecoration(
                                                // border: Border.all(
                                                //     color: Colors.grey[300]),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.r)),
                                            buttonText: Text(
                                              "حدد الخدمات الاضافيه",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Colors.grey[400],
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SvgPicture.asset(
                                                  Assets.getIconSvg('service'),
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                Text("حدد الخدمات الاضافيه"),
                                              ],
                                            ),
                                            items: homeVendorController
                                                .getVendorSubServicesData
                                                .value
                                                .data
                                                .map((e) => MultiSelectItem<
                                                        SubServiceVendorModelData>(
                                                    e, e.title))
                                                .toList(),
                                            onConfirm: (values) {
                                              selectedSub = values;
                                              print(selectedSub);
                                            },
                                            chipDisplay: MultiSelectChipDisplay(
                                              onTap: (value) {
                                                setState(() {
                                                  selectedSub.remove(value);
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  selectedSub == null || selectedSub.isEmpty
                                      ? Container(
                                          padding: EdgeInsets.all(10),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "قم باختيار خدمه",
                                            style: TextStyle(
                                                color: Colors.black54),
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                        // CustomDropDownServiceVendor(
                        //   value:homeVendorController.getVendorSubServicesData.value.data.first?? null,
                        //   hint: "حدد الخدمات المقدمة",
                        //   itemsList: homeVendorController.getVendorSubServicesData.value.data,
                        //   onChanged: (val) {
                        //     setState(() {
                        //       selectedSubService = val.id.toString();
                        //     });
                        //   },
                        //   backgroundColor: Colors.white,
                        //   fontColor: AppColors.hintColor,
                        //   borderColor: AppColors.borderColor,
                        //   iconColor: AppColors.hintColor,
                        //   fontSize: 12,
                        //   height: 55,
                        // ),
                        SizedBox(height: 10.h),
                        InkWell(
                          onTap: () {
                            homeVendorController.addImageOrder();
                          },
                          child: CustomTextFormField(
                            hintText: 'اضافة صور ',
                            fillColor: Colors.white,
                            isBoxShadow: false,
                            enabled: false,
                            onSaved: setTest,
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
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        GetBuilder<HomeVendorController>(
                          id: "imagesOrder",
                          init: HomeVendorController(),
                          builder: (controller) {
                            return controller.resultImagePhoto.isEmpty
                                ? SizedBox()
                                : Container(
                                    height: 75.h,
                                    width: double.infinity,
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          controller.resultImagePhoto.length,
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
                                          image: DecorationImage(
                                            image: AssetThumbImageProvider(
                                                controller
                                                    .resultImagePhoto[index],
                                                width: 100,
                                                height: 75),
                                            //  AssetImage(
                                            //   Assets.getImage('bg'),
                                            // ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            controller.removeImageOrder(index);
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
                        CustomText(
                          'طريقة الحجز:',
                          alignment: AlignmentDirectional.centerStart,
                          fontWeight: FontWeight.bold,
                        ),
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
                        SizedBox(height: 15.h),
                        CustomTextFormField(
                          hintText: 'مبلغ العربون',
                          fillColor: Colors.white,
                          isBoxShadow: false,
                          textInputType: TextInputType.number,
                          onSaved: setPrePrice,
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
                                  fontWeight: FontWeight.bold,
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
                                  fontWeight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        CustomTextFormField(
                          hintText: 'يمكنك إضافة ملاحظات إضافية في الخدمه',
                          fillColor: Colors.white,
                          isBoxShadow: false,
                          maxLines: 3,
                          onSaved: setNote,
                          validator: Helper.validationnoo,
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h),
                  CustomButton(
                      text: 'اضافه الخدمه',
                      onTap: () async {
                        if (addOrderFormKey.currentState.validate()) {
                          addOrderFormKey.currentState.save();
                          if (selectedSub == null || selectedSub.isEmpty) {
                          } else {
                            for (var i = 0; i < selectedSub.length; i++) {
                              selectedSubId.add(selectedSub[i].id.toString());
                            }
                          }
                          if (selectedIndex == null) {
                            Helper.getSheetError("يجب تحديد الخدمه");
                          } else {
                            // Get.back();
                            await HomeVendorApis.homeVendorApis.addShip(
                                homeVendorController.resultImagePhoto,
                                selectedIndex,
                                hourPrice,
                                selectedSubId,
                                prePrice,
                                totalPrice,
                                note,
                                "0",
                                noPerson,
                                isCompleat2 ? "cash" : "prepaid",
                                name,
                                timeTo);
                            // Get.back();
                          }
                        }
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
