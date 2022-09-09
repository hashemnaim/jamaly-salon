import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/apis/home_apis.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/user/home_user_controller.dart';
import 'package:yacht_booking/models/order_details_model.dart';
import 'package:yacht_booking/view/user/reservation_confirmation/reservation_confirmation_screen.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

class CompanyOffersTap extends StatelessWidget {
  HomeUserController homeUserController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return homeUserController.getOwnerDetalsData.value.data.offers == null
          ? Center(
              child: Helper.loading(),
            )
          : homeUserController.getOwnerDetalsData.value.data.offers.isEmpty
              ? Center(child: CustomText("لا يوجد عروض"))
              : GridView.count(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.h,
                  crossAxisSpacing: 10.w,
                  childAspectRatio: 158.w / 100.h,
                  physics: BouncingScrollPhysics(),
                  children: List.generate(
                    homeUserController
                        .getOwnerDetalsData.value.data.offers.length,
                    (index) {
                      Offers offers = homeUserController
                          .getOwnerDetalsData.value.data.offers[index];
                      return InkWell(
                        onTap: () {
                          HomeUserApis.homeUserApis
                              .getShipDetails(offers.id.toString());
                          Get.to(() => ReservationConfirmationScreen(true));
                        },
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadiusDirectional.circular(10.r),
                            image: DecorationImage(
                              image: offers.image == null
                                  ? AssetImage(
                                      Assets.getImage('bg'),
                                    )
                                  : CachedNetworkImageProvider(offers.image),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.black38, BlendMode.darken),
                            ),
                          ),
                          child: CustomText(
                            '${offers.title ?? ""}',
                            fontColor: Colors.white,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                );
    });
  }
}
