import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart' as myGet;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:yacht_booking/common/constant.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/vendor/home_vendor_controller.dart';
import 'package:yacht_booking/controller/vendor/main_vendor_controller.dart';
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
import 'package:yacht_booking/services/progress_dialog_utils.dart';
import 'package:yacht_booking/services/sp_helper.dart';

class HomeVendorApis {
  HomeVendorApis._();

  static HomeVendorApis homeVendorApis = HomeVendorApis._();

  Dio dio;

  HomeVendorController homeVendorController = myGet.Get.find();
  MainVendorController mainVendorController = myGet.Get.find();

  initDio() {
    if (dio == null) {
      dio = Dio();
      return dio;
    } else {
      return dio;
    }
  }

  //===========================================
  getRecievedOrderVendor(String typeUser) async {
    try {
      // homeVendorController.recevedOrderData.value =
      //       RecevedOrder.fromJson({});
      initDio();
      String token = await SPHelper.spHelper.getToken();
      homeVendorController.recevedOrderData.value = RecevedOrder.fromJson({});
      FormData data = FormData.fromMap({"type_order": typeUser});
      Response response = await dio.post(
        baseUrl + getReceivedOrdersEndPoint,
        data: data,
        options: Options(
          headers: {
            'Accept': '*/*',
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) {
            return status < 600;
          },
        ),
      );
      if (response.data['code'].toString() == '200') {
        homeVendorController.recevedOrderData.value =
            RecevedOrder.fromJson(response.data);
      } else {
        homeVendorController.recevedOrderData.value = RecevedOrder.fromJson({});
      }
    } catch (e) {}
  }

  //===========================================
  homeStatstic() async {
    try {
      initDio();
      String token = await SPHelper.spHelper.getToken();

      Response response = await dio.post(
        baseUrl + homeStatsticEndPoint,
        options: Options(
          headers: {
            'Accept': '*/*',
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) {
            return status < 600;
          },
        ),
      );
      if (response.data['code'].toString() == '200') {
        homeVendorController.homeStatsticData.value =
            HomeStatstic.fromJson(response.data);
      } else {
        homeVendorController.homeStatsticData.value = HomeStatstic.fromJson({});
      }
    } catch (e) {}
  }

  //===========================================
  getVendorReviews() async {
    try {
      initDio();
      String token = await SPHelper.spHelper.getToken();

      Response response = await dio.get(
        baseUrl + getVendorReviewsEndPoint,
        options: Options(
          headers: {
            'Accept': '*/*',
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) {
            return status < 600;
          },
        ),
      );
      if (response.data['code'].toString() == '200') {
        homeVendorController.getReviewData.value =
            ReviewVendor.fromJson(response.data);
      } else {
        homeVendorController.getReviewData.value = ReviewVendor.fromJson({});
      }
    } catch (e) {}
  }

  //===========================================
  getGallery({String page, bool isFirst}) async {
    try {
      initDio();
      String token = await SPHelper.spHelper.getToken();
      if (isFirst) {
        homeVendorController.getGallaryVendorData.value =
            GallaryVendor.fromJson({});
      }
      FormData data = FormData.fromMap({
        "page": page,
      });
      Response response = await dio.post(
        baseUrl + getGalleryEndPoint,
        data: data,
        options: Options(
          headers: {
            'Accept': '*/*',
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) {
            return status < 600;
          },
        ),
      );

      if (response.data['code'].toString() == '200') {
        homeVendorController.getGallaryVendorData.value =
            GallaryVendor.fromJson(response.data);
      } else {
        homeVendorController.getGallaryVendorData.value =
            GallaryVendor.fromJson({});
      }
    } catch (e) {}
  }

