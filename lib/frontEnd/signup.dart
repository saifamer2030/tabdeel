import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tabdeel/BackEnd/client_auth.dart';
import 'package:tabdeel/BackEnd/driver_auth.dart';
import 'package:tabdeel/BackEnd/models/client_model.dart';
import 'package:tabdeel/BackEnd/models/driver_model.dart';
import 'package:tabdeel/BackEnd/models/shop_model.dart';
import 'package:tabdeel/BackEnd/shared.dart';
import 'package:tabdeel/BackEnd/shared_prefrences.dart';
import 'package:tabdeel/BackEnd/shops_api.dart';
import 'package:tabdeel/frontEnd/shopWidget.dart';
import 'package:tabdeel/tooles/print.dart';
import 'package:toast/toast.dart';

import '../localizations.dart';
import 'client/cleintTabs.dart';
import 'driver/driver_home.dart';
import 'mandoob.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var radioValue = 1;
  bool checkboxVal = false;
  bool connectionEnded = false;

  var nameController = TextEditingController();
  var mailController = TextEditingController();
  var passController = TextEditingController();
  var phoneController = TextEditingController();
  File _image;

  var shopNameController = TextEditingController();
  var commericalRecordController = TextEditingController();
  StringBuffer subscribeRadioVal = new StringBuffer("month");

  StringBuffer nationalityID = new StringBuffer();
  var numberID = TextEditingController();
  StringBuffer imgIDPath = new StringBuffer();
  StringBuffer imgLicensePath = new StringBuffer();
  StringBuffer imgFrontCarPath = new StringBuffer();
  StringBuffer imgRearCarPath = new StringBuffer();

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
    imageProfile(_image);
  }

  var location = new Location();

  Future<LocationData> getLocation() async {
    return location.getLocation();
  }

  showTerms(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text(AppLocalizations.of(context).acceptis),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      title: new Text(
        AppLocalizations.of(context).terms,
        textAlign: TextAlign.right,
      ),
      content: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
            Text(
              AppLocalizations.of(context).termsone,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              AppLocalizations.of(context).termstwo,
              style: TextStyle(fontSize: 18),
            ),
            Text(AppLocalizations.of(context).termsthree,
                style: TextStyle(fontSize: 16)),
            // Text(AppLocalizations.of(context).termsfour,
            //     style: TextStyle(fontSize: 16)),
            Text(AppLocalizations.of(context).termsfive,
                style: TextStyle(fontSize: 16)),
            Text(AppLocalizations.of(context).termssix,
                style: TextStyle(fontSize: 16)),
            Text(AppLocalizations.of(context).termsseven,
                style: TextStyle(fontSize: 16)),
            Text(AppLocalizations.of(context).termseight),
            Text(AppLocalizations.of(context).termsnine,
                style: TextStyle(fontSize: 16)),
            Text(AppLocalizations.of(context).termsten,
                style: TextStyle(fontSize: 16)),
            // Text(AppLocalizations.of(context).termssone),
            // Text(AppLocalizations.of(context).termsstwo,
            //     style: TextStyle(fontSize: 16)),
            // Text(AppLocalizations.of(context).termssthree,
            //     style: TextStyle(fontSize: 16)),
            // Text(AppLocalizations.of(context).termssfour,
            //     style: TextStyle(fontSize: 16)),
            // Text(AppLocalizations.of(context).termssfive,
            //     style: TextStyle(fontSize: 16)),
            // Text(AppLocalizations.of(context).termsssix,
            //     style: TextStyle(fontSize: 16)),
            // Text(AppLocalizations.of(context).termssseven,
            //     style: TextStyle(fontSize: 16)),
            // Text(AppLocalizations.of(context).termsseight,
            //     style: TextStyle(fontSize: 16)),
            // Text(AppLocalizations.of(context).termssnine,
            //     style: TextStyle(fontSize: 16)),
            // Text(AppLocalizations.of(context).termssten,
            //     style: TextStyle(fontSize: 16)),
          ])),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

