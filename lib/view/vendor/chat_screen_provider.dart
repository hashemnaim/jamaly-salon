import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/common/helper.dart';
import 'package:yacht_booking/controller/vendor/chat_get_provider.dart';
import 'package:yacht_booking/models/message_model.dart';
import 'package:yacht_booking/services/firebase_chat_provider.dart';
import 'package:yacht_booking/view/user/messages/widgets/message_card.dart';
import 'package:yacht_booking/view/vendor/chat_details_provider_screen.dart';
import 'package:yacht_booking/view/widgets/custom_app_bar.dart';

class ChatScreenProvider extends StatelessWidget {
  ChatGetProvider chatGetProvider = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF3F5FA),
      appBar: CustomAppBar(
        title: 'المحادثات',
        backFun: () => Get.back(),
      ),
      body: Obx(() {
        return chatGetProvider.mapChats.isEmpty
            ? Center(
                child: Helper.loading(),
              )
            : chatGetProvider.mapChats.value['map'].length == 0
                ? Center(
                    child: Text('لا يوجد محادثات'),
                  )
                : ListView.builder(
                    // padding: EdgeInsets.only(top: 10.h),
                    itemCount: chatGetProvider.mapChats.length,
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                    itemBuilder: (context, index) {
                      List myChat = chatGetProvider.mapChats.value['map'];
                      log('myChat $myChat');
                      return StreamBuilder<QuerySnapshot>(
                          stream: FireBaseHelperProvider.fireBaseHelperProvider
                              .getAllChatMessages(
                            myChat[index]['usersInfo']['id'],
                            chatGetProvider.getProfileUserData.value.data.id
                                .toString(),
                          ),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Container();
                            } else {
                              log('snapshot.data ${snapshot.data.docs}');
                              var data = snapshot.data.docs
                                  .map((e) => e.data())
                                  .toList();
                              log('data $data');
                              List<MessageModel> messages = data
                                  .map((e) => MessageModel.fromJson(e))
                                  .toList();
                              log('messagesmessages $messages');
                              return InkWell(
                                onTap: () {
                                  FireBaseHelperProvider.fireBaseHelperProvider
                                      .updateReadMessage(
                                    chatGetProvider
                                        .getProfileUserData.value.data.id
                                        .toString(),
                                    myChat[index]['usersInfo']['id'],
                                  );
                                  Get.to(
                                    () => ChatDetailsScreenProvider(
                                      otherId: myChat[index]['usersInfo']['id'],
                                      myId: chatGetProvider
                                          .getProfileUserData.value.data.id
                                          .toString(),
                                      imagename: myChat[index]['usersInfo']
                                          ['profilePic'],
                                      username: myChat[index]['usersInfo']
                                          ['fullName'],
                                    ),
                                  );
                                },
                                child: MessageCard(
                                  imagename: myChat[index]['usersInfo']
                                      ['profilePic'],
                                  name: myChat[index]['usersInfo']['fullName'],
                                  lastMessage: messages.length == 0
                                      ? ""
                                      : messages.last.content,
                                  time: messages.length == 0
                                      ? ''
                                      : messages.last.hour,
                                  noOfMesseges: messages
                                      .where((element) {
                                        return element.isRead == false &&
                                            element.senderId !=
                                                chatGetProvider
                                                    .getProfileUserData
                                                    .value
                                                    .data
                                                    .id
                                                    .toString();
                                      })
                                      .length
                                      .toString(),
                                ),
                              );
                            }
                          });
                    },
                  );
      }),
    );
  }
}

// class ChatItem extends StatelessWidget {
//   final String imagename;
//   final String name;
//   final String lastMessage;
//   final String time;
//   final String noOfMesseges;
//   final Function onTap;

//   ChatItem({
//     this.imagename,
//     this.name,
//     this.lastMessage,
//     this.time,
//     this.noOfMesseges,
//     this.onTap,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return 
//     Column(
//       children: [
//         GestureDetector(
//           onTap: onTap,
//           child: Container(
//             // height: 120.h,
//             width: 354.w,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(5.r), color: Colors.white),
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 20.h,
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         height: 70.h,
//                         width: 70.w,
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                               fit: BoxFit.fill, image: NetworkImage(imagename)),
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 10.w,
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Text(
//                               name,
//                               style: getStyle(14, true, blackColor),
//                             ),
//                             SizedBox(
//                               width: 200.w,
//                             ),
//                             Text(
//                               time,
//                               style: getStyle(11, true, blackColor),
//                             )
//                           ],
//                         ),
//                         SizedBox(
//                           height: 5.h,
//                         ),
//                         Text(
//                           lastMessage,
//                           style: getStyle(12, true, blackColor),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(left: 15.w),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Badge(
//                         toAnimate: true,
//                         shape: BadgeShape.circle,
//                         badgeColor: orangColor,
//                         padding: EdgeInsets.all(8.h),
//                         //borderRadius: BorderRadius.only(topLeft: Radius.circular(8.r)),
//                         badgeContent: Center(
//                             child: Text(
//                           noOfMesseges,
//                           style: getStyle(12, true, whiteColor),
//                         )),
//                       )
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 5.h,
//                 ),
//               ],
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 10.h,
//         ),
//       ],
//     );
//   }
// }
