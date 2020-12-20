//ThirdHomeWidget-ShopLocation
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:location/location.dart' as LocationManager;
import 'package:geolocator/geolocator.dart';
import 'package:tabdeel/BackEnd/models/client_model.dart';
import 'package:tabdeel/BackEnd/models/order_model.dart';
import 'package:tabdeel/BackEnd/models/shop_model.dart';
import 'package:tabdeel/BackEnd/shops_api.dart';
import 'package:tabdeel/frontEnd/client/storeDetails.dart';
import 'package:tabdeel/frontEnd/client/sub_shop.dart';
import 'package:tabdeel/tooles/print.dart';

import '../../localizations.dart';
import 'clientFormOrder.dart';
import 'client_drawer.dart';
import 'client_searchShop.dart';
const kGoogleApiKey = "AIzaSyCCM7B9YznY7Fos6ruLTeRv3KlF7sqfl_M";

GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class MapSecondWidget extends StatefulWidget {
   final ClientModel model;
  final ClientOrder order;
  final String mylat,mylong;
  // final Object homeWidget;
  MapSecondWidget(this.model,this.order,this.mylat,this.mylong);
  @override
  _MapSecondWidgetState createState() => _MapSecondWidgetState();
}

class _MapSecondWidgetState extends State<MapSecondWidget> {
  String shopLat, shopLng;
  List<PlacesSearchResult> places = [];
  bool isLoading = false;
  String errorMessage;
   var searchController = TextEditingController();
 
  Completer<GoogleMapController> mapController = Completer();

  LatLng currentLocation;

  void onMapCreated(GoogleMapController controller) {
    mapController.complete(controller);
  }

  // Geocoder location = new Geocoder();
  String clientLat, clientLng;

  var geolocator = Geolocator();

  LatLng center;
  Future<LatLng> getUserLocation() async {
    // var currentLocation = <String, double>{};
    final location = LocationManager.Location();
    try {
      currentLocation = await location.getLocation().then((s) {
        final lat = s.latitude;
        final lng = s.longitude;
        clientLat = s.latitude.toString();
        clientLng = s.longitude.toString();
        center = LatLng(lat, lng);
      });
      return center;
    } on Exception {
      currentLocation = null;
      return null;
    }
  }

  void getNearbyPlaces(LatLng center) async {
    setState(() {
      this.isLoading = true;
      this.errorMessage = null;
    });

    final location = Location(center.latitude, center.longitude);
    final result = await _places.searchNearbyWithRadius(location, 2000);
    setState(() {
      this.isLoading = false;
      if (result.status == "OK") {
        this.places = result.results;
        print(places);
        result.results.forEach((f) {
          // final markerOptions = MarkerOptions(
          //     position:
          //         LatLng(f.geometry.location.lat, f.geometry.location.lng),
          //     infoWindowText: InfoWindowText("${f.name}", "${f.types?.first}"));
          // mapController.addMarker(markerOptions);
        });
      } else {
        this.errorMessage = result.errorMessage;
      }
    });
  }

  void onError(PlacesAutocompleteResponse response) {
    // homeScaffoldKey.currentState.showSnackBar(
    // SnackBar(content: Text(response.errorMessage)),
    // );
  }

  Future<void> _handlePressButton() async {
    try {
      final center = await getUserLocation();
      Prediction p = await PlacesAutocomplete.show(
          context: context,
          strictbounds: center == null ? false : true,
          apiKey: kGoogleApiKey,
          onError: onError,
          mode: Mode.fullscreen,
          language: "ar",
          location: center == null
              ? null
              : Location(center.latitude, center.longitude),
          radius: center == null ? null : 20000);
      setState(() async {
        print("Dddddskjslasna");
        // homeWidget.setState(() async {
        PlacesDetailsResponse place =
        await _places.getDetailsByPlaceId(p.placeId);
        print(place.result.name);
        // homeWidget.order.shop_name=place.result.name;
        print(place.result.geometry.location);
        // widget.setState(() {
        printRed("sucess location");
        widget.order.shopLat =
            place.result.geometry.location.lat.toString();
        widget.order.shopLng =
            place.result.geometry.location.lng.toString();

        // homeIndex = 3;
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext ctx) =>
                SecondPageData1(widget.model,widget.order,'',place.result.name)));

        // });
        // });
      });
    } catch (e) {
      return;
    }
  }

  @override
  initState() {
    super.initState();
    getUserLocation();
  allshops();
  }

List<ShopModel> listShops = [];
void allshops(){
  setState(() {
    loading=true;
  });
  printBlue(widget.mylat);
  print(widget.mylong);
  getAllShopsNew(double.parse(widget.mylat),double.parse(widget.mylong)).then((data){
             print(data.body);
           setState(() {
    loading=false;
  });
             setState(() {
                 List jsonArray = json.decode(data.body)['all_shops'];
            jsonArray.forEach((shopJson) {
            listShops.add(ShopModel.fromJson(shopJson));
            });
            });

  });
}

