import 'package:flutter/foundation.dart';

class DriverModel {
  String name,
      password,
      deviceID,
      mobile,
      email,
      driverLat,
      driverLon,
      privacy,
      img,
      nationality,
      idNumber,
      idImg,
      carFrontImg,
      carRearImg,
      licenseImg,
      cityID,
      rate;
  int driverID;

  DriverModel(
      {
        // @required this.driverID,
       @required this.driverLat,
       @required this.driverLon,
      this.deviceID,
      this.email,
      this.img,
      @required this.mobile,
      @required this.name,
      @required this.password,
      @required this.privacy,
      @required this.nationality,
      @required this.idNumber,
      @required this.idImg,
      @required this.carFrontImg,
      @required this.carRearImg,
      @required this.cityID,
       this.rate,
      @required this.licenseImg});

  Map<String, dynamic> toJson() => {
        "DriverID": driverID,
        "name": name,
        "password": password,
        "DeviceID": deviceID,
        "mobile": mobile,
        "email": email,
        "DriverLat": driverLat,
        "DriverLon": driverLon,
        "privacy": privacy,
        "img": img,
        "nationality": nationality,
        "id_image": idImg,
        "car_front_image": carFrontImg,
        "car_rear_image": carRearImg,
        "id_number": idNumber,
        "CityID":cityID,
        "rate":rate,
        "license_image": licenseImg
      };

  DriverModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        password = json['password'],
        driverID = json['DriverID'],
        img = json['img'],
        nationality = json['nationality'],
        idImg = json['id_image'],
        carFrontImg = json['car_front_image'],
        carRearImg = json['car_rear_image'],
        idNumber = json['id_number'],
        licenseImg = json['license_image'],
        deviceID = json['DeviceID'],
        mobile = json['mobile'],
        email = json['email'],
        driverLat = json['DriverLat'],
        driverLon = json['DriverLon'],
        cityID=json['CityID'],
        privacy = json['privacy'],
        rate=json['rate'];

  DriverModel.fromMap(Map<String, dynamic> res) {
    this.name = res['name'];
    this.password = res['password'];
    this.mobile = res['Mobile'];
    this.email = res['email'];
    this.img = res['img'];
    this.nationality = res['nationality'];
    this.idImg = res['id_image'];
    this.carFrontImg = res['car_front_image'];
    this.carRearImg = res['car_rear_image'];
    // idNumber = res['id_number'];
    // licenseImg = res['license_image'];
    this.driverLat = res['DriverLat'];
    this.driverLon = res['DriverLon'];
    cityID = res['CityID'];

    if (res['DriverID'] is String) {
      this.driverID = int.parse(res['DriverID']);
    } else {
      this.driverID = res['DriverID'];
    }
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "password": password,
      "DeviceID": deviceID,
      "mobile": mobile,
      "email": email,
      "DriverLat": driverLat,
      "DriverLon": driverLon,
      "privacy": privacy,
      "img": img,
      "nationality": nationality,
      "id_image": idImg,
      "car_front_image": carFrontImg,
      "car_rear_image": carRearImg,
      "id_number": idNumber,
      "CityID":cityID,
      "license_image": licenseImg
    };
  }
}
