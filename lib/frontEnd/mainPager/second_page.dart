import 'package:flutter/material.dart';
import 'package:tabdeel/localizations.dart';

class SecondPage extends StatefulWidget{
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
     return Column(
        mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
     
      children: <Widget>[
        Image.asset('assets/secpage.png'),
        Text(AppLocalizations.of(context).addresstwo,style: TextStyle(color: Colors.white,
        fontSize: 15,
        decoration: TextDecoration.none
        ),
        
        textAlign: TextAlign.center,)
      ],
    );
   
  }
}