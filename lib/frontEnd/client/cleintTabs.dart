import 'package:flutter/material.dart';
import 'package:tabdeel/BackEnd/models/client_model.dart';
import 'package:tabdeel/BackEnd/models/order_model.dart';
import 'package:tabdeel/BackEnd/shared_prefrences.dart';
import '../../localizations.dart';
import '../offers.dart';
import 'client_homeLocation.dart';
import 'client_messages.dart';
import 'client_notifications.dart';
import 'tabs_order.dart';

class ClientHome1 extends StatefulWidget {
  @override
  _HomePage1State createState() => _HomePage1State();
}

class _HomePage1State extends State<ClientHome1> {
  void initState() {
    super.initState();
    setState(() {
      checkStorge();
    });
  }

  checkStorge() async {
    ClientModel clientModel =
        ClientModel.fromJson(await readerItem("ClientModels"));
    print('Client Model is ' + clientModel.toJson().toString());
    setState(() {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => CleintHomePage(clientModel),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CleintHomePage extends StatefulWidget {
  final ClientModel model;

  final ClientOrder newOrder = ClientOrder(
      clientID: null,
      clientLat: null,
      clientLng: null,
      orders: null,
      shopLat: null,
      // shopID:null,
      shopLng: null,
      flag: null,
      deliveryCost: '',
      deliveryTime: '',
      distance: '',
      shopName: null,
      pendingTime: null);

  CleintHomePage(this.model) {
    newOrder.clientID = model.clientID.toString();
  }

  @override
  _HomePageState createState() => _HomePageState(this.model, this.newOrder);
}

class _HomePageState extends State<CleintHomePage> {
  ClientOrder order;

  ClientModel model;
  String name = '';

  _HomePageState(this.model, this.order);

  @override
  void initState() {
    super.initState();
    setState(() {
      checkStorge();
    });
  }

  double userrate;

  checkStorge() async {
    ClientModel clientModel =
        ClientModel.fromJson(await readerItem("ClientModels"));
    setState(() {
      model = clientModel;
      name = clientModel.name;
    });
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.grey[200],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Color.fromRGBO(116, 189, 242, 1.0),
              icon: ImageIcon(AssetImage('assets/homeicon.png')),
              title: new Text(AppLocalizations.of(context).home)),
          BottomNavigationBarItem(
              backgroundColor: Color.fromRGBO(116, 189, 242, 1.0),
              icon: ImageIcon(AssetImage('assets/request.png')),
              title: new Text(AppLocalizations.of(context).orders)),
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
          ? HomeWidget(this.model, this.order)
          : (_selectedIndex == 1)
              ? ClientTabsOrderPage(this.model)
              : (_selectedIndex == 2)
                  ? Offer()
                  : (_selectedIndex == 3)
                      ? ClientNotifyOrderPage(this.model)
                      : (_selectedIndex == 4)
                          ? ClientMsg(this.model)
                          : Container(),
    );
  }
}
