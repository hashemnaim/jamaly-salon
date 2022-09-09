import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/apis/home_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/view/user/company_details/company_details_screen.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/user/home_user_controller.dart';
import 'package:yacht_booking/models/new_order_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yacht_booking/view/widgets/custom_button.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';
import 'package:yacht_booking/view/widgets/custom_text_form_field.dart';
import 'package:yacht_booking/view/widgets/icon_row.dart';
import 'package:yacht_booking/view/widgets/svg_row.dart';

class PastCard extends StatelessWidget {
  HomeUserController homeUserController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Expanded(
        child: homeUserController.getBookingsData.value.oldOrders == null
            ? Center(
                child: Helper.loading(),
              )
            : homeUserController.getBookingsData.value.oldOrders.isEmpty
                ? Center(
                    child: CustomText("لا يوجد حجوزات"),
                  )
                : ListView.separated(
                    itemCount: homeUserController
                        .getBookingsData.value.oldOrders.length,
                    physics: BouncingScrollPhysics(),
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 10.h);
                    },
                    itemBuilder: (context, index) {
                      OldOrders oldOrders = homeUserController
                          .getBookingsData.value.oldOrders[index];
                      return InkWell(
                        onTap: () {
                          HomeUserApis.homeUserApis
                              .getOwnerDetails(oldOrders.owner.id.toString());
                          Get.to(() => CompanyDetailsScreen());
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
                                          '${oldOrders.owner.name ?? ""}',
                                        ),
                                        IconRow(
                                          Icons.star,
                                          '${oldOrders.owner.rate ?? "0"}',
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
                                          '${oldOrders.owner.location ?? ""}',
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SvgRow(
                                          'dolar',
                                          '${oldOrders.price ?? ""} درهم',
                                          fontWeight: FontWeight.bold,
                                          svgWidth: 12,
                                          svgHeight: 12,
                                          fontSize: 10,
                                        ),
                                        SvgRow(
                                          'date',
                                          '${oldOrders.date ?? ""}',
                                          svgWidth: 12,
                                          svgHeight: 12,
                                          fontSize: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.defaultDialog(
                                              title: 'اضف تقييم',
                                              radius: 10.r,
                                              // titlePadding:
                                              // EdgeInsetsDirectional.only(top: 15.h, bottom: 4.h),
                                              // contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
                                              titleStyle: TextStyle(
                                                fontSize: 14.sp,
                                                color:
                                                    AppColors.fontPrimaryColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              content: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  RatingBar.builder(
                                                    initialRating: 0,
                                                    direction: Axis.horizontal,
                                                    tapOnlyMode: true,
                                                    ignoreGestures: false,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemSize: 16,
                                                    itemPadding:
                                                        const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 1.0),
                                                    itemBuilder: (context, _) =>
                                                        const Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                      size: 1,
                                                    ),
                                                    onRatingUpdate: (rating) =>
                                                        null,
                                                  ),
                                                  SizedBox(height: 15.h),
                                                  CustomTextFormField(
                                                    hintText: 'إضافة تعليق',
                                                    maxLines: 3,
                                                    isBoxShadow: false,
                                                    isBorderSide: false,
                                                  ),
                                                  SizedBox(height: 15.h),
                                                  CustomButton(
                                                      text: 'تقييم',
                                                      onTap: () {}),
                                                ],
                                              ),
                                            );
                                          },
                                          child: IconRow(
                                            Icons.star,
                                            'اضف تقييم',
                                            iconColor: AppColors.yellow,
                                            fontSize: 10,
                                          ),
                                        ),
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
