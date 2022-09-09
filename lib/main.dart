import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/apis/auth_apis.dart';
import 'package:yacht_booking/apis/home_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/services/notification_helper.dart';
import 'package:yacht_booking/services/sp_helper.dart';
import 'package:yacht_booking/translations.dart';
import 'services/binding.dart';
import 'view/sheard_screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SPHelper.spHelper.initSharedPrefrences();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    NotificationHelper().initialNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    precacheImages(context);
    return GetMaterialApp(
      title: 'Yacht Booking'.tr,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      initialBinding: Binding(),
      translations: Lang(),
      locale: Locale(
          SPHelper.spHelper.getLanguage() ?? Get.deviceLocale.languageCode),
      fallbackLocale: Locale('ar'),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.amber,
                systemNavigationBarColor: Colors.amber,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.dark)),
        fontFamily: 'Cairo',
        scaffoldBackgroundColor: Colors.white,
        primaryColor: AppColors.primaryColor,
        secondaryHeaderColor: AppColors.primaryColor,
      ),
      home: ScreenUtilInit(
        designSize: Size(375, 881),
        builder: (contex, child) {
          return MyHomePage();
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    NotificationHelper().initialNotification();
    AuthApis.authApis.getSettings();
    HomeUserApis.homeUserApis.getTerms();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}

void precacheImages(BuildContext context) {
  precacheImage(AssetImage("assets/images/bg.png"), context);
  precacheImage(AssetImage("assets/images/splash.png"), context);
  precacheImage(AssetImage("assets/images/khalefa.png"), context);
  precacheImage(AssetImage("assets/images/person.png"), context);
  precacheImage(AssetImage("assets/images/person2.png"), context);
  precacheImage(AssetImage("assets/images/ship_1.png"), context);
  precacheImage(AssetImage("assets/images/ship_2.png"), context);
  precacheImage(AssetImage("assets/images/ship_3.png"), context);
}
