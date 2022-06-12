import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:yacht_booking/models/gallary_vendor_model.dart';
import 'package:yacht_booking/models/home_statistic_model.dart';
import 'package:yacht_booking/models/myOffer.dart';
import 'package:yacht_booking/models/my_ship_model.dart';
import 'package:yacht_booking/models/notification_model.dart';
import 'package:yacht_booking/models/order_details_vendor.dart';
import 'package:yacht_booking/models/plan_model.dart';
import 'package:yacht_booking/models/recieved_order.dart';
import 'package:yacht_booking/models/request_details_model.dart';
import 'package:yacht_booking/models/review_vendor_model.dart';
import 'package:yacht_booking/models/service_vendor_model.dart';
import 'package:yacht_booking/models/sub_services_vendor.dart';

class HomeVendorController extends GetxController {
  Rx<RecevedOrder> recevedOrderData = RecevedOrder().obs;
  Rx<HomeStatstic> homeStatsticData = HomeStatstic().obs;
  Rx<ReviewVendor> getReviewData = ReviewVendor().obs;
  Rx<GallaryVendor> getGallaryVendorData = GallaryVendor().obs;
  Rx<MyShipModel> getMyShipData = MyShipModel().obs;
  Rx<MyOfferModel> getMyOfferData = MyOfferModel().obs;
  Rx<OrderDetailsVendor> orderDetailsVendorData = OrderDetailsVendor().obs;
  Rx<ServiceVendorModel> getVendorServicesData = ServiceVendorModel().obs;
  Rx<SubServiceVendorModel> getVendorSubServicesData =
      SubServiceVendorModel().obs;
  Rx<RequestDetailsModel> getRequestDetailsData = RequestDetailsModel().obs;
  Rx<NotificationModel> getNotificationsData = NotificationModel().obs;
  Rx<PlanModel> getPlansData = PlanModel().obs;

  RxInt filterIndex = 4.obs;

  List<Asset> resultListFinal = <Asset>[];
  List<Asset> resultImagePhoto = <Asset>[];
  List<Asset> resultOffersPhoto = <Asset>[];
  Future<Asset> fileToAsset(File image) async {
    String fileName = basename(image.path);
    var decodedImage = await decodeImageFromList(image.readAsBytesSync());
    return Asset(
      Uuid().v4(),
      fileName,
      decodedImage.width,
      decodedImage.height,
    );
  }

  getImageProfile(ImageSource imageSource) async {
    try {
      // if (Platform.isIOS) {
      //   var photosStatus = await Permission.photos.status;
      //   if (photosStatus.isDenied) {
      //     var photoStatus = await Permission.photos.request();
      //   }
      // } else {
      //   if (await Permission.storage.status.isDenied) {
      //     var storageStatus = await Permission.storage.request();
      //   }
      // }

      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        Asset asset = await fileToAsset(File(pickedFile.path));

        resultListFinal.add(asset);
      } else {}

      update(['images']);
    } catch (e) {}
  }

  addImage2() async {
    List<Asset> resultList = <Asset>[];
    try {
      // var status1 = await Permission.storage.status;

      await Permission.camera.request();
      await Permission.storage.request();

      // var status2 = await Permission.storage.status;

      resultList = await MultiImagePicker.pickImages(
        maxImages: 2,
        enableCamera: true,
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Yacht Booking App",
          allViewTitle: "All Photos",
          selectCircleStrokeColor: "#000000",
        ),
      );

      resultListFinal.addAll(resultList);

      update(['images']);
    } catch (e) {}
  }

  removeImage(int index) {
    resultListFinal.removeAt(index);
    update(['images']);
  }

  addImageOrder() async {
    List<Asset> resultList = <Asset>[];
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 2,
        enableCamera: true,
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Yacht Booking App",
          allViewTitle: "All Photos",
          selectCircleStrokeColor: "#000000",
        ),
      );

      resultImagePhoto.addAll(resultList);

      update(['imagesOrder']);
    } catch (e) {}
  }

  removeImageOrder(int index) {
    resultImagePhoto.removeAt(index);
    update(['imagesOrder']);
  }

  addImageOffers() async {
    List<Asset> resultList = <Asset>[];
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 2,
        enableCamera: true,
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Yacht Booking App",
          allViewTitle: "All Photos",
          selectCircleStrokeColor: "#000000",
        ),
      );

      resultOffersPhoto.addAll(resultList);

      update(['imagesOffers']);
    } catch (e) {}
  }

  removeImageOffers(int index) {
    resultOffersPhoto.removeAt(index);
    update(['imagesOffers']);
  }

  clearImage() {
    resultOffersPhoto.clear();
    resultImagePhoto.clear();
    resultListFinal.clear();

    update(['imagesOffers']);
    update(['imagesOrder']);
    update(['images']);
  }
}
