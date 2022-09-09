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

class ChatTap extends StatelessWidget {
  ChatGetProvider chatGetProvider = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return chatGetProvider.mapChats.isEmpty
          ? Center(
              child: Helper.loading(),
            )
          : chatGetProvider.mapChats.value['map'].length == 0
              ? Column(
                  children: [
                    SizedBox(
                      height: Get.height / 4,
                    ),
                    Center(
                      child: Text('لا يوجد محادثات'),
                    ),
                  ],
                )
              : ListView.builder(
                  // padding: EdgeInsets.only(top: 10.h),
                  itemCount: chatGetProvider.mapChats.length,
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                  itemBuilder: (context, index) {
                    List myChat = chatGetProvider.mapChats.value['map'];

                    return StreamBuilder<QuerySnapshot>(
                        stream: FireBaseHelperProvider.fireBaseHelperProvider
                            .getAllChatMessages(
                          chatGetProvider.getProfileUserData.value.data.id
                              .toString(),
                          myChat[index]['usersInfo']['id'].toString() ?? "",
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container();
                          } else {
                            var data = snapshot.data.docs
                                .map((e) => e.data())
                                .toList();
                            List<MessageModel> messages = data
                                .map((e) => MessageModel.fromJson(e))
                                .toList();

                            return InkWell(
                              onTap: () {
                                FireBaseHelperProvider.fireBaseHelperProvider
                                    .updateReadMessage(
                                  chatGetProvider
                                      .getProfileUserData.value.data.id
                                      .toString(),
                                  myChat[index]['usersInfo']['id'].toString(),
                                );
                                Get.to(
                                  () => ChatDetailsScreenProvider(
                                    otherId: myChat[index]['usersInfo']['id']
                                        .toString(),
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
                                              chatGetProvider.getProfileUserData
                                                  .value.data.id
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
    });
  }
}
