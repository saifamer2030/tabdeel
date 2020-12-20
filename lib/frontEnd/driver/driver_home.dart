import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabdeel/BackEnd/driver_auth.dart';
import 'package:tabdeel/BackEnd/models/driver_model.dart';
import 'package:tabdeel/BackEnd/models/order_model.dart';
import 'package:tabdeel/BackEnd/shared_prefrences.dart';
import 'package:tabdeel/localizations.dart';

import 'deiverDrawer.dart';
import 'driver_deliveries.dart';
import 'driver_message.dart';
import 'driver_notifications.dart';
import 'driver_offers.dart';
import 'driver_stores.dart';

class DriverHome1 extends StatefulWidget {
  @override
  _HomePage1State createState() => _HomePage1State();
}

class _HomePage1State extends State<DriverHome1> {
  void initState() {
    super.initState();

    setState(() {
      checkStorge();
    });
  }

  checkStorge() async {
    DriverModel driverModel =
        DriverModel.fromJson(await readerItem("DriverModels"));
    setState(() {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => DriverHome(driverModel)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class DriverHome extends StatefulWidget {
  final DriverModel model;

  final ClientOrder newOrder = ClientOrder(
      clientID: null,
      clientLat: null,
      clientLng: null,
      orders: null,
      shopLat: null,
      shopLng: null,
      flag: null,
      deliveryCost: null,
      deliveryTime: null,
      distance: null,
      shopID: null,
      shopName: null,
      pendingTime: null);

  DriverHome(this.model) {
    newOrder.clientID = model.driverID.toString();
  }

  @override
  _HomePageState createState() => _HomePageState(this.model, this.newOrder);
}

class _HomePageState extends State<DriverHome> {
  ClientOrder order;

  DriverModel model;

  _HomePageState(this.model, this.order);

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void initState() {
    super.initState();
    userDetails();
    setState(() {
      checkStorge();
    });
  }

  String name = '';
  double userrate;

  userDetails() async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString('userId'));

    driverDetails(prefs.getString('userId')).then((data) {
      print(data.body);
      var result = json.decode(data.body);
      print(result['rate']);
      userrate = double.parse(result['rate'].toString());
    });
  }

  checkStorge() async {
    DriverModel driverModel =
        DriverModel.fromJson(await readerItem("DriverModels"));
    setState(() {
      model = driverModel;
      // order.clientID = model.driverID.toString();
      name = driverModel.name;

      //  print(driverModel.rate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        drawer: MyDriverDrawer(),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(116, 189, 242, 1.0),
          title: ImageIcon(AssetImage('assets/onlyiconlogo.png'), size: 50),
          centerTitle: true,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
                backgroundColor: Color.fromRGBO(116, 189, 242, 1.0),
                // icon: ImageIcon(AssetImage('assets/homeicon.png')),
                // title: new Text('الرئيسية')),
                icon: Icon(Icons.local_car_wash),
                title: new Text(AppLocalizations.of(context).delivery)),
            BottomNavigationBarItem(
                backgroundColor: Color.fromRGBO(116, 189, 242, 1.0),
                icon: ImageIcon(AssetImage('assets/store.png')),
                title: new Text(AppLocalizations.of(context).stores)),
            // BottomNavigationBarItem(
            //     backgroundColor: Color.fromRGBO(116, 189, 242, 1.0),
            //     icon: ImageIcon(AssetImage('assets/request.png')),
            //     title: new Text('الطلبات')),
            BottomNavigationBarItem(
                backgroundColor: Color.fromRGBO(116, 189, 242, 1.0),
                icon: ImageIcon(AssetImage('assets/offer.png')),
                title: new Text(AppLocalizations.of(context).offers)),
            BottomNavigationBarItem(
                backgroundColor: Color.fromRGBO(116, 189, 242, 1.0),
                icon: Icon(Icons.notifications),
                title: new Text(AppLocalizations.of(context).notifications)),
            BottomNavigationBarItem(
                backgroundColor: Color.fromRGBO(116, 189, 242, 1.0),
                icon: ImageIcon(AssetImage('assets/message.png')),
                title: new Text(AppLocalizations.of(context).message)),
          ],
        ),
        body: (_selectedIndex == 0)
            ? DriverTabsOrderPage(this.model)
            // ? HomeWidget(this.model, this.order)
            : (_selectedIndex == 1)
                ? DriverStores()
                : (_selectedIndex == 2)
                    // ? DriverOrderPage(this.model)
                    // : (_selectedIndex == 3)
                    ? DriverOffer()
                    : (_selectedIndex == 3)
                        ? DriverNotificationsPage(this.model)
                        : (_selectedIndex == 4)
                            ? DrviverMessage(this.model)
                            : Container());
  }
}
