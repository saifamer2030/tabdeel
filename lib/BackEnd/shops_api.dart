
import 'package:http/http.dart' as http;
import 'package:tabdeel/tooles/print.dart';
import 'base_url.dart';
import 'models/shop_model.dart';

Future<http.Response> registerShop(ShopModel model) async {
  var baseURL = baseURL_APP + 'Shops/NewShop.php';
  var client = http.Client();

  try {
    return await client.post(baseURL, body: model.toMap(),headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json'
            },);
  } finally {
    client.close();
  }
}

Future<http.Response> loginShop(String mobile, String password) async {
  var baseURL =
      baseURL_APP + 'Shops/ShopLogin.php?mobile=$mobile&password=$password';
  var client = http.Client();
  try {
    return await client.get(baseURL,headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json'
            },);
  } finally {
    client.close();
  }
}

Future<http.Response> rateShop(
    String shopID, String rate, String comment) async {
  var baseURL = baseURL_APP +
      'Shops/RateShop.php?ShopID=' +
      shopID +
      '&Rate=' +
      rate +
      '&Comment=' +
      comment;
  var client = http.Client();
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
// Future<http.Response> searchShop1(String shopTitle, String clientLat, String clientLong) async {
//   var baseURL = baseURL_APP +
//       'Shops/SearchShop.php?Title=' +
//       shopTitle +
//       '&client_lat=' +
//       clientLat +
//       '&client_long=' +
//       clientLong;
//   print("url search "+baseURL);
//   Map<String,String> headers = {
//     'Content-type': 'application/json',
//     'Accept': 'application/json'
//   };
//   var client = http.Client();
//   try {
//     return await client.get(
//       baseURL,
//       headers: {
//         'Content-type': 'application/json',
//         'Accept': 'application/json'
//       },
//     );
//   } finally {
//     client.close();
//   }
// }

Future<http.Response> searchShop(String shopTitle, String clientLat, String clientLong) async {
  var baseURL = baseURL_APP +
      'Shops/SearchShop.php?Title=' +
      shopTitle +
      '&client_lat=' +
      clientLat +
      '&client_long=' +
      clientLong;
      print("url search "+baseURL);
  var client = http.Client();
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

Future<http.Response> shopOrders(String shopID) async {
  var baseURL = baseURL_APP + 'Orders/ShopOrders.php?ShopID=' + shopID;
  var client = http.Client();
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


//
Future<http.Response> getSubShops(String shopID) async {
  var baseURL = baseURL_APP + 'Shops/GetAllShopBranches.php?ParentID=' + shopID;
  var client = http.Client();
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



Future<http.Response> forgetPasswordShop(String mobile) async {
  var baseURL = baseURL_APP + 'Shops/ForgetShopPassword.php?Mobile=' + mobile;
  var client = http.Client();
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

Future<http.Response> getAllShops() async {
  var baseURL = baseURL_APP + 'Shops/GetAllShops.php';
  var client = http.Client();
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


Future<http.Response> getAllShopsNew(double clientLat,double clienLong) async {
  var baseURL = baseURL_APP + 'Shops/GetAllShopsNew.php?ClientLat='+'$clientLat'+'&ClientLon='+'$clienLong';
  var client = http.Client();
  printGreen(baseURL);
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
Future<http.Response> getShopDetails(String shopID) async {
  var baseURL = baseURL_APP + 'Shops/GetShop.php?ShopID=$shopID';
  var client = http.Client();
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

Future<http.Response> updateShopDeviceID(String shopID, String deviceID) async {
  var baseURL = baseURL_APP +
      'Shops/UpdateDeviceID.php?ShopID=' +
      shopID +
      'DeviceID=' +
      deviceID;
  var client = http.Client();
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
