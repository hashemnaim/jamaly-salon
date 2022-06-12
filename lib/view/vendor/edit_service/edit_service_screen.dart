import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:yacht_booking/apis/home_vendor_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/vendor/home_vendor_controller.dart';
import 'package:yacht_booking/models/my_ship_model.dart';
import 'package:yacht_booking/models/sub_services_vendor.dart';
import 'package:yacht_booking/view/widgets/custom_app_bar.dart';
import 'package:yacht_booking/view/widgets/custom_button.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';
import 'package:yacht_booking/view/widgets/custom_text_form_field.dart';

class EditServiceScreen extends StatefulWidget {
 final MyShipModelData myShipModelData;

  const EditServiceScreen({this.myShipModelData});

  @override
  State<EditServiceScreen> createState() => _EditServiceScreenState();
}

class _EditServiceScreenState extends State<EditServiceScreen> {
  String selectedIndex;
  HomeVendorController homeVendorController = Get.find();
  GlobalKey<FormState> addOrderFormKey = GlobalKey<FormState>();
  bool isCompleat = false;
  bool isCompleat2 = true;
  List<SubServiceVendorModelData> selectedSub = [];
  List<String> selectedSubId = [];


  String hourPrice, prePrice, totalPrice, note, noPerson,test;
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
   setNoPerson(String value){
      this.noPerson = value;
  }


  List<String> listNoPerson = [
    "اقل من 5",
    "من 5 الى 10",
    "اكثر من 10",
  ];

  @override
  void initState() {
    super.initState();
    setIniitoal();
    
  }

  setIniitoal(){
    setState(() {
      noPerson = widget.myShipModelData.numberOfPersones.toString();
      if(widget.myShipModelData.bookingWay.toString()=="cash"){
          isCompleat2 = true;
          isCompleat = false;

      }else{
        isCompleat2 = false;
          isCompleat = true;

      }
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
      appBar: CustomAppBar(
        title: 'تعديل الخدمه',
        backFun: (){
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
                          'اختر خدمه:',
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
                                                SvgPicture.asset(
                                                  Assets.getIconSvg('logo'),
                                                  width: 25.r,
                                                  height: 25.r,
                                                  fit: BoxFit.contain,
                                                  color: AppColors.primaryColor,
                                                ),
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
                          hintText: 'سعر الساعة/الدقيقة',
                          fillColor: Colors.white,
                          isBoxShadow: false,
                          textInitialValue:widget.myShipModelData.dayPrice.toString(),
                          onSaved: setHourPrice,
                          validator: Helper.validationNull,
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
                          hintText: 'عدد الاشخاص',     textInputType: TextInputType.number,
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
                            :
                             Column(
                                children: [
                                  MultiSelectBottomSheetField(
                                    initialChildSize: 0.4,
                                    listType: MultiSelectListType.CHIP,
                                    
                                    searchable: true,
                                    buttonText: Text(":حدد الخدمات المقدمة  "),
                                    title: Text(":حدد الخدمات المقدمة  "),
                                    items: homeVendorController
                                        .getVendorSubServicesData.value.data
                                        .map((e) => MultiSelectItem<
                                                SubServiceVendorModelData>(
                                            e, e.title))
                                        .toList(),
                                    onConfirm: (values) {
                                      selectedSub = values;
                                    },
                                    chipDisplay: MultiSelectChipDisplay(
                                      onTap: (value) {
                                        setState(() {
                                          selectedSub.remove(value);
                                        });
                                      },
                                    ),
                                  ),
                                  selectedSub == null || selectedSub.isEmpty
                                      ? Container(
                                          padding: EdgeInsets.all(10),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "None selected",
                                            style: TextStyle(
                                                color: Colors.black54),
                                          ))
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
                          isBoxShadow: false,     textInputType: TextInputType.number,
                          onSaved: setPrePrice,
                          textInitialValue: widget.myShipModelData.prepaid.toString(),
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
                        CustomTextFormField(
                          hintText: 'مبلغ الحجز كاملاً',
                          fillColor: Colors.white,
                          isBoxShadow: false,
                           textInitialValue: widget.myShipModelData.price.toString(),
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
                           textInitialValue: widget.myShipModelData.notes.toString(),
                          onSaved: setNote,
                          validator: Helper.validationNull,
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h),
                  CustomButton(
                      text: 'تعديل الخدمه',
                      onTap: () {
                        
                          addOrderFormKey.currentState.save();
                          if(selectedSub == null || selectedSub.isEmpty){
                            
                          }else{
                            for (var i = 0; i < selectedSub.length; i++) {
                              
                              selectedSubId.add(selectedSub[i].id);
                            }
                          }

                          // Get.back();
                            HomeVendorApis.homeVendorApis.updateShip(
                              homeVendorController.resultImagePhoto, 
                              selectedIndex, 
                              hourPrice, 
                              selectedSubId,
                              prePrice, 
                              totalPrice, 
                              note, 
                              "0", 
                              noPerson, 
                              isCompleat2?
                              "cash"
                              :"prepaid",
                              widget.myShipModelData.id.toString()
                              );
                          

                        
                        // Get.back();
                      }),
                ],
              ),
            ),
          ),
        ),
    );
    })
    ;
  }
}
