import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart';
import 'package:tabdeel/BackEnd/models/client_model.dart';
import 'package:tabdeel/BackEnd/models/orderModel.dart';
import 'package:tabdeel/BackEnd/order_api.dart';
import 'package:tabdeel/tooles/print.dart';

import '../../localizations.dart';
import 'client_drawer.dart';
import 'client_order_details.dart';



class ClientNotifyOrderPage extends StatefulWidget {
  final ClientModel clientModel;

  const ClientNotifyOrderPage(this.clientModel);
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<ClientNotifyOrderPage> {
  @override
  void initState() {
    super.initState();
    // printBlue(widget.clientModel.clientID);
  }

  int openPageDetails = 0;
  int openChatAndRate = 0;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       drawer: MyDrawer(),
     appBar: AppBar(
          backgroundColor: Color.fromRGBO(116, 189, 242, 1.0),
          title: ImageIcon(AssetImage('assets/onlyiconlogo.png'), size: 50),
          centerTitle: true,
          // actions:<Widget>[IconButton(icon: Icon(Icons.arrow_forward_ios,size: 30,), onPressed: (){})]
        ),
      body: Container(
                child: StreamBuilder(
                    stream: Stream.fromFuture(
                        getNotifyClientAlOrders(widget.clientModel.clientID.toString())),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text(AppLocalizations.of(context).notconnect));
                      }
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(child: Text(AppLocalizations.of(context).loading));

                        default:
                          Response rs = snapshot.data;
                          List jsonArray =
                              json.decode(rs.body)['AllClientAcceptedOrders'];
                              printGreen(jsonArray);
                          if(json.decode(rs.body)['success']==0||json.decode(rs.body)['success']==-1
                         || jsonArray==null){ 
                          return const Center(
                    child: Text(
                      "لا يوجد أشعارات",
                      style: TextStyle(fontSize: 18.0, color: Colors.grey),
                    ),
                  );
                        }
 

                          
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
                                          setState(() {
                                            // openPageDetails = 1;
                                             Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext ctx) =>
                                          ClientOrderNewDetalse(
                                           
 orders[index]
                                                                .driverName,
                                                            orders[index]
                                                                .orderID,
                                                            orders[index]
                                                                .orderDate,
                                                            orders[index]
                                                                .shopName,
                                                            orders[index]
                                                                .deliveryTime,
                                                            orders[index]
                                                                .orderStatusNumber,
                                                            orders[index]
                                                                .orderStatus,
                                                            orders[index]
                                                                .shopLon,
                                                            orders[index]
                                                                .shopLat,
                                                            orders[index]
                                                                .distance,
                                                            orders[index]
                                                                .deliverCost,
                                                            orders[index]
                                                                .productsNames,
                                                            orders[index]
                                                                .productsNotes,
                                                            orders[index]
                                                                .clientLon,
                                                            orders[index]
                                                                .clientLat,
                                                            orders[index]
                                                                .clientID,
                                                           orders[index]
                                                                .driverId,

                                                           orders[index].oldsize,
                                                          orders[index].newsize,
                                                          orders[index].color,
                                                          orders[index].bilsImages ,
                                                          orders[index].driverMobile
                                                           
      
      ))); 
                                          });
                                        },
                                        leading:
                                            Image.asset('assets/product.png'),
                                        title: Text(
                                         orders[index].productsNames,
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
                                             AppLocalizations.of(context).dateorder+':' +
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
            );
  }
}

// 