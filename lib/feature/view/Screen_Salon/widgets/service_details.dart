import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:salon_provider/feature/server/getx/app_get_salon.dart';
import 'package:salon_provider/feature/values/colors.dart';
import 'package:salon_provider/feature/values/string.dart';
import 'package:salon_provider/feature/values/style.dart';
import 'package:salon_provider/feature/view/widgets/custom_text.dart';
import 'custom_page_view.dart';

class ServiceDetails extends StatefulWidget {
  final Map map;
  ServiceDetails(this.map);

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails> {
  AppGet appController = Get.find();

  bool add = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 680.h,
      child: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SliderImage(
              imageList: ['${baseImageUrl + widget.map['image_url']}'],
            ),
            // Stack(
            //   children: [
            //     Container(
            //       child: Positioned(
            //         top: 16.h,
            //         child: Container(
            //           width: Get.width,
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: [
            //               Container(
            //                   width: 48.w,
            //                   height: 5.h,
            //                   decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(100.r),
            //                     color: Colors.white,
            //                   )),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: widget.map['name'],
                    // style: AppStyle.h3.copyWith(color: AppColors.black11),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_outlined,
                        color: AppColors.gray80,
                        size: 18.r,
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      CustomText(
                        text: '${widget.map['time']} ' 'hours service'.tr,
                        // style: AppStyle.bodyLarge
                        //     .copyWith(color: AppColors.black11),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${int.parse(widget.map['price']) - (int.parse(widget.map['price']) * int.parse(widget.map['discount'] ?? "0") / 100)} AED',
                        style: AppStyle.h3.copyWith(color: AppColors.primary),
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Text(
                        '${widget.map['price']} AED',
                        style: AppStyle.bodyLarge.copyWith(
                          color: AppColors.gray80,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: 94.w,
                        height: 34.h,
                        decoration: BoxDecoration(
                          color: Color(0xffFFF9E5),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.tag,
                              color: AppColors.orange,
                              size: 13.5.r,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            CustomText(
                              text: '-${widget.map['discount'] ?? "0"}%',
                              color: AppColors.orange,
                              // style:
                              //     AppStyle.h5.copyWith(color: AppColors.orange),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    height: 0,
                    child: Divider(
                      color: AppColors.gray40,
                      thickness: 1.h,
                    ),
                  ),
                  SizedBox(
                    height: 14.h,
                  ),
                  CustomText(
                    text: 'About Service',
                    color: AppColors.black11,
                    // style: AppStyle.h5.copyWith(color: AppColors.black11),
                  ),
                  CustomText(
                    text: widget.map['about'] ?? "",
                    // style:
                    //     AppStyle.bodyMedium.copyWith(color: AppColors.gray80),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
