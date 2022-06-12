import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as myGet;
import 'package:path/path.dart';
import 'package:yacht_booking/apis/home_apis.dart';
import 'package:yacht_booking/common/constant.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/user/auth_controller.dart';
import 'package:yacht_booking/controller/user/home_user_controller.dart';
import 'package:yacht_booking/controller/vendor/main_vendor_controller.dart';
import 'package:yacht_booking/models/setting_app_model.dart';
import 'package:yacht_booking/services/notification_helper.dart';
import 'package:yacht_booking/services/progress_dialog_utils.dart';
import 'package:yacht_booking/services/sp_helper.dart';
import 'package:yacht_booking/view/user/auth/confirmation_code_screen.dart';
import 'package:yacht_booking/view/user/bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'package:yacht_booking/view/user/change_password_success/change_password_success_screen.dart';
import 'package:yacht_booking/view/vendor/main_vendor/main_vendor_screen.dart';

class AuthApis {
  AuthApis._();
  static AuthApis authApis = AuthApis._();

  Dio dio;

  AuthController authController = myGet.Get.find();
  HomeUserController homeUserController = myGet.Get.find();
  MainVendorController mainVendorController = myGet.Get.find();

  initDio() {
    if (dio == null) {
      dio = Dio();
      return dio;
    } else {
      return dio;
    }
  }

  getSettings() async {
    try {
      initDio();
      Response response = await dio.post(
        baseUrl + settingsEndPoint,
        options: Options(
          headers: {
            'Accept': '*/*',
          },
          validateStatus: (status) {
            return status < 500;
          },
        ),
      );
      if (response.data['code'].toString() == '200') {
        authController.settingAppData.value =
            SettingAppModel.fromJson(response.data);
      } else {
        authController.settingAppData.value = SettingAppModel.fromJson({});
      }
    } catch (e) {}
  }

  registerUser(
    String name,
    String email,
    String password,
    String confirmPassword,
    String type,
    String mobile,
    String address,
    String categoryId,
  ) async {
    try {
      String fcmtoken = await NotificationHelper().getToken();
      ProgressDialogUtils.show();
      initDio();
      log('categoryId $categoryId');
      log('type $type');
      FormData data = FormData.fromMap({
        'name': name,
        "email": email,
        "password": password,
        "category_id": categoryId.toString(),
        "password_confirmation": confirmPassword,
        "type": type,
        "mobile": mobile,
        'fcm_token': fcmtoken,
        "location_lat": mainVendorController.lat,
        "location_long": mainVendorController.long,
        'location': address,
      });
      Response response = await dio.post(
        baseUrl + registerEndPoint,
        data: data,
        options: Options(
          headers: {'Accept': 'application/json'},
          validateStatus: (status) {
            return status < 500;
          },
        ),
      );
      ProgressDialogUtils.hide();

      if (response.data['code'].toString() == '200') {
        myGet.Get.to(ConfirmationCodeScreen(
          code: response.data['data']['verify_mobile_code'].toString(),
          mobile: mobile,
        ));
      } else if (response.data['code'].toString() == '422') {
        Map map = jsonDecode(response.toString());
        Map map2 = map['errors'] as Map;
        if (map2.containsKey('name') &&
            map2.containsKey('email') &&
            map2.containsKey('password') &&
            map2.containsKey('mobile') &&
            map2.containsKey('password_confirmation')) {
          Helper.getSheetError(map['message']);
        } else if (map2.containsKey('name')) {
          Helper.getSheetError(map2['name'][0]);
        } else if (map2.containsKey('email')) {
          Helper.getSheetError(map2['email'][0]);
        } else if (map2.containsKey('password')) {
          Helper.getSheetError(map2['password'][0]);
        } else if (map2.containsKey('mobile')) {
          Helper.getSheetError(map2['mobile'][0]);
        } else if (map2.containsKey('password_confirmation')) {
          Helper.getSheetError(map2['password_confirmation'][0]);
        }
      } else if (response.data['code'].toString() == '401') {
        Helper.getSheetError('${response.data['message']}');
      }
    } on Exception catch (e) {}
  }

