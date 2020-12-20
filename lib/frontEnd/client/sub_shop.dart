//ThirdHomeWidget-ShopLocation
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabdeel/BackEnd/models/client_model.dart';
import 'package:tabdeel/BackEnd/models/order_model.dart';
import 'package:tabdeel/BackEnd/models/shop_model.dart';
import 'package:tabdeel/BackEnd/shops_api.dart';
import 'package:http/http.dart';
import 'package:tabdeel/tooles/print.dart';

import 'clientFormOrder.dart';
import 'client_drawer.dart';


class ClientSubShop extends StatefulWidget {
   final ClientModel model;
  final ClientOrder order;
  final String shopid,image;
  // final Object homeWidget;
  ClientSubShop(this.model,this.order,this.shopid,this.image);
  @override
  _MapSecondWidgetState createState() => _MapSecondWidgetState();
}

class _MapSecondWidgetState extends State<ClientSubShop> {
  String shopLat, shopLng;
  String lang;
 _fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    print(prefs.getString('languageCode'));
     setState(() {
       lang=prefs.getString('languageCode');
     }); 

    }
 
  

  @override
  initState() {
    super.initState();

    _fetchLocale();
  }

  Set<Marker> markers = Set.from([]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
         //---------AppBar---------------------------------
        drawer: MyDrawer(),
     appBar: AppBar(
          backgroundColor: Color.fromRGBO(116, 189, 242, 1.0),
          title: lang=='en'?Text(' Subsidiary shops'):Text('المتاجر الفرعية'),
          centerTitle: true,
          actions:<Widget>[IconButton(icon: Icon(Icons.arrow_forward_ios,size: 25,), onPressed: (){Navigator.pop(context);})]
        ),
        body:Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Flexible(
            flex: 8,
            child: Stack(children: <Widget>[
              SizedBox(
                height: 50,
              ),
             Container(
                      child: StreamBuilder(
                    stream: Stream.fromFuture(getSubShops(widget.shopid.toString())),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text("لا يوجد اتصال بالانترنت"));
                      }

                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Center(child: Text("تحميل ....."));
                        default:
                          Response rs = snapshot.data;
                          print(rs);
                          if (json.decode(rs.body)['success'] == 0) {
                            return const Center(
                              child: Text(
                                "لا يوجد محلات",
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.grey),
                              ),
                            );
                          }
                          printGreen(json.decode(rs.body)['success']);
                          List jsonArray = json.decode(rs.body)['AllShops'];
                          print(jsonArray);
                          List<ShopModel> shops = [];
                          jsonArray.forEach((shopJson) {
                            shops.add(ShopModel.fromJson(shopJson));
                          });

                          return ListView.builder(
                            itemCount: shops.length,
                            itemBuilder: (context, index) {
                              return Card(
                                  // margin: index == 0
                                  //     ? const EdgeInsets.only(
                                  //         top: 90.0, left: 5, right: 5)
                                  //     : const EdgeInsets.only(
                                  //         top: 5.0, left: 5, right: 5),
                                  child: InkWell(
                                      onTap: () {
                                        // Navigator.of(context).push(
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>ClientSubShop()));
                                        //             ClientStoreDetails(
                                        //                 shops[index])));
                                        // print(shops[index].shopId);
                                      },
                                      child: ListTile(
                                        leading: (widget.image == null)
                                            ? CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Color.fromRGBO(
                                                    116, 189, 242, 1.0),
                                                backgroundImage: AssetImage(
                                                    'assets/photostore.png'))
                                            : CircleAvatar(
                                                radius: 20,
                                                backgroundColor: Color.fromRGBO(
                                                    116, 189, 242, 1.0),
                                                backgroundImage:
                                                    //  AssetImage('assets/photostore.png')
                                                    NetworkImage(
                                                  widget.image,
                                                ),
                                              ),
                                        title: Text(shops[index].name),
                                        subtitle: Text(shops[index].address),
                                        trailing: RaisedButton(
                                          elevation: 0,
                                          color: Color.fromRGBO(
                                              116, 189, 242, 1.0),
                                          onPressed: () {
                                            // widget.setState(() {
                                              if (shops[index].shopLon ==
                                                      null ||
                                                  shops[index].shoptLat ==
                                                      null) {
                                                printRed("no location");
                                                widget.order.shopLat =
                                                    shopLat;
                                                widget.order.shopLng =
                                                    shopLng;
                                              } else {
                                                printRed("sucess location");
                                                widget.order.shopLat =
                                                    shops[index].shoptLat;
                                                widget.order.shopLng =
                                                    shops[index].shopLon;
                                              }

                                              // homeIndex = 3;
                                              print(shops[index].name);
                                                Navigator.of(context).push(  MaterialPageRoute(
                              builder: (BuildContext ctx) =>
                                  SecondPageData1(widget.model,widget.order,shops[index].shopId.toString(),shops[index].name.toString())));
                                            // });
                                          },
                                          child: lang=='en'? Text(
                                          'Add order',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ):Text(
                                          'أضافة طلب',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      )));
                            },
                          );
                      }
                    },
                  ))
            ]),
          ),
        ],
      )),
    );
  }
}

