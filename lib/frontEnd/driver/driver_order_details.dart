import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:tabdeel/BackEnd/models/driver_model.dart';
import 'package:tabdeel/BackEnd/order_api.dart';
import 'package:tabdeel/BackEnd/shared_prefrences.dart';
import 'package:tabdeel/localizations.dart';
import 'package:tabdeel/tooles/print.dart';
import 'package:toast/toast.dart';
import '../signup.dart';
import 'client_rate.dart';
import 'order_chat.dart';

class OrderNewDetalse extends StatefulWidget {
  final String driverName,
      orderID,
      orderDate,
      shopName,
      deliveryTime,
      orderStatusNumber,
      orderStatus,
      distance,
      deliverCost,
      clientId;

  const OrderNewDetalse(
      this.driverName,
      this.orderID,
      this.orderDate,
      this.shopName,
      this.deliveryTime,
      this.orderStatusNumber,
      this.orderStatus,
     
      this.distance,
      this.deliverCost,
     this.clientId);

  @override
  _OrderNewDetalseState createState() => _OrderNewDetalseState();
}

class _OrderNewDetalseState extends State<OrderNewDetalse> {
  LatLng currentLocation;
   Location location = new Location();

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
  @override
  void initState() {
    super.initState();
    
     location.getLocation().then((loc) {
      currentLocation = LatLng(loc.latitude, loc.longitude);
      print('CurrentLoc:${currentLocation.toString()}');
     });
   
   
  }



String invoicePicture='';
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
    onPressed:  () {
       Navigator.pop(context);
    },
  );
  Widget continueButton = FlatButton(
    child: Text(AppLocalizations.of(context).confirm),
    onPressed:  () {
       setState(() {
                          connectionEnded = true;
                        });
                        printGreen(invoicePicture);
                                      driverEndOrder(widget.orderID,invoicePicture)
                                          .then((res) {
                                        printBlue(res.body);
 setState(() {
                 
                 textend=AppLocalizations.of(context).endoreders;
               });
                                        Toast.show(
                                            json.decode(res.body)['message'],
                                            context,
                                            duration: Toast.LENGTH_LONG,
                                            gravity: Toast.CENTER,
                                            backgroundColor: Colors.grey);
                                      });


 Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext ctx) =>
                                          ClientRateing(widget.clientId
                                            
      ))); 
                                          
                            // Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    content:new Container(
      height: 180,
      child:new Column(children: <Widget>[
       RaisedButton(
        child: Text(AppLocalizations.of(context).imagbill),
        onPressed: () {
         getImage();
        },
      ),
       (_image == null)
                              ? Image.asset('assets/onlyiconlogo.png',height: 80,)
                              : Image.file(_image,height: 80,),
Text(AppLocalizations.of(context).addimagebill,textAlign: TextAlign.center,),
     ],)),
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
  
    String textcancel = 'إلغاء الطلب';
  bool statusButtom = true;
  bool connectionEnded = false;
  String textconfirm='قبول الطلب';
  String textend='إنهاء الطلب';

