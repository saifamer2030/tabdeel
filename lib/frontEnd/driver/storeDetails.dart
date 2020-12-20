import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tabdeel/BackEnd/models/driver_model.dart';
import 'package:tabdeel/BackEnd/models/shop_model.dart';
import 'package:tabdeel/BackEnd/shared_prefrences.dart';
import 'package:tabdeel/frontEnd/driver/shop_rating.dart';
import 'package:tabdeel/localizations.dart';
import 'package:tabdeel/tooles/print.dart';




class DriverStoreDetails extends StatefulWidget {
  final ShopModel shopModel;

  DriverStoreDetails(this.shopModel);

  @override
  _StoreDetailsState createState() => _StoreDetailsState(shopModel);
}

class _StoreDetailsState extends State<DriverStoreDetails> {
  ShopModel shopModel;
   double rating = 0;
  int starCount = 5;
  bool openRate=false;
  _StoreDetailsState(this.shopModel) {
    if (shopModel.shopLon == "" || shopModel.shopLon == "" || shopModel.shopLon.contains(',') ||shopModel.shoptLat.contains(',')) {
      pos = LatLng(double.parse('0'), double.parse('0'));
    } else {
       pos = LatLng(
          double.parse(shopModel.shoptLat), double.parse(shopModel.shopLon));
    }

    printBlue(pos);
  }
  GoogleMapController mapController;

  LatLng pos;
DriverModel clientModel;
 loadSharedPrefs() async {
  try {
    DriverModel user = DriverModel.fromJson(await readerItem("clientObject"));
    setState(() {
          clientModel=user;
    });
  } catch (Excepetion) {
    // do something
  }
}

 @override
  void initState() {
    super.initState();
    loadSharedPrefs();
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(116, 189, 242, 1.0),
        title: Text(AppLocalizations.of(context).shop+" " +widget.shopModel.shopName ),
        centerTitle: true,
        // actions: <Widget>[
        //   new Container(
        //      padding: EdgeInsets.only(right: 15),
        //   child:InkWell(
        //       onTap: () {
 


        //       }, // button pressed
        //       child:
        //           Icon(Icons.chat,color: Colors.white,size: 25,), // icon
               
        //     ))
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              child: Container(
                width: double.infinity,
                height: 200,
                color: Colors.black,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        widget.shopModel.shopName,
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                    widget.shopModel.img != null
                        ? Opacity(
                            opacity: .7,
                            child: 
                            Image.network(
                              widget.shopModel.img,
                              fit: BoxFit.cover,
                            ),
                            )
                        : Opacity(
                            opacity: .7,
                            child: Image.asset('assets/photostore.png'))
                  ],
                ),
              ),
            ),
          
            Card(
              // elevation: 0,
              child: Container(
                padding: EdgeInsets.only(right: 10),
                child: Column(
                  children: <Widget>[
                    Row(
                      textDirection: TextDirection.rtl,
                      children: <Widget>[
                        Text(AppLocalizations.of(context).adressshop),
                        Text(' ${widget.shopModel.address}  ')
                      ],
                    ),
                    Row(
                      textDirection: TextDirection.rtl,
                      children: <Widget>[
                        Text(AppLocalizations.of(context).email),
                        Text(' ${widget.shopModel.email}  ')
                      ],
                    ),
                    Row(
                      textDirection: TextDirection.rtl,
                      children: <Widget>[
                        Text(AppLocalizations.of(context).phone + ' : '),
                        Text(' ${widget.shopModel.mobile}  ')
                      ],
                    ),
             
                  ],
                ),
              ),
            
          // SizedBox(width: 100,),
          ),
            Card(
              child: Container(
                width: double.infinity,
                height: 200,
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: pos,
                    zoom: 11.0,
                  ),
                  markers: _createMarker(),
                ),
              ),
            ),
            Center(
              // elevation: 0,
              child:
              Row(children: <Widget>[
                // Container(
                //   width: MediaQuery.of(context).size.width/2,
                //   child: RaisedButton(
                //     child: Text('أضافة طلب'),
                //     onPressed: () {
                //       Navigator.of(context).push(MaterialPageRoute(
                //                       builder: (context)=>
                //                       DriverOrders(widget.shopModel.shoptLat,widget.shopModel.shopLon)
                //                     ));
                     
                //     },
                //     textColor: Colors.white,
                //     color: Color.fromRGBO(116, 189, 242, 1.0),
                //     shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(20.0)),
                //   ),
                // ),
              // SizedBox(width: 20,),
                      Container(
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                    child: Text(AppLocalizations.of(context).shoprate),
                    onPressed: () {
                      setState(() {
                        openRate=!openRate;
                      });
                    },
                    textColor: Colors.white,
                    color: Color.fromRGBO(110, 180, 240, 1.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                ),
                ],)
            ),
            Card(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: (openRate==true)?RateingWidget(widget.shopModel.shopId):
                Container(),
              ),
            ),
          ],
        ),
      ),
    //    floatingActionButton: FloatingActionButton.extended(
    //   onPressed: () {
    //    Navigator.of(context).push(MaterialPageRoute(
    //                                   builder: (context)=>
    //                                   DriverChatMessage(widget.shopModel)
    //                                 ));
    //   },
    //   label: Text('مراسلة'),
    //   icon: Icon(Icons.chat),
    //   backgroundColor: Color.fromRGBO(110, 180, 240, 1.0),
    // ),

    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  Set<Marker> _createMarker() {
    return <Marker>[
      Marker(markerId: MarkerId("marker_1"), position: pos),
    ].toSet();
  }
}
