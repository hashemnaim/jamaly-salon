import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:salon_provider/feature/server/getx/app_get_salon.dart';
import 'package:salon_provider/feature/values/colors.dart';
import 'package:salon_provider/feature/values/style.dart';

import '../../widgets/cash_network_image_share.dart';

class ServicesItem extends StatefulWidget {
  final Map map;
  final Function onTap;

  ServicesItem({this.map, this.onTap});

  @override
  _ServicesItemState createState() => _ServicesItemState();
}

class _ServicesItemState extends State<ServicesItem> {
  bool add = true;
  AppGet appController = Get.find();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: 120.h,
        width: 343.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r), color: Colors.white),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: widget.map['image_url'] == null
                  ? Image.asset(
                      "assets/images/logo.png",
                      height: 114.h,
                      width: 114.w,
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: CachedNetworkImageShare(
                          widget.map['image_url'], 133.h, 133.w, 5)),
            ),
            SizedBox(
              width: 17.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 16.h,
                ),
                Container(
                  width: 212.w,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        customSplit(widget.map['name'],
                            widget.map['discount'] == null ? 12 : 23),
                        style: AppStyle.h6.copyWith(color: AppColors.black11),
                      ),
                      Visibility(
                        visible: widget.map['discount'] != null,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              FontAwesomeIcons.tag,
                              color: AppColors.orange,
                              size: 14.r,
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            Text(
                              '${widget.map['discount'] ?? "0"}%',
                              style:
                                  AppStyle.h7.copyWith(color: AppColors.orange),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 24.w,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${int.parse(widget.map['price'].toString()) - (int.parse(widget.map['price'].toString()) * int.parse(widget.map['discount'].toString() ?? "0") / 100)} AED',
                      style: AppStyle.h6.copyWith(color: AppColors.primary),
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      '${widget.map['price']} AED',
                      style: AppStyle.h7.copyWith(
                        color: AppColors.gray80,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      '${widget.map['time']} M',
                      style:
                          AppStyle.bodySmall.copyWith(color: AppColors.gray80),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                Container(
                  width: 112.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        constraints: BoxConstraints(maxWidth: 149.w),
                        child: Text(
                          widget.map['about'] ?? "",
                          style: AppStyle.bodySmall
                              .copyWith(color: AppColors.gray80),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Spacer(),
                      // InkWell(
                      //   onTap: () {
                      //     // if (_appController.listIdServices
                      //     //     .contains(widget.map['id'].toString())) {
                      //     //   _appController.subTotalPrice(
                      //     //       int.parse(widget.map['price']) -
                      //     //           (int.parse(widget.map['price']) *
                      //     //               int.parse(
                      //     //                   widget.map['discount'] ?? "0") /
                      //     //               100));
                      //     //   _appController.listServices.remove(widget.map);
                      //     //   _appController.listIdServices
                      //     //       .remove(widget.map['id'].toString());
                      //     //   print(_appController.listIdServices);
                      //     //   setState(() {
                      //     //     add = !add;
                      //     //   });
                      //     // } else {
                      //     //   _appController.addTotalPrice(
                      //     //       int.parse(widget.map['price']) -
                      //     //           (int.parse(widget.map['price']) *
                      //     //               int.parse(
                      //     //                   widget.map['discount'] ?? "0") /
                      //     //               100));

                      //     //   _appController.listServices.add(widget.map);
                      //     //   _appController.listIdServices
                      //     //       .add(widget.map['id'].toString());
                      //     //   print(_appController.listIdServices);
                      //     // }

                      //     // setState(() {
                      //     //   add = !add;
                      //     // });
                      //   },
                      //   child: Visibility(
                      //     visible: true,
                      //     child: Container(
                      //       height: 32.h,
                      //       width: 32.w,
                      //       decoration: BoxDecoration(
                      //         color: AppColors.primary,
                      //         shape: BoxShape.circle,
                      //       ),
                      //       child: Icon(
                      //         Icons.add,
                      //         color: Colors.white,
                      //         size: 28.r,
                      //       ),
                      //       alignment: Alignment.center,
                      //     ),
                      //     replacement: Container(
                      //       height: 32.h,
                      //       width: 32.w,
                      //       decoration: BoxDecoration(
                      //           shape: BoxShape.circle,
                      //           border: Border.all(
                      //             color: AppColors.redAccent,
                      //           )),
                      //       child: Icon(
                      //         Icons.remove,
                      //         color: AppColors.redAccent,
                      //         size: 28.r,
                      //       ),
                      //       alignment: Alignment.center,
                      //     ),
                      //   ),
                      // ),

                      SizedBox(
                        width: 16.w,
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
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
