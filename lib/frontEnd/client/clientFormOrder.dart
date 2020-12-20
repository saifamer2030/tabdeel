//FourthHomeWidget
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tabdeel/BackEnd/models/client_model.dart';
import 'package:tabdeel/BackEnd/models/order_model.dart';
import 'package:tabdeel/BackEnd/order_api.dart';
import 'package:tabdeel/BackEnd/shared.dart';
import 'package:tabdeel/BackEnd/shared_prefrences.dart';
import 'package:tabdeel/frontEnd/client/cleintTabs.dart';
import 'package:tabdeel/frontEnd/client/client_drawer.dart';
import 'package:tabdeel/frontEnd/client/product_form.dart';
import 'package:tabdeel/localizations.dart';
import 'package:tabdeel/tooles/print.dart';
import 'package:toast/toast.dart';


class SecondPageData1 extends StatefulWidget {

  final ClientModel model;
  final ClientOrder order;
  final String shopId,shopname;

  SecondPageData1(this.model,this.order,this.shopId,this.shopname);
  @override
  _SecondPageData1State createState() => _SecondPageData1State();
}

class _SecondPageData1State extends State<SecondPageData1> {
  
     
  List<ProductsDetails> myProducts = [
    ProductsDetails(ClientOrderDetails(
        billImage: null,
        deservedMoney: null,
        newSize: null,
        notes: null,
        oldSize: null,
        orderType: null,
        productName: null, color: null))
  ];

  ClientModel clientModel;

  loadSharedPrefs() async {
    try {
      ClientModel user = ClientModel.fromJson(await readerItem("ClientModels"));
      setState(() {
        clientModel = user;
        printBlue(clientModel);
      });
    } catch (Excepetion) {
      // do something
    }
  }

  bool connectionEnded = false;
  bool loading=false;
String cost;
  calculateDestance() {
    setState(() {
      loading=true;
    });
    setTimeAndDistance(widget.order.clientLat, widget.order.clientLng,
            widget.order.shopLat, widget.order.shopLng)
        .then((response) {
          setState(() {
      loading=false;
    });
      var extractdata = json.decode(response.body);
      printGreen(json.decode(response.body));
      if (extractdata['status'] == 'OK') {
        setState(() {
          var data = extractdata['rows'][0]['elements'];
          if (data[0]['status'] == 'OK') {
            printBlue(data);
            widget.order.deliveryTime =
                (data[0]['duration']['text'].split(' ')[0]).toString();
            widget.order.distance =
                (double.parse(data[0]['distance']['text'].split(' ')[0]) *
                        1.60934)
                    .toString();
            // homeWidget.order.deliveryCost = homeWidget.order.distance * 2+10;
            getDeliveryConstants().then((data) {
              printRed(data.body);
              setState(() {
                
             
              var res = json.decode(data.body);
              var kiloprice = res['kiloPrice'];
              cost=((double.parse(widget.order.distance) *
                              double.parse(kiloprice)) +
                          10.0)
                      .toString();
              widget.order.deliveryCost =
                  ((double.parse(widget.order.distance) *
                              double.parse(kiloprice)) +
                          10.0)
                      .toString();
              print(widget.order.deliveryCost);
               });
            });
          }
        });
      } else {
        printRed("error ");
      }
    });
  }

 var timeendController = TextEditingController();
  alertConfirmSendOrder(BuildContext context) {
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
         widget.order.shopID=widget.shopId;
         widget.order.pendingTime=timeendController.text;
         widget.order.shopName=widget.shopname;
         if(timeendController.text==''||timeendController.text==null)
         {
            Toast.show(
              'وقت انهاء الطلب مطلوب', context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.CENTER,
              backgroundColor: Colors.grey);
         }
         else{
        createOrder(widget.order).then( (val) {
          // var mes = json.decode(val.body);
          // showAlertDialog(context, mes['message']);
           Toast.show(
              'تمت اضافة المنتج بنجاح الرجاء انتظار قبول الطلب', context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.CENTER,
              backgroundColor: Colors.grey);
           Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => ClientHome1()),
              (Route<dynamic> route) => false,
            );
        }).catchError((e) {
          Toast.show("كل البيانات مطلوبة", context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.CENTER,
              backgroundColor: Colors.grey);
          print('ErrorOrder:$e');
           setState(() {
            connectionEnded = false;
          });
        }).whenComplete(() {
          setState(() {
            connectionEnded = false;
          });
        });
        Navigator.pop(context);
        // widget.setState(() {
          // homeIndex = 0;
         
