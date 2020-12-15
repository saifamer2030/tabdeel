import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tabdeel/BackEnd/message_api.dart';
import 'package:tabdeel/BackEnd/models/chat_model.dart';
import 'package:tabdeel/BackEnd/models/driver_model.dart';
import 'package:tabdeel/localizations.dart';

class DrviverMessage extends StatefulWidget {
  final DriverModel driverModel;

  const DrviverMessage(this.driverModel);
  @override
  _DrviverMessageState createState() => _DrviverMessageState();
}

class _DrviverMessageState extends State<DrviverMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
        height: double.infinity,
        color: Colors.white,
        child:Container(
                    child: StreamBuilder(
                  stream: Stream.fromFuture(getAllDriverMyMessage(widget.driverModel.deviceID.toString())),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text(AppLocalizations.of(context).notconnect));
                    }
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(child: Text(AppLocalizations.of(context).loading));
           
                      default:
                        Response rs = snapshot.data;

                    if(json.decode(rs.body)['success']==0||json.decode(rs.body)['success']==-1){ 
                          return const Center(
                    child: Text(
                      "لا يوجد رسائل",
                      style: TextStyle(fontSize: 18.0, color: Colors.grey),
                    ),
                  );
                        }
                        List jsonArray = json.decode(rs.body)['AllMessages'];
                        List<MessageModel> message = [];
                        jsonArray.forEach((shopJson) {
                          message.add(MessageModel.fromJson(shopJson));
                        });
                        return ListView.builder(
                          itemCount: message.length,
                          itemBuilder: (context, index) {
        
         return new Column(children: <Widget>[
           
             ListTile(
              leading: Image.asset('assets/person2.png'),
              title: Text(message[index].toName),
              subtitle: Text(message[index].message),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[Text(message[index].sentDate.split(' ')[1])],
              ),
            ),
            Divider(
              color: Colors.grey,
            )
            
           ],); 
         }
                        );
                  }
                  })),
      ),
    );
  }
}
