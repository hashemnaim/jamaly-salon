import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yacht_booking/models/message_model.dart';
import 'package:yacht_booking/models/profile_model.dart';
import 'package:yacht_booking/services/firebase_chat_provider.dart';
import 'package:intl/intl.dart';

class ChatGetProvider extends GetxController {
  var mapChats = {}.obs;
  File imageFile;
  String url;
  Rx<ProfileModel> getProfileUserData = ProfileModel().obs;

  addImageFirebase(String senderId, String recivedId) async {
    try {
      var image = await ImagePicker().pickImage(
          source: ImageSource.gallery, imageQuality: 10);

      imageFile = File(image.path);

      DateTime date = DateTime.now();

      final snapshot = await FirebaseStorage.instance
          .ref()
          .child('chatImage/$date.jpg')
          .putFile(imageFile);

      url = await snapshot.ref.getDownloadURL();
      String hour = DateFormat.jm().format(DateTime.now());
      MessageModel messageModel = MessageModel(
        content: '',
        timeStamp: FieldValue.serverTimestamp(),
        senderId: senderId,
        recieverId: recivedId,
        hour: hour,
        urlImage: url,
        isRead: false,
      );
      await FireBaseHelperProvider.fireBaseHelperProvider.newMessage(
        message: messageModel,
        senderId: senderId,
        reciverId: recivedId,
      );

   
    } catch (e) {}
  }
}