  updateGalleryImage(
    File image,
    String galleryId,
  ) async {
    try {
      ProgressDialogUtils.show();
      initDio();
      String token = await SPHelper.spHelper.getToken();

      FormData data = FormData.fromMap({
        'image_id': galleryId,
        'image_url': await MultipartFile.fromFile(
          image.path,
          filename: basename(image.path),
        ),
      });
      Response response = await dio.post(
        baseUrl + '/update_image',
        data: data,
        options: Options(
          headers: {
            'Accept': '*/*',
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) {
            return status < 500;
          },
        ),
      );

      if (response.data['code'].toString() == '200') {
        getGallery(isFirst: true);
        myGet.Get.back();
        Helper.getSheetSucsses(response.data['message']);
        ProgressDialogUtils.hide();
      } else {
        ProgressDialogUtils.hide();
        Helper.getSheetError(response.data['message']);
      }
    } catch (e) {
      ProgressDialogUtils.hide();
    }
  }

  delateGalleryImage(
    String galleryId,
  ) async {
    try {
      ProgressDialogUtils.show();
      initDio();
      String token = await SPHelper.spHelper.getToken();
      FormData data = FormData.fromMap({
        'image_id': galleryId,
      });
      Response response = await dio.post(
        baseUrl + '/delete_image',
        data: data,
        options: Options(
          headers: {
            'Accept': '*/*',
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) {
            return status < 500;
          },
        ),
      );

      if (response.data['code'].toString() == '200') {
        getGallery(isFirst: true);
        myGet.Get.back();
        Helper.getSheetSucsses(response.data['message']);
        ProgressDialogUtils.hide();
      } else {
        ProgressDialogUtils.hide();
        Helper.getSheetError(response.data['message']);
      }
    } catch (e) {
      ProgressDialogUtils.hide();
    }
  }

  //===========================================
  storeImagesGallery(List<XFile> images, String shipId) async {
    try {
      ProgressDialogUtils.show();
      initDio();
      List<MultipartFile> imageList = List<MultipartFile>.empty(growable: true);
      File createFile(String path) {
        final file = File(path);
        if (!file.existsSync()) {
          file.createSync(recursive: true);
        }
        return file;
      }

      for (int i = 0; i < images.length; i++) {
        // ByteData byteData = await images[i].path;

        final dir = await path_provider.getTemporaryDirectory();
        File filess = createFile("${dir.absolute.path}/test.png");
        filess.writeAsBytesSync(utf8.encode(images[i].path));
        final result = await FlutterImageCompress.compressWithList(
          utf8.encode(images[i].path),
          minHeight: 720,
          minWidth: 720,
          quality: 60,
          format: CompressFormat.jpeg,
        );
        MultipartFile multipartFile2 = new MultipartFile.fromBytes(
          result,
          filename: 'load_image${Random().nextInt(20)}.jpg',
          contentType: MediaType("image", "jpg"),
        );
        imageList.add(multipartFile2);
      }
      Map<String, dynamic> mapImages = {};

      for (int i = 0; i < imageList.length; i++) {
        mapImages["image_url[$i]"] = imageList[i];
      }

      FormData data = FormData.fromMap({
        'ship_id': shipId,
        ...mapImages ?? null,
      });

      String token = await SPHelper.spHelper.getToken();

      Response response = await dio.post(
        baseUrl + storeImagesGalleryEndPoint,
        data: data,
        options: Options(
          headers: {
            'Accept': '*/*',
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) {
            return status < 600;
          },
        ),
      );
      if (response.data['code'].toString() == '200') {
        getGallery(isFirst: true);
        ProgressDialogUtils.hide();
        homeVendorController.clearImage();
      } else {
        ProgressDialogUtils.hide();
      }
    } catch (e) {
      ProgressDialogUtils.hide();
    }
  }

