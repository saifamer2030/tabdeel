import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:http/http.dart';
import 'package:tabdeel/BackEnd/models/client_model.dart';
import 'package:tabdeel/BackEnd/models/orderModel.dart';
import 'package:tabdeel/BackEnd/order_api.dart';
import 'package:tabdeel/tooles/print.dart';

import '../../localizations.dart';

import 'client_order_details.dart';

class ClientCancelOrders extends StatefulWidget {
  final ClientModel clientModel;

  const ClientCancelOrders(this.clientModel);
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<ClientCancelOrders> {
  @override
  void initState() {
    super.initState();
    // printBlue(widget.clientModel.clientID);
  }

  int openPageDetails = 0;
  int openChatAndRate = 0;
  @override
  Widget build(BuildContext context) {
    return (openPageDetails == 0)
                ? Container(
                    child: StreamBuilder(
                        stream: Stream.fromFuture(getClientCanncelOrders(
                            widget.clientModel.clientID.toString())),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                                child: Text(AppLocalizations.of(context).notconnect));
                          }
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Center(child: Text(AppLocalizations.of(context).loading
                              ));

                            default:
                              Response rs = snapshot.data;
                                print(rs.body);
                              List jsonArray =
                                  json.decode(rs.body)['AllDriverOrders'];
                              if (json.decode(rs.body)['success'] == 0 ||
                                  json.decode(rs.body)['success'] == -1 ||
                                  jsonArray == null) {
                                return const Center(
                                  child: Text(
                                    "لا يوجد طلبات",
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.grey),
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
                                                printGreen(orders[index]
                                                                  .productsNotes);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                ctx) =>
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
                                            leading: Image.asset(
                                                'assets/product.png'),
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
                                                  AppLocalizations.of(context).addorder+' : '+
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
                                                  mainAxisSize:
                                                      MainAxisSize.min,
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
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.person,
                                                      color: Colors.black54,
                                                      size: 15,
                                                    ),
                                                    Text(
                                                      orders[index]
                                                                  .driverName ==
                                                              ''
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
                : OrderPageDetails();
  }
}

class OrderPageDetails extends StatefulWidget {
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderPageDetails> {
  int openChat = 0;
  int currentStep = 0;
  List<Step> mySteps = [
    Step(
        // Title of the Step
        title: Text(
          "بانتظار المندوب",
          style: TextStyle(
              color: Color.fromRGBO(116, 189, 242, 1.0), fontSize: 10),
        ),
        // Content, it can be any widget here. Using basic Text for this example
        content: Text('data'),
        state: StepState.complete,
        isActive: true),
    Step(
        title: Text("جاري توصيلها",
            style: TextStyle(color: Colors.grey, fontSize: 10)),
        content: Container(),
        // You can change the style of the step icon i.e number, editing, etc.
        state: StepState.complete,
        isActive: false),
    Step(
        title: Text("تم توصيلها",
            style: TextStyle(color: Colors.grey, fontSize: 10)),
        content: Container(),
        state: StepState.complete,
        isActive: false),
  ];
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: <Widget>[
            Container(
              height: 80,
              child: Stepper(
                type: StepperType.horizontal,
                steps: mySteps,
                controlsBuilder: (BuildContext context,
                    {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                  return Container();
                },
              ),
            ),
            ListTile(
                leading: Image.asset('assets/product.png'),
                title: Text(
                  'لاب توب ديل 6565',
                  style: TextStyle(color: Colors.black54, fontSize: 15),
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
                      ' تاريخ التسليم المتوقع:25-9-2019',
                      style: TextStyle(color: Colors.black54, fontSize: 12),
                    )
                  ],
                ),
                trailing: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
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
                          ' بانتظار المندوب',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
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
                          ' محمد مصطفى',
                          style: TextStyle(color: Colors.black54, fontSize: 11),
                        )
                      ],
                    ),
                  ],
                )),
            Divider(
              color: Colors.grey,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  width: 130,
                  child: RaisedButton(
                    child: Text('مراسلة المندوب'),
                    onPressed: () {
                      setState(() {
                        openChat = 1;
                      });
                    },
                    textColor: Colors.white,
                    color: Color.fromRGBO(116, 189, 242, 1.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                ),
                Container(
                  width: 130,
                  child: RaisedButton(
                    child: Text('الابلاغ عن مشكلة'),
                    onPressed: () {
                      setState(() {
                        openChat = 2;
                      });
                    },
                    textColor: Colors.white,
                    color: Color.fromRGBO(116, 189, 242, 1.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}


class RateWidget extends StatefulWidget {
  @override
  _RateWidgetState createState() => _RateWidgetState();
}

class _RateWidgetState extends State<RateWidget> {
  double rating = 0;
  int starCount = 5;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: ListView(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'وضع تقييم للمندوب',
                style: TextStyle(color: Colors.grey),
              ),
              StarRating(
                size: 25.0,
                rating: rating,
                color: Color.fromRGBO(116, 189, 242, 1.0),
                borderColor: Color.fromRGBO(116, 189, 242, 1.0),
                starCount: starCount,
                onRatingChanged: (rating) => setState(
                  () {
                    printBlue(rating);
                    this.rating = rating;
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          TextField(
            maxLines: 5,
            decoration: InputDecoration(
                fillColor: Colors.grey[300],
                filled: true,
                border: InputBorder.none,
                hintText: 'كتابة تعليق',
                hintStyle: TextStyle(color: Colors.grey)),
          ),
          RaisedButton(
            textColor: Colors.white,
            color: Color.fromRGBO(116, 189, 242, 1.0),
            child: Text('وضع تقييم'),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
