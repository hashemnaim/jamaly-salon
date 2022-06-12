import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/apis/home_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/view/widgets/custom_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yacht_booking/view/widgets/custom_button.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';
import 'package:yacht_booking/view/widgets/custom_text_form_field.dart';

class CommunicationScreen extends StatefulWidget {

  @override
  _CommunicationScreenState createState() => _CommunicationScreenState();
}

class _CommunicationScreenState extends State<CommunicationScreen> {
  GlobalKey<FormState> contactUsKey = GlobalKey<FormState>();
  String message;
  setMessage(String value){
    this.message = value;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'التواصل مع إدارة التطبيق',
        backFun: () => Get.back(),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: Form(
            key: contactUsKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 100.r,
                  height: 100.r,
                  padding: EdgeInsetsDirectional.all(15.r),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    Assets.getIconSvg('connection'),
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 15.h),
                CustomText(
                  'يمكنك التواصل معنا بأي وقت تريده نحن هنا لمساعدتك ',
                  maxLines: 4,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsetsDirectional.all(15.r),
                  decoration: BoxDecoration(
                    boxShadow: AppColors.boxShadow,
                    color: Colors.white,
                    borderRadius: BorderRadiusDirectional.circular(15.r),
                  ),
                  child: Column(
                    children: [
                      CustomText(
                        'أكتب رسالتك هنا',
                        maxLines: 4,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 15.w),
                      CustomTextFormField(
                        hintText: 'أكتب رسالتك هنا',
                        maxLines: 8,
                        isBoxShadow: false,
                        isBorderSide: false,
                        onSaved: setMessage,
                        validator: Helper.validationNull,
                      ),
                      SizedBox(height: 15.w),
                      CustomButton(
                        text: 'ارسال ',
                          onTap: (){
                            if(contactUsKey.currentState.validate()){
                              contactUsKey.currentState.save();
                              HomeUserApis.homeUserApis.contactUs(message);
                            }
                          },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