//push notifications

//010100447
  void firebaseCloudMessagingListeners() {
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((token) {
      deviceId = token;
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  var _mySelectionnational;
  List nationlyData = [];

  @override
  void initState() {
    super.initState();

    getAllCities().then((response) {
      String res = response.body;
      List data = json.decode(res)['AllCities'];
      print(data);
      nationlyData = json.decode(res)['AllCities'];

      setState(() {});
      print('SuccessGetNations:$data');
    }).catchError((error) {
      print('ErrorGetNations:$error');
    });
    firebaseCloudMessagingListeners();
  }

  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      //---------AppBar---------------------------------
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(116, 189, 242, 1.0),
        elevation: 0,
        centerTitle: true,
        title: new Center(
          child: new Text(AppLocalizations.of(context).creataccount),
        ),
        // leading: IconButton(icon: Icon(Icons.search,size: 30,), onPressed: (){Function_ButtonSearch();}),
      ),
      body: Container(
        color: Color.fromRGBO(116, 189, 242, 1.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              Container(
                width: 200,
                height: 150,
                child: InkWell(
                  onTap: () {
                    getImage();
                  },
                  child: (_image == null)
                      ? Icon(
                          Icons.account_circle,
                          size: 140,
                          color: Colors.white,
                        )
                      : Image.file(_image),
                ),
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
                      child: TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            errorStyle: TextStyle(color: Colors.teal),
                            border: InputBorder.none,
                            hintText: AppLocalizations.of(context).name,
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                            icon: Icon(
                              Icons.person,
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
                      child: TextFormField(
                        controller: mailController,
                        // validator: (val) {
                        //   if (val.isEmpty) {
                        //     return "ادخل البريد الألكتروني";
                        //   }
                        //   return null;
                        // },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                            hintText: AppLocalizations.of(context).email,
                            icon: Icon(
                              Icons.alternate_email,
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
                      child: TextFormField(
                        obscureText: true,
                        controller: passController,
                        validator: (val) {
                          if (val.isEmpty) {
                            return "ادخل كلمة المرور";
                          }
                          return null;
                        },
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
                    Container(
                      height: 50,
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      margin: EdgeInsets.fromLTRB(50, 0, 50, 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                        validator: (val) {
                          if (val.isEmpty) {
                            return "ادخل رقم التليفون";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                            hintText: AppLocalizations.of(context).mobile,
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
                        child: new DropdownButton(
                          iconEnabledColor: Colors.white,
                          isExpanded: true,
                          hint: Text(
                            AppLocalizations.of(context).country,
                          ),
                          items: nationlyData.map((item) {
                            return new DropdownMenuItem(
                              child: SizedBox(
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // for example
                                child: Text(
                                  item['Name'],
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              value: item['ID'],
                            );
                          }).toList(),
                          onChanged: (newVal) {
                            setState(() {
                              _mySelectionnational = newVal;
                              print(_mySelectionnational);
                            });
                          },
                          value: _mySelectionnational,
                        )),
                  ],
                ),
              ),

              //RadioBtns
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
                  margin: (radioValue == 2)
                      ? EdgeInsets.fromLTRB(50, 0, 50, 0)
                      : EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: (radioValue == 1)
                      ? Container()
                      : (radioValue == 2)
                          ? Shop(shopNameController, commericalRecordController,
                              subscribeRadioVal)
                          : Driver(nationalityID, numberID, imgIDPath,
                              imgLicensePath, imgFrontCarPath, imgRearCarPath)),

              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Checkbox(
                      value: checkboxVal,
                      checkColor: Colors.green,
                      activeColor: Colors.white,
                      onChanged: (val) {
                        setState(() {
                          checkboxVal = val;
                        });
                      },
                    ),
                    Text(
                      AppLocalizations.of(context).agree,
                      style: TextStyle(color: Colors.white),
                    ),
                    new InkWell(
                        child: Text(
                          AppLocalizations.of(context).appcondation,
                          style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline),
                        ),
                        onTap: () => showTerms(context)),
                  ],
                ),
              ),

              (connectionEnded == false)
                  ? Container()
                  : Center(
                      child: CircularProgressIndicator(
                          backgroundColor: Color.fromRGBO(116, 189, 242, 1.0),
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(Colors.white)),
                    ),
              //RegButton
              Container(
                margin: EdgeInsets.fromLTRB(90, 0, 90, 5),
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.green,
                  child: Text(
                    AppLocalizations.of(context).regster,
                    textAlign: TextAlign.center,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () async {
                    setState(() {
                      connectionEnded = true;
                    });

                    signUpUser(radioValue).whenComplete(() {
                      setState(() {
                        connectionEnded = false;
                      });
                    }).then((response) {
                      switch (radioValue) {
                        case 1:
                          var resBody = jsonDecode(response.body);
                          printGreen(resBody);
                          if (resBody['success'] == 1) {
                            ClientModel clientModel =
                                ClientModel.fromMap(resBody);

                            save("ClientModels", clientModel);
                            saveToken(resBody['ClientID'].toString(), 'Client');
                            savedata("name", resBody['name']);
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
                            printGreen(resBody);
                            // ClientModel clientModel =
                            //     ClientModel.fromMap(resBody);
                            //
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => DriverHome1()));
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
                            saveToken(resBody['DriverID'].toString(), 'Driver');
                            savedata("name", resBody['name']);
                            save("DriverModels", driverModel);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DriverHome1(),
                              ),
                              (Route<dynamic> route) => false,
                            );
                          } else {
                            showSnackBar(resBody['message']);
                          }

                          break;
                        default:
                      }
                    }).catchError((error) {
                      // showSnackBar('رقم الهاتف والرقم السري مطلوبين');
                      //  showSnackBar('صورة الملف الشخصي مطلوبة');
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String img = "";
  String deviceId;

  imageProfile(image) async {
    await encodeImage(image).then((im) {
      img = base64Encode(im);
    });
  }

  Future<http.Response> signUpUser(int radioVal) async {
    String name = nameController.text;
    String pass = passController.text;
    String mail = mailController.text;
    String phone = phoneController.text;

    //USER-IMG

    String privacy = (checkboxVal == true) ? "1" : "0";
    String latitude = ""; //
    String longitude = "";

    await location.getLocation().then((currentLoc) {
      latitude = currentLoc.latitude.toString();
      longitude = currentLoc.longitude.toString();
    }).catchError((error) {
      print('LocationError:$error');
    }).whenComplete(() {
      print('InsideWhenComplete');
    });
    //

    //  if(pass==''||pass==null){
    //    showSnackBar("كلمة المرور مطلوبة");
    //  }
    //  else if(checkboxVal ==false){
    //    showSnackBar("يجب الموافقة علي الشروط والأحكام");
    //  }
    //  else if(phone==''||phone==null){
    //    showSnackBar("رقم الهاتف مطلوب");
    //  }
    //  else{
    switch (radioVal) {
      case 1:
        printGreen(pass);
        printBlue(phone);
        if (name == '' || name == null) {
          showSnackBar("اسم المستخدم مطلوب");
        } else if (phone == '' || phone == null) {
          showSnackBar("رقم الهاتف مطلوب");
        } else if (pass == '' || pass == null) {
          showSnackBar("كلمة المرور مطلوبة");
        } else if (checkboxVal == false) {
          showSnackBar("يجب الموافقة علي الشروط والأحكام");
        } else {
          return registerClient(
            ClientModel(
              clientLat: latitude,
              clientLon: longitude,
              deviceID: deviceId,
              email: mail,
              cityID: _mySelectionnational,
              img: img,
              mobile: phone,
              name: name,
              password: pass,
              privacy: privacy,
            ),
          );
        }
        break;

      case 2:
        //ExtraData for shop
        String shopName = shopNameController.text;
        String commericalRecord = commericalRecordController.text;
        String subType = subscribeRadioVal.toString();

        return registerShop(ShopModel(
            commericalRecord: commericalRecord,
            deviceID: deviceId,
            email: mail,
            img: img,
            mobile: phone,
            name: name,
            password: pass,
            privacy: privacy,
            shopName: shopName,
            subtype: (subType == "month") ? "0" : "1",
            //
            shopLon: longitude,
            shoptLat: latitude,
            address: null));

        break;

      default:
        //ExtraData forDriver
        String mynationalityID = this.nationalityID.toString();
        String idNumber = numberID.text;

        String imgID = ""; //
        if (imgIDPath.toString() == null || imgIDPath.toString() == '') {
          // showSnackBar("msg");

        } else {
          await encodeImage(File(imgIDPath.toString())).then((im) {
            imgID = base64Encode(im);
          });
        }

        String imgLic = ""; //
        if (imgLicensePath.toString() == null ||
            imgLicensePath.toString() == '') {
          showSnackBar("صورة الرخصة مطلوبة");
        } else {
          await encodeImage(File(imgLicensePath.toString())).then((im) {
            imgLic = base64Encode(im);
          });
        }

        String imgCarFront = ""; //
        if (imgFrontCarPath.toString() == null ||
            imgFrontCarPath.toString() == '') {
          showSnackBar("صورة السيارة الامامية مطلوبة");
        } else {
          await encodeImage(File(imgFrontCarPath.toString())).then((im) {
            imgCarFront = base64Encode(im);
          });
        }
        String imgCarRear = ""; //
        if (imgRearCarPath.toString() == null ||
            imgRearCarPath.toString() == '') {
          showSnackBar("صوره السيارة الخلفية مطلوبة");
        } else {
          await encodeImage(File(imgRearCarPath.toString())).then((im) {
            imgCarRear = base64Encode(im);
          });
        }

        print("NAationality:$mynationalityID");
        if (name == '' || name == null) {
          showSnackBar("اسم المستخدم مطلوب");
        } else if (phone == '' || phone == null) {
          showSnackBar("رقم الهاتف مطلوب");
        } else if (pass == '' || pass == null) {
          showSnackBar("كلمة المرور مطلوبة");
        } else if (idNumber == '' || idNumber == null) {
          showSnackBar("رقم البطاقة الشخصية مطلوب");
        } else if (imgLicensePath.toString() == null ||
            imgLicensePath.toString() == '') {
          showSnackBar("صورة الرخصة مطلوبة");
        } else if (imgFrontCarPath.toString() == null ||
            imgFrontCarPath.toString() == '') {
          showSnackBar("صورة السيارة الامامية مطلوبة");
        } else if (imgRearCarPath.toString() == null ||
            imgRearCarPath.toString() == '') {
          showSnackBar("صوره السيارة الخلفية مطلوبة");
        } else if (imgIDPath.toString() == null || imgIDPath.toString() == '') {
          showSnackBar("صورة البطاقة مطلوبة");
        } else if (checkboxVal == false) {
          showSnackBar("يجب الموافقة علي الشروط والأحكام");
        } else {
          return registerDriver(DriverModel(
            carFrontImg: imgCarFront,
            carRearImg: imgCarRear,
            cityID: _mySelectionnational,
            deviceID: deviceId,
            driverLat: latitude,
            driverLon: longitude,
            email: mail,
            idImg: imgID,
            idNumber: idNumber,
            img: img,
            licenseImg: imgLic,
            mobile: phone,
            name: name,
            nationality: mynationalityID,
            password: pass,
            privacy: privacy,
          ));
        }
    }
    // }
  }

  void showSnackBar(String msg) {
    Toast.show(msg, context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.CENTER,
        backgroundColor: Colors.grey);
  }
}

Future<List<int>> encodeImage(File img) async {
  return await img.readAsBytes();
}
