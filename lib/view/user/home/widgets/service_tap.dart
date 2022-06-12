import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/apis/home_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/user/home_user_controller.dart';
import 'package:yacht_booking/models/services_model.dart';
import 'package:yacht_booking/view/user/home/widgets/all_services_screen.dart';
import 'package:yacht_booking/view/widgets/cash_network_image_share.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

class ServiceTap extends StatefulWidget {
  ServiceTap({
    Key key,
  }) : super(key: key);

  @override
  _ServiceTapState createState() => _ServiceTapState();
}

class _ServiceTapState extends State<ServiceTap> {
  HomeUserController homeUserController = Get.find();

  String nameServices = '';

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return homeUserController.showAllServices.value
          ? ServiceProvidersService2(nameServices)
          : homeUserController.getServicesData.value.data == null
              ? Center(
                  child: Helper.loading(),
                )
              : homeUserController.getServicesData.value.data.isEmpty
                  ? Center(
                      child: CustomText("No Services"),
                    )
                  : GridView.count(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 15.h),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.h,
                      crossAxisSpacing: 10.w,
                      childAspectRatio: 158.w / 88.h,
                      children: List.generate(
                        homeUserController.getServicesData.value.data.length,
                        (index) {
                          ServicesModelData servicesModelData =
                              homeUserController
                                  .getServicesData.value.data[index];
                          return InkWell(
                            onTap: () {
                              HomeUserApis.homeUserApis.getOwnersService(
                                  servicesModelData.id.toString());
                              homeUserController.showAllServices.value =
                                  !homeUserController.showAllServices.value;
                              nameServices = servicesModelData.title;
                              setState(() {});
                              // Get.to(ServiceProvidersService());
                              //  HomeUserApis.homeUserApis.getShipDetails(
                              //   servicesModelData.id.toString());
                              //   Get.to(ReservationConfirmationScreen());
                            },
                            child: Container(
                              padding: EdgeInsetsDirectional.all(5.r),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: AppColors.boxShadow,
                                borderRadius:
                                    BorderRadiusDirectional.circular(10.r),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomText(
                                      '${servicesModelData.title ?? ""}'),
                                  servicesModelData.icon == null
                                      ? SvgPicture.asset(
                                          Assets.getIconSvg('logo'),
                                          width: 35.r,
                                          height: 35.r,
                                          fit: BoxFit.contain,
                                          color: AppColors.primaryColor,
                                        )
                                      : CachedNetworkImageShare(
                                          servicesModelData.icon, 35.r, 35.r, 1)
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
