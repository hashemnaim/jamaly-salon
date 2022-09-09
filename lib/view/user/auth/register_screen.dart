import 'dart:io';

import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/apis/auth_apis.dart';
import 'package:yacht_booking/apis/home_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/common/constant.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/vendor/main_vendor_controller.dart';
import 'package:yacht_booking/view/user/terms_and_conditions/terms_and_conditions.dart';
import 'package:yacht_booking/view/widgets/custom_app_bar.dart';
import 'package:yacht_booking/view/widgets/custom_button.dart';
import 'package:yacht_booking/view/widgets/custom_drop.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';
import 'package:yacht_booking/view/widgets/custom_text_form_field.dart';

import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();
  final MainVendorController _mainVendorController = Get.find();

  String name, password, confirmPassword, mobile, email, dialCode;
  bool isTerm = false;
  int city = citys[0]['id'];
  String cityName;
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  FocusNode focusNode4 = FocusNode();
  FocusNode focusNode5 = FocusNode();
  setName(String value) {
    this.name = value;
    // focusNode1.nextFocus();
  }

  setPassword(String value) {
    this.password = value;
  }

  setConfirmPassword(String value) {
    this.confirmPassword = value;
  }

  setMobile(String value) {
    this.mobile = value;
  }

  setEmail(String value) {
    this.email = value;
    // focusNode2.nextFocus();
  }

  setDialCode(String value) {
    this.dialCode = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: double.infinity,
                      height: 280.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(Assets.getImage('khalefa')),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black26, BlendMode.darken),
                        ),
                      ),
                      child: Column(
                        children: [
                          CustomAppBar(
                            title: '',
                            backgroundColor: Colors.transparent,
                            iconBackColor: Colors.white,
                            backFun: () {
                              Get.back();
                            },
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(start: 15.w),
                            child: CustomText(
                              'أهلاً بك.',
                              alignment: AlignmentDirectional.topStart,
                              fontColor: Colors.white,
                              fontSize: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    top: 230.h,
                    bottom:
                        WidgetsBinding.instance.window.viewInsets.bottom > 0.0
                            ? MediaQuery.of(context).viewInsets.bottom - 70.h
                            : 20,
                    start: 15.w,
                    end: 15.w,
                    child: Container(
                      width: double.infinity,
                      height: _mainVendorController.vendor ? 500.h : 520.h,
                      padding: EdgeInsetsDirectional.all(15.r),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadiusDirectional.circular(15.r),
                        boxShadow: AppColors.boxShadow,
                      ),
                      child: Form(
                        key: registerFormKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              CustomText(
                                'حساب جديد',
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(height: 3.h),
                              Column(
                                children: [
                                  Container(
                                    width: 110.w,
                                    height: 1.h,
                                    color: AppColors.fontPrimaryColor,
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.h),
                              CustomText(
                                _mainVendorController.vendor
                                    ? 'إنشاء حساب مزود'
                                    : 'إنشاء حساب شخصي',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontColor: AppColors.primaryColor,
                              ),
                              SizedBox(height: 20.h),
                              CustomTextFormField(
                                hintText: 'أسم المستخدم',
                                prefixIcon: Icon(
                                  Icons.person,
                                  size: 22.r,
                                  color: AppColors.hintColor,
                                ),
                                isBoxShadow: false,
                                isComplate: true,
                                fillColor: Colors.white,
                                onSaved: setName,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: () {
                                  FocusScope.of(context)
                                      .requestFocus(focusNode2);
                                  setState(() {});
                                },
                                focusNode: focusNode1,
                                textInputType: TextInputType.name,
                                validator: Helper.validationNull,
                              ),
                              SizedBox(height: 15.h),
                              CustomTextFormField(
                                hintText: 'البريد الالكتروني',
                                prefixIcon: Icon(
                                  Icons.email_rounded,
                                  size: 22.r,
                                  color: AppColors.hintColor,
                                ),
                                isBoxShadow: false,
                                isComplate: true,
                                fillColor: Colors.white,
                                onSaved: setEmail,
                                textInputAction: TextInputAction.next,
                                focusNode: focusNode2,
                                onFieldSubmitted: () {
                                  FocusScope.of(context)
                                      .requestFocus(focusNode3);
                                  setState(() {});
                                },
                                textInputType: TextInputType.emailAddress,
                                validator: Helper.validationEmail,
                              ),
                              SizedBox(height: 15.h),
                              CustomTextFormField(
                                hintText: 'كلمة المرور',
                                prefixIcon: Icon(
                                  Icons.lock,
                                  size: 22.r,
                                  color: AppColors.hintColor,
                                ),
                                isBoxShadow: false,
                                isComplate: true,
                                fillColor: Colors.white,
                                obscureText: true,
                                textInputAction: TextInputAction.next,
                                focusNode: focusNode3,
                                onFieldSubmitted: () {
                                  FocusScope.of(context)
                                      .requestFocus(focusNode4);
                                  setState(() {});
                                },
                                onSaved: setPassword,
                                textInputType: TextInputType.visiblePassword,
                                validator: Helper.validationString,
                              ),
                              SizedBox(height: 15.h),
                              CustomTextFormField(
                                hintText: 'تأكيد كلمة المرور',
                                prefixIcon: Icon(
                                  Icons.lock,
                                  size: 22.r,
                                  color: AppColors.hintColor,
                                ),
                                isBoxShadow: false,
                                isComplate: true,
                                fillColor: Colors.white,
                                obscureText: true,
                                focusNode: focusNode4,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: () {
                                  FocusScope.of(context)
                                      .requestFocus(focusNode5);
                                  setState(() {});
                                },
                                textInputType: TextInputType.visiblePassword,
                                onSaved: setConfirmPassword,
                                validator: (value) {
                                  if (password == null || password == '') {
                                    return 'الحقل مطلوب'.tr;
                                  } else if (password.length < 8) {
                                    return 'يجب ان يكون اكبر من 8 احرف'.tr;
                                  } else if (password != confirmPassword) {
                                    return 'تأكيد المرور غير صحيح'.tr;
                                  }
                                },
                              ),
                              SizedBox(height: 15.h),
                              CustomTextFormField(
                                hintText: 'رقم الهاتف',
                                onSaved: setMobile,
                                textInputType: Platform.isAndroid == false
                                    ? TextInputType.text
                                    : TextInputType.number,
                                validator: Helper.validationNull,
                                prefixIcon: Icon(
                                  Icons.call,
                                  size: 22.r,
                                  color: AppColors.hintColor,
                                ),
                                isBoxShadow: false,
                                isComplate: true,
                                fillColor: Colors.white,
                                textInputAction: TextInputAction.done,
                                focusNode: focusNode5,
                                onFieldSubmitted: () {
                                  FocusScope.of(context).unfocus();
                                },
                                suffixIcon: Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: CountryPickerDropdown(
                                    initialValue: 'AE',
                                    onValuePicked: (Country value) {},
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Visibility(
                                visible: _mainVendorController.vendor,
                                child: CustomDrop(
                                  dropList: citys,
                                  onTap: (Map<String, dynamic> item) {
                                    setState(() {
                                      city = item['id'];
                                      cityName = item['name'];
                                    });
                                  },
                                  initValue: city,
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 24.r,
                                        height: 24.r,
                                        child: Checkbox(
                                          value: isTerm,
                                          onChanged: (val) {
                                            isTerm = val;
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 5.w),
                                      CustomText(
                                        'أوافق على الشروط و الأحكام',
                                        fontSize: 12,
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      HomeUserApis.homeUserApis.getTerms();
                                      Get.to(() => TermsAndConditionsScreen());
                                    },
                                    child: CustomText(
                                      'عرض الشروط',
                                      fontSize: 12,
                                      fontColor: AppColors.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 65.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(
                  start: 15.w, end: 15.w, bottom: 10.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomButton(
                    text: 'إنشاء الحساب',
                    onTap: () async {
                      if (registerFormKey.currentState.validate()) {
                        registerFormKey.currentState.save();
                        if (isTerm == false) {
                          Helper.getSheetError(
                              "يجب الموافقة على الشروط والاحكام");
                        } else {
                          if (_mainVendorController.vendor) {
                            HomeUserApis.homeUserApis.getCategories();

                            await AuthApis.authApis.registerUser(
                              name,
                              email,
                              password,
                              confirmPassword,
                              'vendor',
                              mobile,
                              cityName,
                              [].toString(),
                            );
                          } else {
                            AuthApis.authApis.registerUser(
                              name,
                              email,
                              password,
                              confirmPassword,
                              'user',
                              mobile,
                              null,
                              [].toString(),
                            );
                          }
                        }
                      }
                    },
                  ),
                  SizedBox(height: 4.h),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'تمتلك حساب بالفعل؟  ',
                        style: TextStyle(
                          color: AppColors.fontSecondaryColor,
                          fontSize: 14.sp,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      TextSpan(
                        text: 'دخول',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16.sp,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.off(() => LoginScreen());
                          },
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
