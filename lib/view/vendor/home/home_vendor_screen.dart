import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/apis/home_vendor_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/controller/vendor/chat_get_provider.dart';
import 'package:yacht_booking/controller/vendor/home_vendor_controller.dart';
import 'package:yacht_booking/controller/vendor/main_vendor_controller.dart';
import 'package:yacht_booking/services/firebase_chat_provider.dart';
import 'package:yacht_booking/view/vendor/services/widgets/header_vendor.dart';
import 'package:yacht_booking/view/vendor/statistics/statistics_screen.dart';

import 'widgets/chat_tap.dart';
import 'widgets/gallery_tap.dart';
import 'widgets/ratting_tap.dart';
import 'widgets/reservations_tap.dart';

class HomeVendorScreen extends StatefulWidget {
  const HomeVendorScreen({Key key}) : super(key: key);

  @override
  State<HomeVendorScreen> createState() => _HomeVendorScreenState();
}

class _HomeVendorScreenState extends State<HomeVendorScreen>
    with TickerProviderStateMixin {
  TabController _tabController;
  // bool isFirstScreen = true;
  int tabIndex = 0;

  // setIsFirstScreen(bool value) {
  //   this.isFirstScreen = value;
  //   setState(() {});
  // }
  ChatGetProvider chatGetProvider = Get.find();

  changeTabIndex(int val) {
    setState(() {
      this.tabIndex = val;
    });
    if (val == 0) {
      homeVendorController.filterIndex.value = 4;
      HomeVendorApis.homeVendorApis.getRecievedOrderVendor("all");
    } else {
      FireBaseHelperProvider.fireBaseHelperProvider.getAllMyChats(
        myId: chatGetProvider.getProfileUserData.value.data.id.toString(),
      );
    }
  }

  final List<Widget> _tabs = [
    Text(
      'الحجوزات',
      style: TextStyle(
          fontSize: 13.sp, fontWeight: FontWeight.bold, color: Colors.black),
    ),
    Text(
      'معرض الصور',
      style: TextStyle(
          fontSize: 13.sp, fontWeight: FontWeight.bold, color: Colors.black),
    ),
    Text(
      'المحادثات',
      style: TextStyle(
          fontSize: 13.sp, fontWeight: FontWeight.bold, color: Colors.black),
    ),
    Text(
      'التقييمات',
      style: TextStyle(
          fontSize: 13.sp, fontWeight: FontWeight.bold, color: Colors.black),
    ),
  ];

  final List<Widget> _childrenTabBar = <Widget>[
    ReservationsTap(),
    GalleryTap(),
    ChatTap(),
    RattingTap(),
  ];
  HomeVendorController homeVendorController = Get.find();

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainVendorController>(
      id: "first",
      init: MainVendorController(),
      builder: (controller) {
        return Column(
          children: [
            HeaderVendor(),
            Container(
              height: 45.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: AppColors.boxShadow,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(18.r),
                  bottomLeft: Radius.circular(18.r),
                ),
              ),
              child: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: TabBar(
                  labelPadding: EdgeInsetsDirectional.only(
                    start: 13.w,
                    end: 13.w,
                    bottom: 6.5.h,
                  ),
                  unselectedLabelColor: const Color(0xffacb3bf),
                  indicatorColor: controller.isFirstScreen
                      ? Colors.transparent
                      : tabIndex == 3
                          ? Color(0xffF2C409)
                          : AppColors.primaryColor,
                  labelColor: controller.isFirstScreen
                      ? Color(0xffacb3bf)
                      : tabIndex == 3
                          ? Color(0xffF2C409)
                          : AppColors.primaryColor,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 3.w,
                  isScrollable: true,
                  controller: _tabController,
                  tabs: _tabs,
                  physics: NeverScrollableScrollPhysics(),
                  onTap: (value) {
                    controller.setIsFirstScreen(false);
                    changeTabIndex(value);
                  },
                ),
              ),
            ),
            Expanded(
              child: controller.isFirstScreen
                  ? StatisticsScreen()
                  // InitialTap()
                  : TabBarView(
                      controller: _tabController,
                      physics: NeverScrollableScrollPhysics(),
                      children: _childrenTabBar,
                    ),
            ),
          ],
        );
      },
    );
  }
}
