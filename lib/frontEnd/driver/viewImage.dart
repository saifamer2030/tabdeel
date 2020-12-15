import 'package:flutter/material.dart';
import 'package:tabdeel/localizations.dart';

class ViewImage extends StatefulWidget {
  final String image;
  final String title;

  const ViewImage(this.image, this.title);
  @override
  _ViewImageState createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: TextDirection.rtl,
            child:new Scaffold(
        //---------AppBar---------------------------------
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(116, 189, 242, 1.0),
          title: new Text(AppLocalizations.of(context).shop +' '+widget.title ),
          ),
          body:Container(
       decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(15),
          color: Colors.blueGrey,
          
          image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(widget.image)
          )
          ),
    )));
  }
}