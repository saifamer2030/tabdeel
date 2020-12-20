
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ClientOrder{
  
  String
  clientLat,
  clientLng,
  clientID,
  shopLat,
  shopLng,
  deliveryCost,
  distance,
  deliveryTime,
  shopID,
  shopName,
  flag,
  pendingTime;
  

  List<ClientOrderDetails> orders;

  ClientOrder(
    {
      @required this.clientLat,
      @required this.clientLng,
      @required this.shopLat,
      @required this.shopLng,
      @required this.clientID,
      @required this.orders,
      @required this.deliveryCost,
      @required this.distance,
      @required this.deliveryTime,
      @required this.shopName,
      @required this.flag,
      this.shopID,
      @required this.pendingTime
    }
  );


  Map<String,dynamic> toMap(){

      List<Map<String,dynamic>> myOrders=[];

      this.orders.forEach((order){
      myOrders.add(order.toMap());  
      });

    return {
      "clientLat":this.clientLat,
      "clientLon":this.clientLng,
      "clientID":this.clientID,
      "shopLat":this.shopLat,
      "shopLon":this.shopLng,
      "Flag":this.flag,
      "deliveryCost":this.deliveryCost,
      "distance":this.distance,
      "deliveryTime":this.deliveryTime,
      "shop_name":this.shopName,
      "shopId":this.shopID,
      "pending_time":this.pendingTime,
      "orderDetails":jsonEncode(myOrders) 
    };
  }
}


class ClientOrderDetails{
  String productName,
  orderType,
  deservedMoney,
  notes,
  oldSize,
  newSize,
  color,
  billImage;


  ClientOrderDetails(
    {
      @required this.billImage,
      @required this.deservedMoney,
      @required this.newSize,
      @required this.notes,
      @required this.oldSize,
      @required this.orderType,
      @required this.productName,
      @required this.color
      
    }
  );


   Map<String,dynamic> toMap(){
     return {
       "product_name":this.productName,
       "order_type":this.orderType,
       "deserved_money":this.deservedMoney,
       "notes":this.notes,
       "old_size":this.oldSize,
       "new_size":this.newSize,
       "bill_image":this.billImage,
       "color":this.color
     };
   }


}