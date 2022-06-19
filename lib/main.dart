import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salon_provider/splash.dart';
import 'package:salon_provider/utils_Language/translation.dart';

import 'feature/server/getx/app_get_salon.dart';
import 'feature/server/getx/auth_controller.dart';
import 'feature/server/helper/notification_firebase.dart';
import 'feature/server/helper/sp_helpar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light));
  await Firebase.initializeApp();
  await SPHelper.spHelper.initSharedPrefrences();
  String lang = SPHelper.spHelper.getLanguge();
  runApp(MyApp(
    lang: lang,
  ));
}

class MyApp extends StatefulWidget {
  final String lang;

  const MyApp({this.lang});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Get.lazyPut(() => AppGet(), fenix: true);
    Get.lazyPut(() => AuthController(), fenix: true);
    NotificationHelper().initialNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(375, 812),
        builder: (context, w) => GetMaterialApp(
              translations: Translation(),
              locale: Locale(widget.lang ?? "en"),
              fallbackLocale: Locale(widget.lang ?? "en"),
              debugShowCheckedModeBanner: false,
              home: Splash(),
            ));
  }
}
