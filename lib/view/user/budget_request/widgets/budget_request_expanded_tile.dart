import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/models/order_offer_model.dart';
import 'package:yacht_booking/view/widgets/cash_network_image_share.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';
import 'package:yacht_booking/view/widgets/icon_row.dart';
import 'package:yacht_booking/view/widgets/svg_row.dart';

import 'proposal_card.dart';

class BudgetRequestExpandedTile extends StatelessWidget {
  final OrderOfferModelData orderOfferModelData;

  const BudgetRequestExpandedTile({this.orderOfferModelData});
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.hintColor),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: ExpansionTile(
          trailing: SizedBox.shrink(),
          tilePadding: EdgeInsetsDirectional.only(start: 10.w),
          childrenPadding:
              EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 72.r,
                    height: 72.r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(15.r),
                      image: orderOfferModelData.user.photo==null
                      ?
                      DecorationImage(
                        image: AssetImage(Assets.getImage('bg')),
                        fit: BoxFit.cover,
                      ):null
                    ),
                    child: orderOfferModelData.user.photo==null
                    ?SizedBox():
                    CachedNetworkImageShare(
                      orderOfferModelData.user.photo, 
                      72.r, 
                      72.r, 
                      15.r
                      ),
                  ),
                  SizedBox(width: 5.w),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconRow(
                              Icons.person,
                              '${orderOfferModelData.user.name??""}',
                              fontWeight: FontWeight.bold,
                            ),
                            IconRow(
                              Icons.star,
                              '${orderOfferModelData.user.rate??"0"}',
                              iconColor: AppColors.yellow,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                        IconRow(Icons.location_on, '${orderOfferModelData.user.location??""}'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgRow(
                              'dolar',
                              '${orderOfferModelData.price??""} درهم',
                              fontWeight: FontWeight.bold,
                              svgWidth: 12,
                              svgHeight: 12,
                              fontSize: 10,
                            ),
                            SizedBox(width: 10.w),
                            SvgRow(
                              'date',
                              '${orderOfferModelData.createdAt.toString().split("T").first??""}',
                              svgWidth: 12,
                              svgHeight: 12,
                              fontSize: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.whatsapp,
                    size: 22.r,
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(width: 5.w),
                  CustomText(
                    'لديك ${orderOfferModelData.myOffersCount??""} عرض',
                    fontSize: 13,
                    alignment: AlignmentDirectional.centerStart,
                    fontColor: AppColors.primaryColor,
                  ),
                ],
              ),
            ],
          ),
          children: [
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Container(
                width: 30.r,
                height: 30.r,
                alignment: AlignmentDirectional.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: const Color(0xfff7f7f7),
                ),
                child: Icon(
                  Icons.keyboard_arrow_up,
                  size: 22.r,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            orderOfferModelData.myOffers==null
            ?Helper.loading()
            :orderOfferModelData.myOffers.isEmpty
            ?CustomText("No Offers")
            :
            ListView.separated(
              itemCount: orderOfferModelData.myOffers.length,
              shrinkWrap: true,
              primary: false,
              separatorBuilder: (context, index) => Divider(
                height: 30.h,
                color: AppColors.hintColor,
              ),
              itemBuilder: (context, index) => ProposalCard(
                myOffers: orderOfferModelData.myOffers[index],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