showAlertDialogConfirm(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(AppLocalizations.of(context).no),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text(AppLocalizations.of(context).confirm),
      onPressed: () {
        setState(() {
          connectionEnded = true;
        });
        driverAccpetOrder(widget.orderID,  driverModel.driverID.toString())
            .then((res) {
                setState(() {
                              textconfirm=AppLocalizations.of(context).confirmacceptorder;
                              statusButtom=false;
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
        AppLocalizations.of(context).confirmacceptorder+' ? ',
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
      child: Text(AppLocalizations.of(context).no),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text(AppLocalizations.of(context).confirm),
      onPressed: () {
        setState(() {
          connectionEnded = true;
        });
        drivercancelOrder(widget.orderID).then((res) {
          printBlue(res.body);
               setState(() {
                 
                 textcancel='تم إلغاء الطلب';
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
        AppLocalizations.of(context).confirmcancel,
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






 
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(116, 189, 242, 1.0),
          title: ImageIcon(AssetImage('assets/onlyiconlogo.png'), size: 70),
          centerTitle: true,
        ),
        body: Container(
            child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  children: <Widget>[
                    ListTile(
                        leading: Image.asset('assets/product.png'),
                        title: Text(
                          widget.shopName,
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
                              ' تاريخ الإنشاء : ' +
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
                          // Container(
                          //   padding: EdgeInsets.fromLTRB(10, 30, 20, 0),
                          //   color: Colors.white,
                          //   height: 150,
                          //   child: Column(
                          //     children: <Widget>[
                          //       SizedBox(
                          //         height: 5,
                          //       ),
                          //       Row(
                          //         mainAxisAlignment:
                          //             MainAxisAlignment.spaceBetween,
                          //         children: <Widget>[
                          //           Row(
                          //             children: <Widget>[
                          //               Icon(
                          //                 Icons.location_on,
                          //                 color: Colors.black87,
                          //               ),
                          //               Text(
                          //                 'من (موقعك) :'+myaddress,
                          //                 style:
                          //                     TextStyle(color: Colors.black54),
                          //               )
                          //             ],
                          //           ),
                          //         ],
                          //       ),
                          //       SizedBox(
                          //         height: 5,
                          //       ),
                          //       Row(
                          //         mainAxisAlignment:
                          //             MainAxisAlignment.spaceBetween,
                          //         children: <Widget>[
                          //           Row(
                          //             children: <Widget>[
                          //               Icon(
                          //                 Icons.location_on,
                          //                 color: Colors.black87,
                          //               ),
                          //               Text(
                          //                 'الى : '+shopAddress,
                          //                 style:
                          //                     TextStyle(color: Colors.black54),
                          //               )
                          //             ],
                          //           ),
                          //         ],
                          //       ),
                          //       SizedBox(
                          //         height: 5,
                          //       ),
                          //       Row(
                          //         children: <Widget>[
                          //           Icon(
                          //             Icons.mode_edit,
                          //             color: Colors.black87,
                          //           ),
                          //           Text(
                          //             'ملاحظات : '+widget.productsNotes,
                          //             style: TextStyle(color: Colors.black54),
                          //           )
                          //         ],
                          //       )
                          //     ],
                          //   ),
                          // ),
                        
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                            height: 25,
                            width: 120,
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              '',
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
                                      widget.deliverCost==''?'لم يحدد بعد':widget.deliverCost,
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
                              'تكلفة التوصيل',
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
                                ? 
                              new Row(children: <Widget>[
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
                                  
                                  SizedBox(width: 5,),
                                   RaisedButton(
                                    child:new Row(children: <Widget>[
                                     Icon(Icons.chat),SizedBox(width: 2,),
                                     Text('مراسلة العميل'),
                                    ],) ,
                                    color: Colors.blue[200],
                                    textColor: Colors.white,
                                    onPressed: () {
                                      Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext ctx) =>
                                     DriverChatClientOrder(widget.clientId,'')));
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  )
                              ],)
                                : new Text(
                                    'لقد تم  إلغاء هذا الطلب من قبل',
                                    style: TextStyle(color: Colors.red),
                                  )
                      ],
                    ),
                 
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: <Widget>[
              //           // RaisedButton(
              //           //   child: Text('قبول'),
              //           //   color: Colors.green,
              //           //   textColor: Colors.white,
              //           //   onPressed: () {},
              //           //   shape: RoundedRectangleBorder(
              //           //       borderRadius: BorderRadius.circular(20)),
              //           // ),
              //           // SizedBox(
              //           //   width: 20,
              //           // ),
              //          widget.orderStatusNumber=='1'?RaisedButton(
              //             child: Text('إلغاء الطلب'),
              //             color: Colors.red,
              //             textColor: Colors.white,
              //             onPressed: () {
              //               cancelOrder(widget.orderID).then((res) {
              //                 printBlue(res.body);
                              
              //                  Toast.show(json.decode(res.body)['message'], context,
              // duration: Toast.LENGTH_LONG,
              // gravity: Toast.CENTER,
              // backgroundColor: Colors.grey);
              //               });
              //             },
              //             shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(20)),
              //           ):new Text(widget.orderStatus,
              //          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)
              //         ],
              //       ),
                  
                  ],
                ))),
    //                floatingActionButton: FloatingActionButton.extended(
    //   onPressed: () {
    //     printBlue(widget.clientId);
        
    //    Navigator.of(context).push(MaterialPageRoute(
    //                                   builder: (context)=>
    //                                   DriverChatClientOrder(widget.clientId,'')
    //                                 ));
    //   },
    //   label: Text(' مراسلة العميل'),
    //   icon: Icon(Icons.chat),
    //   backgroundColor: Color.fromRGBO(110, 180, 240, 1.0),
    // ),
                );
  }
}
