import 'package:http/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'base_url.dart';

Future<Response> getAllNationalities() async {
  var baseURL = baseURL_APP + 'Drivers/GetAllNationalities.php';

  var client = Client();
  try {
    return await client.get(
      baseURL,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
    );
  } finally {
    client.close();
  }
}

Future<Response> getAllCities() async {
  var baseURL = baseURL_APP_nots + 'General/GetCities.php';

  var client = Client();
  try {
    print('inside get cities and data is');
    var data = client.get(baseURL).then((value) => print(value));
    return await client.get(baseURL);
  } finally {
    client.close();
  }
}

showAlertDialog(BuildContext context, String mes) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text(
      "تم",
      textAlign: TextAlign.center,
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    content: Text(
      mes,
      textAlign: TextAlign.center,
    ),
    actions: [
      okButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Future<Response> setTimeAndDistance(
    latuser, longuser, shoplats, shoplongs) async {
  var baseURL =
      'https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=';
  var client = Client();

  try {
    return await client.get(
        baseURL +
            latuser +
            ',' +
            longuser +
            '&destinations=' +
            shoplats +
            ',' +
            shoplongs +
            '&key=AIzaSyDoJgoZBHb2BgUakAyVDObBXCIGv2SzQT0',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        });
  } finally {
    client.close();
  }
}

//calculate Distance

double calculateDistance(lat1, lon1, lat2, lon2) {
  const p = 0.017453292519943295;
  const c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return (12742 * asin(sqrt(a))) * 1.60934;
}
