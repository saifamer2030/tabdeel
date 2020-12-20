
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ChatModel {
   String fromID,
    toID,
  message,
  flag,
  img;

  ChatModel({
    @required this.fromID,
    @required this.message,
    @required this.flag,
    @required this.toID,
    this.img
  }
  );

  ChatModel.fromMap(Map<String, dynamic> res) {
    this.message = res['Message'];
    this.flag = res['Flag'];
    this.fromID = res['FromID'];
    this.toID = res['ToID'];
    this.img=res['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'Message': message,
      'ToID': toID,
      'FromID': fromID,
      'Flag': flag,
      'image':img
     
    };
  }
}


class MessageModel{

  String fromName,
  toName,
  sentDate,
  message;
  
  MessageModel({
    @required this.fromName,
    @required this.toName,
    @required this.sentDate,
    @required this.message
   
  }
  );

   factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      fromName:json['FromName'],
       toName: json['toName'], 
       sentDate: json['sentDate'], 
       message: json['Message']
    );
  }
}


class MessageChatModel{
  String messageID,
  message,
  fromName,
  toName,
  flag,
  sentDate,
  image;

  MessageChatModel({
    @required this.messageID,
    @required this.message,
    @required this.fromName,
    @required this.toName,
    @required this.flag,
     @required this.sentDate,
     this.image
  }
  );

   factory MessageChatModel.fromJson(Map<String, dynamic> json) {
    return MessageChatModel(
      messageID:json['MessageID'],
       message: json['Message'], 
       fromName: json['FromName'], 
       toName: json['toName'],
       flag: json['Flag'],
       sentDate:json['sentDate'],
       image: json['image']


    );
  }
}







