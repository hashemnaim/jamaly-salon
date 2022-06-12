import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'app_colors.dart';

List<Map<String, dynamic>> citys = [
  {'id': 1, 'name': 'أبوظبي'},
  {'id': 2, 'name': 'عجمان'},
  {'id': 3, 'name': 'دبي'},
  {'id': 4, 'name': 'الفجيرة'},
  {'id': 5, 'name': 'رأس الخيمة'},
  {'id': 6, 'name': '	الشارقة'},
  {'id': 7, 'name': '	أم القيوين'},
];

Future<File> getImagePicker(ImageSource imageSource) async {
  final pickedFile = await ImagePicker().pickImage(source: imageSource);

  try {
    File croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: AppColors.primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));

    return croppedFile;
  } catch (e) {
    return null;
  }
}

//=========== Base Url ===========================
String baseUrl = 'http://api.baharfun.com/api';

//=========== User Url ===========================
//=========== Auth User Url ===========================

String loginEndPoint = '/login';
String registerEndPoint = '/register';
String logoutEndPoint = '/logout';
String settingsEndPoint = '/settings';
String updateProfileEndPoint = '/update_profile';
String updatePhotoEndPoint = '/update_photo';
String getProfileEndPoint = '/get_profile';
String getNotificationsEndPoint = '/get_notifications';
String verifyMobileEndPoint = '/verify_mobile';
String updatePasswordEndPoint = '/update_password';

//=========== Home User Url ===========================

String getSliderEndPoint = '/get_slider';

//=========== Ships User Url ===========================
String getTopRatedOffersEndPoint = '/get_top_rated_offers';
String getOffersEndPoint = '/get_offers';
String getTermsEndPoint = '/get_terms';
String getLastAddedShipsEndPoint = '/get_last_added_ships';
String getTopRatedOwnersEndPoint = '/get_top_rated_owners';
String getShipEndPoint = '/get_ship';
String searchShipsEndPoint = '/search_ships';
//=========== advertisments User Url ===========================
String getAdvertismentsEndPoint = '/get_advertisments';
String getServicesEndPoint = '/get_services';
String getOwnersEndPoint = '/get_owners';

//=========== Order User Url ===========================
String sendOrderEndPoint = '/send_order';
String orderRequestEndPoint = '/order_request';
String getOrdersUserEndPoint = '/get_orders_user';
String getBookingsEndPoint = '/get_bookings';
//=========== Offers User Url ===========================
String orderOffersEndPoint = '/order_offers';

//=========== owner User Url ===========================
String getOwnerEndPoint = '/get_owner';
String getAllOwnersEndPoint = '/get_all_owners';
String filterOwnersEndPoint = '/filter_owners';
String getOwnersServiceEndPoint = '/get_owners';

//=========== Other User Url ===========================
String storeReviewEndPoint = '/store_review';
String getCategoriesEndPoint = '/get_categories';
String storeFavoriteEndPoint = '/store_favorite';
String getFavouritesShipsEndPoint = '/get_favourites';
String deleteFavoriteShipEndPoint = '/delete_favorite';
String storeContactUsEndPoint = '/store_contact_us';

//==================== Vendor Url ==================================================
//==================== Vendor Order Url ====================

String confirmOrderEndPoint = '/confirm_order';
String cancelOrderEndPoint = '/cancel_order';
String finishOrderEndPoint = '/finish_order';
String getReceivedOrdersEndPoint = '/get_received_orders';
String detailsOrderEndPoint = '/details_order';
String homeStatsticEndPoint = '/home';
String getVendorReviewsEndPoint = '/get_vendor_reviews';
String getGalleryEndPoint = '/gallery';
String storeImagesGalleryEndPoint = '/store_images';
String getMyShipsEndPoint = '/my_ships';
String getMyOffersEndPoint = '/my_offers';
String getVendorServicesEndPoint = '/get_vendor_services';
String getVendorSubServicesEndPoint = '/get_vendor_sub_services';
String addShipEndPoint = '/add_ship';
String updateShipEndPoint = '/update_ship';
String deleteShipEndPoint = '/delete_ship';
String detailsOrderRequestEndPoint = '/details_order_request';
String getReceivedOrdersRequestsEndPoint = '/get_received_orders_requests';
String confirmOrderRequestEndPoint = '/confirm_order_request';
String getPlansEndPoint = '/get_plans';
String subscriptionPlanEndPoint = '/subscription_plan';
