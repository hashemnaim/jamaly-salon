import 'package:salon_provider/feature/server/getx/app_get_salon.dart';
import 'package:salon_provider/feature/view/Screen_Salon/widgets/custom_nav_bottom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'feature/view/notification_screen.dart';
import 'feature/view/Screen_Salon/home_Screen/booking_list_screen.dart';
import 'feature/view/Screen_Salon/home_Screen/profile_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> widgetOptions = <Widget>[
    NotificationScreen(),
    BookingListScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<AppGet>(
          init: AppGet(),
          builder: (controller) {
            return widgetOptions[controller.indexNav];
          },
        ),
        bottomNavigationBar: CustomNavSaloneBottom());
  }
}
