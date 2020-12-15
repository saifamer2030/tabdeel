import 'package:flutter/material.dart';
import 'package:tabdeel/localizations.dart';

class FirstPage extends StatefulWidget{
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset('assets/firstpage.png'),
        Text(AppLocalizations.of(context).addressone,style: TextStyle(color: Colors.white,
        fontSize: 15,
        decoration: TextDecoration.none
        ),
        
        textAlign: TextAlign.center,)
      ],
    );
    
  }
}