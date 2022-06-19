import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:salon_provider/feature/server/getx/app_get_salon.dart';
import 'package:salon_provider/feature/values/colors.dart';
import 'package:salon_provider/feature/view/widgets/custom_text.dart';
import 'package:salon_provider/feature/view/widgets/isload.dart';

enum NotificationType { offer, appointment, payment }

class NotificationScreen extends StatefulWidget {
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  AppGet appGet = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 30.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  CustomText(
                    text: 'Notifications',
                    color: AppColors.primary,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    height: 5.h,
                    width: 5.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.primary),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 12.h,
          ),
          SizedBox(
              height: 0,
              child: Divider(
                thickness: 2,
                color: AppColors.gray20,
              )),
          Obx(() => Expanded(
                child: appGet.notifiaction.isEmpty
                    ? IsLoad()
                    : appGet.notifiaction['data'].length == 0
                        ? Center(
                            child: CustomText(text: 'Notification is Empty'),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            physics: BouncingScrollPhysics(),
                            itemCount: appGet.notifiaction['data'].length,
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (context, index) {
                              return NotificationItem(
                                  NotificationType.appointment,
                                  appGet.notifiaction['data'][index]);
                            },
                          ),
              )),
        ],
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final Map map;

  final NotificationType notificationType;

  NotificationItem(this.notificationType, this.map);

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    switch (notificationType) {
      case NotificationType.appointment:
        return Container(
          child: Column(
            children: [
              Container(
                height: 81.h,
                child: Row(
                  children: [
                    Container(
                      height: 48.h,
                      width: 48.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: AppColors.primary20),
                      child: Icon(
                        Icons.calendar_today,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(
                      width: 24.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomText(
                              text: map['title'],
                              color: AppColors.black11,
                            ),
                            // Text(' Get ready for ',
                            //     style: AppStyle.bodyMedium.copyWith(
                            //       color: AppColors.black11,
                            //     )),
                          ],
                        ),
                        CustomText(
                          text: map['body'],
                          color: AppColors.black11,
                        ),
                      ],
                    ),
                    // Spacer(),
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   crossAxisAlignment: CrossAxisAlignment.end,
                    //   children: [
                    //     Text(
                    //       'Just now',
                    //       style: AppStyle.bodySmall.copyWith(
                    //         color: AppColors.gray60,
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       height: 8.h,
                    //     ),
                    //     Container(
                    //       height: 8.h,
                    //       width: 8.w,
                    //       alignment: Alignment.center,
                    //       decoration: BoxDecoration(
                    //           shape: BoxShape.circle, color: AppColors.orange),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
              SizedBox(
                  height: 0,
                  child: Divider(
                    thickness: 1,
                    color: AppColors.gray20,
                  )),
            ],
          ),
        );
        break;
      case NotificationType.offer:
        return Container(
          child: Column(
            children: [
              Container(
                height: 81.h,
                child: Row(
                  children: [
                    Container(
                      height: 48.h,
                      width: 48.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: AppColors.primary20),
                      child: Icon(
                        FontAwesomeIcons.tag,
                        color: AppColors.primary,
                        size: 15.r,
                      ),
                    ),
                    SizedBox(
                      width: 24.w,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CustomText(
                              text: 'Get',
                              color: AppColors.black11,
                            ),
                            CustomText(
                              text: ' 20% ',
                              color: AppColors.black11,
                            ),
                            CustomText(
                              text: 'offers for hair',
                              color: AppColors.black11,
                            ),
                          ],
                        ),
                        CustomText(
                          text: 'service at Lovely Lather',
                          color: AppColors.black11,
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomText(
                          text: 'Just now',
                          color: AppColors.black11,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Container(
                          height: 8.h,
                          width: 8.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: AppColors.orange),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                  height: 0,
                  child: Divider(
                    thickness: 1,
                    color: AppColors.gray20,
                  )),
            ],
          ),
        );
        break;
      case NotificationType.payment:
        return Container(
            child: Column(children: [
          Container(
            height: 81.h,
            child: Row(
              children: [
                Container(
                  height: 48.h,
                  width: 48.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.primary20),
                  child: Icon(
                    Icons.attach_money_rounded,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(
                  width: 24.w,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CustomText(
                          text: 'Payment at',
                          color: AppColors.black11,
                        ),
                        CustomText(
                          text: 'Lovely Lather',
                          color: AppColors.black11,
                        ),
                        CustomText(
                          text: 'was success!',
                          color: AppColors.black11,
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomText(
                          text: 'Just now',
                          color: AppColors.black11,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Container(
                          height: 8.h,
                          width: 8.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: AppColors.orange),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                    height: 0,
                    child: Divider(
                      thickness: 1,
                      color: AppColors.gray20,
                    )),
              ],
            ),
          )
        ]));
        break;
    }
  }
}
