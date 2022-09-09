import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/apis/auth_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/vendor/main_vendor_controller.dart';
import 'package:yacht_booking/view/user/auth/confirmation_code_screen.dart';
import 'package:yacht_booking/view/user/auth/register_screen.dart';
import 'package:yacht_booking/view/widgets/custom_app_bar.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';
import 'package:yacht_booking/view/widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final MainVendorController _mainVendorController = Get.find();
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  String email, password;
  setEmail(String value) {
    this.email = value;
  }

  setPassword(String value) {
    this.password = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 320.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Assets.getImage('khalefa')),
                        fit: BoxFit.cover,
                        colorFilter:
                            ColorFilter.mode(Colors.black26, BlendMode.darken),
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
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: 15.w,
                      end: 15.w,
                      top: 340.h,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'لا تملك حساب؟  ',
                              style: TextStyle(
                                color: AppColors.fontSecondaryColor,
                                fontSize: 14.sp,
                                fontFamily: 'Cairo',
                              ),
                            ),
                            TextSpan(
                                text: 'يمكنك التسجيل بكل سهولة',
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 14.sp,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.off(() => RegisterScreen());
                                  }),
                          ]),
                        ),
                        SizedBox(height: 8.h),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => ConfirmationCodeScreen());
                          },
                          child: CustomText(
                            'هل نسيت كلمة المرور؟',
                            fontColor: AppColors.fontSecondaryColor,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(height: 25.h),
                        // CustomText(
                        //   ' أو تسجيل الدخول من خلال',
                        //   fontColor: AppColors.primaryColor,
                        //   fontSize: 12,
                        //   fontWeight: FontWeight.bold,
                        // ),
                        // SizedBox(height: 20.h),
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     InkWell(
                        //       onTap: () {},
                        //       child: Container(
                        //         height: 40.r,
                        //         width: 40.r,
                        //         decoration: BoxDecoration(
                        //           shape: BoxShape.circle,
                        //           color: Colors.black
                        //         ),
                        //         child: Center(
                        //           child:  SvgPicture.asset(
                        //         Assets.getIconSvg('appelicon'),
                        //         width: 23.r,
                        //         height: 23.r,
                        //         color: Colors.white,
                        //       ),
                        //         ),
                        //       )
                        //       // SvgPicture.asset(
                        //       //   Assets.getIconSvg('apple'),
                        //       //   width: 38.r,
                        //       //   height: 38.r,
                        //       // ),
                        //     ),
                        //     SizedBox(width: 8.w),
                        //     InkWell(
                        //       onTap: () {},
                        //       child: Container(
                        //         height: 40.r,
                        //         width: 40.r,
                        //         decoration: BoxDecoration(
                        //           shape: BoxShape.circle,
                        //           color: Colors.red[900]
                        //         ),
                        //         child: Center(
                        //           child:  SvgPicture.asset(
                        //         Assets.getIconSvg('googleicon'),
                        //         width: 23.r,
                        //         height: 23.r,
                        //         color: Colors.white,
                        //       ),
                        //         ),
                        //       )
                        //     ),
                        //     SizedBox(width: 8.w),
                        //     InkWell(
                        //       onTap: () {},
                        //       child: Container(
                        //         height: 40.r,
                        //         width: 40.r,
                        //         decoration: BoxDecoration(
                        //           shape: BoxShape.circle,
                        //           color: Colors.blue[900]
                        //         ),
                        //         child: Center(
                        //           child:  SvgPicture.asset(
                        //         Assets.getIconSvg('facebookicon'),
                        //         width: 23.r,
                        //         height: 23.r,
                        //         color: Colors.white,
                        //       ),
                        //         ),
                        //       )
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
              PositionedDirectional(
                top: 200.h,
                start: 15.w,
                end: 15.w,
                child: Form(
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 350.h,
                        padding: EdgeInsetsDirectional.all(15.r),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadiusDirectional.circular(15.r),
                          boxShadow: AppColors.boxShadow,
                        ),
                        child: Form(
                          key: loginFormKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomText(
                                'تسجيل الدخول',
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(height: 3.h),
                              Container(
                                width: 110.w,
                                height: 1.h,
                                color: AppColors.fontPrimaryColor,
                              ),
                              SizedBox(height: 5.h),
                              CustomText(
                                _mainVendorController.vendor
                                    ? "حساب مزود"
                                    : 'حساب شخصي',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontColor: AppColors.primaryColor,
                              ),
                              SizedBox(height: 40.h),
                              CustomTextFormField(
                                hintText: 'البريد الالكتروني',
                                prefixIcon: Icon(
                                  Icons.person,
                                  size: 22.r,
                                  color: AppColors.hintColor,
                                ),
                                isBoxShadow: false,
                                isComplate: true,
                                fillColor: Colors.white,
                                focusNode: focusNode1,
                                onFieldSubmitted: () {
                                  focusNode1.nextFocus();
                                },
                                textInputType: TextInputType.emailAddress,
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
                                focusNode: focusNode2,
                                isComplate: true,
                                onFieldSubmitted: () {
                                  focusNode2.nextFocus();
                                },
                                isBoxShadow: false,
                                fillColor: Colors.white,
                                obscureText: true,
                                onSaved: setPassword,
                                validator: Helper.validationNull,
                              ),
                            ],
                          ),
                        ),
                      ),
                      PositionedDirectional(
                        bottom: -35.h,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(50.r),
                          onTap: () {
                            if (loginFormKey.currentState.validate()) {
                              loginFormKey.currentState.save();
                              AuthApis.authApis.loginUser(email, password);
                            }
                            // Get.offAll(() => BottomNavBarScreen());
                          },
                          child: Container(
                            width: 75.r,
                            height: 75.r,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primaryColor,
                              border:
                                  Border.all(color: Colors.white, width: 5.w),
                              boxShadow: AppColors.boxShadow,
                            ),
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 25.r,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
