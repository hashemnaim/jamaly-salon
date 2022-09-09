import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/apis/auth_apis.dart';
import 'package:yacht_booking/apis/home_vendor_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/controller/vendor/main_vendor_controller.dart';
import 'package:yacht_booking/services/sp_helper.dart';
import 'package:yacht_booking/view/sheard_screens/welcome_screen.dart';
import 'package:yacht_booking/view/user/communication/communication_screen.dart';
import 'package:yacht_booking/view/user/terms_and_conditions/terms_and_conditions.dart';
import 'package:yacht_booking/view/vendor/ratting/ratting_screen.dart';
import 'package:yacht_booking/view/vendor/upgrade_account/upgrade_account_screen.dart';
import 'package:yacht_booking/view/widgets/custom_button.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

import 'widgets/header_profile_vendor__widget.dart';

class VendorProfileScreen extends StatefulWidget {
  VendorProfileScreen({Key key}) : super(key: key);

  @override
  _VendorProfileScreenState createState() => _VendorProfileScreenState();
}

class _VendorProfileScreenState extends State<VendorProfileScreen> {
  final MainVendorController _mainVendorController = Get.find();
  final List<String> svgIconList = [
    'promotion',
    'star',
    // 'statistics',
    'insurance',
    'connection'
  ];
  final List<String> titleList = [
    'ترقية حسابك / الباقات',
    'التقييمات',
    // 'الاحصائيات',
    'الشروط و الاحكام',
    'التواصل مع إدارة التطبيق'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // CustomText(
                //   'المزود',
                //   alignment: AlignmentDirectional.centerEnd,
                //   fontColor: AppColors.primaryColor,
                //   fontWeight: FontWeight.w600,
                // ),
                CustomText(
                  'حسابي',
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
                SizedBox(height: 20.h),
                HeaderProfileVendorWidget(),
                SizedBox(height: 25.h),
                ListView.separated(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: svgIconList.length,
                  separatorBuilder: (context, index) => SizedBox(height: 15.h),
                  itemBuilder: (context, index) => Container(
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      boxShadow: AppColors.boxShadow,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                      onTap: () {
                        if (index == 0) {
                          HomeVendorApis.homeVendorApis.getPlans();
                          Get.to(() => UpgradeAccountScreen());
                        } else if (index == 1) {
                          HomeVendorApis.homeVendorApis.getVendorReviews();
                          Get.to(() => RattingScreen());
                        } else if (index == 2) {
                          Get.to(() => TermsAndConditionsScreen());
                        } else if (index == 3) {
                          Get.to(() => CommunicationScreen());
                        }
                        // else if (index == 4) {
                        //   Get.to(CommunicationScreen());
                        // }
                        else {
                          return null;
                        }
                      },
                      title: CustomText(
                        titleList[index],
                        alignment: AlignmentDirectional.centerStart,
                        fontSize: 15,
                      ),
                      leading: Container(
                        height: 20.r,
                        width: 20.r,
                        child: SvgPicture.asset(
                          Assets.getIconSvg(svgIconList[index]),
                          color: Color(0xff3B3B3B),
                          fit: BoxFit.contain,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.hintColor,
                        size: 18.r,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25.h),
                CustomButton(
                  text: 'تسجيل الخروج',
                  icon: SvgPicture.asset(
                    Assets.getIconSvg('logout'),
                    width: 20.r,
                    height: 20.r,
                    fit: BoxFit.cover,
                  ),
                  onTap: () {
                    Get.offAll(() => WelcomeScreen());
                    _mainVendorController.pageIndex = 0;

                    AuthApis.authApis.logOutUser();
                    SPHelper.spHelper.setToken('');
                  },
                ),
                SizedBox(height: 25.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