bool loading=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
         //---------AppBar---------------------------------
        drawer: MyDrawer(),
     appBar: AppBar(
          backgroundColor: Color.fromRGBO(116, 189, 242, 1.0),
          title: ImageIcon(AssetImage('assets/onlyiconlogo.png'), size: 50),
          centerTitle: true,
          actions:<Widget>[IconButton(icon: Icon(Icons.arrow_forward_ios,size: 25,), onPressed: (){Navigator.pop(context);})]
        ),
        body:Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[


          SizedBox(
            height: 20,
          ),
 Flexible(
                  flex: 1,
                  child: GestureDetector(
                      onTap: () async {
                        _handlePressButton();
                      },
                      child: Container(
                          padding: EdgeInsets.only(right: 10, left: 10),
                          margin: EdgeInsets.only(right: 10, left: 10),
                          color: Colors.grey[100],
                          child: IgnorePointer(
                              child:TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: AppLocalizations.of(context).searchstor,
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                          icon: Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 30,
                          )),
                    
                  ),)))),

                  SizedBox(height: 10,),
new Row(
  children: <Widget>[
          Container(
                        width:90,
                          // padding: EdgeInsets.only(right: 10, left: 10),
                          margin: EdgeInsets.only(right: 0, left: 15),
              child: RaisedButton(
    
                                          elevation: 0,
                                          color: Color.fromRGBO(
                                              116, 189, 242, 1.0),
                                          onPressed: () {
                                            print("kkk${widget.mylat}///${widget.mylong}");
 Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context)=>
                                          ClientStoresSearch(widget.model,widget.order,searchController.text,widget.mylat,widget.mylong)
                                    ));
                                          },
                                         child: Text(AppLocalizations.of(context).search,style: TextStyle(color: Colors.white),), 
                                          )),
          Flexible(
                  flex: 1,
                  child:  Container(
                        width: MediaQuery.of(context).size.width-100,
                          padding: EdgeInsets.only(right: 10, left: 10),
                          margin: EdgeInsets.only(right: 10, left: 10),
                          color: Colors.grey[100],
                         child: TextField(
                       controller: searchController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:AppLocalizations.of(context).searchhimstor,
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                          icon: Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 30,
                          ),
                    
                  ),))),
                  
                  ],),
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
                  child:
                    
                      loading==true? Center(
                          child: CircularProgressIndicator(
                              backgroundColor:
                                  Color.fromRGBO(116, 189, 242, 1.0),
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.white)),
                        ):
                      ListView.builder(
                            itemCount: listShops.length,
                            itemBuilder: (context, index) {
                              return Card(
                                  // margin: index == 0
                                  //     ? const EdgeInsets.only(
                                  //         top: 90.0, left: 5, right: 5)
                                  //     : const EdgeInsets.only(
                                  //         top: 5.0, left: 5, right: 5),
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ClientStoreDetails(
                                                        listShops[index])));
                                        print(listShops[index].shopId);
                                      },
                                      child: ListTile(
                                        leading: (listShops[index].img == null)
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
                                                  listShops[index].img,
                                                ),
                                              ),
                                        title: Text(listShops[index].name),
                                        subtitle: Text(listShops[index].address),
                                        trailing:
                        new Container(
                                width: 150,
                        //         child: new Row(children: <Widget>[
                        //         // Text(shops[index].shopDistance.toString()=='null'?'0 كم':shops[index].shopDistance.toString() + ' كم',style: TextStyle(color: Colors.black),),
                        //     SizedBox(width: 5),
                            child:RaisedButton(
                                          elevation: 0,
                                          color: Color.fromRGBO(
                                              116, 189, 242, 1.0),
                                          onPressed: () {
                                            // widget.setState(() {
                                              if (listShops[index].shopLon ==
                                                      null ||
                                                  listShops[index].shoptLat ==
                                                      null) {
                                                printRed("no location");
                                                widget.order.shopLat =
                                                    shopLat;
                                                widget.order.shopLng =
                                                    shopLng;
                                              } else {
                                                printRed("sucess location");
                                                widget.order.shopLat =
                                                    listShops[index].shoptLat;
                                                widget.order.shopLng =
                                                    listShops[index].shopLon;
                                              }
 
                                              // homeIndex = 3;
                                            // setState(() {  loading=true;});
                                               
  
  if(listShops[index].hasBranches==0){
      Navigator.of(context).push(  MaterialPageRoute(
                              builder: (BuildContext ctx) =>
                                  SecondPageData1(widget.model,widget.order,listShops[index].shopId.toString(),listShops[index].shopName.toString())));
                                          
  }
  else{
    Navigator.of(context).push(  MaterialPageRoute(
                              builder: (BuildContext ctx) =>
                                  ClientSubShop(widget.model,widget.order,listShops[index].shopId.toString(),listShops[index].img.toString())));

   
  }
                                                
                                            // });
                                          },
                                          child: (Text(
                                            AppLocalizations.of(context).addorder,
                                            
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                        // )]
                                        )
                                        ),
                                      )));
                            },
                         
                  )),
            ]),
          ),
        ],
      )),
    );
  }
}

