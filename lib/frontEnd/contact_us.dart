import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tabdeel/localizations.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;


class ContactUs extends StatefulWidget {
  _BirdState createState() => new _BirdState();
}

class _BirdState extends State<ContactUs> {

  

  
  List datacontactus = [];
  void getAllSubjects() {
   
    var url = 'http://riyadasa.com/sites/tabdel/ServiceApis/RestFul/General/SendEmail.php?Name='+'${controllerName.text}'+'&Email='+'${controllerEmail.text}'+'&Subject='+'${controllerphone.text}'+'&Message='+'${controllerText.text}';
    http.get(url, headers: {
      // "Accept": "application/x-www-form-urlencoded",
      "Content-Type": "application/x-www-form-urlencoded",
    }).then((response) {
      
      // var extractdata = json.decode(response.body);
      var extractdata = json.decode(response.body);
      print(extractdata['success']);
       print(extractdata);
        setState(() {
        datacontactus = extractdata['Subjects'];
        print(extractdata['message']);
         Toast.show("تم الإرسال بنجاح", context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.CENTER,
            backgroundColor: Colors.grey);
        });
        //  Navigator.push(context, MaterialPageRoute(builder: 
        //     (context) => HomePage()),);
            // Function_ButtonSend();
     
    });
  }


 

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerphone = TextEditingController();
  TextEditingController controllerText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

        //---------AppBar---------------------------------
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(116, 189, 242, 1.0),
          elevation: 0,
          centerTitle: true,
          title: new Center(child: new Text(AppLocalizations.of(context).technecal),),
          // leading: IconButton(icon: Icon(Icons.search,size: 30,), onPressed: (){Function_ButtonSearch();}),
        ),


        //---------endDrawer---------------------------------
        // endDrawer: DrawerApp(),


        //---------body---------------------------------------
        body: ListView(children: <Widget>[
          Directionality(textDirection: TextDirection.rtl,
            child: new Container(
              padding: EdgeInsets.all(30),
              child: Column(children: <Widget>[

                myTextField(radius: 5 ,labelText: AppLocalizations.of(context).name, textInput: TextInputType.text , controllers: controllerName),
                SizedBox(height: 10),

                myTextField(radius: 5 ,labelText: AppLocalizations.of(context).email , textInput: TextInputType.emailAddress , controllers: controllerEmail),
                SizedBox(height: 10),

                  myTextField(radius: 5 ,labelText: AppLocalizations.of(context).addressubject , textInput: TextInputType.emailAddress , controllers: controllerphone),
                SizedBox(height: 10),

                SizedBox(height: 10),
                myTextField(radius: 5 , labelText:AppLocalizations.of(context).message  , maxLines: 8 , controllers: controllerText , textInput: TextInputType.text),

                SizedBox(height: 20),
                myButton(onBtnclicked: (){
                getAllSubjects();} , radiusButton: 5 ,textButton: AppLocalizations.of(context).send ,
                 colorButton: Color.fromRGBO(116, 189, 242, 1.0))
              ],
            ),),
          )

        ],






      ),
    );
  }
}


  //===TextField =============================================
        Widget myTextField({
        String  hintText  ,
        String labelText ,
        TextEditingController controllers ,
        double horizontal :0,
        double vertical:0,
        TextInputType  textInput,
        int maxLines,
        double  radius,
        }) {
        return new Container(
        padding: EdgeInsets.symmetric(horizontal: horizontal ,vertical: vertical ),
        decoration: new BoxDecoration(
            color: Colors.grey[100]
        ),
        child: TextField(
          
        keyboardType: textInput,
        controller:  controllers,
        maxLines: maxLines,
        decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(radius)),
        //      border: InputBorder.none,
        hintText: hintText,
        enabled: true,
        contentPadding: EdgeInsets.all(12.0),
        labelText: labelText,
        ),
        ),
        );
        }

          //===Button=============================================
        Widget myButton({
        String textButton: "ارسال",
        double horizontal : 0,
        double vertical : 0,
        double radiusButton : 0,
        double elevation : 0,
        double heightButton : 50,
        Color colorText,
        Color colorButton ,
        VoidCallback onBtnclicked
        }) {
        textButton ="ارسال";
        horizontal =0.0;
        vertical = 0.0;
        radiusButton =0;
        colorText =Colors.white ;
        colorButton =colorButton ;
        return Padding(
        padding: new EdgeInsets.symmetric(horizontal: horizontal , vertical: vertical ),
        child: new RaisedButton(
        color: colorButton,
        elevation: elevation,
        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.all(new Radius.circular(radiusButton))),
        onPressed: onBtnclicked,
        child: Container(
        height: heightButton,
        child: new Center(child: new Text(textButton, style: new TextStyle(color: colorText, fontSize: 12),),),
        ),
        ),
        );
        }
