import 'package:flutter/material.dart';
import 'package:tabdeel/localizations.dart';
import 'client_cancelOreder.dart';
import 'client_order.dart';
import '../../BackEnd/models/client_model.dart';
import 'client_drawer.dart';



class ClientTabsOrderPage extends StatefulWidget {
final ClientModel clientModel;

  const ClientTabsOrderPage(this.clientModel);
  
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<ClientTabsOrderPage> {
 

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     drawer: MyDrawer(),
     appBar: AppBar(
          backgroundColor: Color.fromRGBO(116, 189, 242, 1.0),
          title: ImageIcon(AssetImage('assets/onlyiconlogo.png'), size: 50),
          centerTitle: true,
          // actions:<Widget>[IconButton(icon: Icon(Icons.arrow_forward_ios,size: 30,), onPressed: (){})]
        ),
        body:DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar:  PreferredSize(
          preferredSize: Size.fromHeight(50.0), // here the desired height
          child:AppBar(
            backgroundColor: Color.fromRGBO(116, 189, 242, 1.0),
            automaticallyImplyLeading: false,
            bottom: TabBar(
              tabs: [
                Tab(text: AppLocalizations.of(context).orders),
                Tab(text: AppLocalizations.of(context).cancelorders),
              ],
            ),
          )),
          body: TabBarView(
            children: [
              ClientOrderPage(widget.clientModel),
                ClientCancelOrders(widget.clientModel),
            ],
          ),
        )),
    );
  }
}