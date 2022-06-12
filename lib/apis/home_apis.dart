import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as myGet;
import 'package:yacht_booking/common/constant.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/user/auth_controller.dart';
import 'package:yacht_booking/controller/user/home_user_controller.dart';
import 'package:yacht_booking/controller/vendor/chat_get_provider.dart';
import 'package:yacht_booking/models/advertisment_model.dart';
import 'package:yacht_booking/models/categories_model.dart';
import 'package:yacht_booking/models/favorite_model.dart';
import 'package:yacht_booking/models/new_order_model.dart';
import 'package:yacht_booking/models/offers_model.dart';
import 'package:yacht_booking/models/order_details_model.dart';
import 'package:yacht_booking/models/owners_model.dart';
import 'package:yacht_booking/models/profile_model.dart';
import 'package:yacht_booking/models/services_model.dart';
import 'package:yacht_booking/models/ships_details.dart';
import 'package:yacht_booking/models/terms_model.dart';
import 'package:yacht_booking/models/top_rat_offer_model.dart';
import 'package:yacht_booking/models/top_rate+ship_model.dart';
import 'package:yacht_booking/models/vendor_service.dart';
import 'package:yacht_booking/services/progress_dialog_utils.dart';
import 'package:yacht_booking/services/sp_helper.dart';

class HomeUserApis {
  HomeUserApis._();

  static HomeUserApis homeUserApis = HomeUserApis._();

  Dio dio;

  HomeUserController homeUserControllerw = myGet.Get.find();
  ChatGetProvider chatGetProvider = myGet.Get.find();
  AuthController authController = myGet.Get.find();

  initDio() {
    if (dio == null) {
      dio = Dio();
      return dio;
    } else {
      return dio;
    }
  }

  //===========================================
  getProfile() async {
    try {
      initDio();
      String token = await SPHelper.spHelper.getToken();
      chatGetProvider.getProfileUserData.value = ProfileModel();
      homeUserControllerw.getProfileUserData.value = ProfileModel.fromJson({});
      Response response = await dio.get(
        baseUrl + getProfileEndPoint,
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
        homeUserControllerw.getProfileUserData.value =
            ProfileModel.fromJson(response.data);
        chatGetProvider.getProfileUserData.value =
            ProfileModel.fromJson(response.data);
      } else {
        homeUserControllerw.getProfileUserData.value =
            ProfileModel.fromJson({});
      }
    } catch (e) {}
  }

  getTerms() async {
    try {
      initDio();
      String token = await SPHelper.spHelper.getToken();
      Response response = await dio.get(
        baseUrl + getTermsEndPoint,
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
        homeUserControllerw.termsData.value =
            TermsModel.fromJson(response.data);
      } else {
        homeUserControllerw.termsData.value = TermsModel.fromJson({});
      }
    } catch (e) {}
  }

  getOffers() async {
    try {
      initDio();
      String token = await SPHelper.spHelper.getToken();
      Response response = await dio.get(
        baseUrl + getOffersEndPoint,
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
        homeUserControllerw.getOffersData.value =
            OffersModel.fromJson(response.data);
      } else {
        homeUserControllerw.getOffersData.value = OffersModel.fromJson({});
      }
    } catch (e) {}
  }

  //===========================================
  getTopRatedOffers() async {
    try {
      initDio();
      String token = await SPHelper.spHelper.getToken();
      Response response = await dio.get(
        baseUrl + getTopRatedOffersEndPoint,
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
        homeUserControllerw.getTopRatedOffersData.value =
            TopRatOfferModel.fromJson(response.data);
      } else {
        homeUserControllerw.getTopRatedOffersData.value =
            TopRatOfferModel.fromJson({});
      }
    } catch (e) {}
  }

  //===========================================
  getLastAddedShips() async {
    try {
      initDio();
      String token = await SPHelper.spHelper.getToken();
      Response response = await dio.get(
        baseUrl + getLastAddedShipsEndPoint,
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
        homeUserControllerw.getLastAddedShipsData.value =
            TopLastAddShipsModel.fromJson(response.data);
      } else {
        homeUserControllerw.getLastAddedShipsData.value =
            TopLastAddShipsModel.fromJson({});
      }
    } catch (e) {}
  }

  //===========================================
  getTopRatedOwners() async {
    try {
      initDio();
      String token = await SPHelper.spHelper.getToken();
      Response response = await dio.get(
        baseUrl + getTopRatedOwnersEndPoint,
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
        homeUserControllerw.getOffersData.value =
            OffersModel.fromJson(response.data);
      } else {
        homeUserControllerw.getOffersData.value = OffersModel.fromJson({});
      }
    } catch (e) {}
  }

