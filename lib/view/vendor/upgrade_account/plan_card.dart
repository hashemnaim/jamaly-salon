import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/apis/home_vendor_apis.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/models/plan_model.dart';
import 'package:yacht_booking/view/widgets/custom_button.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

class PlanCard extends StatelessWidget {
  final PlanModelData planModelData;
  final int index;
  final bool isActive;


  PlanCard({this.planModelData, this.index,this.isActive=false});
  final List<Color> listOfColors = <Color>[
    Color(0xff00A9CA),
    Color(0xff51D474),
    Color(0xff3E9CA3),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150.h,
      padding: EdgeInsetsDirectional.all(10.r),
      decoration: BoxDecoration(
        color: listOfColors[index],
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                Assets.getIconSvg('plan'),
                width: 25.r,
                height: 25.r,
              ),
              SizedBox(width: 10.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    '${planModelData.name ?? ""}',
                    fontColor: Colors.white,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(
                        Icons.check,
                        size: 18.r,
                        color: Colors.white,
                      ),
                      SizedBox(width: 3.w),
                      CustomText(
                        '${planModelData.details ?? ""}',
                        fontColor: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 65.h,
                child: CustomButton(
                  text:isActive?
                  'مشترك'
                  : 'اشترك',
                  onTap: () {
                    
                    if(isActive){

                    }else{
                      Get.back();
                      HomeVendorApis.homeVendorApis
                        .subscriptionPlan(planModelData.id.toString());

                    }
                    
                  },
                  background: Colors.white,
                  fontColor: listOfColors[index],
                  height: 40,
                ),
              ),
              CustomText(
                '${planModelData.price ?? ''} AED',
                fontColor: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
