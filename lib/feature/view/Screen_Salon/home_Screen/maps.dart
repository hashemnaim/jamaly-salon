import 'package:geolocator/geolocator.dart';
import 'package:salon_provider/feature/server/getx/app_get_salon.dart';
import 'package:salon_provider/feature/values/colors.dart';
import 'package:salon_provider/feature/values/constant.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../widgets/custom_text.dart';

class MapsG extends StatefulWidget {
  final int page;
  static String routeName = 'LocationCollecter';
  final Function saveAddress;

  const MapsG({Key key, this.page = 0, this.saveAddress}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return LocationCollecterState();
  }
}

class LocationCollecterState extends State<MapsG> {
  GoogleMapController mapController;
  GlobalKey<ScaffoldState> scaffolState = GlobalKey();
  String label = '';
  String addrees = "";
  AppGet appGet = Get.find();
  final LatLng _center = const LatLng(24.4539, 54.3773);
  Position position;
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<Position> getCurrentLocation() async {
    position = await determinePosition();
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(position.latitude, position.longitude), zoom: 15)));

    // getLoction(LatLng(position.latitude, position.longitude));
    return position;
  }

  @override
  void initState() {
    getCurrentLocation();

    super.initState();
  }

  Future<String> getLoction(LatLng postion) async {
    try {
      // List<Address> address = await Geocoder.local.findAddressesFromCoordinates(
      //     Coordinates(postion.latitude, postion.longitude));
      // addrees = address.first.addressLine;
      setState(() {});
      return addrees;
    } catch (e) {
      return null;
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    getCurrentLocation().then((position) {
      markerPosition = position;
      _markers.clear();
      _markers.add(Marker(
          markerId: MarkerId('userSelection'),
          position: LatLng(position.latitude, position.longitude)));
      setState(() {});
    });
  }

  Set<Marker> _markers = {};
  Position markerPosition;

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          key: scaffolState,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Get.back();
              },
            ),
            title: CustomText(
              text: "Select Location".tr,
              color: Colors.white,
              fontSize: 20,
            ),
            centerTitle: true,
            backgroundColor: AppColors.primaryColor,
          ),
          body: Stack(
            children: <Widget>[
              GoogleMap(
                zoomControlsEnabled: false,
                markers: _markers,
                onTap: (piclerLocation) async {
                  _markers.clear();
                  _markers.add(Marker(
                      markerId: MarkerId('userSelection'),
                      position: LatLng(
                          piclerLocation.latitude, piclerLocation.longitude)));
                  position = markerPosition;
                  addrees = await getLoction(piclerLocation);
                  appGet.address.value = addrees;
                  setState(() {});
                },
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 5.0,
                ),
              ),
              Positioned(
                bottom: 30,
                right: 15,
                child: FlatButton(
                    onPressed: () async {
                      appGet.latitude.value = position.latitude;
                      appGet.longitude.value = position.longitude;

                      appGet.textEditingController.value.text = addrees;
                      setToast(" Your site has been added".tr,
                          AppColors.primaryColor);

                      setState(() {});

                      Get.back();
                    },
                    child: CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.primaryColor,
                        child: Icon(Icons.done, color: Colors.white))),
              )
            ],
          ),
        ));
  }
}
