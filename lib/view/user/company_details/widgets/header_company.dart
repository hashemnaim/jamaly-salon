import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/apis/home_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yacht_booking/view/widgets/cash_network_image_share.dart';
import 'package:yacht_booking/view/widgets/custom_app_bar.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';
import 'package:yacht_booking/view/widgets/icon_row.dart';

class HeaderCompany extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String price;
  final String image;
  final String rate;
  final String shipId;
  String isFavorit;

  HeaderCompany(
      {this.name,
      this.address,
      this.phone,
      this.email,
      this.price,
      this.image,
      this.rate,
      this.shipId,
      this.isFavorit});

  @override
  State<HeaderCompany> createState() => _HeaderCompanyState();
}

class _HeaderCompanyState extends State<HeaderCompany> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 293.h,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.getImage('bg')),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
            title: '',
            backFun: () {
              Get.back();
            },
            backgroundColor: Colors.transparent,
            iconBackColor: Colors.white,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsetsDirectional.all(8.r),
            margin: EdgeInsetsDirectional.only(
              bottom: 25.h,
              start: 15.w,
              end: 15.w,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(10.r),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 80.r,
                  height: 80.r,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.circular(10.r),
                      image: widget.image == null
                          ? DecorationImage(
                              image: AssetImage(Assets.getImage('bg')),
                              fit: BoxFit.cover,
                            )
                          : null),
                  child: widget.image == null
                      ? Container()
                      : CachedNetworkImageShare(widget.image, 80.r, 80.r, 10),
                ),
                SizedBox(width: 5.w),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconRow(
                            Icons.person,
                            '${widget.name}',
                            iconColor: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          Row(
                            children: [
                              IconRow(
                                Icons.star,
                                '${widget.rate}',
                                iconColor: AppColors.yellow,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              InkWell(
                                  onTap: () {
                                    if (widget.isFavorit == "0") {
                                      HomeUserApis.homeUserApis
                                          .storeFavoriteVendor(
                                              widget.shipId, "3");
                                      setState(() {
                                        widget.isFavorit = "1";
                                      });
                                    } else {
                                      HomeUserApis.homeUserApis
                                          .deleteFavoriteShip(
                                              widget.shipId, "3");
                                      setState(() {
                                        widget.isFavorit = "0";
                                      });
                                    }
                                  },
                                  child: widget.isFavorit == "0"
                                      ? Icon(Icons.favorite_border)
                                      : Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        ))
                            ],
                          )
                        ],
                      ),
                      IconRow(
                        Icons.location_on,
                        '${widget.address}',
                        iconColor: AppColors.primaryColor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(2.r),
                            child: Icon(
                              Icons.phone,
                              size: 17.r,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          CustomText(
                            '${widget.phone}',
                            fontColor: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            textAlign: TextAlign.start,
                            alignment: AlignmentDirectional.centerStart,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(2.r),
                            child: Icon(
                              Icons.email_rounded,
                              size: 17.r,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          CustomText(
                            '${widget.email}',
                            fontColor: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            textAlign: TextAlign.start,
                            alignment: AlignmentDirectional.centerStart,
                          ),
                        ],
                      )

                      // IconRow(
                      //   Icons.local_offer,
                      //   'الأسعار من: 100 الى ${widget.price} درهم',
                      //   iconColor: AppColors.primaryColor,
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
