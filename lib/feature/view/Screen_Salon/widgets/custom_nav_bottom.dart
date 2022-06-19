import 'package:salon_provider/feature/server/getx/app_get_salon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_provider/feature/values/colors.dart';
import 'package:salon_provider/feature/view/widgets/custom_image.dart';
import 'custom_Item_nav_bottom.dart';

class CustomNavSaloneBottom extends StatelessWidget {
  final bool internalScreen;
  CustomNavSaloneBottom({this.internalScreen = false});
  final AppGet controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppGet>(
        init: AppGet(),
        builder: (control) {
          return CustomBottomAppBar(
              onTabSelected: (index) async {
                control.setindexNav(index);
              },
              items: [
                CustomAppBarItem(
                    icon: CustomSvgImage(
                      imageName: "alertIcon",
                      color: control.indexNav == 0
                          ? AppColors.primaryColor
                          : Colors.grey,
                    ),
                    titel: ""),
                CustomAppBarItem(
                    icon: CustomSvgImage(
                      imageName: "booking",
                      color: control.indexNav == 1
                          ? AppColors.primaryColor
                          : Colors.grey,
                    ),
                    titel: ""),
                CustomAppBarItem(
                    icon: CustomSvgImage(
                      imageName: "profile",
                      color: control.indexNav == 2
                          ? AppColors.primaryColor
                          : Colors.grey,
                    ),
                    titel: ""),
              ]);
        });
  }
}
