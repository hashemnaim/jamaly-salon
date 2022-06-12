import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:yacht_booking/apis/home_vendor_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/vendor/home_vendor_controller.dart';
import 'package:yacht_booking/view/widgets/custom_app_bar.dart';
import 'package:yacht_booking/view/widgets/custom_button.dart';
import 'package:yacht_booking/view/widgets/custom_drop_down.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';
import 'package:yacht_booking/view/widgets/custom_text_form_field.dart';
import 'package:yacht_booking/view/widgets/svg_row.dart';

import '../../widgets/cash_network_image_share.dart';

class AddNewOfferScreen extends StatefulWidget {
  const AddNewOfferScreen({Key key}) : super(key: key);

  @override
  State<AddNewOfferScreen> createState() => _AddNewOfferScreenState();
}

class _AddNewOfferScreenState extends State<AddNewOfferScreen> {
  String selectedIndex;
  HomeVendorController homeVendorController = Get.find();
  GlobalKey<FormState> addOffersFormKey = GlobalKey<FormState>();

  String hourPrice,
      prePrice,
      totalPrice,
      note,
      noPerson,
      test,
      cach,
      country,
      name;
  String time, periodFrom;
  TextEditingController timeFrom = TextEditingController(text: "من");
  TextEditingController timeTo = TextEditingController(text: "الى");

  setHourPrice(String value) {
    this.hourPrice = value;
  }

