import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:tabdeel/frontend/mainPager/second_page.dart';
import 'package:tabdeel/localizations.dart';

import '../login.dart';
import 'first_page.dart';
import 'third_page.dart';

class MainPage extends StatefulWidget {
  @override
  _SliderState createState() => _SliderState();
}

class _SliderState extends State<MainPage> {
  static PageController controller =
      new PageController(initialPage: 1, keepPage: false);
  static List<Widget> pages = [FirstPage(), SecondPage(), ThirdPage()];
  PageView pageView = new PageView(
    onPageChanged: (pageNumber) {
      print('PageNumber:' + pageNumber.toString());
    },
    scrollDirection: Axis.horizontal,
    controller: controller,
    children: pages,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Color.fromRGBO(116, 189, 242, 1.0),
            child: Stack(
              children: <Widget>[
                Align(
                  child: PageIndicatorContainer(
                    child: pageView,
                    align: IndicatorAlign.bottom,
                    length: 3,
                    indicatorSpace: 10.0,

                    padding: EdgeInsets.fromLTRB(10, 0, 10, 100),
                    indicatorColor: Colors.white,
                    indicatorSelectorColor: Colors.yellow,
                    shape: IndicatorShape.circle(size: 12),
                    // shape: IndicatorShape.roundRectangleShape(size: Size.square(12),cornerSize: Size.square(3)),
                    // shape: IndicatorShape.oval(size: Size(12, 8)),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            width: 150,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              color: Colors.white,
                              textColor: Color.fromRGBO(116, 189, 242, 1.0),
                              child: Text(
                                AppLocalizations.of(context).next,
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
                              },
                            ),
                          ),
                          InkWell(
                            child: Text(
                              AppLocalizations.of(context).skap,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.white,
                                  fontSize: 15),
                            ),
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => Login()));
                            },
                          )
                        ],
                      ),
                    ))
              ],
            )));
  }
}
