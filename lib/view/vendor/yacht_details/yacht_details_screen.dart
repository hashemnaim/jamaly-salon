import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/view/widgets/custom_app_bar.dart';
import 'package:yacht_booking/view/widgets/custom_button.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';
import 'package:yacht_booking/view/widgets/custom_text_form_field.dart';

class YachtDetailsScreen extends StatefulWidget {
  const YachtDetailsScreen({Key key}) : super(key: key);

  @override
  State<YachtDetailsScreen> createState() => _YachtDetailsScreenState();
}

class _YachtDetailsScreenState extends State<YachtDetailsScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'تفاصيل اليخت',
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
                    CustomText(
                      'البيانات الخاصة:',
                      alignment: AlignmentDirectional.centerStart,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 10.h),
                    CustomTextFormField(
                      hintText: 'اسم الشركة',
                      fillColor: Colors.white,
                      isBoxShadow: false,
                      enabled: false,
                      prefixIcon: Icon(
                        Icons.person,
                        size: 22.r,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    CustomTextFormField(
                      hintText: 'تحديد المدينة',
                      fillColor: Colors.white,
                      isBoxShadow: false,
                      enabled: false,
                      prefixIcon: Icon(
                        Icons.location_on,
                        size: 22.r,
                        color: AppColors.primaryColor,
                      ),
                      suffixIcon: Icon(
                        Icons.keyboard_arrow_down,
                        size: 22.r,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    CustomTextFormField(
                      hintText: 'من 100 الى 1000',
                      fillColor: Colors.white,
                      isBoxShadow: false,
                      enabled: false,
                      prefixIcon: Icon(
                        Icons.monetization_on,
                        size: 22.r,
                        color: AppColors.primaryColor,
                      ),
                      suffixIcon: Icon(
                        Icons.keyboard_arrow_down,
                        size: 22.r,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    CustomTextFormField(
                      hintText: 'اضافة صور',
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
                    Container(
                      height: 75.h,
                      width: double.infinity,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 6,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 5.w),
                        itemBuilder: (context, index) => Container(
                          width: 120.w,
                          height: 60.h,
                          padding: EdgeInsetsDirectional.all(5.r),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            image: DecorationImage(
                              image: AssetImage(
                                Assets.getImage('bg'),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: InkWell(
                            onTap: () {},
                            child: Align(
                              alignment: AlignmentDirectional.topStart,
                              child: Container(
                                height: 20.r,
                                width: 20.r,
                                alignment: AlignmentDirectional.center,
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
                    ),
                    SizedBox(height: 10.h),
                    CustomTextFormField(
                      hintText: 'مواعيد توفر الحجز',
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
                    SizedBox(height: 10.h),
                    CustomText(
                      'الخدمات المتوفرة:',
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
                    SizedBox(height: 10.h),
                    CustomText(
                      'طريقة الحجز:',
                      alignment: AlignmentDirectional.centerStart,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: 24.r,
                                height: 24.r,
                                child:
                                    Checkbox(value: true, onChanged: (val) {})),
                            SizedBox(width: 5.w),
                            CustomText(
                              'دفع عربون فقط',
                              fontSize: 12,
                              fontColor: AppColors.fontSecondaryColor,
                            ),
                          ],
                        ),
                        SizedBox(width: 15.w),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: 24.r,
                                height: 24.r,
                                child:
                                    Checkbox(value: true, onChanged: (val) {})),
                            SizedBox(width: 5.w),
                            CustomText(
                              'دفع عربون فقط',
                              fontSize: 12,
                              fontColor: AppColors.fontSecondaryColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    CustomTextFormField(
                      hintText: 'مبلغ العربون',
                      fillColor: Colors.white,
                      textInputType: TextInputType.number,
                      isBoxShadow: false,
                      enabled: false,
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
                      enabled: false,
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
                  ],
                ),
              ),
              SizedBox(height: 15.h),
              CustomButton(
                text: 'اضافة العرض',
                onTap: () {
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
