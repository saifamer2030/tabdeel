
import 'package:http/http.dart' as http;
import 'base_url.dart';
import 'models/chat_model.dart';




//client create new message
Future<http.Response> createNewMessage(ChatModel model) async {
  var baseURL =
      baseURL_APP+'Chat/NewMessage.php';

  var client = http.Client();
  var body={
  "FromID":model.fromID,
  "ToID":model.toID,
  "Flag":model.flag,
  "Message":model.message,
  "image":model.img
};


  try {
    print('MyClient:${model.toMap()}');
    return await client.post(baseURL,body:body);
  } finally {
    client.close();
  }
}

// get all chat message between client and shop
Future<http.Response> getAllClientMessage(String clientId,String shopID) async {
  var baseURL =
      baseURL_APP+'Chat/GetAllChatMessagesBetweenClientAndShop.php?ClientID='+clientId+'&ShopID='+shopID;

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

// get all celient message

Future<http.Response> getAllShopsMessage(String clientId) async {
  var baseURL =
      baseURL_APP+'Chat/GetAllShopsChatClient.php?ClientID='+clientId;

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

// get client all driver and shop message 
Future<http.Response> getAllShopAndDriverMessage(String clientId) async {
  var baseURL =
      baseURL_APP+'Chat/GetAllShopsDriversChatClient.php?ClientID='+clientId;

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

//driver create new message
Future<http.Response> driverCreateNewMessage(ChatModel model) async { 
  var baseURL =
      baseURL_APP+'DriverClientChat/NewMessage.php';

  var client = http.Client();
var body={
  "FromID":model.fromID,
  "ToID":model.toID,
  "Flag":model.flag,
  "Message":model.message,
  "image":model.img
};
  try {
    print('MyClient:${model.toMap()}');
    return await client.post(baseURL,body:body);
  } finally {
    client.close();
  }
}    

//get driver all chat message between client and you 
Future<http.Response> getAllChatDriverMessage(String clientId,String driverId) async {
  var baseURL =
      baseURL_APP+'DriverClientChat/GetAllChatMessagesBetweenClientAndDriver.php?DriverID='+driverId+'&ClientID='+clientId;
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

/// get all driver message
Future<http.Response> getAllDriverMyMessage(String driverID) async {
  var baseURL =
      baseURL_APP+'DriverClientChat/GetAllClientsChatDriver.php?DriverID='+driverID;

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







