// import 'package:salon_provider/feature/server/service/server_salon.dart';
// import 'package:salon_provider/feature/view/widgets/custom_button.dart';
// import 'package:salon_provider/feature/view/widgets/custom_text_field.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:flutter/material.dart';

// class ContactMyScreen extends StatelessWidget {
//   String name;
//   String title;
//   String phoneNumber;
//   String body;
//   saveFirstName(String value) {
//     this.name = value;
//     print(name);
//   }

//   saveTitle(String value) {
//     this.title = value;
//     print(title);
//   }

//   saveBody(String value) {
//     this.body = value;
//   }

//   savePhaoneNumber(String value) {
//     this.phoneNumber = value;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // TopScreen(
//             //   title: 'تواصل معنا',
//             //   searchWidget: false,
//             //   back: true,
//             // ),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 30.w),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 37.h,
//                   ),
//                   CustomTextFormField(
//                     hintText: 'الاسم',
//                     onSaved: saveFirstName,
//                   ),
//                   SizedBox(
//                     height: 13.h,
//                   ),
//                   CustomTextFormField(
//                     hintText: 'رقم الهاتف',
//                     textInputType: TextInputType.number,
//                     onSaved: savePhaoneNumber,
//                   ),
//                   SizedBox(
//                     height: 13.h,
//                   ),
//                   CustomTextFormField(
//                     hintText: 'العنوان',
//                     onSaved: saveTitle,
//                   ),
//                   SizedBox(
//                     height: 13.h,
//                   ),
//                   CustomTextFormField(
//                     hintText: 'التفاصيل',
//                     onSaved: saveBody,
//                   ),
//                   SizedBox(
//                     height: 53.h,
//                   ),
//                   CustomButton(
//                     // height: 37.h,
//                     onPress: () {
//                       ServerProvider.instance
//                           .setContactUs(name, phoneNumber, title, body);
//                     },
//                     // textStyle: kBtnTextStyle2,
//                     text: 'إرسال',
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
