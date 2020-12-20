import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tabdeel/BackEnd/message_api.dart';
import 'package:tabdeel/BackEnd/models/chat_model.dart';
import 'package:tabdeel/BackEnd/models/client_model.dart';
import 'package:tabdeel/tooles/print.dart';

import '../../localizations.dart';
import 'client_drawer.dart';

class ClientMsg extends StatefulWidget {
  final ClientModel clientModel;

  const ClientMsg(this.clientModel);
  @override
  _MsgState createState() => _MsgState();
}

class _MsgState extends State<ClientMsg> {

 @override
  void initState() {
    super.initState();
  print(widget.clientModel.clientID.toString());
  }
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
        height: double.infinity,
        color: Colors.white,
        child:Container(
                    child: StreamBuilder(
                  stream: Stream.fromFuture(getAllShopAndDriverMessage(widget.clientModel.clientID.toString())),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text(AppLocalizations.of(context).notconnect));
                    }
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(child: Text(AppLocalizations.of(context).loading));

                      default:
                        Response rs = snapshot.data;
                        printBlue(rs.body);
                    if(json.decode(rs.body)['success']==0||json.decode(rs.body)['success']==-1){ 
                          return const Center(
                    child: Text(
                      "لا يوجد رسائل",
                      style: TextStyle(fontSize: 18.0, color: Colors.grey),
                    ),
                  );
                        }
                        List jsonArray = json.decode(rs.body)['AllShopsMessages'];
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
              title: Text(message[index].toName==null?'لم يحدد':message[index].toName),
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
