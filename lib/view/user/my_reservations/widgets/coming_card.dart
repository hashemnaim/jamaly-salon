import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/apis/home_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/user/home_user_controller.dart';
import 'package:yacht_booking/models/new_order_model.dart';
import 'package:yacht_booking/view/user/company_details/company_details_screen.dart';
import 'package:yacht_booking/view/vendor/chat_details_provider_screen.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';
import 'package:yacht_booking/view/widgets/icon_row.dart';
import 'package:yacht_booking/view/widgets/svg_row.dart';

class ComingCard extends StatelessWidget {
  HomeUserController homeUserController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Expanded(
        child: homeUserController.getBookingsData.value.newOrders == null
            ? Center(
                child: Helper.loading(),
              )
            : homeUserController.getBookingsData.value.newOrders.isEmpty
                ? Center(
                    child: CustomText("لا يوجد حجوزات"),
                  )
                : ListView.separated(
                    itemCount: homeUserController
                        .getBookingsData.value.newOrders.length,
                    physics: BouncingScrollPhysics(),
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 10.h),
                    itemBuilder: (context, index) {
                      NewOrders newOrders = homeUserController
                          .getBookingsData.value.newOrders[index];
                      return InkWell(
                        onTap: () {
                          HomeUserApis.homeUserApis
                              .getOwnerDetails(newOrders.owner.id.toString());
                          Get.to(CompanyDetailsScreen());
                        },
                        borderRadius: BorderRadius.circular(12.r),
                        child: Container(
                          width: 335.w,
                          height: 110.h,
                          padding: EdgeInsetsDirectional.all(8.r),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: Colors.white,
                            border: Border.all(
                                width: 2.w, color: const Color(0xffe9e9ec)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 85.w,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(15.r),
                                  image: DecorationImage(
                                    image: AssetImage(Assets.getImage('bg')),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 5.w),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconRow(
                                          Icons.person,
                                          '${newOrders.owner.name ?? ""}',
                                        ),
                                        IconRow(
                                          Icons.star,
                                          '${newOrders.owner.rate ?? "0"}',
                                          iconColor: AppColors.yellow,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconRow(
                                          Icons.location_on,
                                          '${newOrders.owner.location ?? ""}',
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.to(
                                              ChatDetailsScreenProvider(
                                                myId: homeUserController
                                                    .getProfileUserData
                                                    .value
                                                    .data
                                                    .id
                                                    .toString(),
                                                imagename:
                                                    newOrders.owner.photo,
                                                otherId: newOrders.owner.id
                                                    .toString(),
                                                username: newOrders.owner.name,
                                              ),
                                            );
                                          },
                                          child: SvgRow(
                                            'messages',
                                            'مراسلة فورية',
                                            fontColor: AppColors.primaryColor,
                                            svgColor: AppColors.primaryColor,
                                            svgWidth: 14,
                                            svgHeight: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SvgRow(
                                              'dolar',
                                              '${newOrders.price ?? ""} درهم',
                                              fontWeight: FontWeight.bold,
                                              svgWidth: 12,
                                              svgHeight: 12,
                                              fontSize: 10,
                                            ),
                                            SizedBox(width: 8.w),
                                            SvgRow(
                                              'date',
                                              '${newOrders.date ?? ""}',
                                              svgWidth: 12,
                                              svgHeight: 12,
                                              fontSize: 10,
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          FontAwesomeIcons.whatsapp,
                                          color: AppColors.primaryColor,
                                          size: 21.r,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      );
    });
  }
}