        // });
      }},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
       shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
   
      content:new Container(
        height: 130,
        child: Column(children: <Widget>[
      Text(
       AppLocalizations.of(context).confirmorder,
        textAlign: TextAlign.right,
      ),
SizedBox(height: 5,),
       TextField(
          keyboardType: TextInputType.number,
          controller: timeendController,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              hintText: AppLocalizations.of(context).timedend,
              hintStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.grey[300]),
        ),
SizedBox(height: 5,),
      Center(child:
      cost==null||cost==''?new Text(''):new Text(AppLocalizations.of(context).costdelvered+" : "+(double.parse(cost).toStringAsFixed(2)).toString() + ' ريال ' , style: TextStyle(color: Colors.red),)
      )]),
      ),actions: [
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
  void initState() {
    super.initState();
    loadSharedPrefs();
    calculateDestance();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        
         //---------AppBar---------------------------------
        drawer: MyDrawer(),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(116, 189, 242, 1.0),
          title: ImageIcon(AssetImage('assets/onlyiconlogo.png'), size: 50),
          centerTitle: true,
          actions:<Widget>[IconButton(icon: Icon(Icons.arrow_forward_ios,size: 25,), onPressed: (){Navigator.pop(context);})]
        ),
        body:
    ListView(children: <Widget>[
      // child:
      Container(
          padding: EdgeInsets.all(10),
         
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                //ListOfProducts

                Container(
                  height: 280,
                  padding: EdgeInsets.only(top: 5),
                  child: ListView.builder(
                    itemCount: myProducts.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: <Widget>[
                          myProducts[index],
                          (index != myProducts.length - 1)
                              ? Divider()
                              : Container()
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            myProducts.add(ProductsDetails(ClientOrderDetails(
                                billImage: null,
                                deservedMoney: null,
                                newSize: null,
                                notes: null,
                                oldSize: null,
                                orderType: null,
                                productName: null, color: null)));

                            setState(() {});
                          },
                          child: Icon(
                            Icons.add_circle_outline,
                            color: Colors.grey,
                            size: 30,
                          ),
                        ),
                        Text(
                         AppLocalizations.of(context).addprodect,
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            myProducts.removeAt(myProducts.length - 1);

                            setState(() {});
                          },
                          child: Icon(
                            Icons.remove_circle_outline,
                            color: Colors.grey,
                            size: 30,
                          ),
                        ),
                        Text(
                        AppLocalizations.of(context).deletdproduct, 
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                        )
                      ],
                    ),
                  ],
                ),

                SizedBox(
                  height: 5,
                ),
                (connectionEnded == false)
                    ? Container()
                    : Center(
                        child: CircularProgressIndicator(
                            backgroundColor: Color.fromRGBO(116, 189, 242, 1.0),
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                Colors.white)),
                      ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: 130,
                  child: RaisedButton(
                    child: Text(AppLocalizations.of(context).next),
                    onPressed: () {
                      setState(() {
                        connectionEnded = true;
                      });
                      List<ClientOrderDetails> clientOrders = [];
                      myProducts.forEach((v) {
                        clientOrders.add(v.orderDetails);
                      });

                      widget.order.orders = clientOrders;
                      widget.order.flag = "1";
                    

                     if (clientOrders[0].orderType == 'null' ||
                          clientOrders[0].orderType == null ||
                          clientOrders[0].orderType == '' ||
                          clientOrders[0].orderType == '0') {

                            if (clientOrders[0].productName == 'null' ||
                            clientOrders[0].productName == null ||
                            clientOrders[0].productName == '') {
                          showAlertDialog(context, "اسم المنتج مطلوب");
                        }
                        else if (clientOrders[0].oldSize == 'null' ||
                            clientOrders[0].oldSize == null ||
                            clientOrders[0].oldSize == '') {
                          showAlertDialog(context, "المقاس القديم مطلوب");
                        } else if (clientOrders[0].newSize == 'null' ||
                            clientOrders[0].newSize == null ||
                            clientOrders[0].newSize == '') {
                          showAlertDialog(context, "المقاس الجديد مطلوب");
                        } else if (clientOrders[0].billImage == 'null' ||
                            clientOrders[0].billImage == null ||
                            clientOrders[0].billImage == '') {
                          showAlertDialog(context, "صورة الفاتورة مطلوبة");
                        } else if (clientOrders[0].color == 'null' ||
                            clientOrders[0].color == null ||
                            clientOrders[0].color == '') {
                          showAlertDialog(context, "لون المنتج مطلوب");
                        } else {
                          alertConfirmSendOrder(context);
                        }
                      } else if (clientOrders[0].orderType == '1') {
                       if (clientOrders[0].productName == 'null' ||
                            clientOrders[0].productName == null ||
                            clientOrders[0].productName == '') {
                          showAlertDialog(context, "اسم المنتج مطلوب");
                        }
                        else if (clientOrders[0].billImage == 'null' ||
                            clientOrders[0].billImage == null ||
                            clientOrders[0].billImage == '') {
                          showAlertDialog(context, "صورة الفاتورة مطلوبة");
                        } else if (clientOrders[0].deservedMoney == 'null' ||
                            clientOrders[0].deservedMoney == null ||
                            clientOrders[0].deservedMoney == '') {
                          showAlertDialog(context, "المبغ المستحق مطلوب");
                        } else {
                          alertConfirmSendOrder(context);
                        }
                      }
                    },
                    
                    textColor: Colors.white,
                    color: Color.fromRGBO(116, 189, 242, 1.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                ),

                SizedBox(height: 20,),
              loading==true?Center(
                          child: CircularProgressIndicator(
                              backgroundColor:
                                  Color.fromRGBO(116, 189, 242, 1.0),
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.white)),
                        ):cost==null||cost==''?new Text(''):new Text(AppLocalizations.of(context).costhisorder +(double.parse(cost).toStringAsFixed(2)).toString() + ' ريال ' , style: TextStyle(color: Colors.red),)
            , SizedBox(
                  height: 400,
                ),
              ],
            ),
          )
    ]));
  }
}
