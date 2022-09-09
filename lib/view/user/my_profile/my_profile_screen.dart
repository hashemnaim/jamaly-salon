import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/apis/auth_apis.dart';
import 'package:yacht_booking/apis/home_apis.dart';
import 'package:yacht_booking/apis/order_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/controller/user/bottom_nav_bar_controller.dart';
import 'package:yacht_booking/controller/vendor/chat_get_provider.dart';
import 'package:yacht_booking/services/firebase_chat_provider.dart';
import 'package:yacht_booking/services/sp_helper.dart';
import 'package:yacht_booking/view/sheard_screens/welcome_screen.dart';
import 'package:yacht_booking/view/user/budget_request/budget_request_screen.dart';
import 'package:yacht_booking/view/user/communication/communication_screen.dart';
import 'package:yacht_booking/view/user/my_reservations/my_reservations_screen.dart';
import 'package:yacht_booking/view/user/terms_and_conditions/terms_and_conditions.dart';
import 'package:yacht_booking/view/vendor/chat_screen_provider.dart';
import 'package:yacht_booking/view/widgets/custom_button.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

import 'widgets/header_profile_widget.dart';

class MyProfileScreen extends StatefulWidget {
  MyProfileScreen({Key key}) : super(key: key);
  final BottomNavBarController _bottomNavBarController = Get.find();

  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final BottomNavBarController _bottomNavBarController = Get.find();
  ChatGetProvider chatGetProvider = Get.find();

  final List<String> svgIconList = [
    'reservations',
    'messages',
    'favorite',
    'your_offer',
    'insurance',
    'connection'
  ];
  final List<String> titleList = [
    'حجوزاتي',
    'المحادثات',
    'المفضلة',
    'حجزك حسب ميزانيتك',
    'الشروط و الاحكام',
    'التواصل مع إدارة التطبيق'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10.h,
                ),
                CustomText(
                  'حسابي',
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
                SizedBox(height: 20.h),
                HeaderProfileWidget(),
                SizedBox(height: 25.h),
                ListView.separated(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: svgIconList.length,
                  separatorBuilder: (context, index) => SizedBox(height: 15.h),
                  itemBuilder: (context, index) => Container(
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      boxShadow: AppColors.boxShadow,
                      borderRadius: BorderRadiusDirectional.circular(10.r),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                      onTap: () {
                        if (index == 0) {
                          HomeUserApis.homeUserApis.getBookings();
                          Get.to(() => MeReservationScreen());
                        } else if (index == 1) {
                          FireBaseHelperProvider.fireBaseHelperProvider
                              .getAllMyChats(
                            myId: chatGetProvider
                                .getProfileUserData.value.data.id
                                .toString(),
                          );
                          Get.to(() => ChatScreenProvider());
                        } else if (index == 2) {
                          HomeUserApis.homeUserApis.getFavoriteShip();
                          HomeUserApis.homeUserApis.getFavoriteVendor();
                          widget._bottomNavBarController.changeSelectedIndex(2);
                        } else if (index == 3) {
                          OrderUserApi.orderUserApi.orderOffers();
                          Get.to(() => BudgetRequestScreen());
                        } else if (index == 4) {
                          HomeUserApis.homeUserApis.getTerms();
                          Get.to(() => TermsAndConditionsScreen());
                        } else if (index == 5) {
                          Get.to(() => CommunicationScreen());
                        } else {
                          return null;
                        }
                      },
                      title: CustomText(
                        titleList[index],
                        alignment: AlignmentDirectional.centerStart,
                        fontSize: 15,
                      ),
                      leading: Container(
                        height: 20.r,
                        width: 20.r,
                        child: SvgPicture.asset(
                          Assets.getIconSvg(svgIconList[index]),
                          color: Color(0xff3B3B3B),
                          fit: BoxFit.contain,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.hintColor,
                        size: 18.r,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25.h),
                CustomButton(
                  text: 'تسجيل الخروج',
                  icon: SvgPicture.asset(
                    Assets.getIconSvg('logout'),
                    width: 20.r,
                    height: 20.r,
                    fit: BoxFit.cover,
                  ),
                  onTap: () {
                    Get.offAll(() => WelcomeScreen());
                    AuthApis.authApis.logOutUser();
                    SPHelper.spHelper.setToken('');

                    // Get.offAll(LoginScreen());
                    _bottomNavBarController.selectedIndex = 0;
                  },
                ),
                SizedBox(height: 25.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
