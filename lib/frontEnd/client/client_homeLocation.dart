import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:tabdeel/BackEnd/models/client_model.dart';
import 'package:tabdeel/BackEnd/models/order_model.dart';
import 'package:tabdeel/BackEnd/shared_prefrences.dart';
import '../../localizations.dart';
import 'client_HomeShops.dart';
import 'client_drawer.dart';

class HomeWidget extends StatefulWidget {
  final ClientModel model;
  final ClientOrder order;

  HomeWidget(this.model, this.order);

  @override
  _HomeWidgetState createState() => _HomeWidgetState(this.model, this.order);
}

class _HomeWidgetState extends State<HomeWidget> {
  ClientModel model;
  ClientOrder order;
  _HomeWidgetState(this.model, this.order);

  @override
  initState() {
    super.initState();
    // requestLocationPermission();
    // _gpsService();

    getlocations();
    checkStorge();
  }
//   Future<bool> _requestPermission(PermissionGroup permission) async {
//     final PermissionHandler _permissionHandler = PermissionHandler();
//     var result = await _permissionHandler.requestPermissions([permission]);
//
//     // if (result[permission] == PermissionStatus.granted) {
//     //   return true;
//     // }
//     return false;
//   }
// /*Checking if your App has been Given Permission*/
//   Future<bool> requestLocationPermission({Function onPermissionDenied}) async {
//     var granted = await _requestPermission(PermissionGroup.location);
//     if (granted!=true) {
//       requestLocationPermission();
//     }
//     debugPrint('requestContactsPermission $granted');
//     return granted;
//   }
// /*Show dialog if GPS not enabled and open settings location*/
//   Future _checkGps() async {
//     if (!(await Geolocator().isLocationServiceEnabled())) {
//       if (Theme.of(context).platform == TargetPlatform.android) {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text("Can't get gurrent location"),
//               content:const Text('Please make sure you enable GPS and try again'),
//               actions: <Widget>[
//                 FlatButton(child: Text('Ok'),
//                   onPressed: () {
//                     final AndroidIntent intent = AndroidIntent(
//                         action: 'android.settings.LOCATION_SOURCE_SETTINGS');
//                     intent.launch();
//                     Navigator.of(context, rootNavigator: true).pop();
//                     _gpsService();
//                   },
//                 ),
//               ],
//             );
//           },
//         );
//       }}}
// /*Check if gps service is enabled or not*/
//   Future _gpsService() async {
//     if (!(await Geolocator().isLocationServiceEnabled())) {
//       _checkGps();
//       return null;
//     } else
//       return true;
//   }




  double userrate;
  String name;

  checkStorge() async {
    ClientModel clientModel =
        ClientModel.fromJson(await readerItem("ClientModels"));
    setState(() {
      model = clientModel;
      name = clientModel.name;
    });
  }

  LatLng currentLocation;

  String myLat, myLong;
  Location location = new Location();

  getlocations() async {
    location.getLocation().then((loc) {
      currentLocation = LatLng(loc.latitude, loc.longitude);
      myLong = loc.longitude.toString();
      myLat = loc.latitude.toString();
    });
  }

  goTosecandpage() async {

    location.getLocation().then(
      (loc) {
        currentLocation = LatLng(loc.latitude, loc.longitude);
        myLong = loc.longitude.toString();
        myLat = loc.latitude.toString();
        print('$myLong - $myLat');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext ctx) => MapFirstWidget(
              widget.model,
              widget.order,
              loc.latitude.toString(),
              loc.longitude.toString(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //---------AppBar---------------------------------
      drawer: MyDrawer(),
      appBar: AppBar(
        //  automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(116, 189, 242, 1.0),
        title: ImageIcon(AssetImage('assets/onlyiconlogo.png'), size: 50),
        centerTitle: true,
        // actions:<Widget>[IconButton(icon: Icon(Icons.arrow_forward_ios,size: 25,), onPressed: (){Navigator.pop(context);})]
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/homepagecar.png'),
              Text(
                AppLocalizations.of(context).replaceorder,
                style: TextStyle(color: Colors.black45),
              ),
              Container(
                width: 130,
                child: RaisedButton(
                  child: Text(AppLocalizations.of(context).start),
                  onPressed: () {
                    goTosecandpage();
                  },
                  textColor: Colors.white,
                  color: Color.fromRGBO(116, 189, 242, 1.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
