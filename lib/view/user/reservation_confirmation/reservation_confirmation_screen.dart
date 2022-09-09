import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/apis/home_apis.dart';
import 'package:yacht_booking/apis/order_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/user/home_user_controller.dart';
import 'package:yacht_booking/models/ships_details.dart';
import 'package:yacht_booking/view/user/reservation_confirmation/date_picker.dart';
import 'package:yacht_booking/view/widgets/cash_network_image_share.dart';
import 'package:yacht_booking/view/widgets/custom_app_bar.dart';
import 'package:yacht_booking/view/widgets/custom_button.dart';
import 'package:yacht_booking/view/widgets/custom_drop_down.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';
import 'package:yacht_booking/view/widgets/custom_text_form_field.dart';
import 'package:yacht_booking/view/widgets/icon_row.dart';
import 'package:yacht_booking/view/widgets/svg_row.dart';

class ReservationConfirmationScreen extends StatefulWidget {
  final bool isOffer;

  const ReservationConfirmationScreen(this.isOffer);
  @override
  _ReservationConfirmationScreenState createState() =>
      _ReservationConfirmationScreenState();
}

class _ReservationConfirmationScreenState
    extends State<ReservationConfirmationScreen> {
  HomeUserController homeUserController = Get.find();
  String serviceId;
  String periodFrom, periodTo, noPerson;
  DateTime selectedDateNew;
  bool isCompleat = false;
  bool isCompleat2 = true;
  DateTime initDate = DateTime.now();
  DatePickerController datePickerController = DatePickerController();
  TimeOfDay _selectedTime;
  TextEditingController timeFrom = TextEditingController(text: "");
  TextEditingController timeTo = TextEditingController(text: "");

  Map<double, String> listPeriodFrom = {
    0.5: "نصف",
    1.0: "الافتراضي",
    2.0: "2",
    3.0: "3",
    4.0: "4",
    5.0: "5",
    6.0: "6",
    7.0: "7",
    8.0: "8",

    // 0.0: "مخصص",
  };

  List<String> listPeriodTo = [
    "30 دقيقه",
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
  List<String> listNoPerson = [
    "اقل من 5",
    "من 5 الى 10",
    "اكثر من 10",
  ];
  setPeriodTime(String val) {
    setState(() {
      periodFrom = val;
    });
  }

  selectDate(
    BuildContext context,
  ) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: initDate != null ? initDate : DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 50)),
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
      initDate = newSelectedDate;
      selectedDateNew = newSelectedDate;

      setState(() {});
    }
  }

  double pricehuor = 1;
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
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: homeUserController.shipsDetaileData.value.data == null
              ? Helper.loading()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 293.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(Assets.getImage('bg')),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black38, BlendMode.darken),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomAppBar(
                            title: '',
                            backFun: () {
                              Get.back();
                            },
                            backgroundColor: Colors.transparent,
                            iconBackColor: Colors.white,
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsetsDirectional.all(8.r),
                            margin: EdgeInsetsDirectional.only(
                              bottom: 25.h,
                              start: 15.w,
                              end: 15.w,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadiusDirectional.circular(10.r),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Container(
                                //   width: 80.w,
                                //   height: 80.h,
                                //   decoration: BoxDecoration(
                                //     borderRadius:
                                //         BorderRadiusDirectional.circular(10.r),
                                //     image: homeUserController.shipsDetaileData
                                //                 .value.data.image ==
                                //             null
                                //         ? null
                                //         : DecorationImage(
                                //             image: AssetImage(
                                //                 Assets.getImage('bg')),
                                //             fit: BoxFit.cover,
                                //           ),
                                //   ),
                                //   child: homeUserController.shipsDetaileData
                                //               .value.data.image ==
                                //           null
                                //       ? SizedBox()
                                //       : CachedNetworkImageShare(
                                //           homeUserController.shipsDetaileData
                                //               .value.data.image,
                                //           80.r,
                                //           80.r,
                                //           10.r),
                                // ),

                                SizedBox(width: 5.w),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          IconRow(
                                            Icons.person,
                                            homeUserController.shipsDetaileData
                                                        .value.data.owner ==
                                                    null
                                                ? ""
                                                : '${homeUserController.shipsDetaileData.value.data.owner.name ?? ""}',
                                            iconColor: AppColors.primaryColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          Row(
                                            children: [
                                              IconRow(
                                                Icons.star,
                                                homeUserController
                                                            .shipsDetaileData
                                                            .value
                                                            .data
                                                            .owner ==
                                                        null
                                                    ? "0"
                                                    : '${homeUserController.shipsDetaileData.value.data.owner.rate ?? "0"}',
                                                iconColor: AppColors.yellow,
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    if (widget.isOffer) {
                                                      if (homeUserController
                                                              .shipsDetaileData
                                                              .value
                                                              .data
                                                              .isFavourite
                                                              .toString() ==
                                                          "0") {
                                                        HomeUserApis
                                                            .homeUserApis
                                                            .storeFavoriteShip(
                                                                homeUserController
                                                                    .shipsDetaileData
                                                                    .value
                                                                    .data
                                                                    .id
                                                                    .toString(),
                                                                "2");
                                                        setState(() {
                                                          homeUserController
                                                              .shipsDetaileData
                                                              .value
                                                              .data
                                                              .isFavourite = 1;
                                                        });
                                                      } else {
                                                        HomeUserApis
                                                            .homeUserApis
                                                            .deleteFavoriteShip(
                                                                homeUserController
                                                                    .shipsDetaileData
                                                                    .value
                                                                    .data
                                                                    .id
                                                                    .toString(),
                                                                "2");
                                                        setState(() {
                                                          homeUserController
                                                              .shipsDetaileData
                                                              .value
                                                              .data
                                                              .isFavourite = 0;
                                                        });
                                                      }
                                                    } else {
                                                      if (homeUserController
                                                              .shipsDetaileData
                                                              .value
                                                              .data
                                                              .isFavourite
                                                              .toString() ==
                                                          "0") {
                                                        HomeUserApis
                                                            .homeUserApis
                                                            .storeFavoriteShip(
                                                                homeUserController
                                                                    .shipsDetaileData
                                                                    .value
                                                                    .data
                                                                    .id
                                                                    .toString(),
                                                                "1");
                                                        setState(() {
                                                          homeUserController
                                                              .shipsDetaileData
                                                              .value
                                                              .data
                                                              .isFavourite = 1;
                                                        });
                                                      } else {
                                                        HomeUserApis
                                                            .homeUserApis
                                                            .deleteFavoriteShip(
                                                                homeUserController
                                                                    .shipsDetaileData
                                                                    .value
                                                                    .data
                                                                    .id
                                                                    .toString(),
                                                                "1");
                                                        setState(() {
                                                          homeUserController
                                                              .shipsDetaileData
                                                              .value
                                                              .data
                                                              .isFavourite = 0;
                                                        });
                                                      }
                                                    }
                                                  },
                                                  child: homeUserController
                                                              .shipsDetaileData
                                                              .value
                                                              .data
                                                              .isFavourite
                                                              .toString() ==
                                                          "0"
                                                      ? Icon(
                                                          Icons.favorite_border)
                                                      : Icon(
                                                          Icons.favorite,
                                                          color: Colors.red,
                                                        ))
                                            ],
                                          )
                                        ],
                                      ),
                                      IconRow(
                                        Icons.location_on,
                                        homeUserController.shipsDetaileData
                                                    .value.data.owner ==
                                                null
                                            ? ""
                                            : '${homeUserController.shipsDetaileData.value.data.owner.location ?? ""}',
                                        iconColor: AppColors.primaryColor,
                                      ),
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
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                          CustomText(
                                            '${homeUserController.shipsDetaileData.value.data.owner.mobile}',
                                            fontColor: Colors.black,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12,
                                            textAlign: TextAlign.start,
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(2.r),
                                            child: Icon(
                                              Icons.email_rounded,
                                              size: 17.r,
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                          CustomText(
                                            '${homeUserController.shipsDetaileData.value.data.owner.email}',
                                            fontColor: Colors.black,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12,
                                            textAlign: TextAlign.start,
                                            alignment: AlignmentDirectional
                                                .centerStart,
                                          ),
                                        ],
                                      )

                                      // IconRow(
                                      //   Icons.local_offer,
                                      //   'الأسعار من: ${homeUserController.shipsDetaileData.value.data.price ?? ""}',
                                      //   iconColor: AppColors.primaryColor,
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 15.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    'الخدمات المقدمة  :',
                                    fontSize: 15,
                                    fontColor: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              homeUserController.shipsDetaileData.value.data
                                          .servicesShip ==
                                      null
                                  ? Helper.loading()
                                  : homeUserController.shipsDetaileData.value
                                          .data.servicesShip.isEmpty
                                      ? CustomText("لا يوجد تفاصيل")
                                      : ListView.separated(
                                          itemCount: homeUserController
                                              .shipsDetaileData
                                              .value
                                              .data
                                              .servicesShip
                                              .length,
                                          shrinkWrap: true,
                                          primary: false,
                                          padding: EdgeInsets.zero,
                                          separatorBuilder: (context, index) =>
                                              SizedBox(height: 5.h),
                                          itemBuilder: (context, index) {
                                            ServicesShip servicesShip =
                                                homeUserController
                                                    .shipsDetaileData
                                                    .value
                                                    .data
                                                    .servicesShip[index];
                                            return SvgRow(
                                              'check_circle',
                                              servicesShip.services == null
                                                  ? ""
                                                  : '${servicesShip.services.title ?? ""}',
                                              svgColor: AppColors.primaryColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              svgHeight: 15,
                                              svgWidth: 15,
                                            );
                                          },
                                        ),
                              // SizedBox(height: 8.h),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Divider(),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    'تفاصيل العرض:',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.watch_later_outlined,
                                        size: 18.r,
                                        color: AppColors.primaryColor,
                                      ),
                                      SizedBox(width: 5.w),
                                      CustomText(
                                        'السعر',
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 2.h),
                                    decoration: BoxDecoration(
                                      color:
                                          AppColors.hintColor.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: CustomText(
                                      '${homeUserController.shipsDetaileData.value.data.price} درهم ' +
                                          '/ ${homeUserController.shipsDetaileData.value.data.price_for} ${homeUserController.shipsDetaileData.value.data.price_for.toString() == "1" ? 'ساعة' : 'ساعات'}',
                                      fontSize: 10,
                                      fontColor: AppColors.fontSecondaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        Assets.getIconSvg('dolar'),
                                        height: 15.r,
                                        width: 15.r,
                                      ),
                                      SizedBox(width: 5.w),
                                      CustomText(
                                        'مبلغ العربون',
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 2.h),
                                    decoration: BoxDecoration(
                                      color:
                                          AppColors.hintColor.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: CustomText(
                                      '${homeUserController.shipsDetaileData.value.data.prepaid ?? "0"} درهم',
                                      fontSize: 10,
                                      fontColor: AppColors.fontSecondaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 18.r,
                                        color: AppColors.primaryColor,
                                      ),
                                      SizedBox(width: 5.w),
                                      CustomText(
                                        'المدينة',
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 2.h),
                                    decoration: BoxDecoration(
                                      color:
                                          AppColors.hintColor.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: CustomText(
                                      '${homeUserController.shipsDetaileData.value.data.country ?? "0"}',
                                      fontSize: 10,
                                      fontColor: AppColors.fontSecondaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.speaker_notes_rounded,
                                        size: 18.r,
                                        color: AppColors.primaryColor,
                                      ),
                                      SizedBox(width: 5.w),
                                      CustomText(
                                        'ملاحظات',
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.w, vertical: 2.h),
                                    decoration: BoxDecoration(
                                      color:
                                          AppColors.hintColor.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: CustomText(
                                      '${homeUserController.shipsDetaileData.value.data.notes ?? "0"}',
                                      fontSize: 10,
                                      fontColor: AppColors.fontSecondaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        Assets.getIconSvg('shape'),
                                        height: 15.r,
                                        width: 15.r,
                                      ),
                                      SizedBox(width: 5.w),
                                      CustomText(
                                        'عدد الاشخاص',
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),

                                  // Container(
                                  //   padding: EdgeInsets.symmetric(
                                  //       horizontal: 10.w, vertical: 2.h),
                                  //   decoration: BoxDecoration(
                                  //     color:
                                  //         AppColors.hintColor.withOpacity(0.4),
                                  //     borderRadius: BorderRadius.circular(10.r),
                                  //   ),
                                  //   child: CustomText(
                                  //     '${homeUserController.shipsDetaileData.value.data.number_of_persones ?? "0"}',
                                  //     fontSize: 10,
                                  //     fontColor: AppColors.fontSecondaryColor,
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  // ),
                                ],
                              ),
                              SizedBox(height: 10.h),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.date_range_outlined,
                                        size: 18.r,
                                        color: AppColors.primaryColor,
                                      ),
                                      SizedBox(width: 5.w),
                                      CustomText(
                                        'التاريخ',
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 2.h),
                                        decoration: BoxDecoration(
                                          color: AppColors.hintColor
                                              .withOpacity(0.4),
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                        child: CustomText(
                                          'من ${homeUserController.shipsDetaileData.value.data.start_date ?? "تسجيل العرض"}',
                                          fontSize: 10,
                                          fontColor:
                                              AppColors.fontSecondaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 5.w),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 2.h),
                                        decoration: BoxDecoration(
                                          color: AppColors.hintColor
                                              .withOpacity(0.4),
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                        child: CustomText(
                                          'إلى ${homeUserController.shipsDetaileData.value.data.end_date ?? "تسجيل العرض"}',
                                          fontSize: 10,
                                          fontColor:
                                              AppColors.fontSecondaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),

                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.image,
                                        size: 18.r,
                                        color: AppColors.primaryColor,
                                      ),
                                      SizedBox(width: 5.w),
                                      CustomText(
                                        'الصور',
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 6.h),
                                  Row(
                                    children: [
                                      CachedNetworkImageShare(
                                          homeUserController.shipsDetaileData
                                              .value.data.image,
                                          100,
                                          100,
                                          10)
                                    ],
                                  ),
                                ],
                              ),

                              SizedBox(height: 6.h),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Divider(),
                              ),
                              CustomText(
                                'احجز الان :',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                alignment: AlignmentDirectional.centerStart,
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: SvgRow(
                                      'time',
                                      'المدة الزمنية المطلوبة ',
                                      svgColor: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(
                                      child: CustomDropDown(
                                    value: pricehuor == 1.0
                                        ? "الافتراضي"
                                        : periodFrom,
                                    fontColor: Color.fromRGBO(0, 0, 0, 0.38),
                                    hint: "ساعة",
                                    onChanged: (val) {
                                      log(periodFrom.toString());

                                      setPeriodTime(val);
                                      pricehuor = listPeriodFrom.keys
                                          .firstWhere(
                                              (k) => listPeriodFrom[k] == val,
                                              orElse: () => null);
                                    },
                                    itemsList: listPeriodFrom.values.toList(),
                                  )),
                                ],
                              ),
                              Visibility(
                                  visible: pricehuor == 0,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 8.h),
                                      CustomTextFormField(
                                        hintText: 'المدة الزمنية',
                                        fillColor: Colors.white,
                                        isBoxShadow: false,
                                        textInputType: TextInputType.number,
                                        onSaved: setPeriodTime,
                                        validator: Helper.validationNull,
                                        prefixIcon: Icon(
                                          Icons.timelapse_rounded,
                                          size: 22.r,
                                          color: AppColors.primaryColor,
                                        ),
                                      )
                                    ],
                                  )),
                              SizedBox(height: 8.h),
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
                                    },
                                    child: CustomTextFormField(
                                      hintText: "من",
                                      textEditingController: timeFrom,
                                      fillColor: Colors.white,
                                      isBoxShadow: false,
                                      onSaved: setPeriodTime,
                                      validator: Helper.validationNull,
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
                                      hintText: "الى",
                                      textEditingController: timeTo,
                                      fillColor: Colors.white,
                                      isBoxShadow: false,
                                      onSaved: setPeriodTime,
                                      validator: Helper.validationNull,
                                      enabled: false,
                                    ),
                                  )),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: SvgRow(
                                      'circle_user',
                                      'عدد الأشخاص',
                                      svgColor: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Expanded(
                                    child: CustomDropDown(
                                      value: noPerson,
                                      hint: "عدد الاشخاص",
                                      onChanged: (val) {
                                        setState(() {
                                          noPerson = val;
                                        });
                                      },
                                      itemsList: listNoPerson,
                                    ),
                                  ),
                                ],
                              ),
                              // SizedBox(height: 10.h),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Divider(),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomText(
                                    'تاريخ الحجز:',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    alignment: AlignmentDirectional.centerStart,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      selectDate(context);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgRow(
                                          'date',
                                          '${initDate.year}/${initDate.month}/${initDate.day}',
                                          fontColor: AppColors.primaryColor,
                                          svgColor: AppColors.primaryColor,
                                        ),
                                        SizedBox(width: 5.w),
                                        Icon(
                                          Icons.keyboard_arrow_down_outlined,
                                          size: 22.r,
                                          color: AppColors.primaryColor,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Divider(),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomText(
                                    'طريقة الدفع :',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    alignment: AlignmentDirectional.centerStart,
                                  ),
                                  SizedBox(width: 8.w),
                                  homeUserController.shipsDetaileData.value.data
                                              .prepaid ==
                                          "0"
                                      ? CustomText(
                                          'دفع عربون فقط',
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          fontSize: 10,
                                        )
                                      : CustomText(
                                          'دفع مبلغ الحجز كاملاً',
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          fontSize: 10,
                                        ),
                                ],
                              ),
                              SizedBox(height: 20.h),
                              Container(
                                width: double.infinity,
                                height: 50.h,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.w, vertical: 5.h),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(10.r),
                                  color: AppColors.secondaryColor,
                                ),
                                child: CustomText(
                                  'المبلغ الأجمالي: ${(double.parse(homeUserController.shipsDetaileData.value.data.price.toString()) * pricehuor).toInt()} درهم',
                                  fontColor: AppColors.fontSecondaryColor,
                                ),
                              ),
                              SizedBox(height: 12.h),
                              CustomButton(
                                  text: 'تأكيد الحجز',
                                  onTap: () {
                                    if (selectedDateNew == null) {
                                      Helper.getSheetError(
                                          "تأكيد من تاريخ الحجز");
                                    } else {
                                      if (timeTo.text == "" &&
                                          timeFrom.text == "") {
                                        Helper.getSheetError(
                                            "تأكيد من وقت الحجز");
                                      } else if (noPerson == null) {
                                        Helper.getSheetError(
                                            "تأكيد من عدد الاشخاص");
                                      } else {
                                        OrderUserApi.orderUserApi.sendOrder(
                                            timeFrom.text,
                                            timeTo.text,
                                            homeUserController
                                                .shipsDetaileData.value.data.id
                                                .toString(),
                                            isCompleat2 ? "cash" : "prepaid",
                                            homeUserController
                                                .getProfileUserData
                                                .value
                                                .data
                                                .mobile,
                                            periodFrom,
                                            noPerson,
                                            "${selectedDateNew.day}/${selectedDateNew.month}/${selectedDateNew.year}",
                                            (double.parse(homeUserController
                                                        .shipsDetaileData
                                                        .value
                                                        .data
                                                        .price
                                                        .toString()) *
                                                    pricehuor)
                                                .toString());
                                      }
                                    }
                                    // Get.defaultDialog(
                                    //   title: 'تم تأكيد الحجز بنجاح',
                                    //   radius: 10.r,
                                    //   titlePadding: EdgeInsetsDirectional.only(
                                    //       top: 15.h, bottom: 4.h),
                                    //   titleStyle: TextStyle(
                                    //       fontSize: 15.sp,
                                    //       color: AppColors.fontPrimaryColor,
                                    //       fontWeight: FontWeight.bold),
                                    //   content: Column(
                                    //     mainAxisAlignment: MainAxisAlignment.start,
                                    //     crossAxisAlignment: CrossAxisAlignment.center,
                                    //     children: [
                                    //       SvgPicture.asset(
                                    //         Assets.getIconSvg('request_success'),
                                    //         fit: BoxFit.contain,
                                    //         width: 150.r,
                                    //         height: 150.r,
                                    //       ),
                                    //     ],
                                    //   ),
                                    // );
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      );
    });
  }
}