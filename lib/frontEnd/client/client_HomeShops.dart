import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as LocationManager;
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:tabdeel/BackEnd/models/client_model.dart';
import 'package:tabdeel/BackEnd/models/order_model.dart';
import 'package:tabdeel/tooles/print.dart';

import '../../localizations.dart';
import 'client_drawer.dart';
import 'client_homeOrder.dart';
const kGoogleApiKey = "AIzaSyCCM7B9YznY7Fos6ruLTeRv3KlF7sqfl_M";

GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class MapFirstWidget extends StatefulWidget {
  final ClientModel model;
  final ClientOrder order;
  final String mylat, mylong;

  MapFirstWidget(this.model, this.order, this.mylat, this.mylong);

  @override
  _MapFirstWidgetState createState() => _MapFirstWidgetState();
}

class _MapFirstWidgetState extends State<MapFirstWidget> {
  Completer<GoogleMapController> mapController = Completer();

  LatLng currentLocation;

  void onMapCreated(GoogleMapController controller) {
    mapController.complete(controller);
  }

  // Location location = new Location();
  double myLat, myLong;
  static LatLng _target = LatLng(21.468685, 39.149994);
  String clientLat, clientLng;
  CameraPosition _initialCamera = CameraPosition(target: _target, zoom: 10);

  // var geolocator = Geolocator();
  Position position;

  List<PlacesSearchResult> places = [];
  bool isLoading = false;
  String errorMessage;
  Location location;

  LatLng center;

  Future<LatLng> getUserLocation() async {
    final location = LocationManager.Location();
    try {
      currentLocation = await location.getLocation().then((s) {
        clientLat = s.latitude.toString();
        clientLng = s.longitude.toString();
        center = LatLng(s.latitude, s.longitude);
        _target = LatLng(s.latitude, s.longitude);
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
    final result = await _places.searchNearbyWithRadius(location, 2500);
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
        print(place.result.adrAddress);
        print(place.result.name);
        print(place.result.formattedAddress);
        widget.order.clientLat = place.result.geometry.location.lat.toString();
        widget.order.clientLng = place.result.geometry.location.lng.toString();

        // homeIndex = 2;
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext ctx) => MapSecondWidget(
                widget.model, widget.order, widget.mylat, widget.mylong)));
      });
      // });
    } catch (e) {
      return;
    }
  }

  @override
  initState() {
    super.initState();
    getUserLocation();
  }

  Set<Marker> markers = Set.from([]);
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //---------AppBar---------------------------------
      drawer: MyDrawer(),
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(116, 189, 242, 1.0),
          title: ImageIcon(AssetImage('assets/onlyiconlogo.png'), size: 50),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 25,
                ),
                onPressed: () {
                  Navigator.pop(context);
                })
          ]),
      body: Container(
          child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Flexible(
              flex: 1,
              child: GestureDetector(
                  onTap: () async {
                    _handlePressButton();
                    print("ddddddddd");
                    // Prediction p = await PlacesAutocomplete.show(
                    //     context: context,
                    //     apiKey: 'AIzaSyCnNMBSipK7BYeGXfAg-j_EeU3jWcUsDPs');
                    // displayPrediction(p);
                  },
                  child: Container(
                      padding: EdgeInsets.only(right: 10, left: 10),
                      margin: EdgeInsets.only(right: 10, left: 10),
                      color: Colors.grey[100],
                      child: IgnorePointer(
                        child: TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText:
                                  AppLocalizations.of(context).searchplace,
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                              icon: Icon(
                                Icons.search,
                                color: Colors.grey,
                                size: 30,
                              )),
                        ),
                      )))),
          SizedBox(
            height: 10,
          ),
          Flexible(
            flex: 5,
            child:
                // Stack(children: <Widget>[
                GoogleMap(
              onTap: (pos) {
                markers.clear();
                markers.add(Marker(markerId: MarkerId('shop'), position: pos));
                print(pos.latitude);
                clientLat = pos.latitude.toString();
                clientLng = pos.longitude.toString();
                setState(() {});
              },
              markers: markers,
              zoomGesturesEnabled: true,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              compassEnabled: true,
              rotateGesturesEnabled: true,
              scrollGesturesEnabled: true,
              tiltGesturesEnabled: true,
              // markers: _markers,
              initialCameraPosition: _initialCamera,
              onMapCreated: (GoogleMapController controller) async {
                _controller.complete(controller);
                printBlue(_target);
                // var pos = await location.getLocation();
                controller.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: myLat == null ? _target : LatLng(myLat, myLong),
                        zoom: 10)));
                // _animateToUser();
                // SearchResult();
              },
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              children: <Widget>[
                // Image.asset('assets/banner.png'),
                SizedBox(
                  height: 5,
                ),
                Text(
                  AppLocalizations.of(context).locationMap,
                  style: TextStyle(color: Colors.black45),
                ),
                Container(
                  width: 130,
                  child: RaisedButton(
                    child: Text(AppLocalizations.of(context).next),
                    onPressed: () {
                      // _handlePressButton();
                      // homeWidget.setState(() {
                      if (clientLat == null || clientLng == null) {
                        widget.order.clientLat = '27';
                        widget.order.clientLng = '30';
                      } else {
                        widget.order.clientLat = clientLat;
                        widget.order.clientLng = clientLng;
                      }
                      // homeIndex = 2;
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext ctx) => MapSecondWidget(
                              widget.model,
                              widget.order,
                              widget.mylat,
                              widget.mylong)));
                      // });
                    },
                    textColor: Colors.white,
                    color: Color.fromRGBO(116, 189, 242, 1.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