  setName(String value) {
    this.name = value;
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

  List<String> listNoPerson = [
    "اقل من 5",
    "من 5 الى 10",
    "اكثر من 10",
  ];

  List<String> listPeriodFrom = [
    "1 ساعه",
    "2 ساغه",
    "3 ساعه",
    "4 ساعه",
  ];
  List<String> listCach = [
    "دفع عربون فقط",
    "دفع مبلغ الحجز كاملاً",
  ];
  List<String> listCountry = [
    "امارات",
    "دبي",
  ];
  List<String> listTimeFrom = [
    "1 صباحا",
    "2 صباحا",
    "3 صباحا",
    "4 صباحا",
    "5 صباحا",
  ];
  List<String> listTimeTo = [
    "1 مساء",
    "2 مساء",
    "3 مساء",
    "4 مساء",
    "5 مساء",
  ];
  List<String> listTime = [
    "30 دقيقة",
    "1 ساعة",
    "2 ساعة",
    "3 ساعات",
    "4 ساعات",
  ];
  DateTime _selectedDate;
  TimeOfDay _selectedTime;
  TextEditingController fromDate =
      TextEditingController(text: "تاريخ بدايه العرض");
  TextEditingController fromTime = TextEditingController(text: "الوقت");
  TextEditingController toDate =
      TextEditingController(text: "تاريخ نهايه العرض");
  TextEditingController toTime = TextEditingController();
  setPeriodTime(String val) {
    setState(() {
      periodFrom = val;
    });
  }

  selectDate(BuildContext context, TextEditingController text) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: AppColors.primaryColor,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: AppColors.primaryColor,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child,
          );
        });

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      text
        ..text = "${_selectedDate.toLocal()}".split(' ')[0]
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: text.text.length, affinity: TextAffinity.upstream));
      setState(() {});
    }
  }

  _selectTime(BuildContext context, TextEditingController text) async {
    TimeOfDay newSelectedTime = await showTimePicker(
        context: context,
        initialTime: _selectedTime != null ? _selectedTime : TimeOfDay.now(),

        // initialDate: ,
        // firstDate: DateTime(2000),
        // lastDate: DateTime(2040),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: AppColors.primaryColor,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: AppColors.primaryColor,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child,
          );
        });

    if (newSelectedTime != null) {
      final localizations = MaterialLocalizations.of(context);

      _selectedTime = newSelectedTime;
      text
        ..text = "${_selectedTime.hour}:${_selectedTime.minute}"
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: text.text.length, affinity: TextAffinity.upstream));
      setState(() {});
    }
  }

  void _showDatePicker(ctx, TextEditingController text) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 500,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  SizedBox(
                    height: 400,
                    child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.time,
                        initialDateTime: DateTime.now(),
                        onDateTimeChanged: (val) {
                          setState(() {
                            text.text = "${val.hour}:${val.minute}";
                          });
                        }),
                  ),

                  // Close the modal
                  CupertinoButton(
                    child: const Text('نعم'),
                    onPressed: () => Navigator.of(ctx).pop(),
                  )
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: CustomAppBar(
          title: 'اضافة عرض جديد',
          backFun: () {
            Get.back();
          },
        ),
        body: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            child: Form(
              key: addOffersFormKey,
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
                        // CustomText(
                        //   'الرجاء تعبئة الحقول الآتية:',
                        //   alignment: AlignmentDirectional.centerStart,
                        //   fontWeight: FontWeight.bold,
                        // ),
                        SizedBox(height: 10.h),
                        CustomText(
                          'اختر الخدمه المقدمة  :',
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
                        SizedBox(
                          height: 15.h,
                        ),
                        CustomTextFormField(
                          hintText: 'اسم العرض',
                          fillColor: Colors.white,
                          isBoxShadow: false,
                          onSaved: setName,
                          validator: Helper.validationNull,
                          prefixIcon: Icon(
                            Icons.verified,
                            size: 22.r,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        CustomDropDown(
                          value: country,
                          hint: 'تحديد المدينة',
                          itemsList: listCountry,
                          onChanged: (val) {
                            setState(() {
                              country = val;
                            });
                          },
                          backgroundColor: Colors.white,
                          fontColor: AppColors.hintColor,
                          borderColor: AppColors.borderColor,
                          iconColor: AppColors.hintColor,
                          fontSize: 12,
                          height: 55,
                        ),
                        SizedBox(height: 10.h),
                        CustomTextFormField(
                          hintText: 'سعر العرض',
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
                              value: time,
                              hint: "المدة",
                              onChanged: (val) {
                                setState(() {
                                  time = val;
                                });
                              },
                              itemsList: listTime,
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        InkWell(
                          onTap: () {
                            homeVendorController.addImageOffers();
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
                          id: "imagesOffers",
                          init: HomeVendorController(),
                          builder: (controller) {
                            return controller.resultOffersPhoto.isEmpty
                                ? SizedBox()
                                : Container(
                                    height: 75.h,
                                    width: double.infinity,
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          controller.resultOffersPhoto.length,
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
                                                    .resultOffersPhoto[index],
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
                                            controller.removeImageOffers(index);
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
                        InkWell(
                          onTap: () {
                            selectDate(context, fromDate);
                          },
                          child: CustomTextFormField(
                            hintText: fromDate.text,
                            fillColor: Colors.white,
                            isBoxShadow: false,
                            enabled: false,
                            onSaved: setTest,
                            validator: Helper.validationnoo,
                            prefixIcon: Icon(
                              Icons.date_range,
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
                        InkWell(
                          onTap: () {
                            selectDate(context, toDate);
                          },
                          child: CustomTextFormField(
                            hintText: toDate.text,
                            fillColor: Colors.white,
                            isBoxShadow: false,
                            enabled: false,
                            onSaved: setTest,
                            validator: Helper.validationnoo,
                            prefixIcon: Icon(
                              Icons.date_range,
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
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: SvgRow(
                                'time',
                                'التوقيت ',
                                svgColor: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                                child: InkWell(
                              onTap: () {
                                _showDatePicker(context, timeFrom);
                                // _selectTime(context, timeFrom);
                              },
                              child: CustomTextFormField(
                                hintText: timeFrom.text,
                                fillColor: Colors.white,
                                isBoxShadow: false,
                                onSaved: setPeriodTime,
                                validator: Helper.validationnoo,
                                enabled: false,
                              ),
                            )),
                            SizedBox(width: 8.w),
                            Expanded(
                                child: InkWell(
                              onTap: () {
                                _showDatePicker(context, timeTo);
                              },
                              child: CustomTextFormField(
                                hintText: timeTo.text,
                                fillColor: Colors.white,
                                isBoxShadow: false,
                                onSaved: setPeriodTime,
                                validator: Helper.validationnoo,
                                enabled: false,
                              ),
                            )),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            // Expanded(
                            //   child: CustomDropDown(
                            //     value: periodTo,
                            //     hint: 'عدد الساعات:',
                            //     itemsList: listPeriodFrom,
                            //     onChanged: (val) {
                            //       setState(() {
                            //         periodTo = val;
                            //       });
                            //     },
                            //     backgroundColor: Colors.white,
                            //     fontColor: AppColors.hintColor,
                            //     borderColor: AppColors.borderColor,
                            //     iconColor: AppColors.hintColor,
                            //     fontSize: 12,
                            //     height: 55,
                            //   ),
                            // ),
                            // SizedBox(width: 5.w),
                            Expanded(
                              child: CustomTextFormField(
                                hintText: 'عدد الاشخاص',
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
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        CustomDropDown(
                          value: cach,
                          hint: 'طريقة الحجز:',
                          itemsList: listCach,
                          onChanged: (val) {
                            setState(() {
                              cach = val;
                            });
                          },
                          backgroundColor: Colors.white,
                          fontColor: AppColors.hintColor,
                          borderColor: AppColors.borderColor,
                          iconColor: AppColors.hintColor,
                          fontSize: 12,
                          height: 55,
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
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        CustomTextFormField(
                          hintText: 'يمكنك إضافة ملاحظات إضافية في العرض',
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
                    text: 'اضافة العرض',
                    onTap: () {
                      print('''
                            $selectedIndex, 
                            $hourPrice, 
                            $prePrice, 
                            $totalPrice, 
                            $note, 
                            
                            $noPerson, 
                            $cach, 
                            $name, 
                            $country, 
                            ${fromDate.text}, 
                            ${toDate.text}, 
                            $time,
                            ${timeFrom.text},
                            ${timeTo.text}
''');

                      if (addOffersFormKey.currentState.validate()) {
                        addOffersFormKey.currentState.save();
                        if (selectedIndex == null) {
                          Helper.getSheetError("يجب تحديد الخدمه");
                        } else {
                          Get.back();
                          HomeVendorApis.homeVendorApis.addShipOffers(
                              homeVendorController.resultOffersPhoto,
                              selectedIndex,
                              hourPrice,
                              prePrice,
                              totalPrice,
                              note,
                              "1",
                              noPerson,
                              cach == "دفع مبلغ الحجز كاملاً"
                                  ? "cash"
                                  : "prepaid",
                              name,
                              country,
                              fromDate.text,
                              toDate.text,
                              time,
                              time,
                              timeFrom.text,
                              timeTo.text);
                        }
                      }
                      // showDialog(
                      //   context: context,
                      //   builder: (BuildContext context) => AlertDialog(
                      //     backgroundColor: AppColors.secondaryColor,
                      //     contentPadding: EdgeInsetsDirectional.only(
                      //       top: 20.h,
                      //       start: 20.w,
                      //       end: 20.w,
                      //       bottom: 20.h,
                      //     ),
                      //     content: Column(
                      //       mainAxisSize: MainAxisSize.min,
                      //       children: [
                      //         SvgPicture.asset(
                      //           Assets.getIconSvg('yacht'),
                      //           width: 120.r,
                      //           height: 120.r,
                      //         ),
                      //         SizedBox(height: 15.h),
                      //         CustomText(
                      //           'تم اضافة اليخت بنجاح',
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
