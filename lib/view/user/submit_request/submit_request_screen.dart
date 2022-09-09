import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/apis/order_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/user/home_user_controller.dart';
import 'package:yacht_booking/models/services_model.dart';
import 'package:yacht_booking/view/widgets/cash_network_image_share.dart';
import 'package:yacht_booking/view/widgets/custom_app_bar.dart';
import 'package:yacht_booking/view/widgets/custom_button.dart';
import 'package:yacht_booking/view/widgets/custom_drop_down.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';
import 'package:yacht_booking/view/widgets/custom_text_form_field.dart';
import 'package:yacht_booking/view/widgets/svg_row.dart';

class SubmitRequestScreen extends StatefulWidget {
  const SubmitRequestScreen({Key key}) : super(key: key);

  @override
  _SubmitRequestScreenState createState() => _SubmitRequestScreenState();
}

class _SubmitRequestScreenState extends State<SubmitRequestScreen> {
  HomeUserController homeUserController = Get.find();
  GlobalKey<FormState> requestOrder = GlobalKey<FormState>();
  int _selectedIndex;
  String serviceId;
  String country, price, periodFrom, periodTo, noPerson, note;
  double rate = 0;
  String selectedDateNew;
  setPrice(String price) => this.price = price;
  setNoPerson(String noPerson) => this.noPerson = noPerson;
  List<String> listCountry = [
    'أبوظبي',
    "عجمان",
    "دبي",
    "الفجيرة",
    "رأس الخيمة",
    "الشارقة",
    "أم القيوين",
  ];
  double pricehuor = 1;
  Map<double, String> listPeriodFrom = {
    0.5: "30 دقيقة",
    1.0: "ساعة",
    2.0: "ساعتين",
    3.0: "3 ساعات",
    4.0: "4 ساعات",
    5.0: "5 ساعات",
    6.0: "6 ساعات",
    7.0: "7 ساعات",
    0.0: "مخصص",
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
  // List<String> listNoPerson = [
  //   "اقل من 5",
  //   "من 5 الى 10",
  //   "اكثر من 10",
  // ];

  setNote(String value) {
    this.note = value;
  }

  setSelectedDateNew(String value) {
    this.selectedDateNew = value;
    setState(() {});
  }

  setPeriodTime(String val) {
    setState(() {
      periodFrom = val;
    });
  }

  TimeOfDay _selectedTime;
  TextEditingController timeFrom = TextEditingController(text: "من");
  TextEditingController timeTo = TextEditingController(text: "الى");

  DateTime selectedDate = DateTime.now();
  TextEditingController _textEditingController = TextEditingController();

  selectDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate != null ? selectedDate : DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2040),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.white,
                onPrimary: AppColors.primaryColor,
                surface: AppColors.primaryColor,
                onSurface: Colors.white,
              ),
              dialogBackgroundColor: AppColors.primaryColor,
            ),
            child: child,
          );
        });

    if (newSelectedDate != null) {
      selectedDate = newSelectedDate;
      setSelectedDateNew("${selectedDate.toLocal()}".split(' ')[0]);
      _textEditingController
        ..text = "${selectedDate.toLocal()}".split(' ')[0]

        // DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textEditingController.text.length,
            affinity: TextAffinity.upstream));
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
    return Scaffold(
      appBar: CustomAppBar(
        title: 'طلبك حسب ميزانيتك',
        backFun: () => Get.back(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsetsDirectional.all(13.r),
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: CustomText(
                'صمم طلبك الخاص حسب ميزانيتك من خلال تحديد خياراتك المفضلة وستصلك العروض من مزودي الخدمه',
                maxLines: 5,
                fontSize: 13,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12.w),
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: CustomText(
                      'اختر نوع الخدمه',
                      fontWeight: FontWeight.bold,
                      alignment: AlignmentDirectional.centerStart,
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Container(
                    height: 93.r,
                    child: homeUserController.getServicesData.value.data == null
                        ? Center(
                            child: Helper.loading(),
                          )
                        : homeUserController.getServicesData.value.data.isEmpty
                            ? Center(
                                child: CustomText("لا يوجد خدمات"),
                              )
                            : ListView.separated(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsetsDirectional.only(
                                  top: 3.h,
                                  bottom: 3.h,
                                  start: 12.w,
                                  end: 12.w,
                                ),
                                itemCount: homeUserController
                                    .getServicesData.value.data.length,
                                separatorBuilder: (context, index) =>
                                    SizedBox(width: 5.w),
                                itemBuilder: (context, index) {
                                  ServicesModelData servicesModelData =
                                      homeUserController
                                          .getServicesData.value.data[index];
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        _selectedIndex = index;
                                        serviceId =
                                            servicesModelData.id.toString();
                                      });
                                    },
                                    child: Container(
                                      width: 88.r,
                                      height: 88.r,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5.w),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: AppColors.boxShadow,
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        border: _selectedIndex == index
                                            ? Border.all(
                                                color: AppColors.primaryColor)
                                            : null,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          _selectedIndex == index
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
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white,
                                                      boxShadow:
                                                          AppColors.boxShadow,
                                                    ),
                                                    child: Container(
                                                      width: 8.r,
                                                      height: 8.r,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: AppColors
                                                            .primaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(),
                                          CustomText(
                                            '${servicesModelData.title ?? ''}',
                                            fontSize: 10,
                                            height: 1,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          servicesModelData.icon == null
                                              ? SvgPicture.asset(
                                                  Assets.getIconSvg('logo'),
                                                  width: 25.r,
                                                  height: 25.r,
                                                  fit: BoxFit.contain,
                                                  color: AppColors.primaryColor,
                                                )
                                              : CachedNetworkImageShare(
                                                  servicesModelData.icon,
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Column(
                      children: [
                        SizedBox(height: 15.h),
                        CustomDropDown(
                          value: country,
                          hint: "حدد المدينة",
                          itemsList: listCountry,
                          onChanged: (val) {
                            setState(() {
                              country = val;
                            });
                          },
                          height: 52,
                          fontSize: 13,
                          backgroundColor: Colors.white,
                        ),
                        SizedBox(height: 5.h),
                        CustomTextFormField(
                          hintText: 'الميزانية',
                          isBoxShadow: false,
                          fillColor: Colors.white,
                          onSaved: setPrice,
                          textInputType: TextInputType.number,
                          validator: Helper.validationNull,
                        ),
                        SizedBox(height: 10.h),
                        CustomText(
                          'تفاصيل الحجز :',
                          fontWeight: FontWeight.bold,
                          alignment: AlignmentDirectional.centerStart,
                          fontSize: 13,
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
                              value: pricehuor == 0.0 ? "مخصص" : periodFrom,
                              fontColor: Color.fromRGBO(0, 0, 0, 0.38),
                              hint: "ساعة",
                              onChanged: (val) {
                                setPeriodTime(val);
                                pricehuor = listPeriodFrom.keys.firstWhere(
                                    (k) => listPeriodFrom[k] == val,
                                    orElse: () => null);
                              },
                              itemsList: listPeriodFrom.values.toList(),
                            )),
                          ],
                        ),
                        Visibility(
                            visible: periodFrom == "مخصص",
                            child: Column(
                              children: [
                                SizedBox(height: 8.h),
                                CustomTextFormField(
                                  hintText: 'المدة الزمنية',
                                  fillColor: Colors.white,
                                  isBoxShadow: false,
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
                                hintText: timeFrom.text,
                                fillColor: Colors.white,
                                isBoxShadow: false,
                                onSaved: setPeriodTime,
                                validator: Helper.validationNull,
                                enabled: false,
                              ),
                            )
                                // CustomDropDown(
                                //   value: timeFrom,
                                //   hint: "من",
                                //   onChanged: (val) {
                                //     setState(() {
                                //       timeFrom = val;
                                //     });
                                //   },
                                //   itemsList: listTimeFrom,
                                // ),
                                ),
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
                                validator: Helper.validationNull,
                                enabled: false,
                              ),
                            )),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        CustomTextFormField(
                          hintText: 'عدد الأشخاص',
                          textInputType: TextInputType.number,
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(14),
                            child: SvgPicture.asset(
                              Assets.getIconSvg('circle_user'),
                              width: 14.w,
                              height: 14.h,
                              fit: BoxFit.contain,
                            ),
                          ),
                          isBoxShadow: false,
                          fillColor: Colors.white,
                          onSaved: setNoPerson,
                          validator: Helper.validationNull,
                        )
                        // Row(
                        //   children: [
                        //     SvgRow(
                        //       'circle_user',
                        //       'عدد الأشخاص',
                        //       svgColor: AppColors.primaryColor,
                        //       fontWeight: FontWeight.bold,
                        //     ),
                        //     SizedBox(width: 10.w),
                        //     Expanded(
                        //       child: CustomDropDown(
                        //         value: noPerson,
                        //         hint: "عدد الاشخاص",
                        //         onChanged: (val) {
                        //           setState(() {
                        //             noPerson = val;
                        //           });
                        //         },
                        //         itemsList: listNoPerson,
                        //         backgroundColor: Colors.grey[300],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        ,
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            SvgRow(
                              'date',
                              'تاريخ الحجز',
                              svgColor: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                                child: InkWell(
                              onTap: () {
                                return selectDate(context);
                              },
                              child: Container(
                                height: 40.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: AppColors.secondaryColor),
                                  // boxShadow: AppColors.boxShadow,
                                ),
                                child: CustomText(
                                  selectedDateNew == null
                                      ? "حدد تاريخ الحجز"
                                      : selectedDateNew,
                                  fontColor: Colors.grey[400],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )),
                          ],
                        ),
                        // SizedBox(height: 15.h),
                        // CustomText(
                        //   'تفاصيل الحجز :',
                        //   fontWeight: FontWeight.bold,
                        //   fontSize: 13,
                        // ),
                        // SizedBox(height: 3.h),
                        //  RatingBar.builder(
                        //             initialRating: topRatOfferModelData.rate == null
                        //       ? 0
                        //       : double.parse(topRatOfferModelData.rate.toString()),
                        //             direction: Axis.horizontal,
                        //             tapOnlyMode: true,
                        //             ignoreGestures: true,
                        //             allowHalfRating: true,
                        //             itemCount: 5,
                        //             itemSize: 16,
                        //             itemPadding: const EdgeInsets.symmetric(
                        //                 horizontal: 1.0),
                        //             itemBuilder: (context, _) => const Icon(
                        //               Icons.star,
                        //               color: Colors.amber,
                        //               size: 1,
                        //             ),
                        //             onRatingUpdate: (rating) => null,
                        //           ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Form(
              key: requestOrder,
              child: CustomTextFormField(
                hintText: 'يمكنك إضافة ملاحظات اضافية',
                maxLines: 4,
                isBoxShadow: false,
                isBorderSide: false,
                onSaved: setNote,
                validator: (value) {},
              ),
            ),
            SizedBox(height: 20),
            CustomButton(
              text: 'قدم طلبك الآن',
              onTap: () {
                if (requestOrder.currentState.validate()) {
                  requestOrder.currentState.save();
                  if (_selectedIndex == null) {
                    Helper.getSheetError("يجب اختيار الخدمه");
                  } else {
                    OrderUserApi.orderUserApi.orderRequest(
                        timeFrom.text,
                        timeTo.text,
                        serviceId,
                        periodFrom ?? "ساعة",
                        noPerson,
                        selectedDateNew,
                        price,
                        note);
                  }
                }
                // Get.defaultDialog(
                //   title:
                //       'تم تقديم العرض بنجاح وستصلك اشعارات بالعروض بمجرد توفرها',
                //   radius: 10.r,
                //   titlePadding:
                //       EdgeInsetsDirectional.only(top: 15.h, bottom: 4.h),
                //   titleStyle: TextStyle(
                //     fontSize: 14.sp,
                //     color: AppColors.fontPrimaryColor,
                //     fontWeight: FontWeight.bold,
                //   ),
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
