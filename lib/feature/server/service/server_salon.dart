import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:salon_provider/feature/values/colors.dart';
import 'package:salon_provider/feature/server/getx/app_get_salon.dart';
import 'package:salon_provider/feature/server/helper/sp_helpar.dart';
import 'package:salon_provider/feature/values/constant.dart';
import 'package:salon_provider/feature/values/string.dart';
import 'package:salon_provider/feature/view/widgets/custom_dialoug.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart' as getx;

import '../../../main_screen.dart';
import '../../view/widgets/ProgressDialog.dart';

class ServerProvider {
  ServerProvider._();
  static ServerProvider instance = ServerProvider._();
  Dio dio;
  initApi() {
    if (dio == null) {
      dio = Dio();
      return dio;
    } else {
      return dio;
    }
  }

  AppGet appGet = getx.Get.find();

  getAllVaraibles() async {
    if (SPHelper.spHelper.getToken() != null) {
      getMySpecialists();

      getMyBookings();
      getMyNotification();
      await getServices();

      await getUser();

      await getMyServices(appGet.services['data'][0]["id"]);
    }
  }

///////////////////////////////////////////////////////////////////////////////////////

  Future<Map> getUser() async {
    dio = initApi();
    try {
      Response response = await dio.post(baseUrl + "vendor/get_profile",
          options: Options(headers: {
            'Authorization': 'Bearer ${SPHelper.spHelper.getToken()}'
          }));

      appGet.getUser(response.data);
      return response.data;
    } catch (e) {
      return CustomDialougs.utils
          .showDialoug(messageKey: e[""] ?? 'خطا', titleKey: 'خطا');
    }
  }

///////////////////////////////////////////////////////////////////////////////////////
  Future<Map> setBookingAccept(int bookingId) async {
    dio = initApi();
    DialogLoading.pr.show();
    print(bookingId);
    try {
      FormData data = FormData.fromMap({"booking_id": bookingId});
      Response response = await dio.post(baseUrl + "vendor/accept_booking",
          data: data,
          options: Options(headers: {
            'Authorization': 'Bearer ${SPHelper.spHelper.getToken()}'
          }));
      getMyBookings();
      DialogLoading.pr.hide();
      setToast(response.data['message'], AppColors.primaryColor);
      return response.data;
    } catch (e) {
      DialogLoading.pr.hide();

      return CustomDialougs.utils
          .showDialoug(messageKey: e ?? 'خطا', titleKey: 'خطا');
    }
  }

///////////////////////////////////////////////////////////////////////////////////////
  setServiceCancel(int serviceId, int mayserviceId) async {
    dio = initApi();
    DialogLoading.pr.show();
    try {
      FormData data = FormData.fromMap({"service_id": mayserviceId});
      Response response = await dio.post(baseUrl + "vendor/delete_service",
          data: data,
          options: Options(headers: {
            'Authorization': 'Bearer ${SPHelper.spHelper.getToken()}'
          }));
      DialogLoading.pr.hide();
      print(response.data);
      if (response.statusCode == 200) {
        // appGet.myServices.clear();

        await getMyServices(serviceId);
        setToast(response.data['message'], AppColors.primaryColor);
        return response.data;
      }
    } catch (e) {
      DialogLoading.pr.hide();

      return CustomDialougs.utils.showDialoug(
          messageKey: e['مشكلة بالانترنت'] ?? 'خطا', titleKey: 'خطا');
    }
  }

///////////////////////////////////////////////////////////////////////////////////////
  setSpashlistCancel(int maySpachilstId) async {
    dio = initApi();
    DialogLoading.pr.show();
    print(maySpachilstId);
    try {
      FormData data = FormData.fromMap({"specialist_id": maySpachilstId});
      Response response = await dio.post(baseUrl + "vendor/delete_specialist",
          data: data,
          options: Options(headers: {
            'Authorization': 'Bearer ${SPHelper.spHelper.getToken()}'
          }));
      DialogLoading.pr.hide();
      print(response.data);
      if (response.statusCode == 200) {
        appGet.myServices.clear();

        await getMySpecialists();
        setToast(response.data['message'], AppColors.primaryColor);
        return response.data;
      }
    } catch (e) {
      DialogLoading.pr.hide();

      return CustomDialougs.utils.showDialoug(
          messageKey: e['مشكلة بالانترنت'] ?? 'خطا', titleKey: 'خطا');
    }
  }

///////////////////////////////////////////////////////////////////////////////////////
  setAddReview(String userId, String rate) async {
    dio = initApi();
    // DialogLoading.pr.show();
    print(userId);
    print(rate);

    try {
      FormData data = FormData.fromMap({"user_id": userId, "rate": rate});
      Response response = await dio.post(baseUrl + "vendor/add_review",
          data: data,
          options: Options(headers: {
            'Authorization': 'Bearer ${SPHelper.spHelper.getToken()}'
          }));
      // DialogLoading.pr.hide();
      print(response.data);
      if (response.statusCode == 200) {
        await getMyBookings();
        // setToast(response.data['message'], AppColors.primaryColor);
        getx.Get.back();
        return response.data;
      }
    } catch (e) {
      DialogLoading.pr.hide();

      return CustomDialougs.utils.showDialoug(
          messageKey: e['مشكلة بالانترنت'] ?? 'خطا', titleKey: 'خطا');
    }
  }

///////////////////////////////////////////////////////////////////////////////////////
  Future<Map> getMyBookings() async {
    dio = initApi();

    try {
      Response response = await dio.post(baseUrl + "vendor/my_booking",
          options: Options(headers: {
            'Authorization': 'Bearer ${SPHelper.spHelper.getToken()}'
          }));
      Map map = response.data;
      appGet.getMyBookings(map);
      return response.data;
    } catch (e) {
      return CustomDialougs.utils
          .showDialoug(messageKey: e ?? 'خطا', titleKey: 'خطا');
    }
  }

