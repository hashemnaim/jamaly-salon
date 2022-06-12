import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/user/home_user_controller.dart';
import 'package:yacht_booking/view/widgets/custom_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  HomeUserController homeUserController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'الشروط و الاحكام',
        backFun: () => Get.back(),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Obx(
          () => homeUserController.termsData.value.status == null
              ? Helper.loading()
              : ListView.builder(
                  itemCount: homeUserController.termsData.value.data.length,
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 15.h),
                  itemBuilder: (context, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(
                            homeUserController
                                .termsData.value.data[index].title,
                            fontColor: AppColors.primaryColor,
                            alignment: AlignmentDirectional.centerStart,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(height: 10.h),
                          CustomText(
                            homeUserController.termsData.value.data[index].body,
                            alignment: AlignmentDirectional.centerStart,
                            maxLines: 15,
                            fontSize: 13,
                          ),
                          SizedBox(height: 20.h),
                        ],
                      )),
        ),
      ),
    );
  }
}
