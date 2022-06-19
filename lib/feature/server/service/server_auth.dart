import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:get/get_core/src/get_main.dart';
import 'package:salon_provider/feature/server/getx/app_get_salon.dart';
import 'package:salon_provider/feature/server/getx/auth_controller.dart';
import 'package:salon_provider/feature/server/helper/sp_helpar.dart';
import 'package:salon_provider/feature/server/service/server_salon.dart';
import 'package:salon_provider/feature/values/string.dart';
import 'package:salon_provider/feature/view/Screen_Salon/auth_screen/sign_in_screen.dart';
import 'package:salon_provider/feature/view/Screen_Salon/auth_screen/verify_mobile_screen.dart';
import 'package:salon_provider/feature/view/Screen_Salon/home_Screen/addProfile.dart';

import '../../../main_screen.dart';
import '../../view/widgets/ProgressDialog.dart';

class ServerAuth {
  ServerAuth._();
  static ServerAuth instance = ServerAuth._();
  Dio dio;

  initApi() {
    if (dio == null) {
      dio = Dio();
      return dio;
    } else {
      return dio;
    }
  }

  AppGet _appController = getx.Get.find();
  AuthController _authController = getx.Get.find();

///////////////////////////////////////////////////////////////////////////////////////
  Future<Map> register({
    String name,
    String mobile,
    String password,
    String type,
    String fcmToken,
    String email,
    double locationLat,
    double locationLong,
  }) async {
    await initApi();

    DialogLoading.pr.show();

    try {
      FormData data = FormData.fromMap(
        {
          'name': name,
          'mobile': mobile,
          'password': password,
          'fcm_token': fcmToken,
          'location_lat': locationLat.toString(),
          'location_long': locationLong.toString(),
          'email': email,
          'type': type,
        },
      );
      Response response = await dio
          .post(baseUrl + "vendor/register", data: data, options: Options(
        validateStatus: (status) {
          return status <= 500;
        },
      ));

      print(response.data);
      DialogLoading.pr.hide();

      Map map = response.data;
      if (response.statusCode == 200) {
        _authController.otp.value = map["otp"];
        _authController.phoneNumber.value = mobile;
        getx.Get.snackbar("Registered Successfully".tr, "");
        getx.Get.offAll(() => VerificationScreen());
      } else if (response.statusCode == 401) {
        getx.Get.snackbar(map['message'], "");
      } else {
        getx.Get.snackbar("Please make sure your data is correct".tr, "");
      }

      return response.data;
    } catch (e) {
      DialogLoading.pr.hide();

      return null;
    }
  }

  // /////////////////////////////////////////////////////////////////////////////////////
  Future<Map> signIn({
    String mobile,
    String password,
    String fcmToken,
  }) async {
    await initApi();

    DialogLoading.pr.show();

    try {
      FormData data = FormData.fromMap(
        {
          'mobile': mobile,
          'password': password,
          'fcm_token': fcmToken,
        },
      );
      Response response =
          await dio.post(baseUrl + "vendor/login", data: data, options: Options(
        validateStatus: (status) {
          return status < 500;
        },
      ));

      print(response.data);
      if (response.data['code'] == 200) {
        await SPHelper.spHelper.setToken(response.data["accessToken"]);
        await ServerProvider.instance.getAllVaraibles();
        _appController.setindexNav(1);
        DialogLoading.pr.hide();
        if (SPHelper.spHelper.getOnBoarding() == false) {
          getx.Get.off(() => AddProfile(
                index: 0,
              ));
        } else {
          Get.off(() => MainScreen());
        }
      } else {
        DialogLoading.pr.hide();

        getx.Get.snackbar(response.data['message'], "");
      }
      return response.data;
    } catch (e) {
      DialogLoading.pr.hide();

      return null;
    }
  }
// // //////////////////////////////////////////////////////////////////////////////////

