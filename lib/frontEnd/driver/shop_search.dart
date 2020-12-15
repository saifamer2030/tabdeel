import 'dart:convert';
import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tabdeel/BackEnd/models/shop_model.dart';
import 'package:tabdeel/BackEnd/shops_api.dart';
import 'package:tabdeel/localizations.dart';
import 'package:tabdeel/tooles/print.dart';

import 'ordershop.dart';

class DriverStoresSearch extends StatefulWidget {
  final String textsearch;
  double lat,long;

   DriverStoresSearch(this.textsearch,this.lat,this.long);
  @override
  _StoresState createState() => _StoresState();
}

class _StoresState extends State<DriverStoresSearch> {
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
    return  Scaffold(appBar: new AppBar(
      automaticallyImplyLeading: false,
            actions:<Widget>[IconButton(icon: Icon(Icons.arrow_forward_ios,size: 25,), onPressed: (){Navigator.pop(context);})],
        title: new Center(child:new Text(AppLocalizations.of(context).search)),
        backgroundColor: Color.fromRGBO(116, 189, 242, 1.0),
        elevation:
            Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0
      ),
    body: Container(
          child: Column(
            children: <Widget>[
            
              SizedBox(height: 5,),
              Expanded(
                child: Container(
                    child: StreamBuilder( 
                  stream: Stream.fromFuture(searchShop(widget.textsearch,
                  latitude.toString(),longitude.toString()
                  )),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text(AppLocalizations.of(context).notconnect));
                    }

                    
                     switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(child: Text(AppLocalizations.of(context).loading));
                      default:
                        Response rs = snapshot.data;
                        List x=json.decode(rs.body)['ShopDetails'];
                        print(x.length);
 if(x.length==0){ 
                          return const Center(
                    child: Text(
                      " لا يوجد محلات نتيجة البحث",
                      style: TextStyle(fontSize: 18.0, color: Colors.grey),
                    ),
                  );
                        }
                        // printGreen(json.decode(rs.body)['ShopDetails']);
                        // List jsonArray = json.decode(rs.body)['ShopDetails'];
                        // List<SearchShopModel> shops = [];
                        // jsonArray.forEach((shopJson) {
                        //   shops.add(SearchShopModel.fromJson(shopJson));
                        // });
                        printGreen(json.decode(rs.body)['ShopDetails']);
                        List jsonArray = json.decode(rs.body)['ShopDetails'];
                        List<SearchShopModel1> shops = [];
                        // jsonArray.forEach((shopJson) {
                        //   shops.add(SearchShopModel.fromJson(shopJson));
                        // });

                        for( var item in jsonArray ){

                          double lat2=double.parse(item['latitude'].toString().trim());
                          double  lon2= double.parse(item['longitude'].toString().trim());
                          double lat1=(latitude);
                          double  lon1=(longitude);

                          var pi = 0.017453292519943295;
                          var c = cos;
                          var a = 0.5 -
                              c((lat2 - lat1) * pi) / 2 +
                              c(lat1 * pi) * c(lat2 * pi) * (1 - c((lon2 - lon1) * pi)) / 2;
                          double distance= 12742 * asin(sqrt(a));
                          item['Distance']=distance;
                          //  if(distance<100.0){
                            print("ggg$distance${item['name']}");
                          shops.add(SearchShopModel1.fromJson(item));

                          //facilities.add(Faculty.fromJson(item));
                          shops.sort((fl1, fl2) => fl1.Distance.compareTo(fl2.Distance));

                          //     }


                        }



                        return ListView.builder(
                          itemCount: shops.length,
                          itemBuilder: (context, index) {
                            return Card(
                                child: InkWell(
                                  onTap: (){
                                    // Navigator.of(context).push(
                                    //         MaterialPageRoute(
                                    //             builder: (context) =>
                                    //                 ClientSearchStoreDetails(
                                    //                     shops[index])));
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
                              subtitle: Text(shops[index].name),
                              trailing: new Container(
                                width: 140,
                                child: new Row(children: <Widget>[
                                Text(num.parse(shops[index].Distance.toStringAsFixed(0)).toString()+' كم',style: TextStyle(color: Colors.black),),
                            SizedBox(width: 3,),
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
            )],)),
                            )));
                          },
                        );
                    }
                   
                  },
                )),
              )
            ],
          ),
        ));
  }
}
