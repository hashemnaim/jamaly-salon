import 'package:get/get.dart';

class BottomNavBarController extends GetxController {
  int selectedIndex = 0;

  changeSelectedIndex(int index) {
    this.selectedIndex = index;
    update();
  }
}
