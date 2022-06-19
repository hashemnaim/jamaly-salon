// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';


// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:salon_provider/feature/view/Screen_Salon/auth_screen/sign_in_screen.dart';
// import 'package:salon_provider/feature/view/Screen_Salon/auth_screen/widgets/top_auth.dart';
// import 'package:salon_provider/feature/view/widgets/custom_button.dart';
// import 'package:salon_provider/feature/view/widgets/custom_text_field.dart';


// class NewPassScreen extends StatelessWidget {
//   GlobalKey<FormState> newPassKey = GlobalKey<FormState>();
//   String email;
//   String newPassword;
//   String confirmPassword;

//   setEmail(String email) {
//     this.email = email;
//   }

//   setNewPassword(String password) {
//     this.newPassword = password;
//   }

//   validationNull(String data) {
//     if (data == null || data == '') {
//       return ' must be filled';
//     }
//   }

//   validationConfirm(String data) {
//     if (data == null || data == '') {
//       return ' must be filled';
//     } else if (data != newPassword) {
//       return 'does not match';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         brightness: Brightness.light,
//         elevation: 0.0,
//         toolbarHeight: 0.0, // H
//         backgroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(horizontal: 14.w),
//         child: Form(
//           key: newPassKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               TopAuth(
//                 title: 'New password,',
//                 subTitle:
//                     'Now, you can create new password and confirm it below',
//               ),
//               SizedBox(
//                 height: 99.h,
//               ),
//               CustomTextFormField(
//                 password: true,
//                 hintText: 'New password',
//                 prefixIcon: Padding(
//                   padding: EdgeInsets.only(left: 16.w),
//                   child: Icon(
//                     Icons.lock,
//                     size: 20.r,
//                   ),
//                 ),
//                 validator: validationNull,
//                 onSaved: setNewPassword,
//               ),
//               SizedBox(
//                 height: 16.h,
//               ),
//               CustomTextFormField(
//                 password: true,
//                 hintText: 'Confirm new password',
//                 prefixIcon: Padding(
//                   padding: EdgeInsets.only(left: 16.w),
//                   child: Icon(
//                     Icons.lock,
//                     size: 20.r,
//                   ),
//                 ),
//                 validator: validationConfirm,
//                 onSaved: (a) => print(a),
//               ),
//               SizedBox(
//                 height: 48.h,
//               ),
//               CustomButton(
//                 text: 'Confirm New Password',
//                 onPress: () {
//                   if (newPassKey.currentState.validate()) {
//                     print('aa');
//                     Get.offAll(() => SignInScreen());
//                   }
//                 },
//               ),
//               SizedBox(
//                 height: 20.h,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
