import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:tabdeel/BackEnd/client_auth.dart';
import 'package:tabdeel/BackEnd/models/client_model.dart';
import 'package:tabdeel/BackEnd/shared_prefrences.dart';

import '../../localizations.dart';
import '../../main.dart';
import '../contact_us.dart';
import '../login.dart';
import '../terms.dart';

class MyDrawer extends StatefulWidget {
  _BirdState createState() => new _BirdState();
}

class _BirdState extends State<MyDrawer> {
  List<RadioModel> _langList = new List<RadioModel>();

  int _index = 0;

  bool isDevicePlatformAndroid() {
    return Theme.of(context).platform == TargetPlatform.android;
  }

  @override
  void initState() {
    super.initState();
    userDetails();
    _initLanguage();
    checkStorge();
  }

  double userrate;
  String name;

  checkStorge() async {
    ClientModel clientModel =
        ClientModel.fromJson(await readerItem("ClientModels"));
    setState(() {
      // model = clientModel;
      name = clientModel.name;
    });
  }

  userDetails() async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString('userId'));

    clientDetails(prefs.getString('userId')).then((data) {
      print(data.body);
      var result = json.decode(data.body);
      print(result['rate']);
      setState(() {
        userrate = double.parse(result['rate'].toString());
      });
    });
  }

  logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('ClientModels');
    prefs.remove('name');
    prefs.remove('userId');

    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: Container(
        color: Color.fromRGBO(116, 189, 242, 1.0),
        child: Column(
          children: <Widget>[
            Container(
              height: 250,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    child: Image.asset('assets/user.png'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    name,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SmoothStarRating(
                      allowHalfRating: false,
                      starCount: 5,
                      rating: userrate == null ? 0.0 : userrate,
                      size: 27.0,
                      color: Colors.yellow,
                      borderColor: Colors.grey,
                      spacing: 0.0),
                ],
              ),
            ),
            Divider(
              endIndent: 30,
              indent: 30,
              color: Colors.black54,
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext ctx) => TermesAndCondetions()));
              },
              leading: Image.asset(
                'assets/term.png',
                width: 35,
                height: 35,
              ),
              title: Text(
                AppLocalizations.of(context).terms,
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
            Divider(
              endIndent: 30,
              indent: 30,
              color: Colors.black54,
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext ctx) => ContactUs()));
              },
              leading: Image.asset(
                'assets/support.png',
                width: 35,
                height: 35,
              ),
              title: Text(
                AppLocalizations.of(context).suport,
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
            Divider(
              endIndent: 30,
              indent: 30,
              color: Colors.black54,
            ),
            ListTile(
              onTap: () {
                // Navigator.pop(context);
                showAlertDialog(context);
              },
              leading: Icon(
                Icons.language,
                color: Colors.white,
                textDirection: TextDirection.ltr,
              ),
              title: Text(
                AppLocalizations.of(context).languge,
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
            Divider(
              endIndent: 30,
              indent: 30,
              color: Colors.black54,
            ),
//  _buildLanguageWidget(),

            ListTile(
              onTap: () {
                logout();
              },
              leading: Image.asset(
                'assets/logout.png',
                width: 35,
                height: 35,
              ),
              title: Text(
                AppLocalizations.of(context).logout,
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
          ],
        ),
      ),
    );
  }

  changeLang() {}

  List<RadioModel> getLangList() {
    if (_index == 0) {
      _langList.add(new RadioModel(true, 'English'));
      _langList.add(new RadioModel(false, 'عربي'));
    } else if (_index == 1) {
      _langList.add(new RadioModel(false, 'English'));
      _langList.add(new RadioModel(true, 'عربي'));
    }

    return _langList;
  }

  Future<String> _getLanguageCode() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('languageCode') == null) {
      return null;
    }
    print('_fetchLocale():' + prefs.getString('languageCode'));
    return prefs.getString('languageCode');
  }

  void _initLanguage() async {
    Future<String> status = _getLanguageCode();
    status.then((result) {
      if (result != null && result.compareTo('en') == 0) {
        setState(() {
          _index = 0;
        });
      }
      if (result != null && result.compareTo('hi') == 0) {
        setState(() {
          _index = 1;
        });
      } else {
        setState(() {
          _index = 0;
        });
      }
      print("INDEX: $_index");

      _setupLangList();
    });
  }

  void _setupLangList() {
    setState(() {
      _langList.add(new RadioModel(_index == 0 ? true : false, 'English'));
      _langList.add(new RadioModel(_index == 0 ? false : true, 'عربي'));
    });
  }

  void _updateLocale(String lang, String country) async {
    print(lang + ':' + country);

    var prefs = await SharedPreferences.getInstance();
    prefs.setString('languageCode', lang);
    prefs.setString('countryCode', country);

    MyApp.setLocale(context, Locale(lang, country));
    Navigator.pop(context);
  }

  void _handleRadioValueChanged() {
    print("SELCET_VALUE: " + _index.toString());
    setState(() {
      switch (_index) {
        case 0:
          print("English");
          _updateLocale('en', '');
          break;
        case 1:
          print("arabic");
          _updateLocale('ar', '');
          break;
      }
    });
  }

  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),

      content: new Container(
        height: 100,
        width: 80,
        child: Container(
          height: 300,
          // padding: EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 4.0),
          margin: EdgeInsets.only(left: 4.0, right: 4.0),
          color: Colors.white,

          child: ListView.builder(
            itemCount: _langList.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              return new InkWell(
                splashColor: Colors.white,
                onTap: () {
                  setState(() {
                    _langList.forEach((element) => element.isSelected = false);
                    _langList[index].isSelected = true;
                    _index = index;
                    _handleRadioValueChanged();
                  });
                },
                child: new RadioItem(_langList[index]),
              );
            },
          ),
        ),
      ),
      // actions: [
      //   okButton,
      // ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget buildLanguageWidget() {
    return new Flexible(
      child: Container(
        height: 300,
        // padding: EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 4.0),
        margin: EdgeInsets.only(left: 4.0, right: 4.0),
        color: Color.fromRGBO(116, 189, 242, 1.0),

        child: ListView.builder(
          itemCount: _langList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return new InkWell(
              splashColor: Color.fromRGBO(116, 189, 242, 1.0),
              onTap: () {
                setState(() {
                  _langList.forEach((element) => element.isSelected = false);
                  _langList[index].isSelected = true;
                  _index = index;
                  _handleRadioValueChanged();
                });
              },
              child: new RadioItem(_langList[index]),
            );
          },
        ),
      ),
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;

  RadioItem(this._item);

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 50,
      // padding: EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 4.0),
      // margin: EdgeInsets.only(left: 4.0, right: 4.0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            // margin: EdgeInsets.only(left: 4.0, right: 4.0),
            child: new Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                new Container(
                  width: 200.0,
                  height: 1.0,
                  decoration: new BoxDecoration(
                    color: _item.isSelected ? Colors.grey : Colors.black,
                    border: new Border.all(
                        width: 1.0,
                        color: _item.isSelected
                            ? Color.fromRGBO(116, 189, 242, 1.0)
                            : Colors.transparent),
                    borderRadius:
                        const BorderRadius.all(const Radius.circular(2.0)),
                  ),
                ),
                new Container(
                  margin: new EdgeInsets.only(top: 8.0),
                  child: new Text(
                    _item.title,
                    style: TextStyle(
                      color: _item.isSelected
                          ? Color.fromRGBO(116, 189, 242, 1.0)
                          : Colors.black54,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String title;

  RadioModel(this.isSelected, this.title);
}
