import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/apis/auth_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/user/auth_controller.dart';
import 'package:yacht_booking/controller/user/home_user_controller.dart';
import 'package:yacht_booking/view/widgets/cash_network_image_share.dart';
import 'package:yacht_booking/view/widgets/custom_app_bar.dart';
import 'package:yacht_booking/view/widgets/custom_avatar.dart';
import 'package:yacht_booking/view/widgets/custom_button.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';
import 'package:yacht_booking/view/widgets/custom_text_form_field.dart';

class EditProfileVendorScreen extends StatelessWidget {
  HomeUserController homeUserController = Get.find();
  AuthController authController = Get.find();

  GlobalKey<FormState> editProfileFormKey = GlobalKey<FormState>();
  String name,email,mobile,address;
  setName(String value){
    this.name = value;
  }
  setEmail(String value){
    this.email = value;
  }
  setMobile(String value){
    this.mobile = value;
  }
  setAddress(String value){
    this.address = value;
  }

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Scaffold(
      appBar: CustomAppBar(
        title: 'تعديل الملف الشخصي',
        backFun: () {
          Get.back();
        },
      ),
      body: SizedBox(
        width: double.infinity,
        child: homeUserController.getProfileUserData.value.data==null
        ?Center(
          child: Helper.loading(),
        ):
        SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          child: Form(
            key: editProfileFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Container(
                      height: 103.r,
                      width: 103.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xffFFE451),
                          width: 2
                        )
                      ),
                      child: homeUserController.getProfileUserData.value.data.photo==null
                      ?CustomAvatar(50, 49, 'person'):
                      CachedNetworkImageShare(
                        homeUserController.getProfileUserData.value.data.photo,
                         103.r, 103.r, 0),
                    ),
                    // CustomAvatar(50, 49, 'person'),
                    InkWell(
                      onTap: (){
                        authController.setImageProfile();
                      },
                      child: Container(
                        width: 30.r,
                        height: 30.r,
                        padding: EdgeInsetsDirectional.all(5.r),
                        alignment: AlignmentDirectional.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor,
                        ),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 18.r,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                CustomText(
                  '${homeUserController.getProfileUserData.value.data.name??''}',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                SizedBox(height: 25.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsetsDirectional.all(15.r),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(10.r),
                    color: AppColors.secondaryColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomText(
                            'البيانات الشخصية:',
                            fontWeight: FontWeight.bold,
                          ),
                          SvgPicture.asset(
                            Assets.getIconSvg('edit'),
                            fit: BoxFit.contain,
                            width: 18.r,
                            height: 18.r,
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      CustomTextFormField(
                        textInitialValue: homeUserController.getProfileUserData.value.data.name??'',
                        prefixIcon: Icon(Icons.person_outline_outlined,size: 22.r),
                        isBoxShadow: false,
                        onSaved: setName,
                        
          
                      ),
                      SizedBox(height: 10.h),
                      CustomTextFormField(
                        textInitialValue: homeUserController.getProfileUserData.value.data.email??'',
                        prefixIcon: Icon(Icons.email_outlined,size: 22.r),
                        isBoxShadow: false,
                        onSaved: setEmail,
                      ),
                      SizedBox(height: 10.h),
                      CustomTextFormField(
                        textInitialValue:homeUserController.getProfileUserData.value.data.mobile??'',
                        prefixIcon: Icon(Icons.call_outlined,size: 22.r),
                        isBoxShadow: false,
                        onSaved: setMobile,
                        //  suffixIcon: Directionality(
                        //   textDirection: TextDirection.ltr,
                        //   child: CountryCodePicker(
                        //     onChanged: print,
                        //     initialSelection: 'PS',
                        //     favorite: ['+970', 'PS'],
                        //     showCountryOnly: false,
                        //     showOnlyCountryWhenClosed: false,
                        //     padding: EdgeInsets.symmetric(vertical: 5.r,horizontal: 5.r),
                        //     flagWidth: 25.w,
                        //     textStyle: TextStyle(
                        //       fontSize: 13.sp,
                        //       color: AppColors.fontSecondaryColor,
                        //     ),
                        //   ),
                        // )
                      ),
                      SizedBox(height: 10.h),
                      CustomTextFormField(
                        textInitialValue: 'الامارات',
                        prefixIcon: Icon(Icons.location_on_outlined,size: 22.r),
                        onSaved: setAddress,
                        isBoxShadow: false,
                       
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25.h),
                CustomButton(
                  text: 'حفظ التعديلات', 
                  onTap: () {
                    editProfileFormKey.currentState.save();
                    Get.back();
                   AuthApis.authApis.setProfileUser(
                     name, email, mobile);
                }),
              ],
            ),
          ),
        ),
      ),
    );
    })
    ;
  }
}
