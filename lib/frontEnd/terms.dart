
import 'package:flutter/material.dart';
import 'package:tabdeel/localizations.dart';

class TermesAndCondetions extends StatefulWidget {

  @override
  _StoresState createState() => _StoresState();
}

class _StoresState extends State<TermesAndCondetions> {
 
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          backgroundColor: Color.fromRGBO(116, 189, 242, 1.0),
          elevation: 0,
          centerTitle: true,
          title: new Center(child: new Text(AppLocalizations.of(context).terms),),
          // leading: IconButton(icon: Icon(Icons.search,size: 30,), onPressed: (){Function_ButtonSearch();}),
        ),
    body: Directionality(
        textDirection: TextDirection.rtl,
        child:Container(
          padding: EdgeInsets.all(20),
          child:ListView(
    //  mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[ 
        Text(
                  AppLocalizations.of(context).termsone,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  AppLocalizations.of(context).termstwo,
                  style: TextStyle(fontSize: 18),
                ),
                Text(AppLocalizations.of(context).termsthree,
                    style: TextStyle(fontSize: 16)),
                Text(AppLocalizations.of(context).termsfour,
                    style: TextStyle(fontSize: 16)),
                Text(AppLocalizations.of(context).termsfive,
                    style: TextStyle(fontSize: 16)),
                Text(AppLocalizations.of(context).termssix,
                    style: TextStyle(fontSize: 16)),
                Text(AppLocalizations.of(context).termsseven,
                    style: TextStyle(fontSize: 16)),
                Text(AppLocalizations.of(context).termseight),
                Text(AppLocalizations.of(context).termsnine,
                    style: TextStyle(fontSize: 16)),
                Text(AppLocalizations.of(context).termsten,
                    style: TextStyle(fontSize: 16)),
                Text(AppLocalizations.of(context).termssone),
                Text(AppLocalizations.of(context).termsstwo,
                    style: TextStyle(fontSize: 16)),
                Text(AppLocalizations.of(context).termssthree,
                    style: TextStyle(fontSize: 16)),
                Text(AppLocalizations.of(context).termssfour,
                    style: TextStyle(fontSize: 16)),
                Text(AppLocalizations.of(context).termssfive,
                    style: TextStyle(fontSize: 16)),
                Text(AppLocalizations.of(context).termsssix,
                    style: TextStyle(fontSize: 16)),
                Text(AppLocalizations.of(context).termssseven,
                    style: TextStyle(fontSize: 16)),
                Text(AppLocalizations.of(context).termsseight,
                    style: TextStyle(fontSize: 16)),
                Text(AppLocalizations.of(context).termssnine,
                    style: TextStyle(fontSize: 16)),
                Text(AppLocalizations.of(context).termssten,
                    style: TextStyle(fontSize: 16)),

        
    ]))
    ));
   
    }
}
