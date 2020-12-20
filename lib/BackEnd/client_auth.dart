import 'package:http/http.dart' as http;
import 'base_url.dart';
import 'models/client_model.dart';


Future<http.Response> registerClient(ClientModel model) async {
  var baseURL =
      baseURL_APP+'Clients/NewClient.php';

  var client = http.Client();

  try {
    print('MyClient:${model.toMap()}');
    return await client.post(baseURL, body: model.toMap());

    
  } finally {
    client.close();
  }
}

Future<http.Response> loginClient(String mobile, String password) async {
  var baseURL =
      baseURL_APP+'Clients/ClientLogin.php?mobile=$mobile&password=$password';

  var client = http.Client();
  try {
    return await client
        .get(baseURL,
        
        );
  } finally {
    client.close();
  }
}


Future<http.Response> clientDetails(String id) async {
  var baseURL =
      baseURL_APP+'Clients/GetClient.php?ClientID='+id;

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

Future<http.Response> rateClient(
    String clientID, String rate, String comment) async {
  var baseURL =
      baseURL_APP+'Clients/RateClient.php?ClientID='+clientID+'&Rate='+rate+'&Comment='+comment;
  var client = http.Client();
  try {
    return await client.get(baseURL,headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json'
            },
        );
  } finally {
    client.close();
  }
}

Future<http.Response> forgotPasswordClient(String mobile) async {
  var baseURL =
      baseURL_APP+'Clients/ForgetClientPassword.php?Email='+mobile;

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

Future<http.Response> updateClientDeviceID(
    String clientID, String deviceID) async {
  var baseURL =
      baseURL_APP+'Clients/UpdateDeviceID.php?ClientID='+clientID+'DeviceID='+deviceID;
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

Future<http.Response> updateClientLastLogin(String clientID) async {
  var baseURL =
      baseURL_APP+'Clients/UpdateLastLogin.php?ClientID='+clientID;

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