  Future<Map> verification({String mobile, String otp}) async {
    await initApi();
    try {
      print(mobile);
      print(otp);
      DialogLoading.pr.show();

      FormData data = FormData.fromMap({
        "mobile": mobile,
        "otp": otp,
      });

      Response response = await dio.post(
        baseUrl + "vendor/verify_mobile",
        data: data,
      );
      DialogLoading.pr.hide();

      Map map = response.data;
      if (map['code'] == 200) {
        getx.Get.snackbar(map['message'], "");
        getx.Get.offAll(() => SignInScreen());
      } else {
        getx.Get.snackbar(map['message'], "");
      }
      return response.data;
    } catch (e) {
      DialogLoading.pr.hide();

      return null;
    }
  }

// // // //////////////////////////////////////////////////////////////////////////////////
//   Future<dynamic> signInWithGoogle() async {
//     DialogLoading.pr.show();

//     try {
//       final GoogleSignInAccount googlevendor =
//           await GoogleSignIn(scopes: ['email']).signIn();
//       final GoogleSignInAuthentication googleAuth =
//           await googlevendor.authentication;

//       print(googleAuth);
//       // var response = await dio.post(
//       //   baseUrl + '/vendor/social_login',
//       //   data: {
//       //     'google_token': googleAuth.accessToken,
//       //     "email": googlevendor.email,
//       //     "first_name": googlevendor.displayName,
//       //     'currency': "USD",
//       //     "photo": googlevendor.photoUrl,
//       //     'fcm_token': appGetServer.fcmToken,
//       //   },
//       // );
//       await AppApi.appApi.getAllVaraibles();

//       // await SPHelper.spHelper.setToken(map["accessToken"]);

//       DialogLoading.pr.hide();

//       getx.Get.offAll(() => MainScreen());
//     } catch (e) {
//       return CustomDialougs.utils
//           .showDialoug(titleKey: 'Error', messageKey: e.message);
//     }
//   }
// }

// // //////////////////////////////////////////////////////////////////////////////////
//   Future<Map> resetPassword(String oldNo, String newNo) async {
//     await initApi();
//     FormData data = FormData.fromMap({
//       'old_no': oldNo,
//       'new_no': newNo,
//     });
//     Response response =
//         await dio.post(baseUrl + "vendor/edit_mobile_no", data: data);
//     return response.data;
//   }

// /////////////////////////////////////////////////////////////////////////////////
//   Future<Map> editProfile(
//       String name, String mobile, String address, String email) async {
//     await initApi();
//     String token = await SHelper.sHelper.getValue('access_token');
//     // try {
//     FormData data = FormData.fromMap({
//       'name': name,
//       'mobile': mobile,
//       'address': address,
//       'email': email,
//     });
//     Response response = await dio.post(baseUrl + "vendor/update_profile",
//         data: data,
//         options: Options(headers: {'Authorization': 'Bearer $token'}));
//     print(response.data);
//     return response.data;
//     // } catch (e) {
//     //   appGet.pr.hide();

//     //   return null;
//     // }
//   }

//   /////////////////////////////////////////////////////////////////////////////////
//   Future<Map> editProfileSalon(
//       String name, String mobile, String address, String email) async {
//     await initApi();
//     String token = await SHelper.sHelper.getValue('access_token');
//     // try {
//     print(name);
//     print(mobile);
//     print(address);
//     print(email);
//     FormData data = FormData.fromMap({
//       'name': name,
//       'mobile': mobile,
//       'address': address,
//       'email': email,
//     });
//     Response response = await dio.post(baseSalonUrl + "vendor/update_profile",
//         data: data,
//         options: Options(headers: {'Authorization': 'Bearer $token'}));
//     ServerSalon.serverSalon.getvendorSalon();

//     print(response.data);
//     return response.data;
//     // } catch (e) {
//     //   appGet.pr.hide();

//     //   return null;
//     // }
//   }

// /////////////////////////////////////////////////////////////////////////////////
//   Future<Map> editPhotoProfile(String name, String photo) async {
//     await initApi();
//     String token = await SHelper.sHelper.getValue('access_token');

//     try {
//       FormData data = FormData.fromMap({
//         'name': appGet,
//         'logo': await MultipartFile.fromFile(photo,
//             filename: photo.substring(photo.lastIndexOf('/') + 1)),
//       });
//       Response response = await dio.post(baseUrl + "vendor/update_profile",
//           data: data,
//           options: Options(headers: {'Authorization': 'Bearer $token'}));
//       print(response.data);
//       return response.data;
//     } catch (e) {
//       appGet.pr.hide();

//       return null;
//     }
//   }

//   /////////////////////////////////////////////////////////////////////////////////
//   Future<Map> editPhotoProfileSalon(String name, String photo) async {
//     await initApi();
//     String token = await SHelper.sHelper.getValue('access_token');
//     // try {
//     FormData data = FormData.fromMap({
//       'name': appGet,
//       'logo': await MultipartFile.fromFile(photo,
//           filename: photo.substring(photo.lastIndexOf('/') + 1)),
//     });
//     Response response = await dio.post(baseSalonUrl + "vendor/update_profile",
//         data: data,
//         options: Options(headers: {'Authorization': 'Bearer $token'}));
//     ServerSalon.serverSalon.getvendorSalon();
//     print(response.data);
//     return response.data;
//     // } catch (e) {
//     //   appGet.pr.hide();

//     //   return null;
//     // }
//   }

// ////////////////////////////////////////////////////////////
//   Future<Map> editAddress(address, lat, long) async {
//     try {
//       await initApi();

//       FormData data = FormData.fromMap({
//         'address': address,
//         'lat': lat,
//         'long': long,
//       });
//       Response response =
//           await dio.post(baseUrl + "vendor/edit_address", data: data);
//       Logger().d(response.data);
//       return response.data;
//     } catch (e) {
//       appGet.pr.hide();

//       return null;
//     }
//   }

// ////////////////////////////////////////////
//   Future<Map> verifyForgetPassword(String mobile) async {
//     await initApi();
//     FormData data = FormData.fromMap({
//       "mobile": mobile,
//     });

//     Response response = await dio.post(
//       baseUrl + "vendors/send_password",
//       data: data,
//     );
//     print(response.data);
//     return response.data;
//   }

}
