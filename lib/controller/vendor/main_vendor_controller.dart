import 'package:geolocator/geolocator.dart' as Geo;
import 'package:get/get.dart';

class MainVendorController extends GetxController {
  int pageIndex = 0;
  bool vendor = false;
  bool isFirstScreen = true;

  String lat;
  String long;

  setIsFirstScreen(bool value) {
    this.isFirstScreen = value;
    update(["first"]);
  }

  changeType(bool val) {
    this.vendor = val;
    update();
  }

  changePageIndex(int index) {
    this.pageIndex = index;
    update();
  }

  getCurrentLocation() async {
    //Geo.Geolocator geolocator = Geo.Geolocator();
    await Geo.Geolocator.requestPermission();
    Geo.Position position = await Geo.Geolocator.getCurrentPosition(
      desiredAccuracy: Geo.LocationAccuracy.high,
    );

    lat = position.latitude.toString();
    long = position.longitude.toString();
  }
}
