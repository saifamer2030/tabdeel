import 'package:flutter/foundation.dart';

class ClientModel {
  String name,
      password,
      deviceID,
      mobile,
      email,
      clientLat,
      clientLon,
      privacy,
      img,
      cityID,
      imgUrl;
  int clientID;

  ClientModel(
      {@required this.clientLat,
      @required this.clientLon,
      @required this.deviceID,
      @required this.cityID,
      this.email,
      this.img,
      @required this.mobile,
      @required this.name,
      @required this.password,
      @required this.privacy});

  Map<String, dynamic> toJson() => {
        "name": name,
        "password": password,
        "DeviceID": deviceID,
        "mobile": mobile,
        "email": email,
        "ClientLat": clientLat,
        "ClientLon": clientLon,
        "privacy": privacy,
        "CityID": cityID,
        "img": img,
        "clientID": clientID
      };

  ClientModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        password = json['password'],
        deviceID = json['deviceID'],
        mobile = json['mobile'],
        email = json['email'],
        clientLat = json['clientLat'],
        clientLon = json['clientLon'],
        privacy = json['privacy'],
        cityID = json['CityID'],
        img = json['img'],
        clientID = json['clientID'];

  ClientModel.fromMap(Map<String, dynamic> res) {
    this.name = res['name'];
    this.password = res['password'];
    this.mobile = res['Mobile'];
    this.email = res['email'];
    this.cityID = res['CityID'];
    this.imgUrl = res['image'];

    if (res['ClientID'] is String) {
      this.clientID = int.parse(res['ClientID']);
    } else {
      this.clientID = res['ClientID'];
    }

    this.clientLat = res['latitude'];
    this.clientLon = res['longitude'];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "password": password,
      "DeviceID": deviceID,
      "mobile": mobile,
      "email": email,
      "CityID": cityID,
      "ClientLat": clientLat,
      "ClientLon": clientLon,
      "privacy": privacy,
      "img": img
    };
  }
}