  loginUser(
    String email,
    String password,
  ) async {
    try {
      String fcmtoken = await NotificationHelper().getToken();
      ProgressDialogUtils.show();
      initDio();
      //String fcmtoken = await NotificationHelper().getToken();

      FormData data = FormData.fromMap({
        "email": email,
        "password": password,
        'fcm_token': fcmtoken
        // "location_lat":authController.lat,
        // "location_long":authController.long,
      });
      Response response = await dio.post(
        baseUrl + loginEndPoint,
        data: data,
        options: Options(
          headers: {'Accept': 'application/json'},
          validateStatus: (status) {
            return status < 500;
          },
        ),
      );
      ProgressDialogUtils.hide();

      if (response.data['code'].toString() == '200') {
        SPHelper.spHelper.setToken(response.data['accessToken']);
        SPHelper.spHelper.setUser(response.data['user']['type'].toString());
        if (response.data['user']['type'].toString() == "user") {
          Helper.getMainDataWithToken();
          myGet.Get.offAll(
            () => BottomNavBarScreen(),
            transition: myGet.Transition.rightToLeft,
            duration: Duration(milliseconds: 700),
          );
        } else {
          Helper.getMainVendorDataWithToken();
          myGet.Get.offAll(
            () => MainVendor(),
            transition: myGet.Transition.rightToLeft,
            duration: Duration(milliseconds: 700),
          );
        }

        // if (response.data['user']['type'] == 'user') {
        //   print('uuuuuuuuuuuuuuuuuuuuuuuuuu ${response.data['user']['type']}');
        //   //  homeUserController.setSelectedIndex(1);
        //   // Helper.getRequiredDataWithToken();
        //   // myGet.Get.offAll(
        //   //   () => MainPageUser(),
        //   //   transition: myGet.Transition.rightToLeft,
        //   //   duration: Duration(milliseconds: 700),
        //   // );
        // } else if(response.data['user']['type'] =='vendor'){
        //   print('vvvvvvvvvvvvvvvvvvvvvvv ${response.data['user']['type']}');
        //   // homeVendorController.setSelectedIndexVendor(1);
        //   // Helper.getRequiredDataWithToken();
        //   // myGet.Get.offAll(
        //   //   () => MainPageVendor(),
        //   //   transition: myGet.Transition.rightToLeft,
        //   //   duration: Duration(milliseconds: 700),
        //   // );
        // }

        Helper.getSheetSucsses('${response.data['message']}');
      } else if (response.data['code'].toString() == '422') {
        Map map = jsonDecode(response.toString());
        Map map2 = map['errors'] as Map;
        if (map2.containsKey('email') && map2.containsKey('password')) {
          Helper.getSheetError(map['message']);
        } else if (map2.containsKey('email')) {
          Helper.getSheetError(map2['email'][0]);
        } else if (map2.containsKey('password')) {
          Helper.getSheetError(map2['password'][0]);
        }
      } else if (response.data['code'].toString() == '401') {
        Helper.getSheetError('${response.data['message']}');
      } else {
        Helper.getSheetError('${response.data['message']}');
      }
    } catch (e) {}
  }

