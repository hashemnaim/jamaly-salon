import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/apis/home_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/user/home_user_controller.dart';
import 'package:yacht_booking/models/offers_model.dart';
import 'package:yacht_booking/view/user/reservation_confirmation/reservation_confirmation_screen.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

class SpecialOffersTap extends StatelessWidget {
  SpecialOffersTap({
    Key key,
  }) : super(key: key);
  HomeUserController homeUserController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return homeUserController.getOffersData.value.data == null
          ? Center(
              child: Helper.loading(),
            )
          : homeUserController.getOffersData.value.data.isEmpty
              ? Center(child: CustomText("No Offers"))
              : GridView.count(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.h,
                  crossAxisSpacing: 8.w,
                  childAspectRatio: 140.w / 95.h,
                  children: List.generate(
                    homeUserController.getOffersData.value.data.length,
                    (index) {
                      OffersModelData offersModelData =
                          homeUserController.getOffersData.value.data[index];
                      return InkWell(
                        onTap: () {
                          HomeUserApis.homeUserApis
                              .getShipDetails(offersModelData.id.toString());
                          Get.to(() => ReservationConfirmationScreen(true));
                        },
                        child: Container(
                          padding: EdgeInsetsDirectional.all(5.r),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: AppColors.boxShadow,
                            borderRadius:
                                BorderRadiusDirectional.circular(10.r),
                            image: DecorationImage(
                              image: offersModelData.image == null
                                  ? AssetImage(Assets.getImage('bg'))
                                  : CachedNetworkImageProvider(
                                      offersModelData.image),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.black26, BlendMode.darken),
                            ),
                          ),
                          child: Center(
                            child: CustomText(
                              '${offersModelData.title ?? ''}',
                              fontColor: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
    });
  }
}