  ///////////////////////////////////////////////////////////////////////////////////////
  Future<Map> getMySpecialists() async {
    dio = initApi();

    try {
      Response response = await dio.post(baseUrl + "vendor/my_specialists",
          options: Options(headers: {
            'Authorization': 'Bearer ${SPHelper.spHelper.getToken()}'
          }));
      Map map = response.data;
      appGet.getMySpecialists(map);
      return response.data;
    } catch (e) {
      return CustomDialougs.utils
          .showDialoug(messageKey: e ?? 'خطا', titleKey: 'خطا');
    }
  }

///////////////////////////////////////////////////////////////////////////////////////
  setAddSpecialists({String name, File photo}) async {
    initApi();
    print(name);

    try {
      FormData data = FormData.fromMap(
        {
          'name': name,
          "image_url": await MultipartFile.fromFile(photo.path,
              filename: photo.path.substring(photo.path.lastIndexOf('/') + 1)),
        },
      );
      // DialogLoading.pr.show();
      // DialogLoading.pr.hide();

      Response response = await dio.post(baseUrl + "vendor/add_specialist",
          data: data,
          options: Options(headers: {
            'Authorization': 'Bearer ${SPHelper.spHelper.getToken()}'
          }));
      print(response.data);
      appGet.spechlistImage = null;
      await getMySpecialists();
      return response.data;
    } catch (e) {
      DialogLoading.pr.hide();

      return CustomDialougs.utils
          .showDialoug(messageKey: e ?? 'خطا', titleKey: 'خطا');
    }
  }

///////////////////////////////////////////////////////
  Future<Map> getMyNotification() async {
    dio = initApi();
    try {
      Response response = await dio.post(baseUrl + "user/get_notifications",
          options: Options(headers: {
            'Authorization': 'Bearer ${SPHelper.spHelper.getToken()}'
          }));
      Map map = response.data;

      appGet.getMyNotification(map);
      return response.data;
    } catch (e) {
      return CustomDialougs.utils
          .showDialoug(messageKey: e ?? 'خطا', titleKey: 'خطا');
    }
  }

///////////////////////////////////////////////////////
  Future<Map> getSlonById(String salonId) async {
    await initApi();
    try {
      Response response = await dio.post(
        baseUrl + "user/get_salon_by_id",
        data: FormData.fromMap({'salon_id': salonId}),
      );

      Map map = response.data;
      DialogLoading.pr.hide();

      if (map['code'] == 200) {
        appGet.salonById.assignAll(map);
        print(response.data);
      } else {
        getx.Get.snackbar(map['message'], "");
      }
      return response.data;
    } catch (e) {
      DialogLoading.pr.hide();

      return null;
    }
  }

///////////////////////////////////////////////////////
  Future<Map> getSlonByIdGallery(String salonId) async {
    await initApi();
    DialogLoading.pr.show();

    try {
      Response response = await dio.post(
        baseUrl + "user/get_salon_gallery",
        data: FormData.fromMap({'salon_id': salonId}),
      );
      DialogLoading.pr.hide();

      Map map = response.data;
      if (map['code'] == 200) {
        appGet.salonByIdGralley.assignAll(map);
        print(response.data);
      } else {
        getx.Get.snackbar(map['message'], "");
      }
      return response.data;
    } catch (e) {
      DialogLoading.pr.hide();

      return null;
    }
  } ///////////////////////////////////////////////////////