  //===========================================
  getMyShips() async {
    try {
      initDio();
      String token = await SPHelper.spHelper.getToken();
      homeVendorController.getMyShipData.value = MyShipModel.fromJson({});
      Response response = await dio.get(
        baseUrl + getMyShipsEndPoint,
        options: Options(
          headers: {
            'Accept': '*/*',
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) {
            return status < 600;
          },
        ),
      );
      if (response.data['code'].toString() == '200') {
        homeVendorController.getMyShipData.value =
            MyShipModel.fromJson(response.data);
      } else {
        homeVendorController.getMyShipData.value = MyShipModel.fromJson({});
      }
    } catch (e) {}
  }

  //===========================================
  getMyOffers() async {
    try {
      initDio();
      String token = await SPHelper.spHelper.getToken();

      Response response = await dio.get(
        baseUrl + getMyOffersEndPoint,
        options: Options(
          headers: {
            'Accept': '*/*',
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) {
            return status < 600;
          },
        ),
      );
      if (response.data['code'].toString() == '200') {
        homeVendorController.getMyOfferData.value =
            MyOfferModel.fromJson(response.data);
      } else {
        homeVendorController.getMyOfferData.value = MyOfferModel.fromJson({});
      }
    } catch (e) {}
  }

  //===========================================
  addship(List title, String description, File image, String prepaid,
      String price, String dayPrice, String country) async {
    try {
      ProgressDialogUtils.show();
      initDio();

      FormData data = FormData.fromMap({
        'title': title,
        'description': description,
        'image': image,
        'prepaid': prepaid,
        'price': price,
        'dayPrice': dayPrice,
        'country': country,
      });
      String token = await SPHelper.spHelper.getToken();

      Response response = await dio.post(
        baseUrl + addShipEndPoint,
        data: data,
        options: Options(
          headers: {
            'Accept': '*/*',
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) {
            return status < 600;
          },
        ),
      );
      if (response.data['code'].toString() == '200') {
        ProgressDialogUtils.hide();
      } else {
        ProgressDialogUtils.hide();
      }
    } catch (e) {
      ProgressDialogUtils.hide();
    }
  }

  //===========================================
  detailsOrder(String orderId) async {
    try {
      initDio();
      String token = await SPHelper.spHelper.getToken();
      homeVendorController.orderDetailsVendorData.value =
          OrderDetailsVendor.fromJson({});
      Response response = await dio.get(
        baseUrl + detailsOrderEndPoint + "/$orderId",
        options: Options(
          headers: {
            'Accept': '*/*',
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) {
            return status < 600;
          },
        ),
      );
      if (response.data['code'].toString() == '200') {
        homeVendorController.orderDetailsVendorData.value =
            OrderDetailsVendor.fromJson(response.data);
      } else {
        homeVendorController.orderDetailsVendorData.value =
            OrderDetailsVendor.fromJson({});
      }
    } catch (e) {}
  }

  //===========================================
  confirmOrder(String orderId) async {
    try {
      ProgressDialogUtils.show();
      initDio();

      FormData data = FormData.fromMap({'id': orderId});
      String token = await SPHelper.spHelper.getToken();

      Response response = await dio.post(
        baseUrl + confirmOrderEndPoint,
        data: data,
        options: Options(
          headers: {
            'Accept': '*/*',
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) {
            return status < 600;
          },
        ),
      );
      if (response.data['code'].toString() == '200') {
        ProgressDialogUtils.hide();
        if (homeVendorController.filterIndex.value == 0) {
          HomeVendorApis.homeVendorApis.getRecievedOrderVendor("new_orders");
        } else if (homeVendorController.filterIndex.value == 1) {
          HomeVendorApis.homeVendorApis
              .getRecievedOrderVendor("confirmed_orders");
        } else if (homeVendorController.filterIndex.value == 2) {
          HomeVendorApis.homeVendorApis
              .getRecievedOrderVendor("finished_orders");
        } else if (homeVendorController.filterIndex.value == 4) {
          HomeVendorApis.homeVendorApis.getRecievedOrderVendor("all");
        } else {
          HomeVendorApis.homeVendorApis
              .getRecievedOrderVendor("order_requests");
        }
      } else {
        ProgressDialogUtils.hide();
      }
    } catch (e) {
      ProgressDialogUtils.hide();
    }
  }

