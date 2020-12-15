import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tabdeel/BackEnd/client_auth.dart';
import 'package:tabdeel/BackEnd/driver_auth.dart';
import 'package:tabdeel/BackEnd/models/client_model.dart';
import 'package:tabdeel/BackEnd/models/driver_model.dart';
import 'package:tabdeel/BackEnd/shared_prefrences.dart';
import 'package:tabdeel/BackEnd/shops_api.dart';
import 'package:tabdeel/frontEnd/signup.dart';
import 'package:tabdeel/localizations.dart';
import 'package:tabdeel/tooles/print.dart';
import 'package:toast/toast.dart';

import 'client/cleintTabs.dart';
import 'driver/driver_home.dart';
import 'forgot_password.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var mobController = TextEditingController();
  var passController = TextEditingController();

  var radioValue = 1;
  bool connectionEnded = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          child: TextField(
                            keyboardType: TextInputType.phone,
                            controller: mobController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: AppLocalizations.of(context).mobile,
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
                        Container(
                          height: 50,
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          margin: EdgeInsets.fromLTRB(50, 0, 50, 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextField(
                            obscureText: true,
                            controller: passController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                                hintText: AppLocalizations.of(context).password,
                                icon: Icon(
                                  Icons.lock_outline,
                                  color: Colors.grey,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
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
                        Text(AppLocalizations.of(context).client,
                            style: TextStyle(color: Colors.white)),
                        // Radio(
                        //   groupValue: radioValue,
                        //   onChanged: (val) {
                        //     setState(() {
                        //       radioValue = val;
                        //     });
                        //   },
                        //   value: 2,
                        //   activeColor: Colors.yellow,
                        // ),
                        // Text('محل', style: TextStyle(color: Colors.white)),
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
                        Text(AppLocalizations.of(context).driver,
                            style: TextStyle(color: Colors.white))
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(60, 0, 60, 10),
                      child: InkWell(
                        child: Text(
                          AppLocalizations.of(context).forgotpass,
                          style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline),
                          textAlign: TextAlign.right,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext ctx) =>
                                      ClientForgotPAssword()));
                        },
                      )),
                  Container(
                    margin: EdgeInsets.fromLTRB(90, 0, 90, 5),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.green,
                      child: Text(
                        AppLocalizations.of(context).login,
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
                                ClientModel clientModel =
                                    ClientModel.fromMap(resBody);

                                save("ClientModels", clientModel);
                                saveToken(
                                    resBody['ClientID'].toString(), 'Client');
                                savedata("name", resBody['name']);
                                savedata('rate', resBody['rate'].toString());
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ClientHome1(),
                                  ),
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
                                printGreen(resBody['DriverID']);
                                DriverModel driverModel =
                                    DriverModel.fromMap(resBody);
                                save("DriverModels", driverModel);
                                saveToken(
                                    resBody['DriverID'].toString(), 'Driver');
                                savedata("name", resBody['name']);
                                print(resBody['rate'].toString());
                                savedata('rate', resBody['rate'].toString());
                                savedata("DriverId", resBody['DriverID']);
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DriverHome1()),
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
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(60, 0, 60, 10),
                      child: InkWell(
                        child: Text(
                          AppLocalizations.of(context).noaccount,
                          style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline),
                          textAlign: TextAlign.center,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext ctx) => SignUp(),
                            ),
                          );
                        },
                      )),
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
        return await loginClient(phone, password);
        break;
      case 2:
        print('Shop');
        return await loginShop(phone, password);
        break;
      default:
        print('driver');
        return await loginDriver(phone, password);
    }
  }

  void showSnackBar(String msg) {
    Toast.show(msg, context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.CENTER,
        backgroundColor: Colors.grey);
  }
}