  //===========================================
  getOwnerDetails(String shipId) async {
    try {
      initDio();
      homeUserControllerw.getOwnerDetalsData.value =
          OwnerDetailsModel.fromJson({});
      String token = await SPHelper.spHelper.getToken();
      Response response = await dio.get(
        baseUrl + getOwnerEndPoint + "/$shipId",
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
        homeUserControllerw.getOwnerDetalsData.value =
            OwnerDetailsModel.fromJson(response.data);
      } else {
        homeUserControllerw.getOwnerDetalsData.value =
            OwnerDetailsModel.fromJson({});
      }
    } catch (e) {}
  }

  getOwnersServiceByCategoryId(String categoryId) async {
    try {
      initDio();
      homeUserControllerw.getVendorsByCategoryIdServiceData.value =
          VendorsService.fromJson({});
      FormData data = FormData.fromMap(
        {
          'category_id': categoryId,
        },
      );
      String token = await SPHelper.spHelper.getToken();
      Response response = await dio.post(
        baseUrl + '/get_owners_by_category',
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
      log('response.data ${response.data}');

      if (response.data['code'].toString() == '200') {
        homeUserControllerw.getVendorsByCategoryIdServiceData.value =
            VendorsService.fromJson(response.data);
      } else {
        homeUserControllerw.getVendorsByCategoryIdServiceData.value =
            VendorsService.fromJson({});
      }
    } catch (e) {}
  }

  //===========================================
  getOwnersService(String serviceId) async {
    try {
      initDio();
      homeUserControllerw.getVendorsServiceData.value =
          VendorsService.fromJson({});
      FormData data = FormData.fromMap({
        'service_id': serviceId,
      });
      String token = await SPHelper.spHelper.getToken();
      Response response = await dio.post(
        baseUrl + getOwnersServiceEndPoint,
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
        homeUserControllerw.getVendorsServiceData.value =
            VendorsService.fromJson(response.data);
      } else {
        homeUserControllerw.getVendorsServiceData.value =
            VendorsService.fromJson({});
      }
    } catch (e) {}
  }

  //===========================================
  getShipDetails(String shipId) async {
    try {
      initDio();

      homeUserControllerw.shipsDetaileData.value =
          ShipsDetailsModel.fromJson({});
      String token = await SPHelper.spHelper.getToken();
      Response response = await dio.get(
        baseUrl + getShipEndPoint + "/$shipId",
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
        homeUserControllerw.shipsDetaileData.value =
            ShipsDetailsModel.fromJson(response.data);
      } else {
        homeUserControllerw.shipsDetaileData.value =
            ShipsDetailsModel.fromJson({});
      }
    } catch (e) {}
  }

  //===========================================
  searchShips(String service, String price, String rate) async {
    try {
      homeUserControllerw.getAllOwnersData.value = OwnersModel.fromJson({});
      initDio();
      String token = await SPHelper.spHelper.getToken();
      FormData data = FormData.fromMap({
        "service": service,
        "price": price,
        // "rate": rate,
      });
      Response response = await dio.post(
        baseUrl + searchShipsEndPoint,
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
        homeUserControllerw.getAllOwnersData.value =
            OwnersModel.fromJson(response.data);
      } else {
        homeUserControllerw.getAllOwnersData.value = OwnersModel.fromJson({});
        Helper.getSheetError(response.data['message']);
      }
    } catch (e) {}
  }

  //===========================================
  getAdvertisments() async {
    try {
      initDio();
      String token = await SPHelper.spHelper.getToken();
      Response response = await dio.get(
        baseUrl + getAdvertismentsEndPoint,
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
        homeUserControllerw.getAdvertismentsData.value =
            AdvertismentModel.fromJson(response.data);
      } else {
        homeUserControllerw.getAdvertismentsData.value =
            AdvertismentModel.fromJson({});
      }
    } catch (e) {}
  }

  //===========================================
  getServices() async {
    try {
      initDio();
      String token = await SPHelper.spHelper.getToken();
      Response response = await dio.get(
        baseUrl + getServicesEndPoint,
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
        homeUserControllerw.getServicesData.value =
            ServicesModel.fromJson(response.data);
      } else {
        homeUserControllerw.getServicesData.value = ServicesModel.fromJson({});
      }
    } catch (e) {}
  }

  //===========================================
  getCategories() async {
    try {
      initDio();
      String token = await SPHelper.spHelper.getToken();
      Response response = await dio.get(
        baseUrl + getCategoriesEndPoint,
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
        homeUserControllerw.getCategoriesData.value =
            CategoriesModel.fromJson(response.data);
      } else {
        homeUserControllerw.getCategoriesData.value =
            CategoriesModel.fromJson({});
      }
    } catch (e) {}
  }

  //===========================================
  getAllOwners() async {
    try {
      initDio();
      String token = await SPHelper.spHelper.getToken();
      Response response = await dio.get(
        baseUrl + getAllOwnersEndPoint,
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
        homeUserControllerw.getAllOwnersData.value =
            OwnersModel.fromJson(response.data);
      } else {
        homeUserControllerw.getAllOwnersData.value = OwnersModel.fromJson({});
      }
    } catch (e) {}
  }

  //===========================================
  getFavoriteShip() async {
    try {
      initDio();

      String token = await SPHelper.spHelper.getToken();
      Response response = await dio.get(
        baseUrl + getFavouritesShipsEndPoint + "/1",
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
        homeUserControllerw.getFavouritesShipsData.value =
            FavoriteModel.fromJson(response.data);
      } else {
        homeUserControllerw.getFavouritesShipsData.value =
            FavoriteModel.fromJson({});
      }
    } catch (e) {}
  }

  //===========================================
  getFavoriteOffer() async {
    try {
      initDio();

      String token = await SPHelper.spHelper.getToken();
      Response response = await dio.get(
        baseUrl + getFavouritesShipsEndPoint + "/2",
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
        homeUserControllerw.getFavouritesOfferData.value =
            FavoriteModel.fromJson(response.data);
      } else {
        homeUserControllerw.getFavouritesOfferData.value =
            FavoriteModel.fromJson({});
      }
    } catch (e) {}
  }

  //===========================================
  getFavoriteVendor() async {
    try {
      initDio();

      String token = await SPHelper.spHelper.getToken();
      Response response = await dio.get(
        baseUrl + getFavouritesShipsEndPoint + "/3",
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
        homeUserControllerw.getFavouritesVendorData.value =
            FavoriteModel.fromJson(response.data);
      } else {
        homeUserControllerw.getFavouritesVendorData.value =
            FavoriteModel.fromJson({});
      }
    } catch (e) {}
  }

  //===========================================
  storeFavoriteVendor(
    String vendorId,
    String type,
  ) async {
    try {
      initDio();
      ProgressDialogUtils.show();
      String token = await SPHelper.spHelper.getToken();
      Response response = await dio.post(
        baseUrl + storeFavoriteEndPoint + "?vendor_id=$vendorId&type=$type",
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
        ProgressDialogUtils.hide();
        getFavoriteVendor();

        Helper.getSheetSucsses('تمت الإضافة إلي المفضلة');
      } else {
        ProgressDialogUtils.hide();
        Helper.getSheetError(response.data['message']);
      }
    } catch (e) {
      ProgressDialogUtils.hide();
    }
  }

  //===========================================
  storeFavoriteShip(
    String shipId,
    String type,
  ) async {
    try {
      initDio();
      ProgressDialogUtils.show();
      String token = await SPHelper.spHelper.getToken();
      Response response = await dio.post(
        baseUrl + storeFavoriteEndPoint + "?ship_id=$shipId&type=$type",
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
        ProgressDialogUtils.hide();
        getFavoriteOffer();
        getFavoriteShip();

        Helper.getSheetSucsses('تمت الإضافة إلي المفضلة');
      } else {
        ProgressDialogUtils.hide();
        Helper.getSheetError(response.data['message']);
      }
    } catch (e) {
      ProgressDialogUtils.hide();
    }
  }

  //===========================================
  deleteFavoriteShip(
    String shipId,
    String type,
  ) async {
    try {
      initDio();
      ProgressDialogUtils.show();
      String token = await SPHelper.spHelper.getToken();
      FormData data = FormData.fromMap({
        'type': type,
      });

      Response response = await dio.post(
        baseUrl + deleteFavoriteShipEndPoint + "/$shipId",
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
        ProgressDialogUtils.hide();
        getFavoriteOffer();
        getFavoriteShip();
        getFavoriteVendor();
        Helper.getSheetSucsses(response.data['message']);
      } else {
        ProgressDialogUtils.hide();

        Helper.getSheetError(response.data['message']);
      }
    } catch (e) {
      ProgressDialogUtils.hide();
    }
  }

  //===========================================
  getBookings() async {
    try {
      initDio();

      String token = await SPHelper.spHelper.getToken();
      Response response = await dio.get(
        baseUrl + getBookingsEndPoint,
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
        homeUserControllerw.getBookingsData.value =
            NewOrderModel.fromJson(response.data);
      } else {
        homeUserControllerw.getBookingsData.value = NewOrderModel.fromJson({});
      }
    } catch (e) {}
  }

  //===========================================
  contactUs(
    String message,
  ) async {
    try {
      initDio();
      ProgressDialogUtils.show();
      String token = await SPHelper.spHelper.getToken();
      FormData data = FormData.fromMap({
        "message": message,
      });
      Response response = await dio.post(
        baseUrl + storeContactUsEndPoint,
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
        ProgressDialogUtils.hide();

        myGet.Get.back();
        Helper.getSheetSucsses(response.data['message']);
      } else {
        ProgressDialogUtils.hide();
        Helper.getSheetError(response.data['message']);
      }
    } catch (e) {}
  }
}
