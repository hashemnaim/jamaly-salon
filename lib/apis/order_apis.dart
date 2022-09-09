import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' as myGet;
import 'package:yacht_booking/apis/home_apis.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/common/assets.dart';
import 'package:yacht_booking/common/constant.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/user/order_user_controller.dart';
import 'package:yacht_booking/models/order_offer_model.dart';
import 'package:yacht_booking/models/orders_model.dart';
import 'package:yacht_booking/services/progress_dialog_utils.dart';
import 'package:yacht_booking/services/sp_helper.dart';

class OrderUserApi {
  OrderUserApi._();

  static OrderUserApi orderUserApi = OrderUserApi._();

  Dio dio;

  OrderUserController orderUserController = myGet.Get.find();

  initDio() {
    if (dio == null) {
      dio = Dio();
      return dio;
    } else {
      return dio;
    }
  }

  //===========================================
  getOrdersUser() async {
    try {
      initDio();
      String token = await SPHelper.spHelper.getToken();
      Response response = await dio.get(
        baseUrl + getOrdersUserEndPoint,
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
        orderUserController.getOrdersUserData.value =
            OrdersModel.fromJson(response.data);
      } else {
        orderUserController.getOrdersUserData.value = OrdersModel.fromJson({});
      }
    } catch (e) {}
  }

  //===========================================
  sendOrder(
    String from,
    String to,
    String shipId,
    String paymentMethod,
    String mobile,
    String duration,
    String numberOfPersones,
    String date,
    String price,
  ) async {
    try {
      initDio();
      ProgressDialogUtils.show();
      String token = await SPHelper.spHelper.getToken();
      FormData data = FormData.fromMap({
        "from": from,
        "to": to,
        "ship_id": shipId,
        "payment_method": paymentMethod,
        "mobile": mobile,
        "duration": duration,
        "number_of_persones": numberOfPersones,
        "date": date,
        "price": price,
      });
      Response response = await dio.post(
        baseUrl + sendOrderEndPoint,
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
        HomeUserApis.homeUserApis.getBookings();
        myGet.Get.back();
        myGet.Get.defaultDialog(
          title: 'تم تأكيد الحجز بنجاح',
          radius: 10.r,
          // titlePadding: EdgeInsetsDirectional.only(
          //     top: 15.h, bottom: 4.h),
          titleStyle: TextStyle(
              fontSize: 15.sp,
              color: AppColors.fontPrimaryColor,
              fontWeight: FontWeight.bold),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                Assets.getIconSvg('request_success'),
                fit: BoxFit.contain,
                width: 150.r,
                height: 150.r,
              ),
            ],
          ),
        );
        Timer(Duration(seconds: 4), () {
          myGet.Get.back();
        });
        //  Helper.getSheetSucsses(response.data['message']);
      } else {
        ProgressDialogUtils.hide();

        Helper.getSheetError(response.data['message']);
      }
    } catch (e) {
      ProgressDialogUtils.hide();
    }
  }

  //===========================================
  orderRequest(
    String from,
    String to,
    String serviceId,
    String duration,
    String numberOfPersones,
    String date,
    String price,
    String notes,
  ) async {
    try {
    initDio();
    ProgressDialogUtils.show();

    print(from);
    print(to);
    print(serviceId);
    print(duration);
    print(numberOfPersones);
    print(date);
    print(price);
    print(notes);
    String token = await SPHelper.spHelper.getToken();
    FormData data = FormData.fromMap({
      "from": from,
      "to": to,
      "service_id": serviceId,
      "duration": duration,
      "number_of_persones": numberOfPersones,
      "date": date,
      "price": price,
      "notes": notes ?? ""
    });
    Response response = await dio.post(
      baseUrl + orderRequestEndPoint,
      data: data,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
        // validateStatus: (status) {
        //   return status < 500;
        // },
      ),
    );
    if (response.data['code'].toString() == '200') {
      ProgressDialogUtils.hide();
      orderOffers();

      myGet.Get.back();

      myGet.Get.defaultDialog(
        title: 'تم تقديم الحجز  بنجاح وستصلك اشعارات بالعروض بمجرد توفرها',
        radius: 10.r,
        // titlePadding:
        //     EdgeInsetsDirectional.only(top: 15.h, bottom: 4.h),
        titleStyle: TextStyle(
          fontSize: 14.sp,
          color: AppColors.fontPrimaryColor,
          fontWeight: FontWeight.bold,
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.getIconSvg('request_success'),
              fit: BoxFit.contain,
              width: 150.r,
              height: 150.r,
            ),
          ],
        ),
      );
      Timer(Duration(seconds: 4), () {
        myGet.Get.back();
      });
      //  Helper.getSheetSucsses(response.data['message']);
    } else {
      ProgressDialogUtils.hide();
      Helper.getSheetError(response.data['message']);
    }
    } catch (e) {
      ProgressDialogUtils.hide();
    }
  }

  //===========================================
  orderOffers() async {
    try {
      initDio();
      String token = await SPHelper.spHelper.getToken();
      Response response = await dio.get(
        baseUrl + orderOffersEndPoint,
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
        orderUserController.orderOffersData.value =
            OrderOfferModel.fromJson(response.data);
      } else {
        orderUserController.orderOffersData.value =
            OrderOfferModel.fromJson({});
      }
    } catch (e) {}
  }

  //===========================================
  getOwner() async {
    try {
      initDio();
      String token = await SPHelper.spHelper.getToken();
      Response response = await dio.get(
        baseUrl + getOwnerEndPoint,
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
        orderUserController.orderOffersData.value =
            OrderOfferModel.fromJson(response.data);
      } else {
        orderUserController.orderOffersData.value =
            OrderOfferModel.fromJson({});
      }
    } catch (e) {}
  }
}
