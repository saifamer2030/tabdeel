
import 'package:flutter/material.dart';

class OfferModel{

  String offerID,
  title,
  description,
  image;

  OfferModel({
    @required this.offerID,
    @required this.title,
    @required this.description,
    @required this.image
  }
  );

   factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      offerID:json['OfferID'],
       description: json['description'], 
       image: json['image'], 
       title: json['title'],

    );
  }
}