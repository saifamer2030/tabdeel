import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:tabdeel/BackEnd/models/driver_model.dart';
import 'package:tabdeel/BackEnd/order_api.dart';
import 'package:tabdeel/BackEnd/shared_prefrences.dart';
import 'package:tabdeel/frontEnd/client/tracking.dart';
import 'package:tabdeel/frontEnd/driver/trackingdriver.dart';
import 'package:tabdeel/frontEnd/driver/viewImage.dart';
import 'package:tabdeel/localizations.dart';
import 'package:tabdeel/tooles/print.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../signup.dart';
import 'client_rate.dart';
import 'order_chat.dart';

class DeliveryDetalse extends StatefulWidget {
  final String driverName,
      orderID,
      orderDate,
      shopName,
      deliveryTime,
      orderStatusNumber,
      orderStatus,
      shopLon,
      shopLat,
      distance,
      deliverCost,
      productsNames,
      productsNotes,
      clientLon,
      clientLat,
      clientID,
      driverId,
      oldsize,
      newsize,
      color,
      bilsImages;

  const DeliveryDetalse(
      this.driverName,
      this.orderID,
      this.orderDate,
      this.shopName,
      this.deliveryTime,
      this.orderStatusNumber,
      this.orderStatus,
      this.shopLon,
      this.shopLat,
      this.distance,
      this.deliverCost,
      this.productsNames,
      this.productsNotes,
      this.clientLon,
      this.clientLat,
      this.clientID,
      this.driverId,
      this.oldsize,
      this.newsize,
      this.color,
      this.bilsImages);

  @override
  _OrderNewDetalseState createState() => _OrderNewDetalseState();
}

class _OrderNewDetalseState extends State<DeliveryDetalse> {
  LatLng currentLocation;
  Location location = new Location();
  double distance=0.0;

  String textcancel = 'رفض الطلب';
  bool statusButtom = true;
  bool connectionEnded = false;
  String textconfirm = 'قبول الطلب';
  String textend = 'إنهاء الطلب';

