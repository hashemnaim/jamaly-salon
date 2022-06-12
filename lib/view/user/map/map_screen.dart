import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart' as Geo;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yacht_booking/apis/home_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/user/home_user_controller.dart';
import 'package:yacht_booking/view/user/company_details/company_details_screen.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';
import 'package:yacht_booking/view/widgets/custom_text_form_field.dart';

import 'widgets/map_card.dart';

class MapScreen extends StatefulWidget {
 
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng initialPostion = LatLng(31.5216628, 34.4390341);
  double lat = 0;
  double long = 0;
  TextEditingController textEditingController = TextEditingController();

  Set<Marker> myMarker = {};

  GoogleMapController _controller;
  HomeUserController homeUserController = Get.find();

  searchandNavigate(String searchAddress) async {
    try {
      FocusScope.of(context).unfocus();
     

      List<Location> result =
          await locationFromAddress(searchAddress, localeIdentifier: 'en_US');

      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(result[0].latitude, result[0].longitude),
              zoom: 10.0),
        ),
      );
      // myMarker.clear();
      myMarker.add(
        Marker(
          markerId:
              MarkerId("Gps${LatLng(result[0].latitude, result[0].longitude)}"),
          position: LatLng(result[0].latitude, result[0].longitude),
        ),
      );
      // lat = result[0].latitude;
      // long = result[0].longitude;

      getPlaceName(LatLng(lat, long));

      setState(() {});
    } catch (e) {
      Helper.getSheetError('Address Error');
    }
  }

  getCurrentLocation() async {
    Geo.Geolocator.requestPermission();
    Geo.Position position = await Geo.Geolocator.getCurrentPosition(
      desiredAccuracy: Geo.LocationAccuracy.high,
    );
    LatLng myLocation = LatLng(position.latitude, position.longitude);
    myMarker.add(Marker(
      markerId: MarkerId("MyLocation"),
      position: myLocation,
      icon: BitmapDescriptor.defaultMarker,
    ));
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: myLocation, zoom: 15),
      ),
    );
    setState(() {});

    // homeController.setLat(position.latitude.toString());
    // homeController.setLong(position.longitude.toString());

    getPlaceName(LatLng(position.latitude, position.longitude));
  }

  getAllResturantLocation() async {
    try {
      for (var i = 0;
          i < homeUserController.getAllOwnersData.value.data.length;
          i++) {
        var now = DateTime.now().millisecondsSinceEpoch;
        if (homeUserController.getAllOwnersData.value.data[i].locationLat !=
                null &&
            homeUserController.getAllOwnersData.value.data[i].locationLong !=
                null) {
          myMarker.add(Marker(
            markerId: MarkerId(
                homeUserController.getAllOwnersData.value.data[i].toString() +
                    now.toString()),
            infoWindow: InfoWindow(
              title: homeUserController.getAllOwnersData.value.data[i].name,
            ),
            position: LatLng(
              double.parse(homeUserController
                  .getAllOwnersData.value.data[i].locationLat),
              double.parse(homeUserController
                  .getAllOwnersData.value.data[i].locationLong),
            ),
            onTap: () {
              HomeUserApis.homeUserApis.getOwnerDetails(homeUserController
                  .getAllOwnersData.value.data[i].id
                  .toString());
              Get.to(CompanyDetailsScreen());
            },
          ));
        }
      }
      setState(() {});
    } catch (e) {
    
    }
  }

  getPlaceName(LatLng position) async {
    try {
      List<Placemark> addresses =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark first = addresses[0];

      // final coordinates = Coordinates(position.latitude, position.longitude);

      // List<Address> addresses = await Geocoder.google(
      //         "AIzaSyDe6zvqYLDbkRdTIGKKIWAXYPbX604C5v8",
      //         language: 'ar')
      //     .findAddressesFromCoordinates(coordinates);
      // Address first = addresses[0];

      // homeController.setLat(position.latitude.toString());
      // homeController.setLong(position.longitude.toString());
      // homeController.setAddress(first.addressLine.toString());
    } catch (e) {}
  }

  void updatePosition(CameraPosition _position) {
     lat = _position.target.latitude;
    long = _position.target.longitude;

    setState(() {});
  }

  bool typeMap = false;

  setTypeMap() {
    typeMap = !typeMap;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<HomeUserController>(
          id: "map",
          init: HomeUserController(),
          builder: (controller) {
            return Obx(() {
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      // color: Colors.blue,
                      child: GoogleMap(
                        zoomControlsEnabled: false,
                        mapType:
                            typeMap == false ? MapType.normal : MapType.hybrid,
                        onMapCreated: (controller) {
                          this._controller = controller;
                          getAllResturantLocation();
                        },
                        onTap: (argument) {},
                        onCameraIdle: () => getPlaceName(LatLng(lat, long)),
                        markers: myMarker,
                        onCameraMove: ((position) async {
                          updatePosition(position);
                        }),
                        initialCameraPosition:
                            CameraPosition(target: initialPostion, zoom: 15),
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    top: 30.h,
                    end: 15.w,
                    start: 15.w,
                    child: SafeArea(
                      child: CustomTextFormField(
                        hintText: 'البحث',
                        textEditingController: textEditingController,
                        onSaved: (value) {},
                        suffixIcon: InkWell(
                          onTap: () {
                            try {
                              FocusScope.of(context).unfocus();
                              searchandNavigate(textEditingController.text);
                            } catch (e) {}
                          },
                          child: Container(
                            margin: EdgeInsets.all(5.h),
                            height: 31.h,
                            width: 31.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.primaryColor),
                            child: Center(
                              child: Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  PositionedDirectional(
                    bottom: 30.h,
                    start: 0,
                    end: 0,
                    child: homeUserController.getAllOwnersData.value.data ==
                            null
                        ? SizedBox(
                            height: 100.h,
                            child: Center(
                              child: Helper.loading(),
                            ),
                          )
                        : homeUserController.getAllOwnersData.value.data.isEmpty
                            ? SizedBox(
                                height: 100.h,
                                child: Center(
                                  child: CustomText("لا يوجد بيانات"),
                                ),
                              )
                            : Container(
                                height: 175.h,
                                child: ListView.separated(
                                  itemCount: homeUserController
                                      .getAllOwnersData.value.data.length,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.w),
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(width: 10.w),
                                  itemBuilder: (context, index) => MapCard(
                                    ownersModelData: homeUserController
                                        .getAllOwnersData.value.data[index],
                                  ),
                                ),
                              ),
                  ),
                ],
              );
            });
          }),
    );
  }
}
