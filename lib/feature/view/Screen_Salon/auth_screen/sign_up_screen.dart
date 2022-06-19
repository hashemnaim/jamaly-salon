import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salon_provider/feature/server/getx/app_get_salon.dart';
import 'package:salon_provider/feature/view/widgets/custom_phone.dart';
import 'package:salon_provider/feature/server/helper/sp_helpar.dart';
import 'package:salon_provider/feature/server/service/server_auth.dart';
import 'package:salon_provider/feature/values/colors.dart';
import 'package:salon_provider/feature/view/Screen_Salon/auth_screen/widgets/top_auth.dart';
import 'package:salon_provider/feature/view/widgets/custom_button.dart';
import 'package:salon_provider/feature/view/widgets/custom_dialoug.dart';
import 'package:salon_provider/feature/view/widgets/custom_text.dart';
import 'package:salon_provider/feature/view/widgets/custom_text_field.dart';
import '../home_Screen/maps.dart';

enum SingingCharacter { Women, Man, Kids }

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> signUpKey = GlobalKey<FormState>();

  AppGet _appController = Get.find();

  TextEditingController password = TextEditingController();

  TextEditingController phone = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController name = TextEditingController();

  SingingCharacter character = SingingCharacter.Women;
  bool click = false;
  List<int> list = [];
  validationEmail(String data) {
    if (data == null || data == '') {
      return 'must be filled'.tr;
    } else if (!GetUtils.isEmail(data)) {
      return 'The email is not appropriate'.tr;
    }
  }

  validationMobile(String data) {
    if (data == null || data == '') {
      return 'must be filled'.tr;
    } else if (!GetUtils.isPhoneNumber(data.toString())) {
      return 'Phone number is incorrect'.tr;
    }
  }

  validationNull(String data) {
    if (data == null || data == '') {
      return ' must be filled'.tr;
    }
  }

  validationString(String data) {
    if (data == null || data == '') {
      return 'must be filled'.tr;
    } else if (data.length < 8) {
      return 'It must be more than 8 characters'.tr;
    }
  }

  saveForm() async {
    if (signUpKey.currentState.validate()) {
      signUpKey.currentState.save();
      // if (ConnectivityService.connectivityStatus !=
      //     ConnectivityStatus.Offline) {
      String fcmToken = SPHelper.spHelper.getFcmToken();

      await ServerAuth.instance.register(
          name: name.text,
          mobile: phone.text,
          password: password.text,
          fcmToken: fcmToken,
          email: email.text,
          locationLat: _appController.latitude.value,
          locationLong: _appController.longitude.value,
          type: list.toString());
    } else {
      // CustomDialougs.utils.showDialoug(
      //     messageKey: 'There is a problem with the internet',
      //     titleKey: 'alert');
    }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0.0,
        toolbarHeight: 0.0, // H
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Form(
            key: signUpKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TopAuth(
                  title: 'Create an Account'.tr,
                  subTitle:
                      'Please type full information bellow and we can create your account'
                          .tr,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextFormField(
                  hintText: 'Name'.tr,
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: Icon(
                      Icons.person,
                      size: 20.r,
                    ),
                  ),
                  textEditingController: name,
                  // onSaved: setName,
                  validator: validationNull,
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomTextFormField(
                  hintText: 'Email address'.tr,
                  textInputType: TextInputType.emailAddress,
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: Icon(
                      Icons.email,
                      size: 20.r,
                    ),
                  ),
                  textEditingController: email,
                  validator: validationEmail,
                ),
                SizedBox(
                  height: 16.h,
                ),
                IntlPhoneField(
                  onSaved: (newValue) {
                    if (newValue.number[0] == "0") {
                      phone.text =
                          newValue.countryCode + newValue.number.substring(1);
                    } else {
                      phone.text = newValue.countryCode + newValue.number;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Phone Number'.tr,
                    fillColor: Colors.white,
                  ),
                  initialCountryCode: 'AE',
                  controller: phone,
                  validator: (value) => validationMobile(value),
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomTextFormField(
                  password: true,
                  hintText: 'Password'.tr,
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: Icon(
                      Icons.lock,
                      size: 20.r,
                    ),
                  ),
                  validator: validationNull,
                  textEditingController: password,

                  // onSaved: setPassword,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            hoverColor: Colors.green,
                            value: list.contains(1) ? true : false,
                            onChanged: (value) {
                              setState(() {
                                click = value;
                              });
                              list.contains(1) ? list.remove(1) : list.add(1);
                            },
                          ),
                          CustomText(
                            text: 'Women',
                            fontSize: 16,
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Checkbox(
                            hoverColor: Colors.green,
                            value: list.contains(2) ? true : false,
                            onChanged: (value) {
                              setState(() {
                                click = value;
                                list.contains(2) ? list.remove(2) : list.add(2);
                              });
                            },
                          ),
                          CustomText(
                            text: 'Man',
                            fontSize: 16,
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Checkbox(
                            hoverColor: Colors.green,
                            value: list.contains(3) ? true : false,
                            onChanged: (value) {
                              setState(() {
                                click = value;
                                list.contains(3) ? list.remove(3) : list.add(3);
                              });
                            },
                          ),
                          CustomText(
                            text: 'Kids',
                            fontSize: 16,
                          ),
                        ],
                      ),

                      // Container(
                      //   height: 10,
                      //   width: 40,
                      //   child: RadioListTile<SingingCharacter>(
                      //     title: CustomText(text: 'Man', fontSize: 12),
                      //     value: SingingCharacter.Man,
                      //     groupValue: _character,
                      //     onChanged: (SingingCharacter value) {
                      //       setState(() {
                      //         _character = value;
                      //       });
                      //     },
                      //   ),
                      // ),
                      // Container(
                      //   height: 10,
                      //   width: 40,
                      //   child: RadioListTile<SingingCharacter>(
                      //     title: CustomText(text: 'Kids', fontSize: 10),
                      //     value: SingingCharacter.Kids,
                      //     groupValue: _character,
                      //     onChanged: (SingingCharacter value) {
                      //       setState(() {
                      //         _character = value;
                      //       });
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Obx(() => RaisedButton.icon(
                      hoverColor: Colors.greenAccent,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10),
                      ),
                      color: AppColors.primaryColor,
                      padding: EdgeInsets.all(10),
                      onPressed: () => Get.to(() => MapsG()),
                      label: CustomText(
                        text: "Select Location".tr,
                        color: Colors.white,
                      ),
                      icon: Icon(Icons.location_on,
                          color: _appController.latitude.value == 0
                              ? Colors.white
                              : Colors.green),
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'By signing up you agree to our',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.grayText,
                          ),
                          CustomText(
                            text: 'notice',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.grayText,
                          ),
                        ],
                      ),
                      CustomText(
                        text: 'Term of use and privacy',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),
                ),
                CustomButton(text: 'Join Now', onPress: saveForm),
                Row(
                  children: [
                    Expanded(
                        child: Divider(
                      color: AppColors.grayText,
                      thickness: 1,
                    )),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CustomText(
                        text: 'or',
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        color: AppColors.grayText,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: AppColors.grayText,
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Already have an account?',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.grayText,
                    ),
                    InkWell(
                      onTap: () => Get.back(),
                      child: CustomText(
                        text: "  " + 'Sign In'.tr,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
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
    );
  }
}
