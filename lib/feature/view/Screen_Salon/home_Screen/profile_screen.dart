import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salon_provider/feature/server/getx/app_get_salon.dart';
import 'package:salon_provider/feature/server/helper/sp_helpar.dart';
import 'package:salon_provider/feature/server/service/server_salon.dart';
import 'package:salon_provider/feature/values/colors.dart';
import 'package:salon_provider/feature/view/Screen_Salon/home_Screen/addProfile.dart';
import 'package:salon_provider/feature/view/Screen_Salon/home_Screen/addService.dart';
import 'package:salon_provider/feature/view/Screen_Salon/home_Screen/shop_details_screen.dart';
import 'package:salon_provider/feature/view/widgets/custom_text.dart';
import '../auth_screen/sign_in_screen.dart';
import 'addSpashlist.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AppGet appGet = Get.find();

  List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 40.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  CustomText(
                    text: 'My Profile',
                    color: AppColors.primary,
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
          Expanded(
            child: Obx(
              () => appGet.userProfil.isEmpty
                  ? Align(
                      alignment: Alignment.topLeft,
                      child: CustomText(
                          text: 'Profile information'.tr,
                          color: AppColors.black11),
                    )
                  : ListView(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      children: [
                        SizedBox(
                          height: 24.h,
                        ),
                        CustomText(
                            text: 'Profile information',
                            color: AppColors.black11),
                        Column(
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
                                        shape: BoxShape.circle,
                                        color: AppColors.primary20),
                                    child: Icon(
                                      Icons.person,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 24.w,
                                  ),
                                  CustomText(
                                    text:
                                        appGet.userProfil['data']['name'] ?? "",
                                    color: AppColors.black11,
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
                        Column(
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
                                        shape: BoxShape.circle,
                                        color: AppColors.primary20),
                                    child: Icon(
                                      Icons.email_outlined,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 24.w,
                                  ),
                                  CustomText(
                                    text: appGet.userProfil['data']['email'],
                                    color: AppColors.black11,
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
                        Column(
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
                                        shape: BoxShape.circle,
                                        color: AppColors.primary20),
                                    child: Icon(
                                      Icons.phone,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 24.w,
                                  ),
                                  CustomText(
                                    text: appGet.userProfil['data']['mobile'],
                                    color: AppColors.black11,
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
                        Column(
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
                                        shape: BoxShape.circle,
                                        color: AppColors.primary20),
                                    child: Icon(
                                      Icons.my_location,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 24.w,
                                  ),
                                  CustomText(
                                    text: appGet.userProfil['data']
                                            ['country'] ??
                                        '',
                                    color: AppColors.black11,
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
                        InkWell(
                          onTap: () {
                            Get.to(() => AddProfile(index: 2));
                          },
                          child: Container(
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
                                            shape: BoxShape.circle,
                                            color: AppColors.primary20),
                                        child: Icon(
                                          Icons.calendar_today,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 24.w,
                                      ),
                                      CustomText(
                                        text: "Work times and settings".tr,
                                        color: AppColors.black11,
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
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await ServerProvider.instance.getMyServices(
                                appGet.services['data'][0]["id"]);

                            Get.to(() => AddService(index: 2));
                          },
                          child: Container(
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
                                            shape: BoxShape.circle,
                                            color: AppColors.primary20),
                                        child: Icon(
                                          Icons.home_repair_service,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 24.w,
                                      ),
                                      CustomText(
                                        text: "My Services".tr,
                                        color: AppColors.black11,
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
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => AddSpecialists(index: 2));
                          },
                          child: Container(
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
                                            shape: BoxShape.circle,
                                            color: AppColors.primary20),
                                        child: Icon(
                                          Icons.person_add,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 24.w,
                                      ),
                                      CustomText(
                                        text: "My Specialists".tr,
                                        color: AppColors.black11,
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
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            print(appGet.userProfil['data']['salon']['id']
                                .toString());
                            await ServerProvider.instance.getSlonById(appGet
                                .userProfil['data']['salon']['id']
                                .toString());
                            await ServerProvider.instance.getSlonByIdGallery(
                                appGet.userProfil['data']['salon']['id']
                                    .toString());
                            await ServerProvider.instance.getSlonByIdReviews(
                                appGet.userProfil['data']['salon']['id']
                                    .toString());
                            // print(appGet.userProfil['data']);
                            Get.to(() =>
                                ShopDetailsScreen(appGet.salonById['data']));
                          },
                          child: Container(
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
                                            shape: BoxShape.circle,
                                            color: AppColors.primary20),
                                        child: Icon(
                                          Icons.view_sidebar_outlined,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 24.w,
                                      ),
                                      CustomText(
                                        text: "View as a visitor".tr,
                                        color: AppColors.black11,
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
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        CustomText(
                          text: 'Profile Setting',
                          color: AppColors.black11,
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        ListTile(
                            title: CustomText(text: 'language'),
                            leading:
                                Icon(Icons.language, color: AppColors.primary),
                            trailing: Container(
                              height: 45.h,
                              child: ToggleButtons(
                                borderColor: AppColors.primary,
                                fillColor: AppColors.primary,
                                borderWidth: 2,
                                selectedBorderColor: AppColors.primary,
                                selectedColor: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: CustomText(
                                      text: 'عربي',
                                      fontSize: 17,
                                      color: isSelected[0]
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: CustomText(
                                      text: 'English',
                                      color: isSelected[1]
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                                onPressed: (int index) async {
                                  if (index == 0) {
                                    await SPHelper.spHelper.setLanguge('ar');
                                    setState(() {
                                      isSelected[0] = true;
                                      isSelected[1] = false;
                                    });
                                    Get.updateLocale(
                                        Locale(SPHelper.spHelper.getLanguge()));
                                  } else {
                                    await SPHelper.spHelper.setLanguge('en');
                                    setState(() {
                                      isSelected[0] = false;
                                      isSelected[1] = true;
                                    });
                                    Get.updateLocale(
                                        Locale(SPHelper.spHelper.getLanguge()));
                                  }
                                },
                                isSelected: isSelected,
                              ),
                            )),
                        InkWell(
                          onTap: () {
                            SPHelper.spHelper.removeToken();
                            Get.offAll(() => SignInScreen());
                          },
                          child: Container(
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
                                            shape: BoxShape.circle,
                                            color: AppColors.primary20),
                                        child: Icon(
                                          Icons.logout,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 24.w,
                                      ),
                                      CustomText(
                                        text: 'Logout',
                                        color: AppColors.black11,
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
                          ),
                        ),
                      ],
                    ),
            ),
          )
        ],
      ),
    );
  }
}
