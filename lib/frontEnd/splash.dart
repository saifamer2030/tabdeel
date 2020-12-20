import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabdeel/BackEnd/models/client_model.dart';
import 'package:tabdeel/BackEnd/models/driver_model.dart';
import 'package:tabdeel/BackEnd/shared_prefrences.dart';
import 'package:tabdeel/tooles/print.dart';

import 'client/cleintTabs.dart';
import 'driver/driver_home.dart';
import 'mainPager/mainPager.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String token = "";
  String _role = "";
  Widget defaultHome = new Container();

  void setPage(Widget page) {
    setState(() {
      defaultHome = page;
    });
  }

  ClientModel clientModel;
  DriverModel driverModel;

  loadSharedPrefs() async {
    try {
      ClientModel user = ClientModel.fromJson(await readerItem("ClientModels"));
      //  DriverModel userDriver = DriverModel.fromJson(await readerItem("DriverModels"));
      setState(() {
        clientModel = user;
        // driverModel=userDriver;
        printBlue(clientModel);
      });
    } catch (Excepetion) {
      // do something
    }
  }

  Future<Null> checkIsLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("role") == 'Client' &&
        prefs.getString("role") == null) {
      clientModel = ClientModel.fromJson(await readerItem("ClientModels"));
    }
    if (prefs.getString("role") == 'Driver' &&
        prefs.getString("role") == null) {
      driverModel = DriverModel.fromJson(await readerItem("DriverModels"));
    } else {}
    setState(() {
      token = prefs.getString("userId");
      _role = prefs.getString("role");
      print("Data storge is");
      print(token);
      //  clientModel = ClientModel.fromJson(readerItem("ClientModels"));
      //  driverModel = DriverModel.fromJson(readerItem("ClientModels"));
      if (token != "" && token != null) {
        print("alreay login.");
        print("role" + _role);
        //your home page is loaded
        if (_role == "Client") {
          print(_role);
          // printGreen(clientModel.clientID);
          // setPage(CleintHomePage(clientModel));

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => ClientHome1(),
            ),
          );
          return;
        } else if (_role == "Driver") {
          print(_role);
          //  setPage( DriverHome(driverModel));
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => DriverHome1()));
          return;
        }
      }
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MainPage(),
        ),
      );
    });
  }

  @override
  void initState() {
    checkIsLogin();
    super.initState();

    setState(() {
      checkIsLogin();
    });
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 5), onDoneLoading);
  }

  Location location = new Location();

  onDoneLoading() async {
    bool enabledService = await location.serviceEnabled();
    if (enabledService) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => MainPage()));
    } else {
      location.requestService().then((service) {
        if (service) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => MainPage()));
        } else {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromRGBO(116, 189, 242, 1.0),
        image: DecorationImage(
          image: AssetImage(
            'assets/logowithtext.png',
          ),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
