import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/services/sp_helper.dart';
import 'package:yacht_booking/view/user/bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'package:yacht_booking/view/vendor/main_vendor/main_vendor_screen.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

class ChangePasswordSuccessScreen extends StatefulWidget {
  const ChangePasswordSuccessScreen({Key key}) : super(key: key);

  @override
  _ChangePasswordSuccessScreenState createState() => _ChangePasswordSuccessScreenState();
}

class _ChangePasswordSuccessScreenState extends State<ChangePasswordSuccessScreen> {

   @override
  void initState() {
    Future.delayed(
      Duration(seconds: 2),
      () async{
        String type = await SPHelper.spHelper.getUser();
         if(type=="user"){
             Helper.getMainDataWithOutToken();
          Helper.getMainDataWithToken();
           Get.off(() => BottomNavBarScreen());

          }else{
            Helper.getMainVendorDataWithToken();
            
           Get.off(() => MainVendor());

          }
      
      },
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 60.h,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                'تهانينا',
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
              CustomText(
                'تم انشاء حساب بنجاح',
                fontSize: 18,
              ),
              SizedBox(height: 55.h),
              SvgPicture.asset(
                Assets.getIconSvg('success'),
                fit: BoxFit.contain,
                width: 300.r,
                height: 300.r,
              ),
              SizedBox(height: 100.h),
              // CustomButton(
              //   text: 'تسجيل الدخول',
              //   onTap: () {
              //     Get.offAll(() => LoginScreen());
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
