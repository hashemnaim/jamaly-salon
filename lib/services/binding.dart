import 'package:get/get.dart';
import 'package:yacht_booking/controller/user/auth_controller.dart';
import 'package:yacht_booking/controller/user/bottom_nav_bar_controller.dart';
import 'package:yacht_booking/controller/vendor/chat_get_provider.dart';
import 'package:yacht_booking/controller/vendor/home_vendor_controller.dart';
import 'package:yacht_booking/controller/vendor/main_vendor_controller.dart';
import 'package:yacht_booking/controller/user/home_user_controller.dart';
import 'package:yacht_booking/controller/user/order_user_controller.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    /// User Controllers
    Get.put(BottomNavBarController());
    Get.put(AuthController());
    Get.put(HomeUserController());
    Get.put(HomeVendorController());
    Get.put(OrderUserController());
    Get.put(ChatGetProvider());


    /// Vendor Controllers
    Get.put(MainVendorController());
    
  }
}