  //===========================================
  cancelOrder(String orderId, String notes) async {
    try {
      ProgressDialogUtils.show();
      initDio();

      FormData data = FormData.fromMap({'id': orderId, 'notes': notes});
      String token = await SPHelper.spHelper.getToken();

      Response response = await dio.post(
        baseUrl + cancelOrderEndPoint,
        data: data,
        options: Options(
          headers: {
            'Accept': '*/*',
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) {
            return status < 600;
          },
        ),
      );
      if (response.data['code'].toString() == '200') {
        ProgressDialogUtils.hide();
        if (homeVendorController.filterIndex.value == 0) {
          HomeVendorApis.homeVendorApis.getRecievedOrderVendor("new_orders");
        } else if (homeVendorController.filterIndex.value == 1) {
          HomeVendorApis.homeVendorApis
              .getRecievedOrderVendor("confirmed_orders");
        } else if (homeVendorController.filterIndex.value == 2) {
          HomeVendorApis.homeVendorApis
              .getRecievedOrderVendor("finished_orders");
        } else if (homeVendorController.filterIndex.value == 4) {
          HomeVendorApis.homeVendorApis.getRecievedOrderVendor("all");
        } else {
          HomeVendorApis.homeVendorApis
              .getRecievedOrderVendor("order_requests");
        }
      } else {
        ProgressDialogUtils.hide();
      }
    } catch (e) {
      ProgressDialogUtils.hide();
    }
  }

  //===========================================
  getVendorServices() async {
    try {
      initDio();
      String token = await SPHelper.spHelper.getToken();

      Response response = await dio.get(
        baseUrl + getVendorServicesEndPoint,
        options: Options(
          headers: {
            'Accept': '*/*',
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) {
            return status < 500;
          },
        ),
      );
      if (response.data['code'].toString() == '200') {
        homeVendorController.getVendorServicesData.value =
            ServiceVendorModel.fromJson(response.data);
      } else {
        homeVendorController.getVendorServicesData.value =
            ServiceVendorModel.fromJson({});
      }
    } catch (e) {}
  }

  //===========================================
  getVendorSubServices(String serviceId) async {
    try {
      initDio();
      String token = await SPHelper.spHelper.getToken();
      homeVendorController.getVendorSubServicesData.value =
          SubServiceVendorModel.fromJson({});
      Response response = await dio.get(
        baseUrl + getVendorSubServicesEndPoint + "/$serviceId",
        options: Options(
          headers: {
            'Accept': '*/*',
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) {
            return status < 600;
          },
        ),
      );
      if (response.data['code'].toString() == '200') {
        homeVendorController.getVendorSubServicesData.value =
            SubServiceVendorModel.fromJson(response.data);
      } else {
        homeVendorController.getVendorSubServicesData.value =
            SubServiceVendorModel.fromJson({});
      }
    } catch (e) {}
  }

