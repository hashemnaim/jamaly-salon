import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:yacht_booking/controller/vendor/chat_get_provider.dart';
import 'package:yacht_booking/models/message_model.dart';
import 'package:yacht_booking/services/sp_helper.dart';

class FireBaseHelperProvider {
  FireBaseHelperProvider._();

  static FireBaseHelperProvider fireBaseHelperProvider =
      FireBaseHelperProvider._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  ChatGetProvider chatGetProvider = Get.find();
  newMessage({MessageModel message, String senderId, String reciverId}) async {
    String type = SPHelper.spHelper.getUser();
    if (type == 'user') {
      firestore.collection('Chats').doc('${senderId + reciverId}').set({
        "users": [senderId, reciverId],
      });
      firestore
          .collection('Chats')
          .doc('${senderId + reciverId}')
          .collection('Messages')
          .add(message.toJson());
    } else {
      firestore.collection('Chats').doc('${reciverId + senderId}').set({
        "users": [reciverId, senderId],
      });
      firestore
          .collection('Chats')
          .doc('${reciverId + senderId}')
          .collection('Messages')
          .add(message.toJson());
    }
  }

  Future<Map<String, dynamic>> getInfoUser(String receviedId) async {
    DocumentSnapshot querySnapshot =
        await firestore.collection('users').doc(receviedId).get();

    Map<String, dynamic> data = querySnapshot.data();
    return data;
  }

  Future<List<Map<String, dynamic>>> getAllMyChats({String myId}) async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('Chats')
          .where('users', arrayContains: myId)
          .get();

      List<Map<String, dynamic>> mapUsers = [];
      for (QueryDocumentSnapshot queryDocumentSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data = queryDocumentSnapshot.data();
        Map<String, dynamic> dataUser = {};

        List users = data['users'];
        String otherId =
            users.where((element) => element != myId).toList().first;
        Map map = await getUserInformation(otherId);
        dataUser['mobile'] = otherId;
        dataUser['usersInfo'] = map;

        mapUsers.add(dataUser);
      }

      chatGetProvider.mapChats.assignAll({'map': mapUsers});
      return mapUsers;
    } catch (e) {}
  }

  Future<Map> getUserInformation(String id) async {
    DocumentSnapshot documentSnapshot =
        await firestore.collection('users').doc(id).get();
    return documentSnapshot.data();
  }

  Stream<QuerySnapshot> getAllChatMessages(String reciverId, String senderId) {
    String type = SPHelper.spHelper.getUser();

    if (type == 'user') {
      Stream<QuerySnapshot> stream = FirebaseFirestore.instance
          .collection('Chats')
          .doc('${senderId + reciverId}')
          .collection('Messages')
          .orderBy('timeStamp')
          .snapshots();
      return stream;
    } else {
      Stream<QuerySnapshot> stream = FirebaseFirestore.instance
          .collection('Chats')
          .doc('${reciverId + senderId}')
          .collection('Messages')
          .orderBy('timeStamp')
          .snapshots();
      return stream;
    }
  }

  deleteMyChats({String reciverId}) async {
    await firestore.collection('Chats').doc(reciverId).delete();
  }

  updateReadMessage(String senderId, String reciverId) async {
    // if ('55' == senderId) {
    QuerySnapshot querySnapshot = await firestore
        .collection('Chats')
        .doc('${senderId + reciverId}')
        .collection('Messages')
        .where('recieverId', isEqualTo: senderId)
        .get();
    for (var i = 0; i < querySnapshot.docs.length; i++) {
      await firestore
          .collection('Chats')
          .doc('${senderId + reciverId}')
          .collection('Messages')
          .doc(querySnapshot.docs[i].id)
          .update({'read': true});
    }
    // } else {
    //   QuerySnapshot querySnapshot = await firestore
    //       .collection('Chats')
    //       .doc('${reciverId + senderId}')
    //       .collection('Messages')
    //       .where('senderId', isEqualTo: reciverId)
    //       .get();

    //   for (var i = 0; i < querySnapshot.docs.length; i++) {
    //     await firestore
    //         .collection('Chats')
    //         .doc('${reciverId + senderId}')
    //         .collection('Messages')
    //         .doc(querySnapshot.docs[i].id)
    //         .update({'read': true});
    //   }
    // }
  }

  // updateUser(String id, String state, String date) async {
  //   await firestore.collection('Users').doc(id).update(
  //     {
  //       'date': date,
  //       'state': state,
  //     },
  //   );
  // }
}
