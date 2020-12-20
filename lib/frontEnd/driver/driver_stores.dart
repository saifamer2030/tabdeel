import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tabdeel/BackEnd/models/shop_model.dart';
import 'package:tabdeel/BackEnd/shops_api.dart';
import 'package:tabdeel/frontEnd/driver/shop_search.dart';
import 'package:tabdeel/frontEnd/driver/storeDetails.dart';
import 'package:tabdeel/localizations.dart';
import 'package:tabdeel/tooles/print.dart';

import 'ordershop.dart';

class DriverStores extends StatefulWidget {
  @override
  _StoresState createState() => _StoresState();
}

class _StoresState extends State<DriverStores> {
 Location location = new Location();
 LatLng currentLocation;
 double latitude,longitude;
 var searchController = TextEditingController();
   @override
  void initState() {
    super.initState();
    location.getLocation().then((loc) {
      currentLocation = LatLng(loc.latitude, loc.longitude);
        latitude=loc.latitude;
        longitude=loc.longitude;
      printGreen('CurrentLoc:${currentLocation.toString()}');
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    return  Container(
          child: Column(
            children: <Widget>[
              Card(
                child: Container(
                  padding: EdgeInsets.all(5),
                  height: 50,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Flexible(
                          flex: 4,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                            color: Colors.grey[300],
                            child: TextField(
                               controller: searchController,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10),
                                  border: InputBorder.none,
                                  hintText: AppLocalizations.of(context).searchstor,
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  )),
                            ),
                          )),
                      Flexible(
                        flex: 1,
                        child: RaisedButton(
                          color: Color.fromRGBO(116, 189, 242, 1.0),
                          textColor: Colors.white,
                          child: Text(
                           AppLocalizations.of(context).search,
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () {
                            print("kkk$latitude,$longitude");
                             Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context)=>
                                      DriverStoresSearch(searchController.text,latitude,longitude)
                                    ));
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Expanded(
                child: Container(
                    child: StreamBuilder(
                  stream: Stream.fromFuture(getAllShops()),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text(AppLocalizations.of(context).notconnect));
                    }

                    
                     switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(child: Text(AppLocalizations.of(context).loading));
                      default:
                        Response rs = snapshot.data;
                        print(rs.body);
 if(json.decode(rs.body)['success']==0){ 
                          return const Center(
                    child: Text(
                      "لا يوجد محلات",
                      style: TextStyle(fontSize: 18.0, color: Colors.grey),
                    ),
                  );
                        }
                        printGreen(json.decode(rs.body)['success']);
                        List jsonArray = json.decode(rs.body)['AllShops'];
                        List<ShopModel> shops = [];
                        jsonArray.forEach((shopJson) {
                          shops.add(ShopModel.fromJson(shopJson));
                        });
                        
                       
                        
                        return ListView.builder(
                          itemCount: shops.length,
                          itemBuilder: (context, index) {
                            return Card(
                                child: InkWell(
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context)=>
                                      DriverStoreDetails(shops[index])
                                    ));
                                    print(shops[index].shopId);
                                  },
                                    child: ListTile(
                              leading: (shops[index].img == null)
                                  ? CircleAvatar(
                                      radius: 20,
                                      backgroundColor:
                                          Color.fromRGBO(116, 189, 242, 1.0),
                                      backgroundImage:
                                          AssetImage('assets/photostore.png'))
                                  : CircleAvatar(
                                      radius: 20,
                                      backgroundColor:
                                          Color.fromRGBO(116, 189, 242, 1.0),
                                      backgroundImage:
                                      //  AssetImage('assets/photo store.png')
                                          NetworkImage(shops[index].img),
                                    ),
                              title: Text(shops[index].shopName),
                              subtitle: Text(shops[index].address),
                              trailing:  
                              RaisedButton(
                                elevation: 0,
                                color: Color.fromRGBO(116, 189, 242, 1.0),
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context)=>
                                      ShopDriverOrderPage(shops[index].shopId)
                                    ));
              },
              child: (Text(AppLocalizations.of(context).orders,style: TextStyle(color: Colors.white),)),
            ),
                                  // Text(
                                  //  'الطلبات'
                                  //   ,
                                  //   style: TextStyle(
                                  //       fontSize: 18,
                                  //       color:
                                  //           Color.fromRGBO(116, 189, 242, 1.0)),
                                  // ),
                                
                            )
                            )
                            );
                          },
                        );
                    }
                   
                  },
                )),
              )
            ],
          ),
        );
  }
}