  //===========================================
  addShip(
    List<XFile> images,
    String serviceId,
    String dayPrice,
    List subServicesId,
    String prepaid,
    String price,
    String notes,
    String offer,
    String numberOfPersones,
    String bookingway,
    String title,
    double priceFor,
  ) async {
    try {
      ProgressDialogUtils.show();
      initDio();
      List<MultipartFile> imageList = List<MultipartFile>.empty(growable: true);
      File createFile(String path) {
        final file = File(path);
        if (!file.existsSync()) {
          file.createSync(recursive: true);
        }
        return file;
      }

      for (int i = 0; i < images.length; i++) {
        // ByteData byteData = await images[i].getByteData();

        final dir = await path_provider.getTemporaryDirectory();
        File filess = createFile("${dir.absolute.path}/test.png");
        filess.writeAsBytesSync(utf8.encode(images[i].path));
        final result = await FlutterImageCompress.compressWithList(
          utf8.encode(images[i].path),
          minHeight: 720,
          minWidth: 720,
          quality: 60,
          format: CompressFormat.jpeg,
        );
        MultipartFile multipartFile2 = new MultipartFile.fromBytes(
          result,
          filename: 'load_image${Random().nextInt(20)}.jpg',
          contentType: MediaType("image", "jpg"),
        );
        imageList.add(multipartFile2);
      }
      Map<String, dynamic> mapImages = {};

      for (int i = 0; i < imageList.length; i++) {
        mapImages["image_url[$i]"] = imageList[i];
      }

      FormData data = FormData.fromMap({
        'service_id': serviceId,
        ...mapImages ?? null,
        'day_price': dayPrice,
        'sub_services_id': subServicesId,
        'prepaid': prepaid,
        'price': price,
        'notes': notes,
        'offer': offer,
        'number_of_persones': numberOfPersones,
        'booking_way': bookingway,
        "title": title,
        "location_lat": mainVendorController.lat.toString(),
        "location_long": mainVendorController.long.toString(),
        "price_for": priceFor,
      });

      String token = await SPHelper.spHelper.getToken();
      print(token);

      Response response = await dio.post(
        baseUrl + addShipEndPoint,
        data: data,
        options: Options(
          headers: {
            'Accept': '*/*',
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) {
            return status < 500;
          },
        ),
      );
      if (response.data['code'].toString() == '200') {
        getGallery(isFirst: true);
        homeVendorController.clearImage();

        getMyShips();
        myGet.Get.back();

        ProgressDialogUtils.hide();
        Helper.getSheetSucsses("${response.data['message']}");
      } else {
        homeVendorController.clearImage();

        ProgressDialogUtils.hide();
        Helper.getSheetError("${response.data['message']}");
      }
    } catch (e) {
      log(e);
      homeVendorController.clearImage();

      ProgressDialogUtils.hide();

      print(e);
    }
  }

  //===========================================
  deleteShip(String shipId) async {
    try {
      ProgressDialogUtils.show();
      initDio();

      String token = await SPHelper.spHelper.getToken();

      Response response = await dio.delete(
        baseUrl + deleteShipEndPoint + "/$shipId",
        options: Options(
          headers: {
            'Accept': '*/*',
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) {
            return status < 600;
          },
        ),
      );
      if (response.data['code'].toString() == '200') {
        ProgressDialogUtils.hide();
        getMyShips();
        getMyOffers();
      } else {
        ProgressDialogUtils.hide();
      }
    } catch (e) {
      ProgressDialogUtils.hide();
    }
  }

  //===========================================
  getRequestDetails(String requestId) async {
    try {
      initDio();
      String token = await SPHelper.spHelper.getToken();
      homeVendorController.getRequestDetailsData.value =
          RequestDetailsModel.fromJson({});
      Response response = await dio.get(
        baseUrl + detailsOrderRequestEndPoint + "/$requestId",
        options: Options(
          headers: {
            'Accept': '*/*',
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) {
            return status < 600;
          },
        ),
      );
      if (response.data['code'].toString() == '200') {
        homeVendorController.getRequestDetailsData.value =
            RequestDetailsModel.fromJson(response.data);
      } else {
        homeVendorController.getRequestDetailsData.value =
            RequestDetailsModel.fromJson({});
      }
    } catch (e) {}
  }

