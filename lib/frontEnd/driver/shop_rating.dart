import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:tabdeel/BackEnd/shops_api.dart';
import 'package:tabdeel/localizations.dart';
import 'package:tabdeel/tooles/print.dart';
import 'package:toast/toast.dart';

class RateingWidget extends StatefulWidget {
  final String shopid;

  const RateingWidget(this.shopid);
  @override
  _RateingWidgetState createState() => _RateingWidgetState();
}

class _RateingWidgetState extends State<RateingWidget> {
  double rating = 1;
  int starCount = 5;
  bool connectionEnded=false;
  var commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
                            textDirection: TextDirection.rtl,
                            child:Container(
       height: 300,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: ListView(
        children: <Widget>[
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
              printGreen(widget.shopid+rating.toString()+commentController.text);
              setState(() {
                          connectionEnded = true;
                        });
              rateShop(widget.shopid,rating.toString(),commentController.text).then((resp){
                printBlue(resp.body);
                setState(() {
                    Toast.show(AppLocalizations.of(context).sucessrate, context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.CENTER,
              backgroundColor: Colors.grey);
                          connectionEnded = false;
                        });
              });
            },
          )
        ],
      ),
    ));
  }
}
