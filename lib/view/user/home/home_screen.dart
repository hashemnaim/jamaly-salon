import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/controller/user/home_user_controller.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

import '../../../apis/home_vendor_apis.dart';
import 'widgets/all_tap.dart';
import 'widgets/header_widget.dart';
import 'widgets/service_providers_tap.dart';
import 'widgets/service_tap.dart';
import 'widgets/special_offers_tap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  HomeUserController homeUserController = Get.find();
  final List<Widget> _tabs = [
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SvgPicture.asset(Assets.getIconSvg('home'),
          width: 20.w, height: 20.h, fit: BoxFit.contain),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: CustomText(
        'الخدمات',
        fontSize: 13,
        fontColor: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: CustomText(
        'مزودي الخدمه',
        fontSize: 13,
        fontColor: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: CustomText(
        'عروض مميزة',
        fontSize: 13,
        fontColor: Colors.black,
        fontWeight: FontWeight.bold,
        // height: 1.25,
      ),
    ),
  ];
  final List<Widget> _childrenTabBar = <Widget>[
    AllTap(),
    ServiceTap(),
    ServiceProvidersTap(),
    SpecialOffersTap(),
  ];

  @override
  void initState() {
    super.initState();
    homeUserController.tabController =
        new TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    homeUserController.tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeUserController>(
      init: HomeUserController(),
      builder: (controller) {
        return Scaffold(
          body: Column(
            children: [
              HeaderWidget(),
              Container(
                height: 50.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: AppColors.boxShadow,
                  borderRadius: BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(18.r),
                    bottomEnd: Radius.circular(18.r),
                  ),
                ),
                child: Align(
                  alignment: AlignmentDirectional.bottomStart,
                  child: TabBar(
                    automaticIndicatorColorAdjustment: false,
                    unselectedLabelColor: Colors.black,
                    indicatorColor: AppColors.primaryColor,
                    labelColor: AppColors.primaryColor,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight: 3.w,
                    labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    unselectedLabelStyle:
                        TextStyle(fontWeight: FontWeight.bold),
                    isScrollable: true,
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    controller: controller.tabController,
                    tabs: _tabs,
                    onTap: (index) {
                      if (index == 2) {
                        HomeVendorApis.homeVendorApis.getVendorServices();
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: controller.tabController,
                  children: _childrenTabBar,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