  //===========================================
  confirmRequestOrder(String orderId, String price, String message) async {
    try {
      ProgressDialogUtils.show();
      initDio();

      FormData data = FormData.fromMap({
        'id': orderId,
        'price': price,
        'message': message,
      });
      String token = await SPHelper.spHelper.getToken();

      Response response = await dio.post(
        baseUrl + confirmOrderRequestEndPoint,
        data: data,
        options: Options(
          headers: {
            'Accept': '*/*',
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) {
            return status < 600;
          },
        ),
      );
      if (response.data['code'].toString() == '200') {
        ProgressDialogUtils.hide();
        if (homeVendorController.filterIndex.value == 0) {
          HomeVendorApis.homeVendorApis.getRecievedOrderVendor("new_orders");
        } else if (homeVendorController.filterIndex.value == 1) {
          HomeVendorApis.homeVendorApis
              .getRecievedOrderVendor("confirmed_orders");
        } else if (homeVendorController.filterIndex.value == 2) {
          HomeVendorApis.homeVendorApis
              .getRecievedOrderVendor("finished_orders");
        } else if (homeVendorController.filterIndex.value == 4) {
          HomeVendorApis.homeVendorApis.getRecievedOrderVendor("all");
        } else {
          HomeVendorApis.homeVendorApis
              .getRecievedOrderVendor("order_requests");
        }
      } else {
        ProgressDialogUtils.hide();
      }
    } catch (e) {
      ProgressDialogUtils.hide();
    }
  }

  //===========================================
  getNotifications() async {
    try {
      initDio();
      String token = await SPHelper.spHelper.getToken();
      homeVendorController.getNotificationsData.value =
          NotificationModel.fromJson({});
      Response response = await dio.get(
        baseUrl + getNotificationsEndPoint,
        options: Options(
          headers: {
            'Accept': '*/*',
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) {
            return status < 600;
          },
        ),
      );

      if (response.data['code'].toString() == '200') {
        homeVendorController.getNotificationsData.value =
            NotificationModel.fromJson(response.data);
      } else {
        homeVendorController.getNotificationsData.value =
            NotificationModel.fromJson({});
      }
    } catch (e) {}
  }

  //===========================================
  getPlans() async {
    try {
      initDio();
      String token = await SPHelper.spHelper.getToken();
      homeVendorController.getPlansData.value = PlanModel.fromJson({});
      Response response = await dio.get(
        baseUrl + getPlansEndPoint,
        options: Options(
          headers: {
            'Accept': '*/*',
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) {
            return status < 600;
          },
        ),
      );

      if (response.data['code'].toString() == '200') {
        homeVendorController.getPlansData.value =
            PlanModel.fromJson(response.data);
      } else {
        homeVendorController.getPlansData.value = PlanModel.fromJson({});
      }
    } catch (e) {}
  }

  //===========================================
  subscriptionPlan(String planId) async {
    try {
      ProgressDialogUtils.show();
      initDio();

      FormData data = FormData.fromMap({
        'plan_id': planId,
      });
      String token = await SPHelper.spHelper.getToken();

      Response response = await dio.post(
        baseUrl + subscriptionPlanEndPoint,
        data: data,
        options: Options(
          headers: {
            'Accept': '*/*',
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) {
            return status < 600;
          },
        ),
      );

      if (response.data['code'].toString() == '200') {
        ProgressDialogUtils.hide();
        getPlans();
        Helper.getSheetSucsses("${response.data['message']}");
      } else {
        ProgressDialogUtils.hide();
        Helper.getSheetError("${response.data['message']}");
      }
    } catch (e) {
      ProgressDialogUtils.hide();
    }
  }

