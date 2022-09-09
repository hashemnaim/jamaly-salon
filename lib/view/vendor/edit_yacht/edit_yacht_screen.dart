import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/view/widgets/custom_app_bar.dart';
import 'package:yacht_booking/view/widgets/custom_button.dart';
import 'package:yacht_booking/view/widgets/custom_drop_down.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';
import 'package:yacht_booking/view/widgets/custom_text_form_field.dart';

class EditYachtScreen extends StatefulWidget {
  const EditYachtScreen({Key key}) : super(key: key);

  @override
  State<EditYachtScreen> createState() => _EditYachtScreenState();
}

class _EditYachtScreenState extends State<EditYachtScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'تعديل بيانات اليخت',
        backFun: () {
          Get.back();
        },
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
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
                    CustomTextFormField(
                      hintText: 'اسم الشركة',
                      fillColor: Colors.white,
                      isBoxShadow: false,
                      prefixIcon: Icon(
                        Icons.person,
                        size: 22.r,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    CustomDropDown(
                      value: 'تحديد المدينة',
                      itemsList: ['تحديد المدينة'],
                      onChanged: (val) {},
                      backgroundColor: Colors.white,
                      fontColor: AppColors.hintColor,
                      borderColor: AppColors.borderColor,
                      iconColor: AppColors.hintColor,
                      fontSize: 12,
                      height: 55,
                    ),
                    SizedBox(height: 10.h),
                    CustomTextFormField(
                      hintText: 'تحديد الاسعار',
                      fillColor: Colors.white,
                      isBoxShadow: false,
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
                      hintText: 'اضافة صور / فيديوهات',
                      fillColor: Colors.white,
                      isBoxShadow: false,
                      enabled: false,
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
                    SizedBox(height: 10.h),
                    InkWell(
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime(2020, 11, 17),
                          firstDate: DateTime(2017, 1),
                          lastDate: DateTime(2022, 7),
                          helpText: 'Select a date',
                        );
                      },
                      child: CustomTextFormField(
                        hintText: 'تاريخ بداية / انتهاء الحجز',
                        fillColor: Colors.white,
                        isBoxShadow: false,
                        enabled: false,
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
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(hour: 7, minute: 15),
                        );
                      },
                      child: CustomTextFormField(
                        hintText: 'توقيت الحجز',
                        fillColor: Colors.white,
                        isBoxShadow: false,
                        enabled: false,
                        prefixIcon: Icon(
                          Icons.watch_later_outlined,
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
                          child: CustomDropDown(
                            value: 'عدد الساعات:',
                            itemsList: ['عدد الساعات:'],
                            onChanged: (val) {},
                            backgroundColor: Colors.white,
                            fontColor: AppColors.hintColor,
                            borderColor: AppColors.borderColor,
                            iconColor: AppColors.hintColor,
                            fontSize: 12,
                            height: 55,
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Expanded(
                          child: CustomDropDown(
                            value: 'عدد الاشخاص:',
                            itemsList: ['عدد الاشخاص:'],
                            onChanged: (val) {},
                            backgroundColor: Colors.white,
                            fontColor: AppColors.hintColor,
                            borderColor: AppColors.borderColor,
                            iconColor: AppColors.hintColor,
                            fontSize: 12,
                            height: 55,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    CustomText(
                      'اختر الخدمه المقدمة  :',
                      alignment: AlignmentDirectional.centerStart,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      height: 93.r,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsetsDirectional.only(
                          top: 3.h,
                          bottom: 3.h,
                          end: 12.w,
                        ),
                        itemCount: 6,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 5.w),
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                          child: Container(
                            width: 120.r,
                            height: 88.r,
                            padding: EdgeInsets.symmetric(horizontal: 5.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: AppColors.boxShadow,
                              borderRadius: BorderRadius.circular(10.r),
                              border: _selectedIndex == index
                                  ? Border.all(color: AppColors.primaryColor)
                                  : null,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                _selectedIndex == index
                                    ? Align(
                                        alignment:
                                            AlignmentDirectional.centerEnd,
                                        child: Container(
                                          width: 10.r,
                                          height: 10.r,
                                          alignment:
                                              AlignmentDirectional.center,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            boxShadow: AppColors.boxShadow,
                                          ),
                                          child: Container(
                                            width: 8.r,
                                            height: 8.r,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                        ),
                                      )
                                    : SizedBox(),
                                CustomText(
                                  'أعياد ميلاد',
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
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    CustomDropDown(
                      value: 'طريقة الحجز:',
                      itemsList: ['طريقة الحجز:'],
                      onChanged: (val) {},
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
                      textInputType: TextInputType.number,
                      isBoxShadow: false,
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
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
              SizedBox(height: 15.h),
              CustomButton(text: 'اضافة العرض', onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
