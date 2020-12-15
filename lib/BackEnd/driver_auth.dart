import 'package:http/http.dart' as http;
import 'base_url.dart';
import 'models/driver_model.dart';

Future<http.Response> registerDriver(DriverModel model) async {
  var baseURL =
      baseURL_APP+'Drivers/NewDriver.php';

  var client = http.Client();
  try {
    return await client.post(baseURL, body: model.toMap(),
    // headers: {
    //           "Content-Type": "application/x-www-form-urlencoded"  
    //           // 'Content-type': 'application/json',
    //           // 'Accept': 'application/json'
    //         },
            );
  } finally {
    client.close();
  }
}

Future<http.Response> loginDriver(String mobile, String password) async {
  var baseURL =
     baseURL_APP+'Drivers/DriverLogin.php?mobile=$mobile&password=$password';
  var client = http.Client();
  try {
    return await client
        .get(baseURL,headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json'
            },);
  } finally {
    client.close();
  }
}

Future<http.Response> rateDriver(
    String driverID, String rate, String comment) async {
  var baseURL =
      baseURL_APP+'Drivers/RateDriver.php?DriverID='+driverID+'&Rate='+rate+'&Comment='+comment;
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

Future<http.Response> forgotPasswordDriver(String mobile) async {
  var baseURL =
      baseURL_APP+'Drivers/ForgetDriverPassword.php?Email='+mobile;
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

Future<http.Response> updateDriverLastLogin(String driverID) async {
  var baseURL =
      baseURL_APP+'Drivers/UpdateLastLogin.php?DriverID='+driverID;
  var client = http.Client();
  try {
    return await client.get(baseURL, headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json'
            },);
  } finally {
    client.close();
  }
}

Future<http.Response> driverDetails(String id) async {
  var baseURL =
      baseURL_APP+'Drivers/GetDriverDetails.php?DriverID='+id;

  var client = http.Client();
  try {
    return await client
        .get(baseURL,headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json'
            },
        
        );
  } finally {
    client.close();
  }
}

Future<http.Response> updateDriverLastLocations(String driverID,String driverLat,String driverLong) async {
  var baseURL =
      baseURL_APP+'Drivers/UpdateDriverLocations.php?DriverID='+driverID+'&driver_lat='+driverLat+'&driver_long='+driverLong;
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
