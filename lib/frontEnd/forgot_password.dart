import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tabdeel/BackEnd/client_auth.dart';
import 'package:tabdeel/BackEnd/driver_auth.dart';
import 'package:tabdeel/BackEnd/shops_api.dart';
import 'package:tabdeel/localizations.dart';
import 'package:tabdeel/tooles/print.dart';
import 'package:toast/toast.dart';

import 'login.dart';

class ClientForgotPAssword extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<ClientForgotPAssword> {
  var mobController = TextEditingController();
  var passController = TextEditingController();

  var radioValue = 1;
  bool connectionEnded = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(116, 189, 242, 1.0),
          elevation: 0,
          centerTitle: true,
          title: new Center(child: new Text(AppLocalizations.of(context).forgotpass),),
          // leading: IconButton(icon: Icon(Icons.search,size: 30,), onPressed: (){Function_ButtonSearch();}),
        ),
        body: Container(
            color: Color.fromRGBO(116, 189, 242, 1.0),
            child: Center(
              child: ListView(
                children: <Widget>[
                  Container(
                    width: 300,
                    height: 300,
                    child: Image.asset('assets/logowithtext.png'),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 50,
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          margin: EdgeInsets.fromLTRB(50, 0, 50, 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextField(
                              keyboardType: TextInputType.text,
                              controller: mobController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: AppLocalizations.of(context).email,
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                  ),
                                  icon: Icon(
                                    Icons.phone_android,
                                    color: Colors.grey,
                                  )),
                            ),
                          ),
                        ),
                  
                      ],
                    ),
                  ),
                  Container(
                    child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                             AppLocalizations.of(context).accounttype,
                              style: TextStyle(color: Colors.white),
                            ),
                            Radio(
                              groupValue: radioValue,
                              onChanged: (val) {
                                setState(() {
                                  radioValue = val;
                                });
                              },
                              value: 1,
                              activeColor: Colors.yellow,
                            ),
                            Text(AppLocalizations.of(context).client, style: TextStyle(color: Colors.white)),
                            Radio(
                              groupValue: radioValue,
                              onChanged: (val) {
                                setState(() {
                                  radioValue = val;
                                });
                              },
                              value: 3,
                              activeColor: Colors.yellow,
                            ),
                            Text(AppLocalizations.of(context).driver, style: TextStyle(color: Colors.white))
                          ],
                        )),
                  ),


                 
                  Container(
                    margin: EdgeInsets.fromLTRB(90, 0, 90, 5),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.green,
                      child: Text(
                        'دخول',
                        textAlign: TextAlign.center,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {
                        setState(() {
                          connectionEnded = true;
                        });
                        _loginUser(radioValue, mobController.text,
                                passController.text)
                            .then((response) {
                          print("DoneRequestLOgin:${response.body.toString()}");
                          switch (radioValue) {
                            case 1:
                              var resBody = jsonDecode(response.body);
                              if (resBody['success'] == 1) {
                                showSnackBar(resBody['message']);
                              printGreen(resBody);
                                   Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Login()),
              (Route<dynamic> route) => false,
            );
                              
                              } else {
                                showSnackBar(resBody['message']);
                              }

                              break;
                                case 2:
                              var resBody = jsonDecode(response.body);
                              if (resBody['success'] == 1) {
                                // ClientModel clientModel =
                                //     ClientModel.fromMap(resBody);

                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) =>
                                //         HomePage(clientModel)));
                              } else {
                                showSnackBar(resBody['message']);
                              }

                              break;
                                case 3:
                              var resBody = jsonDecode(response.body);
                              if (resBody['success'] == 1) {
                                printGreen(resBody);
                               showSnackBar(resBody['message']);
                                 Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Login()),
              (Route<dynamic> route) => false,
            );
                               
                              } else {
                                showSnackBar(resBody['message']);
                              }

                              break;
                            default:
                          }
                        }).catchError((error) {
                          print('ErrorLoginRequest:$error');
                        }).whenComplete(() {
                          setState(() {
                            connectionEnded = false;
                          });
                        });
                      },
                    ),
                  ),
                  
                  (connectionEnded == false)
                      ? Container()
                      : Center(
                          child: CircularProgressIndicator(
                              backgroundColor:
                                  Color.fromRGBO(116, 189, 242, 1.0),
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.white)),
                        )
                ],
              ),
            )));
  }

                                Future<http.Response> _loginUser(
                                      int radioValue, String phone, String password) async {
                                    switch (radioValue) {
                                      case 1:
                                      print('Client');
                                        return await forgotPasswordClient(phone);
                                        break;
                                      case 2:
                                      print('Shop');
                                        return await forgetPasswordShop(phone);
                                        break;
                                      default:
                                      print('driver');
                                        return await forgotPasswordDriver(phone);
                                    }
                                  }
  void showSnackBar(String msg) {
     Toast.show(msg, context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.CENTER,
              backgroundColor: Colors.grey);
  }
}
