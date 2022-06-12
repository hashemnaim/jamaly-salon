import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String content;
  String senderId;
  String recieverId;
  FieldValue timeStamp;
  String hour;
  String urlImage;
  bool isRead;

  MessageModel({
    this.content,
    this.recieverId,
    this.senderId,
    this.timeStamp,
    this.hour,
    this.urlImage,
    this.isRead,
  });
  MessageModel.fromJson(Map map) {
    this.content = map['content'];
    this.senderId = map['senderId'];
    this.recieverId = map['recieverId'];
    this.hour = map['hour'];
    this.urlImage = map['urlImage'];
    this.isRead = map['read'];
  }
  toJson() {
    return {
      'content': this.content,
      'senderId': this.senderId,
      'recieverId': this.recieverId,
      'timeStamp': this.timeStamp,
      'hour': this.hour,
      'urlImage': this.urlImage,
      'read': this.isRead,
    };
  }
}
