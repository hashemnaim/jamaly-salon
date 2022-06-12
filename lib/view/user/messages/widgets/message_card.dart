import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

class MessageCard extends StatelessWidget {
  final String imagename;
  final String name;
  final String lastMessage;
  final String time;
  final String noOfMesseges;

  MessageCard({
    this.imagename,
    this.name,
    this.lastMessage,
    this.time,
    this.noOfMesseges,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70.h,
      decoration: BoxDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 65.r,
            height: 65.r,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(10.r),
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  imagename,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      '$name',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      alignment: AlignmentDirectional.centerStart,
                    ),
                    Visibility(
                      visible: time != null,
                      child: CustomText(
                        '$time',
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.h, 
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: lastMessage != null,
                      child: Expanded(
                        child: CustomText(
                          '$lastMessage',
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          height: 1,
                          alignment: AlignmentDirectional.centerStart,
                        ),
                      ),
                    ),
                    // Visibility(
                    //   visible: noOfMesseges != null,
                    //   child: Badge(
                    //     animationType: BadgeAnimationType.fade,
                    //     badgeColor: AppColors.primaryColor,
                    //     badgeContent: CustomText(
                    //       '$noOfMesseges',
                    //       fontColor: Colors.white,
                    //       fontSize: 10,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
