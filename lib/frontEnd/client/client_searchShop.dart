import 'dart:convert';
import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tabdeel/BackEnd/models/client_model.dart';
import 'package:tabdeel/BackEnd/models/order_model.dart';
import 'package:tabdeel/BackEnd/models/shop_model.dart';
import 'package:tabdeel/BackEnd/shops_api.dart';
import 'package:tabdeel/frontEnd/client/clientFormOrder.dart';
import 'package:tabdeel/tooles/print.dart';

import '../../localizations.dart';

class ClientStoresSearch extends StatefulWidget {
  final String textsearch,lat,long;
   final ClientModel model;
  final ClientOrder order;


  const ClientStoresSearch(this.model,this.order, this.textsearch,this.lat,this.long);
  @override
  _StoresState createState() => _StoresState();
}

class _StoresState extends State<ClientStoresSearch> {
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
        title: new Center(child:new Text(AppLocalizations.of(context).search)),
        backgroundColor: Color.fromRGBO(116, 189, 242, 1.0),
        elevation:
            Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
            actions:<Widget>[IconButton(icon: Icon(Icons.arrow_forward_ios,size: 25,), onPressed: (){Navigator.pop(context);})]
      ),
    body: Container(
          child: Column(  
            children: <Widget>[
            
              SizedBox(height: 5,),
              Expanded(
                child: Container(
                    child: StreamBuilder(   
                  stream: Stream.fromFuture(searchShop(widget.textsearch,
                  widget.lat.toString(),widget.long.toString()
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
                        print(x);
 if(x.length==0){ 
                          return const Center(
                    child: Text(
                      " لا يوجد محلات نتيجة البحث",
                      style: TextStyle(fontSize: 18.0, color: Colors.grey),
                    ),
                  );
                        }
                        printGreen(json.decode(rs.body)['ShopDetails']);
                        List jsonArray = json.decode(rs.body)['ShopDetails'];
                        List<SearchShopModel1> shops = [];
                        // jsonArray.forEach((shopJson) {
                        //   shops.add(SearchShopModel.fromJson(shopJson));
                        // });

                        for( var item in jsonArray ){

                          double lat2=double.parse(item['latitude'].toString().trim());
                          double  lon2= double.parse(item['longitude'].toString().trim());
                          double lat1=double.parse(widget.lat);
                          double  lon1= double.parse(widget.long);

                          var pi = 0.017453292519943295;
                          var c = cos;
                          var a = 0.5 -
                              c((lat2 - lat1) * pi) / 2 +
                              c(lat1 * pi) * c(lat2 * pi) * (1 - c((lon2 - lon1) * pi)) / 2;
                          double distance= 12742 * asin(sqrt(a));
                          item['Distance']=distance;
                        //  if(distance<100.0){
                          //  print("ggg$distance${item['name']}");
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
                                    // Navigator.of(context).push(MaterialPageRoute(
                                    //   builder: (context)=>
                                    //   DriverStoreDetails(shops[index])
                                    // ));
                                    // print(shops[index].shopId);
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
                              trailing: new Container(
                                width: 150,
                                child: new Row(children: <Widget>[
                                  //num.parse(numberToRound.toStringAsFixed(2));
                                Text(num.parse(shops[index].Distance.toStringAsFixed(0)).toString()+' كم',style: TextStyle(color: Colors.black),),
                            SizedBox(width: 5,),
                               RaisedButton(
                                elevation: 0,
                                color: Color.fromRGBO(116, 189, 242, 1.0),
              onPressed: (){

                                                printRed("sucess location");
                                                widget.order.shopLat =
                                                    shops[index].shoptLat;
                                                widget.order.shopLng =
                                                    shops[index].shopLon;
                                          

             Navigator.of(context).push(  MaterialPageRoute(
                              builder: (BuildContext ctx) =>
                                  SecondPageData1(widget.model,widget.order,shops[index].shopId.toString(),shops[index].shopName.toString())));
       
              },
              child: (Text('انشاء الطلب',style: TextStyle(color: Colors.white),)),
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
