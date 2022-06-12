import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/models/order_offer_model.dart';
import 'package:yacht_booking/view/widgets/cash_network_image_share.dart';
import 'package:yacht_booking/view/widgets/custom_avatar.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

class ProposalCard extends StatelessWidget {
  final MyOffers myOffers;

  const ProposalCard({this.myOffers});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            myOffers.owner.photo==null
            ?
            CustomAvatar(24, 23, 'person')
            :Container(
              height: 36.r,
              width: 36.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color(0xffFFE451)
                )
              ),
              child: CachedNetworkImageShare(
                myOffers.owner.photo, 
                36.r, 36.r, 0),

            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 10.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadiusDirectional.circular(10.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          '${myOffers.owner.name??""}',
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        CustomText(
                          'السعر ${myOffers.price??""} درهم',
                          fontSize: 10,
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    CustomText(
                      '${myOffers.message??""}',
                      maxLines: 15,
                      fontSize: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.getIconSvg('call'),
              fit: BoxFit.contain,
              width: 22.r,
              height: 22.r,
              color: AppColors.primaryColor,
            ),
            SizedBox(width: 10.w),
            SvgPicture.asset(
              Assets.getIconSvg('whatsapp'),
              fit: BoxFit.contain,
              width: 22.r,
              height: 22.r,
            ),
            SizedBox(width: 10.w),
            SvgPicture.asset(
              Assets.getIconSvg('circle_call'),
              fit: BoxFit.contain,
              width: 22.r,
              height: 22.r,
            ),
          ],
        ),
      ],
    );
  }
}
