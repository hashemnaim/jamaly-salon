import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:salon_provider/feature/server/helper/sp_helpar.dart';
import 'package:salon_provider/feature/values/animate_do.dart';
import 'package:salon_provider/feature/values/colors.dart';
import 'package:salon_provider/feature/view/Screen_Salon/auth_screen/sign_in_screen.dart';
import 'package:salon_provider/feature/view/Screen_Salon/onboardingUI/widgets/detailsOnboarding.dart';
import 'package:salon_provider/feature/view/Screen_Salon/onboardingUI/widgets/indicatorOnboarding.dart';
import 'package:salon_provider/feature/view/widgets/custom_button.dart';
import 'package:salon_provider/feature/view/widgets/custom_text.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  ValueNotifier<double> _pageNotifier;
  int _currentPage = 0;
  DateTime currentBackPressTime;

  @override
  void initState() {
    _pageController.addListener(_pageListener);
    _pageNotifier = ValueNotifier(1.0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageListener);
    _pageController.dispose();
    super.dispose();
  }

  void _pageListener() {
    _pageNotifier.value = _pageController.page;
  }

  @override
  Widget build(BuildContext context) {
    // ApiProvider apiProvider = Provider.of<ApiProvider>(context,);
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            PageView(
              physics: ClampingScrollPhysics(),
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: <Widget>[
                DetailsOnboarding(
                    image: 'onboarding-1',
                    title: 'My Salon',
                    subTitle:
                        "Styling your appearance according to your lifestyle"),
                DetailsOnboarding(
                  image: 'onboarding-2',
                  title: 'Meet Our Specialists',
                  subTitle:
                      "There are many best stylists from all the best salons ever",
                ),
                DetailsOnboarding(
                    image: 'onboarding-3',
                    title: 'Find The Best Service',
                    subTitle:
                        "There are various controller.services from the best salons that have become our partners.",
                    maxWidthTitle: 303.w),
              ],
            ),
            Positioned(
              bottom: 60.h,
              left: 0,
              right: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ValueListenableBuilder(
                    valueListenable: _pageNotifier,
                    builder: (context, value, child) {
                      final factorChange = (value - _currentPage).abs();
                      print(factorChange);
                      return IndicatorOnboarding(
                        currentPage: _currentPage,
                        numPages: _numPages,
                        factorChange: factorChange,
                      );
                    },
                  ),
                  SizedBox(
                    height: 36.h,
                  ),
                  ZoomIn(
                    child: Container(
                      width: 250,
                      child: CustomButton(
                        text: "Get Started",
                        onPress: () async {
                          await SPHelper.spHelper.setOnBoarding(true);

                          Get.off(() => SignInScreen());
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: 'Already have an account?',
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                          // fontFamily: 'NunitoSans',
                          // letterSpacing: 1.16,
                          color: Colors.white,
                        ),
                        GestureDetector(
                          onTap: () {
                            // SPHelper.spHelper.setOnBoarding(true);
                            Get.to(() => SignInScreen());
                          },
                          child: CustomText(
                            text: ' Sign In',
                            fontWeight: FontWeight.w600,
                            fontSize: 16.sp,
                            color: AppColors.primary20,
                            // fontFamily: 'NunitoSans',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: 'Tap again to leave',
          backgroundColor: AppColors.primaryColor,
          textColor: Colors.white);
      return Future.value(false);
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return Future.value(true);
  }
}
