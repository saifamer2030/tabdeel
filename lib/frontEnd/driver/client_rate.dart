import 'package:flutter/material.dart';
import 'package:tabdeel/BackEnd/client_auth.dart';
import 'package:tabdeel/localizations.dart';
import 'package:tabdeel/tooles/print.dart';
import 'package:toast/toast.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'driver_home.dart';

class ClientRateing extends StatefulWidget {
  final String clientID;

  const ClientRateing(this.clientID);
  @override
  _RateingWidgetState createState() => _RateingWidgetState();
}

class _RateingWidgetState extends State<ClientRateing> {
  double rating = 1;
  int starCount = 5;
  bool connectionEnded=false;
  var commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(

        //---------AppBar---------------------------------
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(116, 189, 242, 1.0),
          elevation: 0,
          centerTitle: true,
          title: new Center(child: new Text(AppLocalizations.of(context).clientrate),),
        ),

body:Directionality(
                            textDirection: TextDirection.rtl,
                            child:Container(
       height: 300,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
               AppLocalizations.of(context).addrate,
                style: TextStyle(color: Colors.grey),
              ),
             StarRating(
              size: 25.0,
              rating: rating,
               color: Color.fromRGBO(116, 189, 242, 1.0),
                  borderColor: Color.fromRGBO(116, 189, 242, 1.0),
              starCount: starCount,
              onRatingChanged: (rating) => setState(
                    () {
                      printBlue(rating);
                      this.rating = rating;
                    },
                  ),
            ),
              
            ],
          ),
          SizedBox(
            height: 8,
          ),
          TextField(
            maxLines: 5,
             controller: commentController,
            decoration: InputDecoration(
                fillColor: Colors.grey[300],
                filled: true,
                
                border: InputBorder.none,
                hintText: AppLocalizations.of(context).addcomment,
                hintStyle: TextStyle(color: Colors.grey)),
          ),
         (connectionEnded == true)?Center(
                                                          child: CircularProgressIndicator(
                                                              backgroundColor:
                                                                  Color.fromRGBO(116, 189, 242, 1.0),
                                                              valueColor: new AlwaysStoppedAnimation<Color>(
                                                                  Colors.white)),
                                                        ):
                                                      
                                                       RaisedButton(
            textColor: Colors.white,
            color: Color.fromRGBO(116, 189, 242, 1.0),
            child: Text(AppLocalizations.of(context).evaluation),
            onPressed: () {
              printGreen(widget.clientID+rating.toString()+commentController.text);
              setState(() {
                          connectionEnded = true;
                        });
              rateClient(widget.clientID,rating.toString(),commentController.text).then((resp){
                printBlue(resp.body);
                setState(() {
                    Toast.show('تم التقييم بنجاح', context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.CENTER,
              backgroundColor: Colors.grey);
                          connectionEnded = false;
                        });
 Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => DriverHome1()));
              });
            },
          )
        ],
      ),
    )));
  }
}
