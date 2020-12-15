import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabdeel/BackEnd/models/color.dart';
import 'package:tabdeel/BackEnd/models/order_model.dart';
import 'package:tabdeel/localizations.dart';
import 'package:tabdeel/tooles/print.dart';

class ProductsDetails extends StatefulWidget {
  final ClientOrderDetails orderDetails;
  ProductsDetails(this.orderDetails);

  @override
  _ProductsDetailsState createState() =>
      _ProductsDetailsState(this.orderDetails);
}

class _ProductsDetailsState extends State<ProductsDetails> {
  int radioVal = 0;
  String dropdownValue = 'اللون';
   String dropdownEnValue = 'The color';
  bool inputtype = false;
  bool inputOldsizetype=false;
  bool inputNewsizetype=false;
 FocusNode _focusNode;
  FocusNode _focusNodenewsize;
   FocusNode _focusNodeoldsize;
  ClientOrderDetails orderDetails;
  var timeend;
 
  var productNameController = TextEditingController();
  var productColorController = TextEditingController();
  var productColorEnController = TextEditingController();
   var productNewSizeController = TextEditingController();
    var productEnNewSizeController = TextEditingController();
    var productOldSizeController = TextEditingController();
    var productEnOldSizeController = TextEditingController();
  String orderType = "0";
  var deservedMoneyController = TextEditingController();
  var notesController = TextEditingController();
  var oldSizeController = 'المقاس القديم';
  var oldSizeEnController = 'Old size';
  var newSizeController = 'المقاس الجديد';
   var newSizeEnController = 'New size';
  String billImage = "";

  File billImageGalary;

  String lang;
 _fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    print(prefs.getString('languageCode'));
     setState(() {
       lang=prefs.getString('languageCode');
     }); 

    }

 List<ColorModel> _companies = ColorModel.getCompanies();
  List<DropdownMenuItem<ColorModel>> _dropdownMenuItems;
  ColorModel selectedCompany;
List<DropdownMenuItem<ColorModel>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<ColorModel>> items = List();
    for (ColorModel company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }
 
  onChangeDropdownItem(ColorModel selectedCompany) {
    setState(() {
      selectedCompany = selectedCompany;
      printBlue(selectedCompany.name);
    });
  }

  @override
  initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_companies);
    selectedCompany = _dropdownMenuItems[0].value;
    super.initState();
    _fetchLocale();
    orderType = '0';
    productColorController.text='اللون';
    productNewSizeController.text='المقاس الجديد';
    productOldSizeController.text='المقاس القديم';
    productEnNewSizeController.text='New size';
    productEnOldSizeController.text='Old size';

      _focusNode = FocusNode();
      _focusNodenewsize = FocusNode();
      _focusNodeoldsize= FocusNode();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) productColorController.clear();
    });
    _focusNodenewsize.addListener(() {
      if (_focusNodenewsize.hasFocus) productNewSizeController.clear();
    });
    _focusNodenewsize.addListener(() {
      if (_focusNodenewsize.hasFocus) productEnNewSizeController.clear();
    });
    _focusNodeoldsize.addListener(() {
      if (_focusNodeoldsize.hasFocus) productOldSizeController.clear();
    });
    _focusNodeoldsize.addListener(() {
      if (_focusNodeoldsize.hasFocus) productEnOldSizeController.clear();
    });
  }

  _ProductsDetailsState(this.orderDetails);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: productNameController,
          onChanged: (val) {
            print(val);
            orderDetails.productName = val;
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              hintText: lang=='en'?'Product name':'اسم المنتج',
              hintStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.grey[300]),
        ),

