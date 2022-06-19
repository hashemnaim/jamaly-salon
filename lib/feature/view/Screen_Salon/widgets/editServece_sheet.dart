// import 'package:salon_provider/feature/server/getx/app_get_salon.dart';
// import 'package:salon_provider/feature/server/service/server_salon.dart';
// import 'package:salon_provider/feature/view/widgets/custom_button.dart';
// import 'package:salon_provider/feature/view/widgets/custom_text.dart';
// import 'package:salon_provider/feature/view/widgets/custom_text_field.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class EditServeceSheet extends StatefulWidget {
//   final String title, price, image;
//   final int id;

//   const EditServeceSheet({Key key, this.title, this.price, this.image, this.id})
//       : super(key: key);
//   @override
//   _AddProductSheetState createState() => _AddProductSheetState();
// }

// class _AddProductSheetState extends State<EditServeceSheet> {
//   final AppGet appGet = Get.find();

//   String title;

//   String price;

//   saveTitle(String value) {
//     this.title = value;
//     setState(() {});
//   }

//   savePrice(String value) {
//     this.price = value;
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 500.h,
//       padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           CustomText(text: "بيانات الخدمة"),
//           SizedBox(
//             height: 15.h,
//           ),
//           CustomTextFormField(
//             hintText: 'اسم الخدمة',
//             onSaved: saveTitle,
//             initialText: widget.title,
//           ),
//           SizedBox(
//             height: 10.h,
//           ),
//           CustomTextFormField(
//               initialText: widget.price,
//               hintText: 'سعر الخدمة',
//               onSaved: savePrice),
//           SizedBox(
//             height: 10.h,
//           ),
//           // GetBuilder<AppGet>(
//           //   init: AppGet(),
//           //   builder: (controller) => controller.imageFile == null
//           //       ? CustomerImageNetwork(
//           //           widget.image,
//           //           100,
//           //           100,
//           //           10,
//           //           circle: false,
//           //         )
//           //       : Container(
//           //           height: 150, child: Image.asset(controller.imageFile.path)),
//           //    ),
//           // Center(
//           //   child: GestureDetector(
//           //     onTap: () async {
//           //       showCupertinoModalPopup(
//           //           context: context,
//           //           builder: (context) {
//           //             return CupertinoActionSheet(
//           //               title: CustomText(
//           //                 text: "رفع صورة",
//           //                 color: Colors.grey,
//           //               ),
//           //               actions: <Widget>[
//           //                 Row(
//           //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //                   children: [
//           //                     Expanded(
//           //                       child: Container(
//           //                         child: CupertinoActionSheetAction(
//           //                           child: Icon(
//           //                             Icons.camera,
//           //                             size: 30,
//           //                             color: Colors.red,
//           //                           ),
//           //                           // isDefaultAction: true,
//           //                           onPressed: () async {
//           //                             AppGet.getImage(ImageSource.camera);
//           //                             Navigator.pop(context);
//           //                           },
//           //                         ),
//           //                       ),
//           //                     ),
//           //                     Expanded(
//           //                       child: CupertinoActionSheetAction(
//           //                         child: Icon(
//           //                           Icons.image,
//           //                           size: 35,
//           //                           color: Colors.red,
//           //                         ),

//           //                         // isDestructiveAction: true,
//           //                         onPressed: () async {
//           //                           AppGet.getImage(ImageSource.gallery);
//           //                           Navigator.pop(context);
//           //                           // editImage(
//           //                           //     imageFile,
//           //                           //     appGet.userInfoModel.value
//           //                           //         .data.name);
//           //                         },
//           //                       ),
//           //                     ),
//           //                   ],
//           //                 ),
//           //               ],
//           //               cancelButton: CupertinoActionSheetAction(
//           //                 child: CustomText(text: "cancel"),
//           //                 onPressed: () {
//           //                   Navigator.pop(context);
//           //                 },
//           //               ),
//           //             );
//           //           });
//           //     },
//           //     child: Container(
//           //       height: 72.h,
//           //       width: 72.w,
//           //       padding: EdgeInsets.all(15),
//           //       decoration: BoxDecoration(
//           //           color: Color(0xffF5F5F5),
//           //           shape: BoxShape.circle,
//           //           border: Border.all(
//           //             color: Color(0xff171717),
//           //           )),
//           //       child: SvgPicture.asset(
//           //         'assets/svg/addImage.svg',
//           //         height: 34.h,
//           //         width: 38.w,
//           //       ),
//           //     ),
//           //   ),
//           // ),

//           Expanded(child: Container()),
//           CustomButton(
//             onPress: () {
//               // print(AppGet.imageFile.path ?? "");
//               // print(title);
//               // print(price);

//               // if (AppGet.imageFile != null) {
//               //   if (title != null && price != null) {
//               Navigator.pop(context);

//               ServerProvider.instance.setEditService(
//                 title ?? widget.title,
//                 price ?? widget.price,
//                 widget.id,
//               );
//               //   } else {
//               //     setToast(
//               //       "يجب اكمال جميع البيانات",
//               //     );
//               //   }
//               // } else {
//               //   setToast(
//               //     "يجب ارفاق صورة ",
//               //   );
//               // }
//             },
//             text: 'تعديل',
//           ),
//         ],
//       ),
//     );
//   }
// }
