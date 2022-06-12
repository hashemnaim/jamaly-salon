// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:yacht_booking/view/widgets/custom_app_bar.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'widgets/message_card.dart';

// class MessagesScreen extends StatelessWidget {
//   const MessagesScreen({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: 'المحادثات',
//         backFun: () => Get.back(),
//       ),
//       body: SizedBox(
//         width: double.infinity,
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
//           child: ListView.separated(
//             itemCount: 20,
//             shrinkWrap: true,
//             primary: false,
//             separatorBuilder: (context, index) => Divider(thickness: 1),
//             itemBuilder: (context, index) => MessageCard(),
//           ),
//         ),
//       ),
//     );
//   }
// }


