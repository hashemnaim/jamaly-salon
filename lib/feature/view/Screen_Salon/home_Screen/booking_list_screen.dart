import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salon_provider/feature/server/getx/app_get_salon.dart';
import 'package:salon_provider/feature/server/service/server_salon.dart';
import 'package:salon_provider/feature/values/colors.dart';

import 'package:salon_provider/feature/view/widgets/custom_text.dart';
import 'package:salon_provider/feature/view/widgets/isload.dart';

import '../widgets/bookingsItem.dart';

class BookingListScreen extends StatefulWidget {
  @override
  _BookingListScreenState createState() => _BookingListScreenState();
}

class _BookingListScreenState extends State<BookingListScreen> {
  List<String> list = [
    'new',
    'accepted',
    'Finished',
  ];

  int selected = 0;
  AppGet appGet = Get.find();
  @override
  Widget build(BuildContext context) {
    print(appGet.myBookings);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 32.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 23.h),
                child:
                    CustomText(text: 'Bookings List', color: AppColors.black11),
              ),
              SizedBox(
                height: 32.h,
                width: Get.width,
                child: ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  physics: BouncingScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        selected = index;
                        setState(() {});
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 88.w,
                            height: 32.h,
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: selected == index
                                    ? AppColors.primary20
                                    : Colors.white,
                                border: Border.all(
                                    color: selected == index
                                        ? AppColors.primary
                                        : AppColors.gray60),
                                borderRadius: BorderRadius.circular(100)),
                            child: CustomText(
                                text: list[index],
                                color: selected == index
                                    ? AppColors.primary
                                    : AppColors.black11),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Expanded(
                child: appGet.myBookings.isEmpty
                    ? IsLoad()
                    : selected == 0 &&
                            appGet.myBookings['data']['new'].length == 0
                        ? Center(
                            child: CustomText(text: 'No Booking'),
                          )
                        : selected == 1 &&
                                appGet.myBookings['data']['accepted'].length ==
                                    0
                            ? Center(
                                child: CustomText(text: 'No Booking'),
                              )
                            : selected == 2 &&
                                    appGet.myBookings['data']['finished']
                                            .length ==
                                        0
                                ? Center(
                                    child: CustomText(text: 'No Booking'),
                                  )
                                : RefreshIndicator(
                                    onRefresh: () {
                                      return ServerProvider.instance
                                          .getMyBookings();
                                    },
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      primary: false,
                                      itemCount: selected == 0
                                          ? appGet
                                              .myBookings['data']['new'].length
                                          : selected == 1
                                              ? appGet
                                                  .myBookings['data']
                                                      ['accepted']
                                                  .length
                                              : selected == 2
                                                  ? appGet
                                                      .myBookings['data']
                                                          ['finished']
                                                      .length
                                                  : 0,
                                      physics: BouncingScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                        vertical: 14.h,
                                      ),
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.only(bottom: 8.h),
                                          child: BookingsItem(
                                            map: selected == 0
                                                ? appGet.myBookings['data']
                                                    ['new'][index]
                                                : selected == 1
                                                    ? appGet.myBookings['data']
                                                        ['accepted'][index]
                                                    : selected == 2
                                                        ? appGet.myBookings[
                                                                'data']
                                                            ['finished'][index]
                                                        : 0,
                                            selected: selected,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
              ),
            ],
          ),
        ));
  }
}