  addShipOffers(
    List<XFile> images,
    String serviceId,
    String dayPrice,
    String prepaid,
    String price,
    String notes,
    String offer,
    String numberOfPersones,
    String bookingway,
    String name,
    String country,
    String startDate,
    String endDate,
    String time,
    String priceFor,
    String timeFrom,
    String timeTo,
  ) async {
    try {
      ProgressDialogUtils.show();
      initDio();
      List<MultipartFile> imageList = List<MultipartFile>.empty(growable: true);
      File createFile(String path) {
        final file = File(path);
        if (!file.existsSync()) {
          file.createSync(recursive: true);
        }
        return file;
      }

      for (int i = 0; i < images.length; i++) {
        // ByteData byteData = await images[i].getByteData();

        final dir = await path_provider.getTemporaryDirectory();
        File filess = createFile("${dir.absolute.path}/test.png");
        filess.writeAsBytesSync(utf8.encode(images[i].path));
        final result = await FlutterImageCompress.compressWithList(
          utf8.encode(images[i].path),
          minHeight: 720,
          minWidth: 720,
          quality: 60,
          format: CompressFormat.jpeg,
        );
        MultipartFile multipartFile2 = new MultipartFile.fromBytes(
          result,
          filename: 'load_image${Random().nextInt(20)}.jpg',
          contentType: MediaType("image", "jpg"),
        );
        imageList.add(multipartFile2);
      }
      Map<String, dynamic> mapImages = {};

      for (int i = 0; i < imageList.length; i++) {
        mapImages["image_url[$i]"] = imageList[i];
      }

      FormData data = FormData.fromMap({
        'service_id': serviceId,
        ...mapImages ?? null,
        'day_price': dayPrice.toString(),
        'prepaid': prepaid,
        'price': price.toString(),
        'notes': notes,
        'offer': offer,
        'number_of_persones': numberOfPersones,
        'booking_way': bookingway,
        'title': name,
        // 'description': desc,
        'country': country,
        'start_date': startDate,
        'end_date': endDate,
        'time': time,
        "location_lat": mainVendorController.lat.toString(),
        "location_long": mainVendorController.long.toString(),
        "price_for": priceFor.toString(),
        "time_from": timeFrom,
        "time_to": timeTo,
      });

      String token = await SPHelper.spHelper.getToken();

      Response response = await dio.post(
        baseUrl + addShipEndPoint,
        data: data,
        options: Options(
          headers: {
            'Accept': '*/*',
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) {
            return status < 500;
          },
        ),
      );
      print(response.data);
      if (response.data['code'].toString() == '200') {
        getGallery(isFirst: true);
        myGet.Get.back();

        homeVendorController.clearImage();
        getMyOffers();
        ProgressDialogUtils.hide();
        Helper.getSheetSucsses("${response.data['message']}");
      } else {
        ProgressDialogUtils.hide();
        Helper.getSheetError("${response.data['message']}");
      }
    } catch (e) {
      ProgressDialogUtils.hide();
      Helper.getSheetSucsses("${e}");
      // myGet.Get.back();
    }
  }

  updateShip(
      List<XFile> images,
      String serviceId,
      String dayPrice,
      List subServicesId,
      String prepaid,
      String price,
      String notes,
      String offer,
      String numberOfPersones,
      String bookingway,
      String shipId) async {
    try {
      ProgressDialogUtils.show();
      initDio();
      List<MultipartFile> imageList = List<MultipartFile>.empty(growable: true);
      File createFile(String path) {
        final file = File(path);
        if (!file.existsSync()) {
          file.createSync(recursive: true);
        }
        return file;
      }

      for (int i = 0; i < images.length; i++) {
        // ByteData byteData = await images[i].getByteData();

        final dir = await path_provider.getTemporaryDirectory();
        File filess = createFile("${dir.absolute.path}/test.png");
        filess.writeAsBytesSync(utf8.encode(images[i].path));
        final result = await FlutterImageCompress.compressWithList(
          utf8.encode(images[i].path),
          minHeight: 720,
          minWidth: 720,
          quality: 60,
          format: CompressFormat.jpeg,
        );
        MultipartFile multipartFile2 = new MultipartFile.fromBytes(
          result,
          filename: 'load_image${Random().nextInt(20)}.jpg',
          contentType: MediaType("image", "jpg"),
        );
        imageList.add(multipartFile2);
      }
      Map<String, dynamic> mapImages = {};

      for (int i = 0; i < imageList.length; i++) {
        mapImages["image_url[$i]"] = imageList[i];
      }

      FormData data = FormData.fromMap({
        'service_id': serviceId,
        ...mapImages ?? null,
        'day_price': dayPrice,
        'sub_services_id': subServicesId,
        'prepaid': prepaid,
        'price': price,
        'notes': notes,
        'offer': offer,
        'number_of_persones': numberOfPersones,
        'booking_way': bookingway,
      });

      String token = await SPHelper.spHelper.getToken();

      Response response = await dio.post(
        baseUrl + updateShipEndPoint + "/$shipId",
        data: data,
        options: Options(
          headers: {
            'Accept': '*/*',
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) {
            return status < 500;
          },
        ),
      );

      if (response.data['code'].toString() == '200') {
        getGallery(isFirst: true);
        homeVendorController.clearImage();
        getMyShips();

        ProgressDialogUtils.hide();
        Helper.getSheetSucsses("${response.data['message']}");
      } else {
        ProgressDialogUtils.hide();
        Helper.getSheetError("${response.data['message']}");
      }
    } catch (e) {
      ProgressDialogUtils.hide();
    }
  }

