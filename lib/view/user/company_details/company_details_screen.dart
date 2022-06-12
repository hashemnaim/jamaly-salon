import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/user/home_user_controller.dart';

import 'widgets/company_gallery_tap.dart';
import 'widgets/company_offers_tap.dart';
import 'widgets/company_ratting_tap.dart';
import 'widgets/company_services_tap.dart';
import 'widgets/header_company.dart';

class CompanyDetailsScreen extends StatefulWidget {
  const CompanyDetailsScreen({Key key}) : super(key: key);

  @override
  _CompanyDetailsScreenState createState() => _CompanyDetailsScreenState();
}

class _CompanyDetailsScreenState extends State<CompanyDetailsScreen>
    with TickerProviderStateMixin {
  TabController _tabController;
  List<Widget> _tabs = [
    Text(
      'معرض الصور',
      style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
    ),
    Text(
      'الخدمات',
      style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
    ),
    Text(
      'العروض',
      style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
    ),
    Text(
      'التقييمات',
      style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
    ),
  ];
  HomeUserController homeUserController = Get.find();
  List<Widget> _childrenTabBar = <Widget>[
    CompanyGalleryTap(),
    CompanyServicesTap(),
    CompanyOffersTap(),
    CompanyRattingTap(),
  ];
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
    return Obx(() {
      return Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: homeUserController.getOwnerDetalsData.value.data == null
              ? Center(
                  child: Helper.loading(),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    HeaderCompany(
                      name: homeUserController
                              .getOwnerDetalsData.value.data.name ??
                          '',
                      phone: homeUserController
                              .getOwnerDetalsData.value.data.mobile ??
                          '',
                      email: homeUserController
                              .getOwnerDetalsData.value.data.email ??
                          '',
                      address: homeUserController
                              .getOwnerDetalsData.value.data.location ??
                          '',
                      image: homeUserController
                          .getOwnerDetalsData.value.data.photo,
                      price: '1000',
                      rate: homeUserController
                              .getOwnerDetalsData.value.data.rate ??
                          '0',
                      shipId: homeUserController
                          .getOwnerDetalsData.value.data.id
                          .toString(),
                      isFavorit: homeUserController
                          .getOwnerDetalsData.value.data.isFavourite
                          .toString(),
                    ),
                    Container(
                      height: 45.h,
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
                        alignment: AlignmentDirectional.bottomCenter,
                        child: TabBar(
                          labelPadding: EdgeInsetsDirectional.only(
                            start: 13.w,
                            end: 13.w,
                            bottom: 6.5.h,
                          ),
                          unselectedLabelColor: const Color(0xffacb3bf),
                          indicatorColor: AppColors.primaryColor,
                          labelColor: AppColors.primaryColor,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorWeight: 3.w,
                          isScrollable: true,
                          controller: _tabController,
                          tabs: _tabs,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: _childrenTabBar,
                      ),
                    ),
                  ],
                ),
        ),
      );
    });
  }
}
