import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/user/home_user_controller.dart';
import 'package:yacht_booking/view/vendor/edit_profile_vendor/edit_profile_vendor_screen.dart';
import 'package:yacht_booking/view/widgets/cash_network_image_share.dart';
import 'package:yacht_booking/view/widgets/custom_avatar.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:yacht_booking/view/widgets/svg_row.dart';

class HeaderProfileVendorWidget extends StatefulWidget {
  const HeaderProfileVendorWidget();

  @override
  _HeaderProfileVendorWidgetState createState() =>
      _HeaderProfileVendorWidgetState();
}

class _HeaderProfileVendorWidgetState extends State<HeaderProfileVendorWidget> {
  bool status = false;
   HomeUserController homeUserController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Container(
      width: double.infinity,
      height: 250.h,
      padding: EdgeInsetsDirectional.all(10.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: const Color(0xfff8f8f8),
        boxShadow: AppColors.boxShadow,
      ),
      child: homeUserController.getProfileUserData.value.data==null
      ?Center(
        child: Helper.loading(),
      ):
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: InkWell(
                  onTap: () {
                    Get.to(EditProfileVendorScreen());
                  },
                  child: SvgPicture.asset(
                    Assets.getIconSvg('edit'),
                    fit: BoxFit.contain,
                    height: 22.r,
                    width: 22.r,
                  ),
                ),
              ),
               homeUserController.getProfileUserData.value.data.photo==null
            ?
            CustomAvatar(30, 29, 'person'):
            Container(
              height: 55.r,
              width: 55.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.orange
                )
              ),
              child: CachedNetworkImageShare(
                homeUserController.getProfileUserData.value.data.photo, 
                55.r, 55.r, 0),
              ),
              SizedBox(height: 8.h),
              CustomText(
                '${homeUserController.getProfileUserData.value.data.mobile??""}',
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              CustomText(
                '${homeUserController.getProfileUserData.value.data.name??""}',
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(
                    'التوقيت في بلدك : 12:00',
                    fontWeight: FontWeight.bold,
                    fontSize: 9,
                  ),
                  SizedBox(width: 5.w),
                  SvgPicture.string(
                    '<svg viewBox="109.9 506.1 1.0 15.0" ><path transform="translate(109.88, 506.13)" d="M 0 0 L 0 15" fill="none" stroke="#707070" stroke-width="1" stroke-opacity="0.24" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(width: 5.w),
                  CustomText(
                     '${homeUserController.getProfileUserData.value.data.location??""}',
                    fontWeight: FontWeight.bold,
                    fontSize: 9,
                  ),
                  SizedBox(width: 5.w),
                  SvgPicture.asset(
                    Assets.getIconSvg('flag'),
                    fit: BoxFit.cover,
                    width: 18.w,
                    height: 12.h,
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgRow(
                'shape',
                'اظهار بياناتي للجميع',
                fontSize: 14,
                svgWidth: 23,
                svgHeight: 23,
              ),
              FlutterSwitch(
                width: 40.w,
                height: 23.h,
                toggleSize: 18.r,
                value: status,
                borderRadius: 30.r,
                activeColor: AppColors.hintColor,
                inactiveColor: AppColors.primaryColor,
                onToggle: (val) {
                  setState(() {
                    status = val;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
    })
    ;
  }
}
