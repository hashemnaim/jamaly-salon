 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/vendor/home_vendor_controller.dart';
import 'package:yacht_booking/models/plan_model.dart';
import 'package:yacht_booking/view/vendor/upgrade_account/plan_card.dart';
import 'package:yacht_booking/view/widgets/custom_app_bar.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

class UpgradeAccountScreen extends StatefulWidget {
  @override
  State<UpgradeAccountScreen> createState() => _UpgradeAccountScreenState();
}

class _UpgradeAccountScreenState extends State<UpgradeAccountScreen> {
  final List<Color> listOfColors = <Color>[
    Color(0xff00A9CA),
    Color(0xff51D474),
    Color(0xff3E9CA3),
  ];

  HomeVendorController homeVendorController = Get.find();

  int selectedTab = 1;

  setSelectedTab(int value) {
    this.selectedTab = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: CustomAppBar(
          title: 'ترقية حسابك / الباقات',
          backFun: () {
            Get.back();
          },
        ),
        body: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        setSelectedTab(1);
                      },
                      child: Container(
                        height: 40.h,
                        decoration: BoxDecoration(
                            border: selectedTab == 1
                                ? Border(
                                    bottom: BorderSide(
                                        color: AppColors.primaryColor,
                                        width: 2))
                                : null),
                        child: Center(
                          child: CustomText(
                            'الباقة المفعلة ',
                            fontWeight: FontWeight.w700,
                            fontColor: selectedTab == 1
                                ? AppColors.primaryColor
                                : AppColors.fontPrimaryColor,
                          ),
                        ),
                      ),
                    )),
                    Expanded(
                        child: InkWell(
                      onTap: () {
                        setSelectedTab(0);
                      },
                      child: Container(
                        height: 40.h,
                        decoration: BoxDecoration(
                            border: selectedTab == 0
                                ? Border(
                                    bottom: BorderSide(
                                        color: AppColors.primaryColor,
                                        width: 2))
                                : null),
                        child: Center(
                          child: CustomText(
                            'جميع الباقات',
                            fontWeight: FontWeight.w700,
                            fontColor: selectedTab == 0
                                ? AppColors.primaryColor
                                : AppColors.fontPrimaryColor,
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                selectedTab == 0
                    ? homeVendorController.getPlansData.value.data == null
                        ? Center(
                            child: Helper.loading(),
                          )
                        : homeVendorController.getPlansData.value.data.isEmpty
                            ? Center(
                                child: CustomText("No Plans"),
                              )
                            : SingleChildScrollView(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15.w,
                                  vertical: 15.h,
                                ),
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: homeVendorController
                                      .getPlansData.value.data.length,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: 15.h),
                                  itemBuilder: (context, index) {
                                    PlanModelData planModelData =
                                        homeVendorController
                                            .getPlansData.value.data[index];
                                    return PlanCard(
                                      planModelData: planModelData,
                                      index: index,
                                      isActive: planModelData.id.toString() ==
                                          homeVendorController.getPlansData
                                              .value.currentPlan.plan.id
                                              .toString(),
                                    );
                                  },
                                ),
                              )
                    : Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 10.h),
                        child: Column(
                          children: [
                            homeVendorController
                                        .getPlansData.value.currentPlan ==
                                    null
                                ? Center(
                                    child: Helper.loading(),
                                  )
                                : PlanCard(
                                    planModelData: homeVendorController
                                        .getPlansData.value.currentPlan.plan,
                                    index: 0,
                                    isActive: true,
                                  )
                          ],
                        ),
                      )
              ],
            )),
      );
    });
  }
}