  Future<Map> getSlonByIdReviews(String salonId) async {
    await initApi();

    try {
      Response response = await dio.post(
        baseUrl + "user/get_salon_reviews",
        data: FormData.fromMap({'salon_id': salonId}),
      );

      Map map = response.data;
      if (map['code'] == 200) {
        appGet.salonByIdReviews.assignAll(map);
      } else {
        getx.Get.snackbar(map['message'], "");
      }
      return response.data;
    } catch (e) {
      return null;
    }
  }

///////////////////////////////////////////////////////
  Future<Map> getSlonProductByIdService(String serviceId) async {
    await initApi();

    try {
      Response response = await dio.post(
        baseUrl + "user/get_products_by_service",
        data: FormData.fromMap({
          'salon_id': appGet.userProfil['data']['salon']['id'],
          'service_id': serviceId
        }),
      );

      Map map = response.data;
      if (map['code'] == 200) {
        appGet.salonByIdService.assignAll(map);
      } else {
        getx.Get.snackbar(map['message'], "");
      }
      return response.data;
    } catch (e) {
      return null;
    }
  }

///////////////////////////////////////////////////////
  Future<Map> getServices() async {
    initApi();
    try {
      Response response = await dio.post(
        baseUrl + "user/get_services",
      );
      appGet.setServices(response.data);

      return response.data;
    } catch (e) {
      return CustomDialougs.utils.showDialoug(
          messageKey: e['message_ar'] ?? 'error', titleKey: 'error');
    }
  }

  ///////////////////////////////////////////////////////
  Future<Map> getMyServices(int serviceId) async {
    dio = initApi();
    print(serviceId);
    try {
      Response response = await dio.post(baseUrl + "vendor/my_services",
          data: FormData.fromMap({'service_id': serviceId}),
          options: Options(headers: {
            'Authorization': 'Bearer ${SPHelper.spHelper.getToken()}'
          }));
      appGet.getMyServices(response.data);
      print(response.data);
      return response.data;
    } catch (e) {
      return CustomDialougs.utils.showDialoug(
          messageKey: e['message_ar'] ?? 'error', titleKey: 'error');
    }
  }

///////////////////////////////////////////////////////////////////////////////////////
  Future<Map> setAddService(
      {int serviceId,
      String name,
      String price,
      String timeNeeded,
      String discount,
      String details,
      List<File> photo}) async {
    dio = initApi();

    try {
      FormData data = FormData.fromMap(
        {
          'service_id': serviceId,
          'name': name,
          'price': price,
          'time_needed': timeNeeded,
          'discount': discount,
          'details': details,
          "image_url": [
            await MultipartFile.fromFile(photo[0].path,
                filename: photo[0]
                    .path
                    .substring(photo[0].path.lastIndexOf('/') + 1)),
          ]
          // ...imagesMap
        },
      );
      DialogLoading.pr.show();

      Response response = await dio.post(baseUrl + "vendor/add_service",
          data: data,
          options: Options(headers: {
            'Authorization': 'Bearer ${SPHelper.spHelper.getToken()}'
          }));
      DialogLoading.pr.hide();

      print(response.data);
      // appGet.serviceImage.clear();
      await getMyServices(serviceId);
      return response.data;
    } catch (e) {
      DialogLoading.pr.hide();

      return CustomDialougs.utils.showDialoug(
          messageKey: e['مشكلة بالانترنت'] ?? 'خطا', titleKey: 'خطا');
    }
  }

