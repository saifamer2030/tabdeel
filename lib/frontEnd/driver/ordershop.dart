import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tabdeel/BackEnd/models/orderModel.dart';
import 'package:tabdeel/BackEnd/shops_api.dart';
import 'package:tabdeel/localizations.dart';
import 'package:tabdeel/tooles/print.dart';

import 'driver_order_details.dart';

class ShopDriverOrderPage extends StatefulWidget {

   final String shopID;

  const ShopDriverOrderPage( this.shopID);
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<ShopDriverOrderPage> {

  @override
  void initState() {
    super.initState();
    
  }

  int openPageDetails = 0;
  int openChatAndRate = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          backgroundColor: Color.fromRGBO(116, 189, 242, 1.0),
          elevation: 0,
          centerTitle: true,
          title: new Center(child: new Text(AppLocalizations.of(context).orders),),
        ),

body:Directionality(
        textDirection: TextDirection.rtl,
        child: (openPageDetails == 0)
            ? Container(
                child: StreamBuilder( 
                    stream: Stream.fromFuture(
                        shopOrders(widget.shopID.toString())),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text(AppLocalizations.of(context).notconnect));
                      }
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(child: Text(AppLocalizations.of(context).loading));

                        default:
                          Response rs = snapshot.data;
                          printGreen(rs.body);
                          if(json.decode(rs.body)['success']==0||json.decode(rs.body)['success']==-1){ 
                          return const Center(
                    child: Text(
                      "لا يوجد طلبات",
                      style: TextStyle(fontSize: 18.0, color: Colors.grey),
                    ),
                  );
                        }
                          List jsonArray =
                              json.decode(rs.body)['AllClientOrders'];
                              printBlue(jsonArray);
                          List<OrderModel> orders = [];
                          jsonArray.forEach((orderJson) {
                            orders.add(OrderModel.fromJson(orderJson));
                          });
                          return ListView.builder(
                              itemCount: orders.length,
                              itemBuilder: (context, index) {
                                return new Column(
                                  children: <Widget>[
                                    ListTile(
                                        onTap: () {
      //                                     setState(() {
      //                                       // openPageDetails = 1;
                                             Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext ctx) =>
                                          OrderNewDetalse(
                                            orders[index].driverName,
                                          orders[index].orderID,orders[index].orderDate,
      orders[index].shopName,
      orders[index].deliveryTime,
      orders[index].orderStatusNumber,
      orders[index].orderStatus,
      orders[index].distance,
      orders[index].deliverCost,
      orders[index].clientID,

      
      ))); 
                                          // });
                                        },
                                        leading:
                                            Image.asset('assets/product.png'),
                                        title: Text(
                                         AppLocalizations.of(context).shop+' '+orders[index].shopName,
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 15),
                                        ),
                                        subtitle: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Icon(
                                              Icons.date_range,
                                              color: Colors.black54,
                                              size: 15,
                                            ),
                                            Text(
                                             AppLocalizations.of(context).dateorder+
                                                  orders[index]
                                                      .orderDate
                                                      .split(' ')[0],
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 12),
                                            )
                                          ],
                                        ),
                                        trailing: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.directions_car,
                                                  color: Colors.black54,
                                                  size: 15,
                                                ),
                                                Text(
                                                  orders[index].orderStatus,
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )
                                              ],
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.person,
                                                  color: Colors.black54,
                                                  size: 15,
                                                ),
                                                Text(
                                                  orders[index].driverName == ''
                                                      ? 'لا يوجد'
                                                      : orders[index]
                                                          .driverName,
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 11),
                                                )
                                              ],
                                            ),
                                          ],
                                        )),
                                    Divider(
                                      color: Colors.grey,
                                    )
                                  ],
                                );
                              });
                      }
                    }))
            : new Container()));
  }
}

