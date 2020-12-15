
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tabdeel/BackEnd/message_api.dart';
import 'package:tabdeel/BackEnd/models/chat_model.dart';
import 'package:tabdeel/BackEnd/models/client_model.dart';
import 'package:tabdeel/BackEnd/shared_prefrences.dart';
import 'package:tabdeel/tooles/print.dart';

import '../../localizations.dart';
import '../signup.dart';






class ClientOrderNewChat extends StatefulWidget {
  // ChatMessage({this.text,this.shopId, this.animationController});
  final String driverId,driverNAme,clientName;

  const ClientOrderNewChat(this.driverId,this.driverNAme,this.clientName);
    @override
  _ChatMessageState createState() => _ChatMessageState();
}

 class _ChatMessageState extends State<ClientOrderNewChat> {

  String name='',clientID;
 final TextEditingController _textController = new TextEditingController();
  loadSharedPrefs() async {
  try {
    ClientModel user = ClientModel.fromJson(await readerItem("ClientModels"));
    setState(() {
       name = user.name;
       clientID=user.clientID.toString();
      printYellow(name);
     

     
    });
  } catch (Excepetion) {
    // do something
  }
}



//get image
File _image;
var img='';
Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
    imageProfile(_image);
  }
  
   imageProfile(image) async {
    await encodeImage(image).then((im) {
      img = base64Encode(im);
      creaetMessage();
    });
  }

Future creaetMessage() async {
  print('add message'+_textController.text);
   
  return driverCreateNewMessage(ChatModel(
    flag: "1",fromID: clientID,
    message: _textController.text,
    toID: widget.driverId,
    img:img)).then((res){
      printBlue(res.body);
      setState(() {
      getAllChatDriverMessage( widget.driverId,clientID);
        
      });
      _textController.clear();
    });
    // _textController.clear();
}
    @override
  void initState() {
    super.initState();
    loadSharedPrefs();
    
  }
    @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        actions:<Widget>[IconButton(icon: Icon(Icons.arrow_forward_ios,size: 25,), onPressed: (){Navigator.pop(context);})]
        ,
        title: new Center(child:new Text(widget.driverNAme)),
        backgroundColor: Color.fromRGBO(116, 189, 242, 1.0),
        elevation:
            Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
   child:Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 10,
              child: 
                  StreamBuilder(
                        stream: Stream.fromFuture(getAllChatDriverMessage(clientID.toString(),widget.driverId.toString())),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                                child: Text( AppLocalizations.of(context).notconnect));
                          }
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Center(child: Text(AppLocalizations.of(context).loading));

                            default:
                              Response rs = snapshot.data;
                                print(rs.body);
                              List jsonArray =
                                  json.decode(rs.body)['AllMessages'];
                              if (json.decode(rs.body)['success'] == 0 ||
                                  json.decode(rs.body)['success'] == -1 ||
                                  jsonArray == null) {
                                return const Center(
                                  child: Text(
                                    "لا يوجد رسايل",
                                    style: TextStyle(
                                        fontSize: 18.0, color: Colors.grey),
                                  ),
                                );
                              }
                             List<MessageChatModel> mesg = [];
                        jsonArray.forEach((msgJson) {
                          mesg.add(MessageChatModel.fromJson(msgJson));
                        });
                                      return ListView.builder(
                            itemCount: mesg.length,
                            itemBuilder: (context, index) {
              
                              return new Column(children: <Widget>[
                                mesg[index].flag == "1"
                                    ? Row(
                                        children: <Widget>[
                                          new Container(
                                            margin: const EdgeInsets.only(
                                                right: 16.0),
                                            child: new CircleAvatar(
                                                child: new Text(
                                                 "")),
                                          ),
                                          new Expanded(
                                            child: new Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                // new Text(mesg[index].fromName, style: Theme.of(context).textTheme.subhead),
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0, 2, 0, 0),
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: Colors.grey[300]),
                                                  child:  mesg[index].image==null||mesg[index].image=='null'||mesg[index].image==''?Text(
                                                    '  ' +
                                                      mesg[index].message +
                                                        '   ',
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ):new Container(height: 100,child:Image.network(mesg[index].image),
                                                )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    : Row(
                                        textDirection: TextDirection.ltr,
                                        children: <Widget>[
                                          new Container(
                                            margin: const EdgeInsets.only(
                                                right: 16.0),
                                            child: new CircleAvatar(
                                                child: new Text(
                                                   "")),
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                0, 10, 0, 0),
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.grey[300]),
                                            child: mesg[index].image==null||mesg[index].image=='null'||mesg[index].image==''?Text(
                                                    '  ' +
                                                      mesg[index].message +
                                                        '   ',
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ):new Container(height: 100,child:Image.network(mesg[index].image),
                                          )),
                                        ],
                                      ),
                              ]);
                            });
                    }
                        }
            )),
            Flexible(
              flex: 2,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(50)),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Flexible(
                            flex:7,
                            child: TextField(
                               controller: _textController,
                              decoration: InputDecoration(
                                  hintText:  AppLocalizations.of(context).writemessage,
                                  hintStyle: TextStyle(color: Colors.grey),
                                  contentPadding: EdgeInsets.all(10),
                                  border: InputBorder.none),
                            ),
                          ),
                          Flexible(
                              flex: 2,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  // Icon(
                                  //   Icons.mic,
                                  //   color: Colors.black87,
                                  //   textDirection: TextDirection.rtl,
                                  // ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  GestureDetector(
  onTap: () {
   getImage();
  },child:Icon(
                                    Icons.image,
                                    color: Color.fromRGBO(116, 189, 242, 1.0),
                                    textDirection: TextDirection.rtl,
                                   ) ),

                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
  onTap: () {
   creaetMessage();
  },child:Icon(
                                    Icons.send,
                                    color: Color.fromRGBO(116, 189, 242, 1.0),
                                    textDirection: TextDirection.rtl,
                                   ) ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ))));
  }
  }