  ///////////////////////////////////////////////////////////////////////////////////////
  Future setEditProduct({
    String about,
    List<File> photo,
    File logo,
    File background,
    List<Map> workDays,
  }) async {
    DialogLoading.pr.show();
    dio = initApi();

    try {
      String workDay = jsonEncode(workDays);

      Map photoMap = await convertFilesToMultiparts('photos', photo);
      FormData data = FormData.fromMap({
        'about': about,
        'workDays': workDay,
        "logo": await MultipartFile.fromFile(logo.path,
            filename: logo.path.substring(logo.path.lastIndexOf('/') + 1)),
        "background_url": await MultipartFile.fromFile(background.path,
            filename: background.path
                .substring(background.path.lastIndexOf('/') + 1)),
        ...photoMap,
      });

      Response response = await dio.post(baseUrl + "vendor/set_profile",
          data: data,
          options: Options(headers: {
            'Authorization': 'Bearer ${SPHelper.spHelper.getToken()}'
          }));
      print(response.data);
      DialogLoading.pr.hide();
      setToast("Done", Colors.green);
      return response.data;
    } catch (e) {
      DialogLoading.pr.hide();

      return null;
    }
  }

///////////////////////////////////////////////////////
  Future<Map> getProducts() async {
    dio = initApi();
    try {
      Response response = await dio.get(baseUrl + "product/my_products",
          options:
              Options(headers: {'Authorization': 'Bearer ${appGet.token}'}));
      Map<String, dynamic> map = response.data;
      appGet.getProducts(map);
      return map;
    } catch (e) {
      return CustomDialougs.utils.showDialoug(
          messageKey: e['message_ar'] ?? 'error', titleKey: 'error');
    }
  }

///////////////////////////////////////////////////////////////////////////////////////
  Future<Map> setDeleteProduct(int productId) async {
    dio = initApi();
    DialogLoading.pr.show();

    try {
      FormData data = FormData.fromMap({"product_id": productId});
      Response response = await dio.post(baseUrl + "product/delete_product",
          data: data,
          options:
              Options(headers: {'Authorization': 'Bearer ${appGet.token}'}));
      await getProducts();

      DialogLoading.pr.hide();

      return response.data;
    } catch (e) {
      DialogLoading.pr.hide();

      return CustomDialougs.utils.showDialoug(
          messageKey: e['مشكلة بالانترنت'] ?? 'خطا', titleKey: 'خطا');
    }
  }

/////////////////////////////////////////////////////////////////////////////////
  Future<Map> convertFilesToMultiparts(
      String name, List<File> resultList) async {
    // List<File> imageList = <File>[];
    // File createFile(String path) {
    //   final file = File(path);
    //   if (!file.existsSync()) {
    //     file.createSync(recursive: true);
    //   }
    //   return file;
    // }

    // for (int i = 0; i < resultList.length; i++) {
    //   // ByteData byteData = await resultList[i].getByteData();

    //   final dir = await getTemporaryDirectory();
    //   File filess = createFile("${dir.absolute.path}.png");
    //   // filess.writeAsBytesSync(byteData.buffer.asUint8List());
    //   // final result = await FlutterImageCompress.compressWithList(
    //   //   byteData.buffer.asUint8List(),
    //   //   minHeight: 720,
    //   //   minWidth: 720,
    //   //   quality: 50,
    //   //   // format: CompressFormat.jpeg,
    //   // );
    //   MultipartFile multipartFile2 = new MultipartFile.fromBytes(
    //     result,
    //     filename: 'load_image${Random().nextInt(20)}.jpg',
    //   );
    //   imageList.add(multipartFile2);
    // }

    Map<String, dynamic> mapImages = {};
    for (int i = 0; i < resultList.length; i++) {
      mapImages.addAll({name: resultList});
      mapImages["$name[$i]"] = resultList[i];
    }

    return mapImages;
  }

////////////////////////////////////////////////////////////////////////////
  Future setAddProduct(
      {String name,
      int type,
      String description,
      String price,
      String address,
      String locationLong,
      String locationLat,
      int cityId,
      String mobile,
      List<File> photo,
      List<int> listPrimary,
      List<int> listOptional,
      File video}) async {
    DialogLoading.pr.show();
    dio = initApi();

    try {
      // Map imagesMap = await convertFilesToMultiparts('photo', photo);
      FormData data = FormData.fromMap({
        'name': name,
        'type': type,
        'description': description,
        'price': price,
        'city_id': cityId,
        'mobile': mobile,
        'address': address,
        'location_long': locationLong,
        'location_lat': locationLat,
        'service_list_primary': listPrimary.toString(),
        'service_list_optional': listOptional.toString(),
        // ...imagesMap,
      });

      Response response = await dio.post(baseUrl + "product/add_product",
          data: data,
          options: Options(headers: {
            'Authorization': 'Bearer ${SPHelper.spHelper.getToken()}'
          }));

      if (response.data["status"] == false) {
        DialogLoading.pr.hide();

        getx.Get.snackbar(response.data["message_ar"], "",
            colorText: Colors.white);
      } else {
        DialogLoading.pr.hide();

        getProducts();
        appGet.setindexNav(2);
        getx.Get.off(() => MainScreen());
        getx.Get.snackbar("تم اضافة المنتج", "", colorText: Colors.white);
        video != null ? appGet.setFile(video) : null;
        appGet.extraService.clear();
        appGet.textEditingController.value.text = "";
        appGet.regiserImages.clear();
        // appGet.images.clear();
      }
      return response.data;
    } catch (e) {
      DialogLoading.pr.hide();

      return null;
    }
  }

////////////////////////////////////////////////////////////////////////////
  // Future getAddAppointment(
  //   int centerId,
  //   String date,
  //   String details,
  //   String total,
  //   int type,
  //   List<int> listPrimary,
  //   List<int> listOptional,
  // ) async {
  //   DialogLoading.pr.show();
  //   dio = initApi();

