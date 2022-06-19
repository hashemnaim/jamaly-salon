import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salon_provider/feature/server/getx/app_get_salon.dart';
import 'package:salon_provider/feature/server/helper/sp_helpar.dart';
import 'package:salon_provider/feature/values/colors.dart';
import 'package:salon_provider/feature/values/string.dart';
import 'package:salon_provider/feature/values/style.dart';
import 'package:salon_provider/feature/view/Screen_Salon/widgets/service_details.dart';
import 'package:salon_provider/feature/view/Screen_Salon/widgets/services_item.dart';
import 'package:salon_provider/feature/view/widgets/cash_network_image_share.dart';
import 'package:salon_provider/feature/view/widgets/custom_text.dart';
import 'package:salon_provider/feature/view/widgets/isload.dart';

class ShopDetailsScreen extends StatefulWidget {
  final Map map;
  ShopDetailsScreen(this.map);

  @override
  _ShopDetailsScreenState createState() => _ShopDetailsScreenState();
}

class _ShopDetailsScreenState extends State<ShopDetailsScreen> {
  int max = 3;
  int currentIndex = 0;
  int idSpachlist = 0;
  int idIndex = -1;
  AppGet _appController = Get.find();
  bool isFav;
  Map mapSalon;
  @override
  void initState() {
    idSpachlist = 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  // fit: StackFit.expand,
                  children: [
                    Center(
                      child: widget.map['image_url'] == null
                          ? Image.asset(
                              "assets/images/logo.png",
                              height: 194.h,
                              width: 194.w,
                            )
                          : ClipRRect(
                              // borderRadius: BorderRadius.circular(8.r),
                              child: CachedNetworkImageShare(
                                  widget.map['image_url'][0],
                                  230.h,
                                  Get.width.w,
                                  5)),
                    ),
                    Positioned(
                      top: 50,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        width: Get.width,
                        child: Row(
                          children: [
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: circleButton(
                                  color: AppColors.primary,
                                  icon: Icons.arrow_forward_ios_outlined,
                                  onTap: () {
                                    Get.back();
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 14.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.map['name'] ?? "",
                        style: AppStyle.h3.copyWith(color: AppColors.black11),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        widget.map['address'] ?? "",
                        style: AppStyle.bodyMedium
                            .copyWith(color: AppColors.gray80),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_outlined,
                                color: AppColors.primary,
                                size: 18.r,
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              CustomText(
                                text: widget.map['open']
                                    ? "[Open Today]"
                                    : "[Close Today]",
                                color: AppColors.gray80,
                                // style: AppStyle.bodyMedium
                                //     .copyWith(color: AppColors.gray80),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 50.h,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: AppColors.orange,
                                size: 18.r,
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                '${widget.map['rate']}',
                                style: AppStyle.h6
                                    .copyWith(color: AppColors.gray80),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 17.h,
                      ),
                      SizedBox(
                          height: 0,
                          child: Divider(
                            color: AppColors.gray40,
                            thickness: 1,
                          )),
                      SizedBox(
                        height: 24.5.h,
                      ),
                      widget.map['about'] == null
                          ? Container()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: 'About',
                                  color: AppColors.black11,
                                  // style: AppStyle.h5
                                  //     .copyWith(color: AppColors.black11),
                                ),
                                SizedBox(
                                  height: 14.h,
                                ),
                                StatefulBuilder(
                                  builder: (context, setState) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '''${widget.map['about'] ?? ""}''',
                                          style: AppStyle.bodyMedium.copyWith(
                                              color: AppColors.gray80),
                                          maxLines: max,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              max == 100 ? max = 3 : max = 100;
                                            });
                                          },
                                          child: CustomText(
                                            text: max == 100
                                                ? 'Read less'
                                                : 'Read more',
                                            color: AppColors.primary,
                                            // style:
                                            //     AppStyle.buttonSmall.copyWith(
                                            //   color: AppColors.primary,
                                            // ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 32.h,
                                ),
                              ],
                            ),
                      CustomText(
                        text: 'Opening Hours',
                        color: AppColors.black11,
                        // style: AppStyle.h5.copyWith(color: AppColors.black11),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Container(
                        height: 53.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.map['times'].length,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              children: [
                                SizedBox(
                                  width: 10.w,
                                ),
                                Container(
                                  height: 8.h,
                                  width: 8.w,
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.map['times'][index]['day'],
                                      style: AppStyle.buttonMedium
                                          .copyWith(color: AppColors.gray80),
                                    ),
                                    CustomText(
                                      text:
                                          '${widget.map['times'][index]['time_from']} - ${widget.map['times'][index]['time_to']}',
                                      // style: AppStyle.h6
                                      //     .copyWith(color: AppColors.black11),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 14.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Our Services',
                        color: AppColors.black11,
                        // style: AppStyle.h5.copyWith(color: AppColors.black11),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      SizedBox(
                        height: 40.h,
                        width: Get.width,
                        child: StatefulBuilder(builder: (context, setState) {
                          return ListView.builder(
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            // padding: EdgeInsets.symmetric(horizontal: 12.w),
                            physics: BouncingScrollPhysics(),
                            itemCount: widget.map['services'].length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    // _appController.salonByIdService
                                    //     .assignAll({});
                                    // AppApi.appApi.getSlonProductByIdService(
                                    //     widget.map['id'].toString(),
                                    //     widget.map['services'][index]['id']);
                                    // currentIndex = index;
                                    // // _appController.listServicesSalon.contains(
                                    // //         widget.map['services'][index]['id'])
                                    // //     ? _appController.listServicesSalon.remove(
                                    // //         widget.map['services'][index]['id'])
                                    // //     : _appController.listServicesSalon.add(widget
                                    // //         .map['services'][index]['id']);
                                    // setState(() {});
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 48.h,
                                        width: 100.w,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 4.w),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: currentIndex == index
                                                ? AppColors.primary20
                                                : Colors.white,
                                            border: Border.all(
                                                color: currentIndex == index
                                                    ? AppColors.primary
                                                    : AppColors.gray60),
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            widget.map['services'][index]
                                                        ['image_url'] ==
                                                    null
                                                ? Image.asset(
                                                    "assets/images/logo.png",
                                                    height: 194.h,
                                                    width: 194.w,
                                                  )
                                                : ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.r),
                                                    child:
                                                        CachedNetworkImageShare(
                                                      widget.map['services']
                                                          [index]['image_url'],
                                                      24.h,
                                                      24.w,
                                                      5,
                                                      service: true,
                                                    )),

                                            // Container(
                                            //   height: 24.h,
                                            //   width: 24.w,
                                            //   decoration: BoxDecoration(
                                            //       image: DecorationImage(
                                            //           image: NetworkImage(
                                            //     baseImageUrl +
                                            //         widget.map['services'][index]
                                            //             ['image_url'],
                                            //   ))),
                                            // ),
                                            SizedBox(
                                              width: 16.w,
                                            ),
                                            CustomText(
                                              text: widget.map['services']
                                                  [index]['name'],
                                              // style: AppStyle.buttonMedium
                                              //     .copyWith(
                                              //         color: currentIndex ==
                                              //                 index
                                              //             ? AppColors.primary
                                              //             : AppColors.black11),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ));
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                ),

                _appController.myServices['data'].length == 0
                    ? Center(
                        child: CustomText(text: 'No Services'),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: _appController.myServices['data'].length,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 14.h,
                        ),
                        itemBuilder: (context, index) {
                          return ServicesItem(
                            map: _appController.myServices['data'][index],
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(32.r),
                                    topRight: Radius.circular(32.r),
                                  ),
                                ),
                                builder: (BuildContext _) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(32.r),
                                      topRight: Radius.circular(32.r),
                                    ),
                                    child: ServiceDetails(_appController
                                        .myServices['data'][index]),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                // _appController.salonByIdService['data']['data'].length < 2
                //     ? Container()
                //     : Padding(
                //         padding: EdgeInsets.symmetric(
                //             horizontal: 16.w, vertical: 20.h),
                //         child: Row(
                //           children: [
                //             Expanded(
                //               child: FlatButton(
                //                 onPressed: () {
                //                   // Get.to(() => ServiceMenuScreen());
                //                   // showModalBottomSheet(
                //                   //     context: context,
                //                   //     shape: RoundedRectangleBorder(
                //                   //       borderRadius:
                //                   //           BorderRadius.circular(32.r),
                //                   //     ),
                //                   //     builder: (BuildContext _) {
                //                   //       return ClipRRect(
                //                   //         borderRadius:
                //                   //             BorderRadius.circular(32.r),
                //                   //         child: ServiceMenuScreen(),
                //                   //       );
                //                   //     },
                //                   //     isScrollControlled: true);
                //                 },
                //                 splashColor: AppColors.primary,
                //                 color: Colors.transparent,
                //                 padding: EdgeInsets.zero,
                //                 height: 54.h,
                //                 shape: RoundedRectangleBorder(
                //                     borderRadius: BorderRadius.circular(100.r),
                //                     side: BorderSide(color: AppColors.primary)),
                //                 child: Text(
                //                   'View All Services',
                //                   style: AppStyle.buttonMedium
                //                       .copyWith(color: AppColors.primary),
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: CustomText(
                    text: 'Our Specialists'.tr,
                    // style: AppStyle.h6.copyWith(color: AppColors.black11),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                widget.map['specialists'].length == 0
                    ? Center(
                        child: Container(
                        child: CustomText(text: "No Specialists".tr),
                      ))
                    : SizedBox(
                        height: 100.h,
                        width: Get.width,
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          itemCount: widget.map['specialists'].length,
                          primary: false,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(1000.r),
                                              child: CachedNetworkImageShare(
                                                widget.map['specialists'][index]
                                                    ["image_url"],
                                                40.h,
                                                40.w,
                                                5,
                                              )),
                                          idIndex != index
                                              ? Container()
                                              : CircleAvatar(
                                                  radius: 10.r,
                                                  backgroundColor: Colors.green,
                                                  child: Icon(
                                                    Icons.done,
                                                    size: 13.r,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 6.h,
                                      ),
                                      Text(
                                        widget.map['specialists'][index]
                                            ["name"],
                                        style: AppStyle.buttonMedium
                                            .copyWith(color: AppColors.black11),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                SizedBox(
                  height: 14.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomText(
                        text: 'Gralley',
                        color: AppColors.black11,
                        // style: AppStyle.h5.copyWith(color: AppColors.black11),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                _appController.salonByIdGralley.isEmpty
                    ? IsLoad()
                    : _appController.salonByIdGralley['data'].length == 0
                        ? Center(
                            child: Container(
                            child: CustomText(text: "No Gralley"),
                          ))
                        : SizedBox(
                            height: 94.h,
                            width: Get.width,
                            child: ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              itemCount: _appController
                                  .salonByIdGralley['data'].length,
                              primary: false,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.w),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        child: Container(
                                          width: 94.w,
                                          height: 94.h,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                baseImageUrl +
                                                    _appController
                                                                .salonByIdGralley[
                                                            'data'][index]
                                                        ['image_url'],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                SizedBox(
                  height: 12.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomText(
                        text: 'Reviews',
                        color: AppColors.black11,
                        // style: AppStyle.h5.copyWith(color: AppColors.black11),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                _appController.salonByIdReviews.isEmpty
                    ? IsLoad()
                    : _appController.salonByIdReviews['data'].length == 0
                        ? Center(
                            child: Container(
                            child: CustomText(text: "No Reviews"),
                          ))
                        : Container(),
                Container(
                  height: 100,
                  child: ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: _appController.salonByIdReviews['data'].length,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _appController.salonByIdReviews['data']
                                          [index]['user'] ==
                                      null
                                  ? Image.asset(
                                      "assets/images/logo.png",
                                      height: 194.h,
                                      width: 194.w,
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(8.r),
                                      child: CachedNetworkImageShare(
                                          _appController
                                                  .salonByIdReviews['data']
                                              [index]['user']['photo'],
                                          48.h,
                                          48.w,
                                          5)),
                            ),
                            SizedBox(
                              width: 16.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _appController.salonByIdReviews['data'][index]
                                              ["user"] ==
                                          null
                                      ? Container()
                                      : Text(
                                          _appController
                                                  .salonByIdReviews['data']
                                              [index]["user"]['name'],
                                          style: AppStyle.bodyLarge.copyWith(
                                              color: AppColors.black11),
                                        ),
                                  SizedBox(
                                    height: 8.h,
                                  ),
                                  // CustomRateRead(
                                  //   rate: int.parse(
                                  //       _appController.salonByIdReviews['data']
                                  //               [index]['rate'] ??
                                  //           "0"),
                                  //   size: 10.r,
                                  // ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  Text(
                                    _appController.salonByIdReviews['data']
                                            [index]['review'] ??
                                        "",
                                    style: AppStyle.bodyMedium
                                        .copyWith(color: AppColors.gray80),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // bottomNavigationBar: Container(
          //   height: 86.w,
          //   width: Get.width,
          //   padding: EdgeInsets.symmetric(horizontal: 16.w),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Column(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Row(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               CustomText(
          //                 text: 'Total',
          //                 color: Colors.black,
          //                 // style: AppStyle.h6.copyWith(color: Colors.black),
          //               ),
          //               SizedBox(
          //                 width: 4.w,
          //               ),
          //               // Text(
          //               //   '(1 Service)',
          //               //   style: AppStyle.bodyMedium.copyWith(color: Colors.black),
          //               // ),
          //             ],
          //           ),
          //           SizedBox(
          //             height: 5.h,
          //           ),
          //           Row(
          //             crossAxisAlignment: CrossAxisAlignment.end,
          //             children: [
          //               Text(
          //                 '${_appController.totalPrice} AED',
          //                 style: AppStyle.h4.copyWith(color: AppColors.primary),
          //               ),
          //               // SizedBox(
          //               //   width: 6.w,
          //               // ),
          //               // Text(
          //               //   '10AED',
          //               //   style: AppStyle.bodyLarge.copyWith(
          //               //     color: AppColors.black11,
          //               //     decoration: TextDecoration.lineThrough,
          //               //   ),
          //               // ),
          //             ],
          //           ),
          //         ],
          //       ),
          //       // Container(
          //       //   height: 52.h,
          //       //   width: 52.w,
          //       //   alignment: Alignment.center,
          //       //   decoration: BoxDecoration(
          //       //     shape: BoxShape.circle,
          //       //     border: Border.all(color: AppColors.primary),
          //       //   ),
          //       //   child: Icon(
          //       //     FontAwesomeIcons.solidCommentDots,
          //       //     color: AppColors.primary,
          //       //     size: 20.r,
          //       //   ),
          //       // ),

          //       // Container(
          //       //   width: 134.w,
          //       //   child: FlatButton(
          //       //     onPressed: () async {
          //       //       if (SPHelper.spHelper.getToken() == null) {
          //       //         Get.dialog(CustomDialogBox(
          //       //             "Please sign in to your account", onPress: () {
          //       //           Get.to(() => SignInScreen());
          //       //         }));
          //       //       } else {
          //       //         if (_appController.totalPrice.value == 0) {
          //       //           Get.snackbar('Select Services'.tr, "");
          //       //         } else {
          //       //           await AppApi.appApi.getTimesFree(
          //       //               DateTime.now().toString().split(' ')[0],
          //       //               widget.map['id'].toString(),
          //       //               [
          //       //                 "Mon",
          //       //                 "Tue",
          //       //                 "Wed",
          //       //                 "Thr",
          //       //                 "Fri",
          //       //                 "Sat",
          //       //                 "Sun",
          //       //               ][DateTime.now().weekday - 1]);
          //       //           print(widget.map['id'].toString());
          //       //           _appController.bookingDate.value =
          //       //               DateTime.now().toString().split(' ')[0];
          //       //           Get.to(() => BookingScreen(
          //       //                 salonId: widget.map['id'].toString(),
          //       //                 map: mapSalon,
          //       //                 specialistsId:
          //       //                     idSpachlist == -1 ? 0 : idSpachlist,
          //       //               ));
          //       //         }
          //       //       }
          //       //     },
          //       //     splashColor: AppColors.gray50.withOpacity(0.5),
          //       //     color: AppColors.primary,
          //       //     padding: EdgeInsets.zero,
          //       //     height: 54.h,
          //       //     shape: RoundedRectangleBorder(
          //       //       borderRadius: BorderRadius.circular(100.r),
          //       //     ),
          //       //     child: CustomText(
          //       //       'Book Now'.tr,
          //       //       color: Colors.white,
          //       //       fontWeight: FontWeight.w600,
          //       //       style: TextStyle(
          //       //           fontSize: 16.sp,
          //       //           fontWeight: FontWeight.w600,
          //       //           fontFamily: "Manrope",
          //       //           color: Colors.white),
          //       //     ),
          //       //   ),
          //       // )
          //     ],
          //   ),
          // ),
        ));
  }

  Widget circleButton({
    Function onTap,
    IconData icon,
    Color color,
  }) {
    return SizedBox(
      height: 48.h,
      width: 48.w,
      child: FlatButton(
        padding: EdgeInsets.zero,
        onPressed: onTap,
        splashColor: AppColors.primary,
        color: Color(0xffF9FAFA).withOpacity(0.6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.r),
        ),
        child: Icon(
          icon ?? Icons.arrow_back_ios_rounded,
          color: color ?? AppColors.primary,
          size: 20.r,
        ),
      ),
    );
  }

  customSplit(String value, int length) {
    return value.toString().length > length
        ? value.toString().substring(0, length) + '..'
        : value;
  }
}
