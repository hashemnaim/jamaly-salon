import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yacht_booking/common/app_colors.dart';
import 'package:yacht_booking/controller/user/home_user_controller.dart';
import 'package:yacht_booking/controller/vendor/chat_get_provider.dart';
import 'package:yacht_booking/models/message_model.dart';
import 'package:yacht_booking/services/firebase_chat_provider.dart';
import 'package:yacht_booking/view/widgets/custom_app_bar.dart';
import 'package:yacht_booking/view/widgets/custom_avatar.dart';
import 'package:yacht_booking/view/widgets/custom_text.dart';

class ChatDetailsScreenProvider extends StatefulWidget {
  final String imagename;
  final String myId;
  final String otherId;
  final String username;
  ChatDetailsScreenProvider(
      {this.imagename, this.username, this.otherId, this.myId});

  @override
  _ChatDetailsScreenProviderState createState() =>
      _ChatDetailsScreenProviderState();
}

class _ChatDetailsScreenProviderState extends State<ChatDetailsScreenProvider> {
  ChatGetProvider chatGetProvider = Get.find();

  TextEditingController textEditingController = TextEditingController();

  ScrollController _controller;

  HomeUserController homeUserController = Get.find();
  @override
  void initState() {
    _controller = ScrollController();
    try {
      Timer(
        Duration(milliseconds: 200),
        () {
          if (_controller.isNull) {
          } else {
            _controller.jumpTo(_controller.position.maxScrollExtent);
          }
        },
      );
    } catch (e) {}
    super.initState();
  }

  buildMessage(Map map, String myId, double width) {
    if (map['senderId'] == myId) {
      return myMessage(map, width, map['hour']);
    } else {
      return partnerMessageView(map, width, map['hour']);
    }
  }

  Widget myMessage(Map map, double width, String hour) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child:
                    homeUserController.getProfileUserData.value.status == null
                        ? CustomAvatar(24, 23, 'person')
                        : CircleAvatar(
                            radius: 15.r,
                            backgroundColor: AppColors.primaryColor,
                            child: CircleAvatar(
                              radius: 15.r,
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(homeUserController
                                  .getProfileUserData.value.data.photo),
                            ),
                          ),
              ),
              SizedBox(height: 3.h),
              CustomText(map['hour'], fontSize: 10),
            ],
          ),
          SizedBox(width: 10.w),
          Container(
            constraints: BoxConstraints(
              maxWidth: 250.w,
              minWidth: 0,
              maxHeight: double.infinity,
              minHeight: 40.h,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 5.h,
            ),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadiusDirectional.circular(10.r),
            ),
            child: Text(
              map['content'].toString(),
              textAlign: TextAlign.end,
              maxLines: 25,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Cairo', fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget partnerMessageView(Map map, double width, String hour) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0, left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: 250.w,
              minWidth: 0,
              maxHeight: double.infinity,
              minHeight: 40.h,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 5.h,
            ),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadiusDirectional.circular(10.r),
            ),
            child: Text(
              map['content'],
              textAlign: TextAlign.end,
              maxLines: 25,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: AppColors.fontPrimaryColor,
                  fontFamily: 'Cairo',
                  fontSize: 14.sp),
            ),
          ),
          SizedBox(width: 10.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: CircleAvatar(
                  radius: 15.r,
                  backgroundColor: AppColors.primaryColor,
                  child: CircleAvatar(
                    radius: 15.r,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(widget.imagename),
                  ),
                ),
              ),
              SizedBox(height: 3.h),
              CustomText(map['hour'], fontSize: 10),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.username,
        text: '',
        isText: true,
        backFun: () => Get.back(),
        // actionFun: () => reservationConfirmationDialog(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FireBaseHelperProvider.fireBaseHelperProvider
                      .getAllChatMessages(widget.otherId, widget.myId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Container(),
                      );
                    } else if (snapshot.hasData && snapshot.data == null) {
                      return Center(
                        child: CustomText(
                          'لا يوجد رسائل',
                        ),
                      );
                    } else {
                      var data =
                          snapshot.data.docs.map((e) => e.data()).toList();
                      List<MessageModel> messages =
                          data.map((e) => MessageModel.fromJson(e)).toList();

                      return ListView.builder(
                        controller: _controller,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          return buildMessage(
                            data[index],
                            widget.myId,
                            size.width,
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
            Container(
              height: 60.h,
              width: Get.width,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () async {
                          if (textEditingController.text.trim().isNotEmpty) {
                            // DateTime dateTime = DateTime.now();
                            // String hour = '${dateTime.hour}:${dateTime.minute}';
                            String hour =
                                DateFormat.jm().format(DateTime.now());
                            MessageModel messageModel = MessageModel(
                              content: textEditingController.text,
                              timeStamp: FieldValue.serverTimestamp(),
                              senderId: widget.myId,
                              recieverId: widget.otherId,
                              hour: hour,
                              isRead: false,
                            );

                            await FireBaseHelperProvider.fireBaseHelperProvider
                                .newMessage(
                              message: messageModel,
                              senderId: widget.myId,
                              reciverId: widget.otherId,
                            );

                            textEditingController.clear();

                            Timer(
                              Duration(milliseconds: 300),
                              () => _controller
                                  .jumpTo(_controller.position.maxScrollExtent),
                            );
                          }
                        },
                        child: Transform.rotate(
                          angle: pi,
                          child: Icon(Icons.send),
                        )
                        //  CustomSvgImage(
                        //   imageName: "send",
                        //   color: AppColors.primaryColor,
                        //   height: 22.h,
                        //   width: 22.w,
                        // ),
                        ),
                    Container(
                      width: 266.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: Color(0xffF3F5FA),
                          borderRadius: BorderRadius.circular(25.r)),
                      child: TextField(
                        controller: textEditingController,
                        onTap: () {
                          try {
                            Timer(
                              Duration(milliseconds: 300),
                              () => _controller
                                  .jumpTo(_controller.position.maxScrollExtent),
                            );
                          } catch (e) {}
                        },
                        decoration: InputDecoration(
                          hintText: "اكتب الرسالة هنا",
                          hintStyle: TextStyle(
                            fontFamily: "SF Pro Display",
                            fontSize: 15,
                            color: Color(0xffc8c7cc),
                          ),

                          contentPadding:
                              EdgeInsets.only(left: 15, right: 15, top: 15),
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          // hintText: translator.translate('message_here'),
                        ),
                      ),
                      // child: TextFormField(
                      //   onTap: () {
                      //     try {
                      //       Timer(
                      //         Duration(milliseconds: 300),
                      //         () => _controller
                      //             .jumpTo(_controller.position.maxScrollExtent),
                      //       );
                      //     } catch (e) {}
                      //   },
                      //   controller: textEditingController,
                      //   decoration: InputDecoration(
                      //       border: InputBorder.none,
                      //       contentPadding:
                      //           EdgeInsets.only(right: 5.w, bottom: 20.h)),
                      // ),
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(height: 60.h),
          ],
        ),
      ),
    );
  }
}
