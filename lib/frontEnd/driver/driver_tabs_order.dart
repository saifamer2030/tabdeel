import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:tabdeel/BackEnd/driver_auth.dart';
import 'package:tabdeel/BackEnd/models/driver_model.dart';
import 'package:tabdeel/frontEnd/driver/pending_orders.dart';
import 'package:tabdeel/localizations.dart';
import 'package:tabdeel/tooles/print.dart';

import 'current_orders.dart';
import 'ended_orders.dart';



class DriverTabsOrderPage extends StatefulWidget {
  final DriverModel driverModel;

  const DriverTabsOrderPage(this.driverModel);
  
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<DriverTabsOrderPage> {
 
 Location location = new Location();
  @override
  void initState() {
    super.initState();
    location.getLocation().then((loc) {
      
        loc.latitude.toString();
        loc.longitude.toString();

printGreen(loc.longitude.toString());
  updateDriverLastLocations(widget.driverModel.driverID.toString(),loc.latitude.toString(),loc.longitude.toString()).then((data){
    print(data.body);
    print(widget.driverModel.driverID.toString(),);
  });
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Directionality(
              textDirection: TextDirection.rtl, 
              child:DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar:  PreferredSize(
          preferredSize: Size.fromHeight(50.0), // here the desired height
          child:AppBar(
            backgroundColor: Color.fromRGBO(116, 189, 242, 1.0),
            automaticallyImplyLeading: false,
            bottom: TabBar(
              tabs: [
                Tab(text: AppLocalizations.of(context).currentOder),
                Tab(text: AppLocalizations.of(context).acceptorder),
                Tab(text: AppLocalizations.of(context).endedorders),
              ],
            ),
          )),
          body: TabBarView(
            children: [
              DriverPendingOrderPage(widget.driverModel.driverID.toString()),
              DriverCurrentOrderPage(widget.driverModel.driverID.toString()),
              DriverEndOrderPage(widget.driverModel.driverID.toString()),
            ],
          ),
        )),
    );
  }
}