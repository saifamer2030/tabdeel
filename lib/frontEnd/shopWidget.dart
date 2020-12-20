import 'package:flutter/material.dart';

class Shop extends StatefulWidget {
   var shopNameController;
   var commericalRecordController;
  final StringBuffer subscribeRadioVal;

  Shop(this.shopNameController,this.commericalRecordController,this.subscribeRadioVal);

  @override
  _ShopState createState() => _ShopState(shopNameController,commericalRecordController,subscribeRadioVal);
}

class _ShopState extends State<Shop> {

   StringBuffer subscribeRadioVal;
  var shopNameController;
  var commericalRecordController;
  
  int radioVal=1;

  _ShopState(this.shopNameController,this.commericalRecordController,this.subscribeRadioVal);

  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextField(
              controller: shopNameController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'اسم المحل',
                hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    ),
              ),
            ),
          ),
        ),
        Container(

          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextField(
              controller: commericalRecordController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    ),
                hintText: 'السجل التجاري',
              ),
            ),
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
                    'الأشتراك',
                    style: TextStyle(color: Colors.white),
                  ),
                  Radio(
                    groupValue: radioVal,
                    onChanged: (val) {
                      setState(() {
                        radioVal = val;
                        subscribeRadioVal.clear();
                        subscribeRadioVal.write("month");
                      });
                    },
                    value: 1,
                    activeColor: Colors.yellow,
                  ),
                  Text('شهري', style: TextStyle(color: Colors.white)),
                  Radio(
                    groupValue: radioVal,
                    onChanged: (val) {
                      setState(() {
                        radioVal = val;

                        subscribeRadioVal.clear();
                        subscribeRadioVal.write("year");
                      });
                    },
                    value: 2,
                    activeColor: Colors.yellow,
                  ),
                  Text('سنوي', style: TextStyle(color: Colors.white)),
                 
                ],
              )),
        ),
      ],
    );
  }
}
