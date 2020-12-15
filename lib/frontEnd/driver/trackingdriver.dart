import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:tabdeel/BackEnd/base_url.dart';
import 'package:tabdeel/BackEnd/models/driver_model.dart';
import 'package:tabdeel/BackEnd/order_api.dart';
import 'package:tabdeel/BackEnd/shared_prefrences.dart';
import 'package:tabdeel/frontEnd/driver/viewImage.dart';
import 'package:tabdeel/tooles/print.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../../localizations.dart';

class TrackingDreiver extends StatefulWidget {
 String  shopLat,shopLon,clientLat,
  clientLon,driverId,orderID;

 TrackingDreiver( this.shopLat,this.shopLon,this.clientLat,
      this.clientLon ,this.driverId,this.orderID );

  @override
  _TrackingDreiverState createState() => _TrackingDreiverState();
}

class _TrackingDreiverState extends State<TrackingDreiver> {
  PolylinePoints polylinePoints;
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
 // Marker marker;
  final Set<Marker> _markers = {};
  Position startCoordinates,destinationCoordinates;
  LatLng slatlng , dlatlng;
  Circle circle;
  GoogleMapController _controller;

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(21.5078941, 39.2255419),
    zoom: 14.4746,
  );

  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load("assets/holdiconmap.png");
    return byteData.buffer.asUint8List();
  }
     updatedriverlocation(lat,long) async {
       var baseURL =
       baseURL_APP+'Drivers/UpdateOrderIDLocations.php?OrderID=${widget.orderID}&DriverID=${widget.driverId}&driver_lat=${lat}&driver_long=${long}';
       http.Response response = await http.get(baseURL,
           headers: {
             'Content-type': 'application/json',
             'Accept': 'application/json'
           }).then((value){
         print("lll${value.body}//${widget.orderID}///$lat//$long");
       });
       print("lll${response.body}//${widget.orderID}$lat//$long");
       //
       // var client = http.Client();
       // try {
       //   return await client.get(
       //     baseURL,headers: {
       //     'Content-type': 'application/json',
       //     'Accept': 'application/json'
       //   },
       //   ).then((value){
       //     print("lll${value.body}//${widget.orderID}$lat//$long");
       //   });
       // } finally {
       //   client.close();
       // }


    //    http.post(
    //   'http://topdealarabia.com/sites/tabdel/ServiceApis/RestFul/Drivers/UpdateOrderIDLocations.php?OrderID=${widget.orderID},DriverID=${widget.driverId},driver_lat=${lat},driver_long=${long}',
    //   // 'https://jsonplaceholder.typicode.com/albums/1',
    //      headers: <String, String>{
    //       'Content-type': 'application/json',
    //       'Accept': 'application/json'
    //     },
    //     body: jsonEncode(<String, String>{
    //
    //       'OrderID':widget.orderID,
    //       'DriverID':widget.driverId,
    //       'driver_lat':"$lat",
    //       'driver_long':"$long"
    //     }),
    //   ).then((response){
    //      print('Response status lll: ${response.statusCode}');
    //      print('Response body lll: ${response.body}');
    //    }).catchError((e){print("lll${e}");});
    }


   //  print("hhh$lat////$long////${widget.driverId}");
   //  var baseURL =
   //      "http://topdealarabia.com/sites/tabdel/ServiceApis/RestFul/Drivers/UpdateOrderIDLocations.php?OrderID=254";//${widget.orderID}";
   //   //   baseURL_APP+'Drivers/UpdateDriverLocations.php?DriverID=${widget.driverId}';
   // //  "http://topdealarabia.com/sites/tabdel/ServiceApis/RestFul/Drivers/UpdateDriverLocations.php?DriverID=65";
   //  var client = http.Client();
   //  var body=jsonEncode({
   //    'DriverID':widget.driverId,
   //    'driver_lat':"0.0",
   //    'driver_lon':"0.0"
   //  });
   //  try {
   //    return await client.put(
   //      baseURL,body:body,headers: {
   //     'Content-type': 'application/json',
   //      'Accept': 'application/json'
   //    },
   //    ).then((value) {
   //      print("lll${value.statusCode}");
   //      print("lll${value.body}");
   //
   //    }).catchError((e){print("lll${e}");});
   //  } finally {
   //    client.close();
   //  }

  //}
  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      // marker = Marker(
      //     markerId: MarkerId("home"),
      //     position: latlng,
      //     rotation: newLocalData.heading,
      //     draggable: false,
      //     zIndex: 2,
      //     flat: true,
      //     anchor: Offset(0.5, 0.5),
      //     icon: BitmapDescriptor.fromBytes(imageData));
      _markers.add(Marker(
          markerId: MarkerId("home"),
          infoWindow: InfoWindow(title: "المندوب",),
          position: latlng,
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData)
      ));


      circle = Circle(
          circleId: CircleId("car"),
          radius: newLocalData.accuracy,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    });
  }
  _createPolylines(Position start, Position destination) async {
    polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyCCM7B9YznY7Fos6ruLTeRv3KlF7sqfl_M", // Google Maps API Key
      PointLatLng(start.latitude, start.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.driving,
    );
//print("hhhh///${result.errorMessage}");
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {

        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        // print("hhhh///${polylineCoordinates}");

      });
    }

    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.blue,
      points: polylineCoordinates,
      width: 3,
    );
    polylines[id] = polyline;
  }

  void getCurrentLocation() async {
    try {

      Uint8List imageData = await getMarker();
      print("mmm");

      var location = await _locationTracker.getLocation();
print("mmm$location");
      updateMarkerAndCircle(location, imageData);
      print("mmm1");

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }


      _locationSubscription = _locationTracker.onLocationChanged().listen((newLocalData) {
        if (_controller != null) {
          _controller.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
              bearing: 192.8334901395799,
              target: LatLng(newLocalData.latitude, newLocalData.longitude),
              tilt: 0,
              zoom: 15.00)));
          print("mmm2");

          updateMarkerAndCircle(newLocalData, imageData);
          updatedriverlocation(newLocalData.latitude, newLocalData.longitude);
        }
      });

    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }
  @override
  initState()  {
    super.initState();
     slatlng = LatLng( double.parse(widget.clientLat), double.parse(widget.clientLon));
     dlatlng = LatLng( double.parse(widget.shopLat), double.parse(widget.shopLon));
    _markers.add(Marker(
      markerId: MarkerId("start"),
      position: slatlng,
      infoWindow: InfoWindow(title: "العميل",),
      icon:  BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),

    ));
    _markers.add(Marker(
      markerId: MarkerId("des"),
      position: dlatlng,
      infoWindow: InfoWindow(title: "المحل",),
      icon:  BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),

    ));
    startCoordinates =Position(latitude: double.parse(widget.clientLat), longitude: double.parse(widget.clientLon));
     destinationCoordinates = Position(latitude: double.parse(widget.shopLat), longitude: double.parse(widget.shopLon));
     _createPolylines(startCoordinates, destinationCoordinates);
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(

        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   backgroundColor: Color.fromRGBO(116, 189, 242, 1.0),
        //   title: new Center(child:Text( "widget.shopName" +AppLocalizations.of(context).shop )),
        //   centerTitle: true,
        //   actions:<Widget>[IconButton(icon: Icon(Icons.arrow_forward_ios,size: 25,), onPressed: (){Navigator.pop(context);})]
        // ),
      floatingActionButton: FloatingActionButton(
        heroTag: "unique9",
        onPressed: () {
          getCurrentLocation();
          // Position startCoordinates =Position(latitude: double.parse(widget.clientLat), longitude: double.parse(widget.clientLon));
          // Position destinationCoordinates = Position(latitude: double.parse(widget.shopLat), longitude: double.parse(widget.shopLon));
          _createPolylines(startCoordinates, destinationCoordinates);
        },
      //  backgroundColor: Colors.white,
        elevation: 20.0,
        child: Icon(
          Icons.location_searching,
          size: 30,
          color: const Color(0xff171732),
        ),
      ),

      body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
             width: MediaQuery.of(context).size.width,

              child: GoogleMap(
               // mapType: MapType.normal,
                polylines: Set<Polyline>.of(polylines.values),
                initialCameraPosition: initialLocation,
                markers: _markers,

                // markers: Set.of((marker != null) ? [marker] : []),
                circles: Set.of((circle != null) ? [circle] : []),
                onMapCreated: (GoogleMapController controller) {
                  _controller = controller;
                },

              ),
            ),

          ],
        ),
                       );
  }
}