  showAlertDialogConfirm(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("لا"),
      onPressed: () {
        Navigator.pop(context);
      },
        );
    Widget continueButton = FlatButton(
      child: Text("تأكيد"),
      onPressed: () {
        setState(() {
          connectionEnded = true;
        });
        driverAccpetOrder(widget.orderID, driverModel.driverID.toString())
            .then((res) {
          setState(() {
            textconfirm = 'تم قبول الطلب';
            statusButtom = false;
            connectionEnded = false;
          });
          printBlue(res.body);
          Toast.show(json.decode(res.body)['message'], context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.CENTER,
              backgroundColor: Colors.grey);
        });
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(
        "تأكيد قبول الطلب ؟",
        textAlign: TextAlign.right,
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("لا"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("تأكيد"),
      onPressed: () {
        setState(() {
          connectionEnded = true;
        });
        drivercancelOrder(widget.orderID).then((res) {
          printBlue(res.body);
          setState(() {
            textcancel = 'تم رفض الطلب';
          });
          Toast.show(json.decode(res.body)['message'], context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.CENTER,
              backgroundColor: Colors.grey);
        });
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(
        "تأكيد إلغاء الطلب ؟",
        textAlign: TextAlign.right,
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  String invoicePicture = '';
  File _image;

  imageInvoice(image) async {
    await encodeImage(image).then((im) {
      invoicePicture = base64Encode(im);
      printBlue(invoicePicture);
    });
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    imageInvoice(_image);
  }

  showAlertDialogEnd(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("لا"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("تأكيد"),
      onPressed: () {
        setState(() {
          connectionEnded = true;
        });

        driverEndOrder(widget.orderID, invoicePicture).then((res) {
          printBlue(res.body);
          setState(() {
            textend = 'تم إنهاء الطلب';
          });
          Toast.show(json.decode(res.body)['message'], context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.CENTER,
              backgroundColor: Colors.grey);
        });

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext ctx) => ClientRateing(widget.clientID)));

        // Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: new Container(
          height: 180,
          child: new Column(
            children: <Widget>[
              RaisedButton(
                child: Text('صورة الفاتورة'),
                onPressed: () {
                  getImage();
                },
              ),
              (_image == null)
                  ? Image.asset(
                      'assets/onlyiconlogo.png',
                      height: 80,
                    )
                  : Image.file(
                      _image,
                      height: 80,
                    ),
              Text(
                "قم بإرقاق صورة الفاتورة لتأكيد أنهاء الطلب .",
                textAlign: TextAlign.center,
              ),
            ],
          )),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

// String myLat,myLong;
  Future<void> openMaps(BuildContext context, String cLatitude,
      String cLongitude, String sLatitude, String sLongitude)  async {

      //    location.getLocation().then((loc) {
      // currentLocation = LatLng(loc.latitude, loc.longitude);
      //          myLong=loc.longitude.toString();
      //           myLat=loc.latitude.toString();
      //    });
    TargetPlatform platform = Theme.of(context).platform;
    if (platform == TargetPlatform.iOS) {
      Uri uri = Uri.https('maps.apple.com', '/',
          {'ll': '$cLatitude,$cLongitude/$sLatitude,$sLongitude/@$cLatitude,$cLongitude', 'z': '19.5', 'q': ''});
      launch(uri.toString());
    } else {
      print(
          'https://www.google.com/maps/dir/$cLatitude,$cLongitude/$sLatitude,$sLongitude/@$cLatitude,$cLongitude,15z');
      String androidUrl =
          'https://www.google.com/maps/dir/$cLatitude,$cLongitude/$sLatitude,$sLongitude/@$cLatitude,$cLongitude,15z';
       if (await canLaunch(androidUrl)) {
           launch(androidUrl);
       } else {
         throw 'Could not open the map.';
       }
    }
  }

  @override
  void initState() {
    super.initState();
    loadSharedPrefs();
    printBlue(widget.driverName.toString());
    LatLng currentLocation1 =
        LatLng(double.parse(widget.clientLat), double.parse(widget.clientLon));
    _markers
        .add(Marker(markerId: MarkerId('shop'), position: currentLocation1));

    LatLng currentLocation2 =
        LatLng(double.parse(widget.shopLat), double.parse(widget.shopLon));
    _markers1
        .add(Marker(markerId: MarkerId('shop'), position: currentLocation2));

    double lat2=double.parse(widget.clientLat);
    double  lon2= double.parse(widget.clientLon);
    double lat1=double.parse(widget.shopLat);
    double  lon1= double.parse(widget.shopLon);

    var pi = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * pi) / 2 +
        c(lat1 * pi) * c(lat2 * pi) * (1 - c((lon2 - lon1) * pi)) / 2;
    distance= 12742 * asin(sqrt(a));
  //   getShopAddress();
  //   location.getLocation().then((loc) {
  //     currentLocation = LatLng(loc.latitude, loc.longitude);
  //     getAddress(loc.latitude.toString(), loc.longitude.toString());

  //     print('CurrentLoc:${currentLocation.toString()}');
  //   });
  }

//   var myaddress = '', shopAddress = '';
//   getAddress(driverLat, driverLong) async {
//     final coordinates =
//         new Coordinates(double.parse(driverLat), double.parse(driverLong));
// // final coordinates = new Coordinates(31.2, 27.1);
//     var addresses =
//         await Geocoder.local.findAddressesFromCoordinates(coordinates);
//     setState(() {
//       myaddress = addresses.first.featureName.toString();
//     });
//   }

  // getShopAddress() async {
  //   final coordinates = new Coordinates(
  //       double.parse(widget.shopLat), double.parse(widget.shopLon));
  //   var addresses =
  //       await Geocoder.local.findAddressesFromCoordinates(coordinates);
  //   setState(() {
  //     shopAddress = addresses.first.featureName.toString();
  //   });
  // }

  DriverModel driverModel;
  loadSharedPrefs() async {
    try {
      DriverModel user = DriverModel.fromJson(await readerItem("DriverModels"));
      setState(() {
        driverModel = user;
        printBlue(driverModel);
      });
    } catch (Excepetion) {
      // do something
    }
  }

  final Set<Marker> _markers ={};
  final Set<Marker> _markers1 = {};
  GoogleMapController mapController;
  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(116, 189, 242, 1.0),
          title: new Center(child:Text(widget.shopName + AppLocalizations.of(context).shop)),
          centerTitle: true,
        ),
        body: Container(
            child: Directionality(
                textDirection: TextDirection.rtl,
                child: ListView(
                  children: <Widget>[
                    ListTile(
                        leading: Image.asset('assets/product.png'),
                        title: Text(
                          widget.productsNames,
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
                              AppLocalizations.of(context).dateorder +" : " +
                                  widget.orderDate.split(" ")[0],
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 12),
                            )
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              Icons.person,
                              size: 20,
                            ),
                            Text(
                              widget.driverName,
                              style: TextStyle(fontSize: 13),
                            )
                          ],
                        )),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 30, 20, 0),
                            color: Colors.white,
                            // height: 150,
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 15,
                                ),

Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.format_size,
                                          color: Colors.black87,
                                        ),
                                        Text(
                                          AppLocalizations.of(context).oldsize,
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                      
                                            Text(widget.oldsize),
                                        
                                       

                                      ],
                                    ),
                                  ],
                                ),
 SizedBox(height: 3,),
                                 Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.format_size,
                                          color: Colors.black87,
                                        ),
                                        Text(
                                         AppLocalizations.of(context).newsize,
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                      
                                            Text(widget.newsize),
                                        
                                       

                                      ],
                                    ),
                                SizedBox(height: 3,),

 Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.collections,
                                          color: Colors.black87,
                                        ),
                                        Text(
                                         AppLocalizations.of(context).ordercolor,
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                      
                                            Text(widget.color),
                                        
                                       

                                      ],
                                    ),
                                   SizedBox(height: 3,),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        openMaps(
                                            context,
                                            widget.clientLat,
                                            widget.clientLon,
                                            widget.shopLat,
                                            widget.shopLon);
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.location_on,
                                            color: Colors.black87,
                                          ),
                                          Text(
                                           AppLocalizations.of(context).from+" "+AppLocalizations.of(context).clientsite,
                                            style:
                                                TextStyle(color: Colors.black54),
                                          ),
                                         // InkWell(
                                         //    onTap: () {
                                         //      openMaps(
                                         //          context,
                                         //          widget.clientLat,
                                         //          widget.clientLon,
                                         //          widget.shopLat,
                                         //          widget.shopLon);
                                         //    },
                                         //    child: Text(AppLocalizations.of(context).determinmap),
                                         //  ),
                                          // Icon(
                                          //   Icons.location_on,
                                          //   color: Colors.blue[100],
                                          // )

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5,),
                                new Container(
                                  // color: Colors.red,
                                  height: 130,
                                  child: GoogleMap(
                                    onTap: (pos) {
                                      // _markers.clear();
                                      // _markers.add(Marker(
                                      //     markerId: MarkerId('shop'),
                                      //     position: pos));
                                      //  openMaps(context,widget.clientLat,widget.clientLon,widget.shopLat,widget.shopLon);

                                      // setState(() {
                                      //   openMaps(
                                      //       context,
                                      //       widget.clientLat,
                                      //       widget.clientLon,
                                      //       widget.shopLat,
                                      //       widget.shopLon);
                                      // });
                                    },
                                    onMapCreated: _onMapCreated,
                                    initialCameraPosition: CameraPosition(
                                      target: LatLng(
                                          double.parse(widget.clientLat),
                                          double.parse(widget.clientLon)),
                                      zoom: 10.0,
                                    ),
                                    markers: _markers,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        openMaps(
                                            context,
                                            widget.clientLat,
                                            widget.clientLon,
                                            widget.shopLat,
                                            widget.shopLon);
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.location_on,
                                            color: Colors.black87,
                                          ),
                                          Text(
                                           AppLocalizations.of(context).to+" "+AppLocalizations.of(context).shoplocation,
                                            style:
                                                TextStyle(color: Colors.black54),
                                          ),
                                          // InkWell(
                                          //   onTap: () {
                                          //     openMaps(
                                          //         context,
                                          //         widget.shopLat,
                                          //         widget.shopLon,
                                          //         widget.clientLat,
                                          //         widget.clientLon);
                                          //   },
                                          //   child: Text(AppLocalizations.of(context).determinmap),
                                          // ),
                                          SizedBox(height: 3,)
                                          // Icon(
                                          //   Icons.location_on,
                                          //   color: Colors.blue[100],
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                new Container(
                                  // color: Colors.red,
                                  height: 130,
                                  child: GoogleMap(
                                    onTap: (pos) {
                                      // _markers.clear();
                                      // _markers.add(Marker(
                                      //     markerId: MarkerId('shop'),
                                      //     position: pos));

                                      // setState(() {
                                      //   openMaps(
                                      //       context,
                                      //       widget.shopLat,
                                      //       widget.shopLon,
                                      //       widget.clientLat,
                                      //       widget.clientLon);
                                      // });
                                    },
                                    onMapCreated: _onMapCreated,
                                    initialCameraPosition: CameraPosition(
                                      target: LatLng(
                                          double.parse(widget.shopLat),
                                          double.parse(widget.shopLon)),
                                      zoom: 10.0,
                                    ),
                                    markers: _markers1,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TrackingDreiver(  widget.shopLat,
                                                    widget.shopLon,
                                                    widget.clientLat,
                                                    widget.clientLon,widget.driverId,widget.orderID)));
                                    // openMaps(
                                    //     context,
                                    //     widget.shopLat,
                                    //     widget.shopLon,
                                    //     widget.clientLat,
                                    //     widget.clientLon);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: Colors.black87,
                                          ),
                                          Text(AppLocalizations.of(context).determinmap),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.mode_edit,
                                      color: Colors.black87,
                                    ),
                                    Text(
                                      AppLocalizations.of(context).nots+" : " + widget.productsNotes,
                                      style: TextStyle(color: Colors.black54),
                                    )
                                  ],
                                ),
                                 Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.image,
                                      color: Colors.black87,
                                    ),
                                    Text(
                                      AppLocalizations.of(context).imagbill,
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                    
                                  ],
                                ),
                               widget.bilsImages==null||widget.bilsImages==''?Text('لم يحدد بعد'):InkWell( 
                                 onTap: (){
                                    Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext ctx) => ViewImage(widget.bilsImages,widget.shopName)));
                                 },
                                 child: Image.network(
                                      
                                
                                     
                                     widget.bilsImages,
                                     width:200,
                                     height: 150,
                                    )
                               )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                            height: 25,
                            width: 120,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              AppLocalizations.of(context).order_details,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 18),
                            ),
                          )
                        ],
                      ),
                    ),
                    
                     
                    
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(8, 30, 20, 0),
                            color: Colors.white,
                            height: 90,
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.local_offer,
                                      color: Colors.black87,
                                    ),
                                    Text(
                                      ((distance*3+10).toStringAsFixed(2)).toString() + ' ريال ',
                                      style: TextStyle(color: Colors.black54),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                            height: 25,
                            width: 120,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                             AppLocalizations.of(context).ordercost +" : ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 18),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        widget.orderStatusNumber == '1'
                            ? new Row(children: <Widget>[
                                RaisedButton(
                                  child: Text(textcancel),
                                  color: Colors.red,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    showAlertDialog(context);
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                RaisedButton(
                                  child: Text(textconfirm),
                                  color: Colors.green,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    showAlertDialogConfirm(context);
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                )
                              ])
                            : widget.orderStatusNumber == '3'
                                ? new Row(
                                    children: <Widget>[
                                      RaisedButton(
                                        child: Text(textend),
                                        color: Colors.green,
                                        textColor: Colors.white,
                                        onPressed: () {
                                          showAlertDialogEnd(context);
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      RaisedButton(
                                        child: new Row(
                                          children: <Widget>[
                                            Icon(Icons.chat),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(AppLocalizations.of(context).clientchat),
                                          ],
                                        ),
                                        color: Colors.blue[200],
                                        textColor: Colors.white,
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext ctx) =>
                                                      DriverChatClientOrder(
                                                          widget.clientID,
                                                          '')));
                                        },
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                      )
                                    ],
                                  )
                                : new Text(
                                    AppLocalizations.of(context).clientchat,
                                    style: TextStyle(color: Colors.red),
                                  )
                      ],
                    ),
                  ],
                ))));
  }
}
