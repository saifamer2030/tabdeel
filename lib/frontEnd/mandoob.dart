import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tabdeel/BackEnd/shared.dart';
import 'package:tabdeel/localizations.dart';

class Driver extends StatefulWidget {
  final StringBuffer nationality;
  var numberID;
  final StringBuffer imgIDPath;
  final StringBuffer imgLicensePath;
  final StringBuffer imgFrontCarPath;
  final StringBuffer imgRearCarPath;

  Driver(this.nationality, this.numberID, this.imgIDPath, this.imgLicensePath,
      this.imgFrontCarPath, this.imgRearCarPath);

  @override
  _DriverState createState() => _DriverState(
      this.nationality,
      this.numberID,
      this.imgIDPath,
      this.imgLicensePath,
      this.imgFrontCarPath,
      this.imgRearCarPath);
}

class _DriverState extends State<Driver> {
  StringBuffer nationality;
  var numberID;
  StringBuffer imgIDPath;
  StringBuffer imgLicensePath;
  StringBuffer imgFrontCarPath;
  StringBuffer imgRearCarPath;

  _DriverState(this.nationality, this.numberID, this.imgIDPath,
      this.imgLicensePath, this.imgFrontCarPath, this.imgRearCarPath);

  List nations = [];
  List<String> nationsNames = ['سعودي'];
  String dropVal = 'سعودي';
  @override
  void initState() {
    super.initState();

    getAllNationalities().then((response) {
      String res = response.body;
      List data = json.decode(res)['AllNationalities'];
      nations.addAll(data);

      nations.forEach((myMap) {
        nationsNames.add(myMap['name']);
      });
      setState(() {});
      print('SuccessGetNations:$data');
    }).catchError((error) {
      print('ErrorGetNations:$error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                 AppLocalizations.of(context).nationality,
                  style: TextStyle(color: Colors.white),
                ),
                RaisedButton(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {},
                  child: DropdownButton<String>(
                    iconEnabledColor: Colors.grey,
                    value: dropVal,
                    icon: Icon(Icons.arrow_drop_down),
                    onChanged: (String newValue) {
                      print(newValue);

                      setState(() {
                        dropVal = newValue;
                        nationality.clear();

                        nations.forEach((myMap) {
                          if (myMap['name'] == dropVal) {
                            nationality.write(myMap['NationalityID']);
                          }
                        });

                        print(nationality.toString());
                      });
                    },
                    items: nationsNames
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(
                              value,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ));
                    }).toList(),
                  ),
                ),
                (imgIDPath.isEmpty)
                    ? RaisedButton(
                        color: Colors.white,
                        child: Text(
                          AppLocalizations.of(context).imagenation,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        textColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          getImage().then((img) {
                            imgIDPath.clear();
                            imgIDPath.write(img.path);

                            setState(() {});
                          });
                        },
                      )
                    : Container(
                        width: 100,
                        height: 50,
                        margin: EdgeInsets.only(top: 5),
                        child: InkWell(
                          onTap: () {
                            getImage().then((img) {
                              imgIDPath.clear();
                              imgIDPath.write(img.path);
                              setState(() {});
                            });
                          },
                          child: Image.file(File(imgIDPath.toString())),
                        ),
                      ),
                (imgFrontCarPath.isEmpty)
                    ? RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Colors.white,
                        child: Text(
                          AppLocalizations.of(context).frontcar,
                          style: TextStyle(fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        textColor: Colors.grey,
                        onPressed: () {
                          getImage().then((img) {
                            imgFrontCarPath.clear();
                            imgFrontCarPath.write(img.path);
                            setState(() {});
                          });
                        },
                      )
                    : Container(
                        width: 100,
                        height: 50,
                        margin: EdgeInsets.only(top: 5),
                        child: InkWell(
                          onTap: () {
                            getImage().then((img) {
                              imgFrontCarPath.clear();
                              imgFrontCarPath.write(img.path);
                              setState(() {});
                            });
                          },
                          child: Image.file(File(imgFrontCarPath.toString())),
                        ),
                      ),
              ],
            ),
          ),
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                 AppLocalizations.of(context).ids,
                  style: TextStyle(color: Colors.white),
                ),
                Container(
                  width: 120,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    controller: numberID,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: AppLocalizations.of(context).enternumber,
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                (imgLicensePath.isEmpty)
                    ? RaisedButton(
                        color: Colors.white,
                        child: Text(
                          AppLocalizations.of(context).cellimag,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        textColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          getImage().then((img) {
                            imgLicensePath.clear();
                            imgLicensePath.write(img.path);
                            setState(() {});
                          });
                        },
                      )
                    : Container(
                        margin: EdgeInsets.only(top: 5),
                        width: 100,
                        height: 50,
                        child: InkWell(
                          onTap: () {
                            getImage().then((img) {
                              imgLicensePath.clear();
                              imgLicensePath.write(img.path);
                              setState(() {});
                            });
                          },
                          child: Image.file(File(imgLicensePath.toString())),
                        ),
                      ),
                (imgRearCarPath.isEmpty)
                    ? RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Colors.white,
                        child: Text(
                          AppLocalizations.of(context).carback,
                          style: TextStyle(fontWeight: FontWeight.w500),
                          textAlign: TextAlign.center,
                        ),
                        textColor: Colors.grey,
                        onPressed: () {
                          getImage().then((img) {
                            imgRearCarPath.clear();
                            imgRearCarPath.write(img.path);

                            setState(() {});
                          });
                        },
                      )
                    : Container(
                        margin: EdgeInsets.only(top: 5),
                        width: 100,
                        height: 50,
                        child: InkWell(
                          onTap: () {
                            getImage().then((img) {
                              imgRearCarPath.clear();
                              imgRearCarPath.write(img.path);

                              setState(() {});
                            });
                          },
                          child: Image.file(File(imgRearCarPath.toString())),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<File> getImage() async {
  return await ImagePicker.pickImage(source: ImageSource.gallery);
}
