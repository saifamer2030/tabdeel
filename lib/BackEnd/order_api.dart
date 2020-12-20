import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import 'base_url.dart';
import 'models/order_model.dart';

Future<Response>createOrder(ClientOrder order) async {

  var baseURL=baseURL_APP+'Orders/NewOrder.php';
   var client = Client();
  
  try { 
    print('MYORDER:${order.toMap()}'); 
    return await client.post(baseURL, body:order.toMap(), headers : {
      'Content-Type': 'application/x-www-form-urlencoded',
    });
  } 
  finally {
    client.close();
  }
}

Future<http.Response> getDriverAllOrders(driverID) async {
  var baseURL =
      baseURL_APP+'Orders/DriverOrders.php?DriverID='+driverID;
  var client = http.Client();
  try {
    return await client.get(
      baseURL,headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json'
            },
    );
  } finally {
    client.close();
  }
}



Future<http.Response> getDriverCurrentOrders(driverID) async {
  var baseURL =
      baseURL_APP+'Drivers/ViewCurrentOrders.php?DriverID='+driverID;
  var client = http.Client();
  try {
    return await client.get(
      baseURL,headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json'
            },
    );
  } finally {
    client.close();
  }
}

Future<http.Response> getDriverPenddingOrders(driverID) async {
  var baseURL =
      baseURL_APP+'Drivers/ViewPendingOrders.php?DriverID='+driverID;
  var client = http.Client();
  try {
    return await client.get(
      baseURL,headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json'
            },
    );
  } finally {
    client.close();
  }
}

Future<http.Response> getDriverDeliverOrders() async {
  var baseURL =
      baseURL_APP+'Orders/ViewPendingOrders.php';
  var client = http.Client();
  try {
    return await client.get(
      baseURL,headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json'
            },
    );
  } finally {
    client.close();
  }
}


Future<http.Response> getDriverEndOrders(driverID) async {
  var baseURL =
      baseURL_APP+'Drivers/ViewEndedOrders.php?DriverID='+driverID;
  var client = http.Client();
  try {
    return await client.get(
      baseURL,headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json'
            },
    );
  } finally {
    client.close();
  }
}


Future<http.Response> drivercancelOrder(orderID) async {
  var baseURL =
      baseURL_APP+'Orders/DriverCancelOrder.php?OrderID='+orderID;
  var client = http.Client();
  try {
    return await client.get(
      baseURL,headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json'
            },
    );
  } finally {
    client.close();
  }
}

Future<http.Response> driverAccpetOrder(orderID,driverId) async {
  var baseURL =
      baseURL_APP+'Orders/DriverAcceptOrder.php?OrderID='+orderID+'&DriverID='+driverId;
  var client = http.Client();
  try {
    return await client.get(
      baseURL,headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json'
            },
    );
  } finally {
    client.close();
  }
}

Future<http.Response> driverEndOrder(orderID,img) async {
  var baseURL =
      baseURL_APP+'Orders/DriverEndOrder.php';
  var client = http.Client();
  var body={
    'OrderID':orderID,
    '&img':img
  };
  try {
    return await client.post(
      baseURL,body:body,headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json'
            },
    );
  } finally {
    client.close();
  }
}


Future<http.Response> getClientAlOrders(clientId) async {
  var baseURL =
      baseURL_APP+'Orders/ClientOrders.php?ClientID='+clientId;
  //http://topdealarabia.com/sites/tabdel/ServiceApis/RestFul/Orders/ClientOrders.php?ClientID='+clientId'
  var client = http.Client();
  try {
    return await client.get(
      baseURL,headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json'
            },
    );
  } finally {
    client.close();
  }
}


Future<http.Response> getClientCanncelOrders(clientId) async {
  var baseURL =
      baseURL_APP+'Clients/ViewCancelledOrders.php?UserID='+clientId;
  var client = http.Client();
  try {
    return await client.get(
      baseURL,headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json'
            },
    );
  } finally {
    client.close();
  }
}


Future<http.Response> getNotifyClientAlOrders(clientId) async {
  var baseURL =
      baseURL_APP+'Clients/ViewAcceptedOrder.php?ClientID='+clientId;
  var client = http.Client();
  try {
    return await client.get(
      baseURL,headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json'
            },
    );
  } finally {
    client.close();
  }
}

Future<http.Response> cancelOrder(orderID) async {
  var baseURL =
      baseURL_APP+'Clients/CancelOrder.php?OrderID='+orderID;
  var client = http.Client();
  try {
    return await client.get(
      baseURL,headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json'
            },
    );
  } finally {
    client.close();
  }
}

Future<http.Response> getDeliveryConstants() async {
  var baseURL =
      baseURL_APP+'Orders/DeliveryConstants.php';
  var client = http.Client();
  try {
    return await client.get(
      baseURL,headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json'
            },
    );
  } finally {
    client.close();
  }
}
