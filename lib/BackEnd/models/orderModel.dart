import 'package:flutter/foundation.dart';

class OrderModel {
  String orderID,
      orderDate,
      shopName,
      driverName,
      deliveryTime,
      orderStatusNumber,
      orderStatus,
      clientLat,
      clientLon,
      productsNotes,
      productsNames,
      shopLon,
      shopLat,
      distance,
      deliverCost,
      clientID,
      clientName,
      driverId,
      oldsize,
      newsize,
      color,
      bilsImages,
      driverMobile
     ;

     
			
  OrderModel(
      {@required this.orderID,
      @required this.orderDate,
      @required this.shopName,
      @required this.deliveryTime,
      @required this.driverName,
      @required this.orderStatus,
      @required this.orderStatusNumber,
      @required this.clientLat,
      @required this.clientLon,
      @required this.productsNotes,
      @required this.productsNames,
      @required this.shopLon,
      @required this.shopLat,
     @required this. distance,
      @required this.deliverCost,
      @required this.clientID,
      @required this.clientName,
       @required this.driverId,
       @required this.bilsImages,
       this.driverMobile
     });

  OrderModel.getALL({
      @required this.orderID,
      @required this.orderDate,
      @required this.shopName,
      @required this.deliveryTime,
      @required this.driverName,
      @required this.orderStatus,
      @required this.orderStatusNumber,
      @required this.clientLat,
      @required this.clientLon,
      @required this.productsNotes,
      @required this.productsNames,
      @required this.shopLon,
      @required this.shopLat,
     @required this. distance,
      @required this.deliverCost,
       @required this.clientID,
      // @required this.clientName,
       @required this.driverId,
       @required this.oldsize,
       @required this.newsize,
       @required this.color,
       @required this.bilsImages,
       this.driverMobile

  });

  Map<String, dynamic> toMap() {
    return {
      "OrderID": orderID,
			"OrderDate": orderDate,
			"ShopName": shopName,
			"DriverName": driverName,
			"DeliveryTime": deliveryTime,
			"orderStatusNumber": orderStatusNumber,
			"orderStatus": orderStatus,
      "ClientLat":clientLat,
      "ClientLon":clientLon,
      "ProductsNotes":productsNotes,
      "productsNames":productsNames,
      "ShopLon":shopLon,
      "ShopLat":shopLat,
      "Distance":distance,
      "DeliverCost":deliverCost,
      "ClientID":clientID,
      "DriverID":driverId,
      "productsOldSizes":oldsize,
      "productsNewSizes":newsize,
      "productsColors":color,
      "BilsImages":bilsImages,
      "DriverMobile":driverMobile

    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel.getALL(
      orderID: json['OrderID'],
      orderDate: json['OrderDate'],
      orderStatus: json['orderStatus'],
      shopName: json['ShopName'],
      deliveryTime: json['DeliveryTime'],
      driverName: json['DriverName'],
      orderStatusNumber: json['orderStatusNumber'],
     clientLat:json['ClientLat'],
     clientLon:json['ClientLon'],
      productsNotes:json['productsNotes'],
      productsNames:json['productsNames'],
     shopLon:json['ShopLon'],
     shopLat:json['ShopLat'],
     distance:json['Distance'],
      deliverCost:json['DeliverCost'],
      clientID:json['ClientID'],
       driverId:json['DriverID'],
       oldsize: json['productsOldSizes'],
       newsize:json['productsNewSizes'],
       color: json['productsColors'],
       bilsImages: json['BilsImages'],
       driverMobile:json['DriverMobile']

      

    );
  }
}
