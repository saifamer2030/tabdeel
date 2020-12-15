import 'package:flutter/material.dart';
import 'package:tabdeel/localizations.dart';

class ThirdPage extends StatefulWidget{
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
     return Column(
        mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
     
      children: <Widget>[
        Image.asset('assets/thirpage.png'),
        Text(AppLocalizations.of(context).addressthree,style: TextStyle(color: Colors.white,
        fontSize: 15,
        decoration: TextDecoration.none
        ),
        
        textAlign: TextAlign.center,)
      ],
    );
   
  }
}