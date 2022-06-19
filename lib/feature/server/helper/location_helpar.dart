import 'package:geolocator/geolocator.dart';

class Location {
  Location._();
  static final Location location = Location._();
  Position currentPosition;
  String name;
  String phoneNum;
  Geolocator geolocator;

  Future<Geolocator> initGeolocator() async {
    if (geolocator == null) {
      geolocator = Geolocator();
      return geolocator;
    } else {
      return geolocator;
    }
  }

  Future getCurrentLocation() async {
    geolocator = await initGeolocator();
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      this.currentPosition = position;
      return currentPosition;
    }).catchError((e) {
      print(e);
    });
  }

  // getAddressFromLatLng() async {
  //   try {
  //     geolocator =await initGeolocator();
  //     List<Placemark> placemarks = await placemarkFromCoordinates(currentPosition.latitude, currentPosition.longitude);

  //     Placemark place = placemarks[0];
  //       currentAddress ="${place.locality}, ${place.administrativeArea}, ${place.subLocality}";

  //       return currentAddress ;
  //   } catch (e) {
  //     print(e);
  //   }
  // }

}