  //   try {
  //     dio.options.headers["authorization"] = "Bearer ${appGet.token}";

  //     FormData data = FormData.fromMap({
  //       'product_id': centerId,
  //       'date': date,
  //       'total': total,
  //       'type': type.toString(),
  //       'service_list_primary': listOptional.toString(),
  //       'service_list_optional': listPrimary.toString(),
  //       'payment_method': 1,
  //       'details': details,
  //     });

  //     Response response =
  //         await dio.post(baseUrl + "appointments/add_appointment", data: data);

  //     DialogLoading.pr.hide();
  //     await getMyBookings();
  //     getx.Get.snackbar("تم حجز الموعد بنحاح", "", colorText: Colors.white);
  //     // getx.Get.back();
  //     appGet.setindexNav(0);
  //     getx.Get.offAll(() => MainScreen());
  //     return response.data;
  //   } catch (e) {
  //     DialogLoading.pr.hide();

  //     return null;
  //   }
  // }

  ///////////////////////////////////////////////////////////////////////////////////////

  // Future<Map> setContactUs(
  //     String name, String mobile, String title, String body) async {
  //   try {
  //     await initApi();
  //     FormData data = FormData.fromMap(
  //       {
  //         'name': name,
  //         'mobile': mobile,
  //         'title': title,
  //         'body': body,
  //       },
  //     );

  //     Response response = await dio.post(baseUrl + "contact_us/send_message",
  //         data: data,
  //         options:
  //             Options(headers: {'Authorization': 'Bearer ${appGet.token}'}));
  //     Map map = response.data;
  //     setToast(map['message_ar'], AppColors.primaryColor);
  //     return response.data;
  //   } catch (e) {
  //     return null;
  //   }
  // }
//   ////////////////////////////////////////////////////////////////////////////////////////////

//   Future<Map> setHoursAvailableInDate(
//       int centerId, String appointmentDate) async {
//     try {
//       await initApi();
//       FormData data = FormData.fromMap(
//         {
//           'product_id': centerId,
//           'appointment_date': appointmentDate,
//         },
//       );

//       Response response = await dio.post(
//           baseUrl + "center/hours_available_in_date",
//           data: data,
//           options:
//               Options(headers: {'Authorization': 'Bearer ${appGet.token} '}));
//       Map map = response.data;
//       appGet.setHoursAvailableInDate(map);
//       return response.data;
//     } catch (e) {
//       return null;
//     }
//   }

// ///////////////////////////////////////////////////////////////////////////////////////
//   Future<Map> setAvailableInDate(
//       int productId, String appointmentDate, String type) async {
//     initApi();
//     DialogLoading.pr.show();
//     try {
//       FormData data = FormData.fromMap(
//         {
//           'product_id': productId,
//           'appointment_date': appointmentDate,
//           'type': type,
//         },
//       );
//       Response response = await dio.post(baseUrl + "center/available_in_date",
//           data: data,
//           options:
//               Options(headers: {'Authorization': 'Bearer ${appGet.token}'}));
//       DialogLoading.pr.hide();

//       Map map = response.data;
//       appGet.setAvailableInDate(map);

//       return response.data;
//     } catch (e) {
//       DialogLoading.pr.hide();

//       return null;
//     }
//   }

// ///////////////////////////////////////////////////////////////////////////////////////
//   Future<Map> getArchiveVisits() async {
//     dio = initApi();

//     try {
//       Response response = await dio.get(baseUrl + "appointments/archive_visits",
//           options:
//               Options(headers: {'Authorization': 'Bearer ${appGet.token}'}));
//       appGet.getArchiveVisits(response.data);
//       return response.data;
//     } catch (e) {
//       return CustomDialougs.utils.showDialoug(
//           messageKey: e['مشكلة بالانترنت'] ?? 'خطا', titleKey: 'خطا');
//     }
//   }
}
