import 'package:country_code_picker/country_code_picker.dart';
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
import 'package:yacht_booking/view/vendor/choose_category_screen.dart';
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

  setName(String value) {
    this.name = value;
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
  }

  setDialCode(String value) {
    this.dialCode = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    top: 220.h,
                    start: 15.w,
                    end: 15.w,
                    child: Container(
                      width: double.infinity,
                      height: _mainVendorController.vendor ? 550.h : 520.h,
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
                            // mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.center,
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
                              SizedBox(height: 40.h),
                              CustomTextFormField(
                                hintText: 'أسم المستخدم',
                                prefixIcon: Icon(
                                  Icons.person,
                                  size: 22.r,
                                  color: AppColors.hintColor,
                                ),
                                isBoxShadow: false,
                                fillColor: Colors.white,
                                onSaved: setName,
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
                                fillColor: Colors.white,
                                onSaved: setEmail,
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
                                fillColor: Colors.white,
                                obscureText: true,
                                onSaved: setPassword,
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
                                fillColor: Colors.white,
                                obscureText: true,
                                onSaved: setConfirmPassword,
                                validator: Helper.validationString,
                              ),
                              SizedBox(height: 15.h),
                              CustomTextFormField(
                                hintText: 'رقم الهاتف',
                                onSaved: setMobile,
                                validator: Helper.validationNull,
                                prefixIcon: Icon(
                                  Icons.call,
                                  size: 22.r,
                                  color: AppColors.hintColor,
                                ),
                                isBoxShadow: false,
                                fillColor: Colors.white,
                                textInputType: TextInputType.phone,
                                suffixIcon: Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: CountryCodePicker(
                                    onChanged: print,
                                    initialSelection: 'AE',
                                    favorite: ['+971', 'AE'],
                                    showCountryOnly: false,
                                    showOnlyCountryWhenClosed: false,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5.r, horizontal: 5.r),
                                    flagWidth: 25.w,
                                    textStyle: TextStyle(
                                      fontSize: 13.sp,
                                      color: AppColors.fontSecondaryColor,
                                    ),
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
                                height: 20.h,
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
                  start: 15.w, end: 15.w, bottom: 15.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomButton(
                    text: 'إنشاء الحساب',
                    onTap: () {
                      if (registerFormKey.currentState.validate()) {
                        registerFormKey.currentState.save();
                        if (_mainVendorController.vendor) {
                          HomeUserApis.homeUserApis.getCategories();

                          Get.to(
                            () => ChooseCategoryScreen(
                              name: name,
                              address: cityName,
                              confirmPassword: confirmPassword,
                              email: email,
                              mobile: mobile,
                              password: password,
                              type: 'vendor',
                            ),
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
                      // Get.offAll(() => BottomNavBarScreen());
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
                          fontSize: 14.sp,
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