//  Expanded(
//                         child: RaisedButton(
//                           color: Colors.grey[300],
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(5)),
//                           onPressed: () {},
//   child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Text("Select a company"),
//                 SizedBox(
//                   height: 20.0,
//                 ),DropdownButton(
//                   value: _selectedCompany,
//                   items: _dropdownMenuItems,
//                   onChanged: onChangeDropdownItem,
//                 ),
//                 SizedBox(
//                   height: 20.0,
//                 ),
//                 Text('Selected: ${_selectedCompany.name}'),
//                     ]))),


        Row(
          children: <Widget>[
            Radio(
              value: 0,
              onChanged: (val) {
                radioVal = val;

                if (val == 0)
                  orderType = "0";
                else
                  orderType = "1";
                orderDetails.orderType = orderType;
                setState(() {});
              },
              groupValue: radioVal,
              activeColor: Color.fromRGBO(116, 189, 242, 1.0),
            ),
            Text(
              lang=='en'?'Replace':'استبدال',
              style: TextStyle(color: Colors.grey),
            ),
            Radio(
              value: 1,
              onChanged: (val) {
                radioVal = val;

                if (val == 0)
                  orderType = "0";
                else
                  orderType = "1";
                orderDetails.orderType = orderType;
                setState(() {});
              },
              groupValue: radioVal,
              activeColor: Color.fromRGBO(116, 189, 242, 1.0),
            ),
            Text(
               lang=='en'?'Recovery':'استرجاع',
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
        (radioVal == 1)
            ? TextField(
                keyboardType: TextInputType.phone,
                controller: deservedMoneyController,
                onChanged: (val) {
                  orderDetails.deservedMoney = val;
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    hintText:  lang=='en'?'deserved amount':'المبلغ المستحق',
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.grey[300]),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                  lang=='en'?'Will be replaced':'سيتم استبدال:',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 10,
                  ),



              
             
          



                  
                  lang=='en'?Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Colors.grey[300],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: () {},
                          child: DropdownButton<String>(
                            iconEnabledColor: Colors.grey,
                            value: dropdownEnValue,
                           
                            icon: Icon(Icons.arrow_drop_down),
                            onChanged: (String newValue) {
                              setState(() {
                                printGreen(newValue);
                                if (newValue == 'Other') {
                                  inputtype = true;
                                   orderDetails.color = productColorEnController.text;
                                      dropdownEnValue =  productColorEnController.text;
                                } else {
                                  inputtype = false;
                                   orderDetails.color = newValue;
                                      dropdownEnValue = newValue;
                                }
                              });
                            },
                            items: <String>[
                             'The color',
                             'white',
                             'black',
                             'green',
                             'blue',
                             'yellow',
                             'brouwn',
                             'red',
                             'orange',
                             'Purple',
                             'grey',
                             'Other'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              );
                            }).toList(),
                            isExpanded: true,
                          ),
                         
                        ),
                      )
                    ],
                  )
                  :Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Colors.grey[300],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: () {},
                          child: DropdownButton<String>(
                            iconEnabledColor: Colors.grey,
                            value: dropdownValue,
                           
                            icon: Icon(Icons.arrow_drop_down),
                            onChanged: (String newValue) {
                              setState(() {
                             
                               
                                printGreen(newValue);

                                if (newValue == 'غير ذلك') {
                                  inputtype = true;
                                   orderDetails.color = productColorController.text;
                                      dropdownValue =  productColorController.text;
                                } else {
                                  inputtype = false;
                                   orderDetails.color = newValue;
                                      dropdownValue = newValue;
                                }
                              });
                            },
                            items: <String>[
                              'اللون',
                              'أبيض',
                              'أسود',
                              'أخضر',
                              'أزرق',
                              'أصفر',
                              'بني',
                              'أحمر',
                              'برتقالي',
                              'لبني',
                              'بنفسجي',
                              'رمادي',
                              'غير ذلك'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              );
                            }).toList(),
                            isExpanded: true,
                          ),
                         
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  inputtype == true
                      ? TextField(
                          controller: productColorController,
                          focusNode: _focusNode, 
                         onChanged: (val) {
            print(val);
            orderDetails.color = val;
          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              hintText: AppLocalizations.of(context).ordercolor,
                              hintStyle: TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Colors.grey[300]),
                        )
                      : new Container(),

                  
                  
                 lang=='en'? Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Colors.grey[300],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: () {},
                          child: DropdownButton<String>(
                            hint: new Text(AppLocalizations.of(context).oldsize),
                            iconEnabledColor: Colors.grey,
                            value:oldSizeEnController,
                            isExpanded: true,
                            icon: Icon(Icons.arrow_drop_down),
                            onChanged: (String newValue) {
                              setState(() {
                                

                                 if (newValue == 'Not for you') {
                                  inputOldsizetype = true;
                                  //  orderDetails.color = productColorController.text;
                                    oldSizeEnController = productEnOldSizeController.text;
                                orderDetails.oldSize = productEnOldSizeController.text;
                                } else {
                                  inputOldsizetype = false;
                                  oldSizeEnController = newValue;
                                orderDetails.oldSize = newValue;
                                }

                              });
                            },
                            items: <String>[
                              'Old size',
                              'XS',
                              'S',
                              'M',
                              'L',
                              'XL',
                              'Not for you'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      )
                    ],
                  ):Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Colors.grey[300],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: () {},
                          child: DropdownButton<String>(
                            hint: new Text(AppLocalizations.of(context).oldsize),
                            iconEnabledColor: Colors.grey,
                            value:  oldSizeController,
                            isExpanded: true,
                            icon: Icon(Icons.arrow_drop_down),
                            onChanged: (String newValue) {
                              setState(() {
                                

                                 if (newValue == 'غير ذلك') {
                                  inputOldsizetype = true;
                                  //  orderDetails.color = productColorController.text;
                                    oldSizeController = productOldSizeController.text;
                                orderDetails.oldSize = productOldSizeController.text;
                                } else {
                                  inputOldsizetype = false;
                                  oldSizeController = newValue;
                                orderDetails.oldSize = newValue;
                                }

                              });
                            },
                            items: <String>[
                              'المقاس القديم',
                              'XS',
                              'S',
                              'M',
                              'L',
                              'XL',
                              'غير ذلك'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      )
                    ],
                  ),




 SizedBox(
                    height: 5,
                  ),
                  inputOldsizetype == true
                      ? TextField(
                        focusNode: _focusNodeoldsize,
                         keyboardType: TextInputType.number,
                          controller: productOldSizeController,
                         onChanged: (val) {
            print(val);
            orderDetails.oldSize = val;
          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              hintText: AppLocalizations.of(context).oldsize,
                              hintStyle: TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Colors.grey[300]),
                        )
                      : new Container(),
                  // TextField(
                  //   controller: oldSizeController,
                  //   onChanged: (val){
                  //     orderDetails.oldSize=val;
                  //   },
                  //   decoration: InputDecoration(
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(5),
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(5),
                  //       ),
                  //       hintText: 'المقاس القديم',
                  //       hintStyle: TextStyle(color: Colors.grey),
                  //       filled: true,
                  //       fillColor: Colors.grey[300]),
                  // ),

                  SizedBox(
                    height: 5,
                  ),
                 lang=='en'?Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Colors.grey[300],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: () {},
                          child: DropdownButton<String>(
                            hint: new Text(AppLocalizations.of(context).newsize),
                            iconEnabledColor: Colors.grey,
                            value: newSizeEnController,
                            isExpanded: true,
                            icon: Icon(Icons.arrow_drop_down),
                            onChanged: (String newValue) {
                              setState(() {
                                // orderDetails.newSize = newValue;
                                // newSizeController = newValue;

                                 if (newValue == 'Not for you') {
                                  inputNewsizetype = true;
                                    newSizeEnController = productEnNewSizeController.text;
                               orderDetails.newSize = productEnNewSizeController.text;
                                } else {
                                  inputNewsizetype = false;
                                  newSizeEnController = newValue;
                               orderDetails.newSize = newValue;
                                }
                              });
                            },
                            items: <String>[
                              'New size',
                              'XS',
                              'S',
                              'M',
                              'L',
                              'XL',
                              'Not for you'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      )
                    ],
                  ):
                   Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Colors.grey[300],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          onPressed: () {},
                          child: DropdownButton<String>(
                            hint: new Text(AppLocalizations.of(context).newsize),
                            iconEnabledColor: Colors.grey,
                            value: newSizeController,
                            isExpanded: true,
                            icon: Icon(Icons.arrow_drop_down),
                            onChanged: (String newValue) {
                              setState(() {
                                // orderDetails.newSize = newValue;
                                // newSizeController = newValue;

                                 if (newValue == 'غير ذلك') {
                                  inputNewsizetype = true;
                                  //  orderDetails.color = productColorController.text;
                                    newSizeController = productNewSizeController.text;
                               orderDetails.newSize = productNewSizeController.text;
                                } else {
                                  inputNewsizetype = false;
                                  newSizeController = newValue;
                               orderDetails.newSize = newValue;
                                }
                              });
                            },
                            items: <String>[
                              'المقاس الجديد',
                              'XS',
                              'S',
                              'M',
                              'L',
                              'XL',
                              'غير ذلك'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      )
                    ],
                  ),
 SizedBox(
                    height: 5,
                  ),
                  inputNewsizetype == true
                      ? TextField(
                        focusNode: _focusNodenewsize,
                         keyboardType: TextInputType.number,
                          controller: productNewSizeController,
                          onChanged: (val) {
            print(val);
            orderDetails.newSize = val;
          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5), 
                              ),
                              hintText: AppLocalizations.of(context).newsize,
                              hintStyle: TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Colors.grey[300]),
                        )
                      : new Container(),
                  // TextField(
                  //   controller: newSizeController,
                  //   onChanged: (val){
                  //     orderDetails.newSize=val;
                  //   },
                  //   decoration: InputDecoration(
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(5),
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(5),
                  //       ),
                  //       hintText: 'المقاس الجديد',
                  //       hintStyle: TextStyle(color: Colors.grey),
                  //       filled: true,
                  //       fillColor: Colors.grey[300]),
                  // )
                ],
              ),
        (billImageGalary == null)
            ? Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      color: Colors.grey[300],
                      textColor: Colors.grey,
                      child: Text(
                        AppLocalizations.of(context).imagbill
                       ,
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () async {
                        await getBillImageFromGallery();

                        encodeImage(billImageGalary).then((myImg) {
                          String encodedImg = base64Encode(myImg);
                          orderDetails.billImage = encodedImg;
                        });
                      },
                    ),
                  )
                ],
              )
            : Container(
                width: 100,
                height: 100,
                child: Image.file(billImageGalary),
              ),


             
        new Container(
            height: 200,
            child: TextField(
              controller: notesController,
              onChanged: (val) {
                orderDetails.notes = val;
              },
              // maxLines: 10,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 70.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  hintText: AppLocalizations.of(context).nots,
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[300]),
            )),
      ],
    );
  }

  Future getBillImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      billImageGalary = image;
    });
  }

  Future<List<int>> encodeImage(File img) async {
    return await img.readAsBytes();
  }
}