  //====================================================
  setProfileUser(
    String name,
    String email,
    String mobile,
  ) async {
    try {
      ProgressDialogUtils.show();
      initDio();
      String token = await SPHelper.spHelper.getToken();
      FormData data = FormData.fromMap({
        'name': name,
        "email": email,
        "mobile": mobile,
      });
      Response response = await dio.post(
        baseUrl + updateProfileEndPoint,
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
        // authController.clearImageProfile();
        // HomeUserApis.homeUserApis.getProfile();
        ProgressDialogUtils.hide();
        Helper.getSheetSucsses('${response.data['message']}');
      } else if (response.data['code'].toString() == '422') {
        ProgressDialogUtils.hide();

        Map map = jsonDecode(response.toString());
        Map map2 = map['errors'] as Map;
        if (map2.containsKey('name') &&
            map2.containsKey('email') &&
            map2.containsKey('mobile')) {
          Helper.getSheetError(map['message']);
        } else if (map2.containsKey('name')) {
          Helper.getSheetError(map2['name'][0]);
        } else if (map2.containsKey('email')) {
          Helper.getSheetError(map2['email'][0]);
        } else if (map2.containsKey('mobile')) {
          Helper.getSheetError(map2['mobile'][0]);
        }
      } else if (response.data['code'].toString() == '401') {
        Helper.getSheetError('${response.data['message']}');
      }
    } on Exception catch (e) {}
  }

  //====================================================
  setImageProfileUser(File image) async {
    try {
      ProgressDialogUtils.show();
      initDio();
      String token = await SPHelper.spHelper.getToken();
      FormData data = FormData.fromMap({
        'photo': await MultipartFile.fromFile(
          image.path,
          filename: basename(image.path),
        ),
      });
      Response response = await dio.post(
        baseUrl + updatePhotoEndPoint,
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
        authController.clearImageProfile();
        HomeUserApis.homeUserApis.getProfile();
        Helper.getSheetSucsses(response.data['message']);
        ProgressDialogUtils.hide();
      } else {
        authController.clearImageProfile();
        ProgressDialogUtils.hide();
        Helper.getSheetError(response.data['message']);
      }
    } catch (e) {
      authController.clearImageProfile();
      ProgressDialogUtils.hide();
    }
  }

  //====================================================
  logOutUser(
      // String mobile , String type
      ) async {
    try {
      // ProgressDialogUtils.show();
      initDio();
      String token = await SPHelper.spHelper.getToken();
      // FormData data = FormData.fromMap({
      //   'mobile':mobile,
      //   'type':type
      // });
      Response response = await dio.post(
        baseUrl + logoutEndPoint,
        // data: data,
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
      } else {
        ProgressDialogUtils.hide();
        Helper.getSheetError(response.data['message']);
      }
    } catch (e) {
      ProgressDialogUtils.hide();
    }
  }

  //====================================================
  updatePassword(String password, String passwordConfirmation) async {
    try {
      // ProgressDialogUtils.show();
      initDio();
      String token = await SPHelper.spHelper.getToken();
      FormData data = FormData.fromMap({
        'password': password,
        'password_confirmation': passwordConfirmation
      });
      Response response = await dio.post(
        baseUrl + updatePasswordEndPoint,
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
      } else {
        ProgressDialogUtils.hide();
        Helper.getSheetError(response.data['message']);
      }
    } catch (e) {
      ProgressDialogUtils.hide();
    }
  }

  //====================================================
  verifyMobile(String mobile, String verifyMobileCode) async {
    try {
      ProgressDialogUtils.show();

      initDio();
      String token = await SPHelper.spHelper.getToken();
      FormData data = FormData.fromMap(
          {'mobile': mobile, 'verify_mobile_code': verifyMobileCode});
      Response response = await dio.post(
        baseUrl + verifyMobileEndPoint,
        data: data,
        options: Options(
          headers: {'Accept': 'application/json'},
          validateStatus: (status) {
            return status < 500;
          },
        ),
      );

      if (response.data['code'].toString() == '200') {
        ProgressDialogUtils.hide();
        SPHelper.spHelper.setToken(response.data['accessToken']);
        SPHelper.spHelper.setUser(response.data['user']['type'].toString());
        Helper.getMainDataWithToken();
        myGet.Get.offAll(ChangePasswordSuccessScreen());
      } else {
        ProgressDialogUtils.hide();
        Helper.getSheetError(response.data['message']);
      }
    } catch (e) {
      ProgressDialogUtils.hide();
    }
  }
}