  updateShipOffers(
      List<XFile> images,
      String serviceId,
      String dayPrice,
      String prepaid,
      String price,
      // String notes,
      String offer,
      String shipId
      // String numberOfPersones,
      // String bookingway,
      // String name,
      // String country,
      // String startDate,
      // String endDate,
      // String time,
      // String nuHour,
      // // String desc

      ) async {
    try {
      ProgressDialogUtils.show();
      initDio();
      List<MultipartFile> imageList = List<MultipartFile>.empty(growable: true);
      File createFile(String path) {
        final file = File(path);
        if (!file.existsSync()) {
          file.createSync(recursive: true);
        }
        return file;
      }

      for (int i = 0; i < images.length; i++) {
        // ByteData byteData = await images[i].getByteData();

        final dir = await path_provider.getTemporaryDirectory();
        File filess = createFile("${dir.absolute.path}/test.png");
        filess.writeAsBytesSync(utf8.encode(images[i].path));
        final result = await FlutterImageCompress.compressWithList(
          utf8.encode(images[i].path),
          minHeight: 720,
          minWidth: 720,
          quality: 60,
          format: CompressFormat.jpeg,
        );
        MultipartFile multipartFile2 = new MultipartFile.fromBytes(
          result,
          filename: 'load_image${Random().nextInt(20)}.jpg',
          contentType: MediaType("image", "jpg"),
        );
        imageList.add(multipartFile2);
      }
      Map<String, dynamic> mapImages = {};

      for (int i = 0; i < imageList.length; i++) {
        mapImages["image_url[$i]"] = imageList[i];
      }

      FormData data = FormData.fromMap({
        'service_id': serviceId,
        ...mapImages ?? null,
        'day_price': dayPrice,
        'prepaid': prepaid,
        'price': price,
        // 'notes': notes,
        'offer': offer,

        // 'number_of_persones': numberOfPersones,
        // 'booking_way': bookingway,
        // 'title': name,
        // // 'description': desc,
        // 'country': country,
        // 'start_date': startDate,
        // 'end_date': endDate,
        // 'time': time,
      });

      String token = await SPHelper.spHelper.getToken();

      Response response = await dio.post(
        baseUrl + updateShipEndPoint + "/$shipId",
        data: data,
        options: Options(
          headers: {
            'Accept': '*/*',
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) {
            return status < 600;
          },
        ),
      );

      if (response.data['code'].toString() == '200') {
        getGallery(isFirst: true);
        homeVendorController.clearImage();
        getMyOffers();
        ProgressDialogUtils.hide();
        Helper.getSheetSucsses("${response.data['message']}");
      } else {
        ProgressDialogUtils.hide();
        Helper.getSheetError("${response.data['message']}");
      }
    } catch (e) {
      ProgressDialogUtils.hide();
    }
  }
}
