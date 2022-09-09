import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/apis/home_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/view/user/reservation_confirmation/reservation_confirmation_screen.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/user/home_user_controller.dart';
import 'package:yacht_booking/models/order_details_model.dart';
import 'package:yacht_booking/models/ships_details.dart';
import 'package:yacht_booking/view/widgets/cash_network_image_share.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

class CompanyServicesTap extends StatelessWidget {
  CompanyServicesTap({Key key}) : super(key: key);
  HomeUserController homeUserController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return homeUserController.getOwnerDetalsData.value.data.serviceOwners ==
              null
          ? Center(
              child: Helper.loading(),
            )
          : homeUserController
                  .getOwnerDetalsData.value.data.serviceOwners.isEmpty
              ? Center(
                  child: CustomText(""),
                )
              : GridView.count(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.h,
                  crossAxisSpacing: 10.w,
                  childAspectRatio: 158.w / 88.h,
                  physics: BouncingScrollPhysics(),
                  children: List.generate(
                    homeUserController
                        .getOwnerDetalsData.value.data.serviceOwners.length,
                    (index) {
                      ServiceOwners serviceOwners = homeUserController
                          .getOwnerDetalsData.value.data.serviceOwners[index];
                      return InkWell(
                        onTap: () {
                          HomeUserApis.homeUserApis.getShipDetails(
                              homeUserController.getOwnerDetalsData.value.data
                                  .gallary[index].ship_id
                                  .toString());
                          Get.to(() => ReservationConfirmationScreen(false));
                        },
                        borderRadius: BorderRadius.circular(10.r),
                        child: Container(
                          padding: EdgeInsetsDirectional.all(5.r),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: AppColors.boxShadow,
                            borderRadius:
                                BorderRadiusDirectional.circular(10.r),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomText(
                                  '${serviceOwners.services.title ?? ''}'),
                              serviceOwners.services.icon == null
                                  ? SvgPicture.asset(
                                      Assets.getIconSvg('logo'),
                                      width: 35.r,
                                      height: 35.r,
                                      fit: BoxFit.contain,
                                      color: AppColors.primaryColor,
                                    )
                                  : CachedNetworkImageShare(
                                      serviceOwners.services.icon,
                                      35.r,
                                      35.r,
                                      1)
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
