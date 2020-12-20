import 'package:flutter/foundation.dart';

class ShopModel {
  String shopId,
      name,
      password,
      deviceID,
      mobile,
      email,
      shoptLat,
      shopLon,
      privacy,
      img,
      shopName,
      commericalRecord,
      subtype,
      stutase,
      address
      ;
      int shopDistance,hasBranches;

  ShopModel(
      {@required this.shoptLat,
      @required this.shopLon,
      @required this.deviceID,
      @required this.email,
      @required this.img,
      @required this.mobile,
      @required this.name,
      @required this.password,
      @required this.privacy,
      @required this.shopName,
      @required this.commericalRecord,
      @required this.subtype,
      @required this.address,
      this.shopDistance,
      this.hasBranches
      
      });

  ShopModel.getALL({
    @required this.shopName,
    @required this.shopId,
    @required this.name,
    @required this.email,
    @required this.mobile,
    @required this.shoptLat,
    @required this.shopLon,
    @required this.img,
    @required this.deviceID,
    @required this.address,
    this.stutase,
    this.shopDistance
    ,this.hasBranches
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "password": password,
      "DeviceID": deviceID,
      "mobile": mobile,
      "email": email,
      "ShopLat": shoptLat,
      "ShopLon": shopLon,
      "privacy": privacy,
      "img": img,
      "commercial_record": commericalRecord,
      "subType": subtype,
      "shop_name": shopName,
      "address":address,
      "ShopDistance":shopDistance,
      "hasBranches":hasBranches

    };
  }

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel.getALL(
      name: json['name'],
      email: json['email'],
      img: json['image'],
      mobile: json['mobile'],
      shopId: json['shopID'],
      shopName: json['ShopName'],
      shopLon: json['longitude'],
      shoptLat: json['latitude'],
      deviceID: json['deviceID'],
      address:json['address'],
      stutase: json['subscriptionType'],
      shopDistance:json['Distnace'],
      hasBranches:json['hasBranches']
    );
  }
}


///////////////////search model

class SearchShopModel {
  String shopId,
      name,
      password,
      deviceID,
      mobile,
      email,
      shoptLat,
      shopLon,
      privacy,
      img,
      shopName,
      commericalRecord,
      subtype,
      address;
      int shopDistance;

  SearchShopModel(
      {@required this.shoptLat,
      @required this.shopLon,
      @required this.deviceID,
      @required this.email,
      @required this.img,
      @required this.mobile,
      @required this.name,
      @required this.password,
      @required this.privacy,
      @required this.shopName,
      @required this.commericalRecord,
      @required this.subtype,
      @required this.address,
      this.shopDistance
      });

  SearchShopModel.getALL({
    @required this.shopName,
    @required this.shopId,
    @required this.name,
    @required this.email,
    @required this.mobile,
    @required this.shoptLat,
    @required this.shopLon,
    @required this.img,
    @required this.deviceID,
    @required this.address,
    this.shopDistance
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "password": password,
      "DeviceID": deviceID,
      "mobile": mobile,
      "email": email,
      "ShopLat": shoptLat,
      "ShopLon": shopLon,
      "privacy": privacy,
      "img": img,
      "commercial_record": commericalRecord,
      "subType": subtype,
      "shop_name": shopName,
      "address":address,
      "ShopDistance":shopDistance

    };
  }

  factory SearchShopModel.fromJson(Map<String, dynamic> json) {
    return SearchShopModel.getALL(
      name: json['name'],
      email: json['email'],
      img: json['image'],
      mobile: json['mobile'],
      shopId: json['ShopID'],
      shopName: json['ShopName'],
      shopLon: json['longitude'],
      shoptLat: json['latitude'],
      deviceID: json['deviceID'],
      address:json['address'],
      shopDistance:json['ShopDistance']
    );
  }
}



///////////////////search model1

class SearchShopModel1 {
  String shopId,
      name,
      password,
      deviceID,
      mobile,
      email,
      shoptLat,
      shopLon,
      privacy,
      img,
      shopName,
      commericalRecord,
      subtype,
      address;
  int shopDistance;
  double Distance;

  SearchShopModel1(
      {@required this.shoptLat,
        @required this.shopLon,
        @required this.deviceID,
        @required this.email,
        @required this.img,
        @required this.mobile,
        @required this.name,
        @required this.password,
        @required this.privacy,
        @required this.shopName,
        @required this.commericalRecord,
        @required this.subtype,
        @required this.address,
        this.shopDistance,
        this.Distance

      });

  SearchShopModel1.getALL({
    @required this.shopName,
    @required this.shopId,
    @required this.name,
    @required this.email,
    @required this.mobile,
    @required this.shoptLat,
    @required this.shopLon,
    @required this.img,
    @required this.deviceID,
    @required this.address,
    this.shopDistance,
    this.Distance

  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "password": password,
      "DeviceID": deviceID,
      "mobile": mobile,
      "email": email,
      "ShopLat": shoptLat,
      "ShopLon": shopLon,
      "privacy": privacy,
      "img": img,
      "commercial_record": commericalRecord,
      "subType": subtype,
      "shop_name": shopName,
      "address":address,
      "ShopDistance":shopDistance,
      "Distance":Distance

    };
  }

  factory SearchShopModel1.fromJson(Map<String, dynamic> json) {
    return SearchShopModel1.getALL(
        name: json['name'],
        email: json['email'],
        img: json['image'],
        mobile: json['mobile'],
        shopId: json['ShopID'],
        shopName: json['ShopName'],
        shopLon: json['longitude'],
        shoptLat: json['latitude'],
        deviceID: json['deviceID'],
        address:json['address'],
        shopDistance:json['ShopDistance'],
        Distance:json['Distance']

    );
  }
}