import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salon_provider/feature/server/service/server_salon.dart';
import 'package:salon_provider/feature/values/colors.dart';
import 'package:salon_provider/feature/view/Screen_Salon/widgets/rate_product_screen.dart';
import 'package:salon_provider/feature/view/widgets/custom_text.dart';

class BookingsItem extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  final Map map;
  final int selected;
  final Function onTap;

  BookingsItem({this.margin, this.onTap, this.map, this.selected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => print('a'),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 141.h,
            width: 343.w,
            margin: margin ?? EdgeInsets.symmetric(horizontal: 4.w),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                // boxShadow: AppShadow.cardShadow,
                color: Colors.white),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                child: map['user'] == null
                    ? Image.asset(
                        "assets/images/logo.png",
                        height: 131.h,
                        width: 131.w,
                      )
                    : Container(
                        width: 131.w,
                        height: 131.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                image: NetworkImage(map['user']['photo']))),
                      ),
              ),
              SizedBox(
                width: 8.w,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 11.h,
                    ),
                    map['user'] == null
                        ? Container()
                        : CustomText(
                            text: map['user']['name'] ?? "",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.black11,
                          ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      children: [
                        CustomText(
                          text: '${map['date']} ',
                          color: Color(0xff156778),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        Transform.translate(
                          offset: Offset(4, 12),
                          child: CustomText(
                            text: ' ${map['time']}',
                            color: AppColors.gray80,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    map['product_list'] == null
                        ? Container()
                        : SizedBox(
                            width: 200,
                            height: 30,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                ...List.generate(
                                  map['product_list'].length,
                                  (index) => Positioned(
                                    left: index * 55.w,
                                    child: Container(
                                      width: 60.w,
                                      height: 25.h,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4.w),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: AppColors.primary20,
                                          border: Border.all(
                                              color: AppColors.primary),
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      child: Center(
                                        child: CustomText(
                                          text: map['product_list'][index]
                                                  ['name'] ??
                                              "",
                                          color: AppColors.primary,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ).toList(),
                              ],
                            ),
                          ),

                    // Container(
                    //     // height: 50,
                    //     // width: 100,
                    //     child: Expanded(
                    //                                   child: ListView.builder(
                    //           scrollDirection: Axis.vertical,
                    //           padding: EdgeInsets.all(0),
                    //           itemCount: map['product_list'].length,
                    //           itemBuilder: (context, index) => Container(
                    //             child: CustomText(
                    //                   text: map['product_list'][index]['name'],
                    //                   fontSize: 10.sp,
                    //                   fontWeight: FontWeight.w700,
                    //                   color: AppColors.black11,
                    //                 ),
                    //           )),
                    //     ),
                    //   ),

                    map['total_price'] == null
                        ? Container()
                        : CustomText(
                            text:
                                "Total Price: " + map['total_price'] + " AED" ??
                                    "",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              selected == 0
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            return ServerProvider.instance
                                .setBookingAccept(map['id']);
                          },
                          child: Container(
                            height: 32.h,
                            width: 32.w,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.done,
                              color: Colors.white,
                              size: 28.r,
                            ),
                            alignment: Alignment.center,
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 32.h,
                            width: 32.w,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.redAccent,
                                )),
                            child: Icon(
                              Icons.remove,
                              color: AppColors.redAccent,
                              size: 28.r,
                            ),
                            alignment: Alignment.center,
                          ),
                        ),
                      ],
                    )
                  : selected == 1
                      ? Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {
                              Get.dialog(Container(
                                height: 200,
                                child: AlertDialog(
                                    title: RateProductScreen(
                                  userId: map['user_id'].toString(),
                                )),
                              ));
                              // return
                            },
                            child: Container(
                              height: 32.h,
                              width: 32.w,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 28.r,
                              ),
                              alignment: Alignment.center,
                            ),
                          ),
                        )
                      : Container(),
              SizedBox(
                width: 8.w,
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
