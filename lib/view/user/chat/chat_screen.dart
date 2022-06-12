import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/view/widgets/custom_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yacht_booking/view/widgets/custom_avatar.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';
import 'package:yacht_booking/view/widgets/custom_text_form_field.dart';

import 'widgets/reservation_confirmation_dialog.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'شركة أعالي البحار',
        text: '',
        isText: true,
        backFun: () => Get.back(),
        actionFun: () => reservationConfirmationDialog(),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomAvatar(15, 15, 'person'),
                            SizedBox(height: 3.h),
                            CustomText('8:07 pm', fontSize: 10),
                          ],
                        ),
                        SizedBox(width: 10.w),
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: 250.w,
                            minWidth: 0,
                            maxHeight: double.infinity,
                            minHeight: 40.h,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 15.w,
                            vertical: 5.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius:
                                BorderRadiusDirectional.circular(10.r),
                          ),
                          child: Text(
                            'السلام عليكم',
                            textAlign: TextAlign.end,
                            maxLines: 25,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Cairo',
                              fontSize: 14.sp
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: 250.w,
                            minWidth: 0,
                            maxHeight: double.infinity,
                            minHeight: 40.h,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 15.w,
                            vertical: 5.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius:
                            BorderRadiusDirectional.circular(10.r),
                          ),
                          child: Text(
                            'هلا أخي و عليكم السلام',
                            textAlign: TextAlign.end,
                            maxLines: 25,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: AppColors.fontPrimaryColor,
                                fontFamily: 'Cairo',
                                fontSize: 14.sp
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomAvatar(15, 15, 'person2'),
                            SizedBox(height: 3.h),
                            CustomText('9:57 pm', fontSize: 10),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: CustomTextFormField(
                hintText: 'اكتب هنا...',
                isBoxShadow: false,
                fillColor: Colors.white,
                isBorderRadius: false,
                suffixIcon: Icon(
                  Icons.send,
                  color: AppColors.primaryColor,
                  size: 25.r,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
