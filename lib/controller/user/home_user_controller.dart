import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

import '../../models/search_ship_model.dart';

class HomeUserController extends GetxController {
  Rx<ProfileModel> getProfileUserData = ProfileModel().obs;
  Rx<OffersModel> getOffersData = OffersModel().obs;
  Rx<TermsModel> termsData = TermsModel().obs;
  Rx<TopRatOfferModel> getTopRatedOffersData = TopRatOfferModel().obs;
  Rx<TopLastAddShipsModel> getLastAddedShipsData = TopLastAddShipsModel().obs;
  Rx<OffersModel> getTopRatedOwnersData = OffersModel().obs;
  Rx<OwnerDetailsModel> getOwnerDetalsData = OwnerDetailsModel().obs;
  Rx<VendorsService> getVendorsServiceData = VendorsService().obs;
  Rx<VendorsService> getVendorsByCategoryIdServiceData = VendorsService().obs;

  Rx<ShipsDetailsModel> shipsDetaileData = ShipsDetailsModel().obs;
  Rx<SearchShipsModel> searchShipsModel = SearchShipsModel().obs;

  Rx<AdvertismentModel> getAdvertismentsData = AdvertismentModel().obs;
  Rx<ServicesModel> getServicesData = ServicesModel().obs;
  Rx<CategoriesModel> getCategoriesData = CategoriesModel().obs;
  Rx<OwnersModel> getAllOwnersData = OwnersModel().obs;
  Rx<FavoriteModel> getFavouritesShipsData = FavoriteModel().obs;
  Rx<FavoriteModel> getFavouritesOfferData = FavoriteModel().obs;
  Rx<FavoriteModel> getFavouritesVendorData = FavoriteModel().obs;

  Rx<NewOrderModel> getBookingsData = NewOrderModel().obs;
  TabController tabController;
  RxBool showAllServices = false.obs;
  RxList categoryIdList = [].obs;
  addCategoryIdList(int id) {
    if (categoryIdList.contains(id)) {
      categoryIdList.remove(id);
    } else {
      categoryIdList.add(id);
    }
  }
}
