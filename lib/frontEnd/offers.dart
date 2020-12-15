import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tabdeel/BackEnd/models/offer_model.dart';
import 'package:tabdeel/BackEnd/offers_api.dart';
import 'package:tabdeel/localizations.dart';

import 'client/client_drawer.dart';

class Offer extends StatefulWidget {
  @override
  _OfferState createState() => _OfferState();
}

class _OfferState extends State<Offer> {
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
        body: Container(
          child: StreamBuilder(
              stream: Stream.fromFuture(getAllOffers()),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                      child: Text(AppLocalizations.of(context).notconnect));
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                        child: Text(AppLocalizations.of(context).loading));

                  default:
                    Response rs = snapshot.data;
                    List jsonArray = json.decode(rs.body)['AllAppOffers'];
                    if (json.decode(rs.body)['success'] == 0 ||
                        json.decode(rs.body)['success'] == -1 ||
                        jsonArray == null) {
                      return const Center(
                        child: Text(
                          "لا يوجد عروض",
                          style: TextStyle(fontSize: 18.0, color: Colors.grey),
                        ),
                      );
                    }
                    List<OfferModel> offers = [];
                    jsonArray.forEach((offersJson) {
                      offers.add(OfferModel.fromJson(offersJson));
                    });
                    return ListView.builder(
                        itemCount: offers.length,
                        itemBuilder: (context, index) {
                          return new Card(
                              elevation: 1,
                              child: Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: <Widget>[
                                    Image.network(
                                      offers[index].image,
                                      fit: BoxFit.fill,
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                          // height: 60,
                                          width: double.infinity,
                                          color: Colors.grey[200],
                                          child: Container(
                                            padding: EdgeInsets.all(5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Text(offers[index].title),
                                                Text(
                                                  offers[index].description,
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                  textAlign: TextAlign.start,
                                                )
                                              ],
                                            ),
                                          )),
                                    )
                                  ],
                                ),
                              ));
                        });
                }
              }),
        ));
  }
}
