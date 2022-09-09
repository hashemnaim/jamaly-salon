import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/apis/auth_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/user/home_user_controller.dart';
import 'package:yacht_booking/models/categories_model.dart';
import 'package:yacht_booking/view/widgets/cash_network_image_share.dart';
import 'package:yacht_booking/view/widgets/custom_app_bar.dart';
import 'package:yacht_booking/view/widgets/custom_button.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../apis/auth_apis.dart';
import '../user/change_password_success/change_password_success_screen.dart';

class ChooseCategoryScreen extends StatelessWidget {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String type;
  final String mobile;
  final String address;

  ChooseCategoryScreen(
      {Key key,
      this.name,
      this.email,
      this.password,
      this.confirmPassword,
      this.type,
      this.mobile,
      this.address})
      : super(key: key);
  HomeUserController homeUserController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'التصنيفات',
        isBack: true,
      ),
      body: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                CustomText(
                  'الرجاء قم باختيار التصنيفات التي تقدمها ',
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  fontSize: 15.0,
                  fontColor: const Color(0xFF161617).withOpacity(0.6),
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
                SizedBox(
                  height: 20.h,
                ),
                homeUserController.getCategoriesData.value.data == null
                    ? Center(
                        child: Helper.loading(),
                      )
                    : homeUserController.getCategoriesData.value.data.isEmpty
                        ? Center(
                            child: CustomText("لا يوجد تصنيفات"),
                          )
                        : GridView.count(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.w, vertical: 15.h),
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            mainAxisSpacing: 10.h,
                            crossAxisSpacing: 10.w,
                            childAspectRatio: 158.w / 88.h,
                            children: List.generate(
                              homeUserController
                                  .getCategoriesData.value.data.length,
                              (index) {
                                CategoriesModelData servicesModelData =
                                    homeUserController
                                        .getCategoriesData.value.data[index];
                                return InkWell(
                                  onTap: () {
                                    homeUserController.addCategoryIdList(
                                        servicesModelData.id);
                                  },
                                  child: Container(
                                    padding: EdgeInsetsDirectional.all(5.r),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: AppColors.boxShadow,
                                        borderRadius:
                                            BorderRadiusDirectional.circular(
                                                10.r),
                                        border: Border.all(
                                          color: homeUserController
                                                  .categoryIdList.value
                                                  .contains(
                                                      servicesModelData.id)
                                              ? AppColors.primaryColor
                                              : Colors.transparent,
                                          width: 2.w,
                                        )),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CustomText(
                                          '${servicesModelData.title ?? ""}',
                                        ),
                                        CachedNetworkImageShare(
                                          servicesModelData.image,
                                          50,
                                          50,
                                          1,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
              child: CustomButton(
                text: 'تأكيد',
                onTap: () {
                  if (homeUserController.categoryIdList.length != 0) {
                    AuthApis.authApis.setVendorCategories(
                        homeUserController.categoryIdList.toString());
                    Get.offAll(() => ChangePasswordSuccessScreen());

                    // AuthApis.authApis.registerUser(
                    //   name,
                    //   email,
                    //   password,
                    //   confirmPassword,
                    //   type,
                    //   mobile,
                    //   address,
                    //   homeUserController.categoryIdList.toString(),
                    // );
                  } else {
                    Helper.getSheetError('الرجاء اختيار التصنيفات التي تقدمها');
                  }

                  // Get.offAll(() => BottomNavBarScreen());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
