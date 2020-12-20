import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabdeel/localizations.dart';
import 'package:tabdeel/translation.dart';
import 'frontend/splash.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// void main(List<String> args) {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: Splash(),
//      localizationsDelegates: [
//             AppLocalizationsDelegate(),
//             GlobalMaterialLocalizations.delegate,
//             GlobalWidgetsLocalizations.delegate,
//           ],
//           supportedLocales: [
//             const Locale('en', ''), // English
//             const Locale('hi', ''), // Hindi
//           ],
//           locale: locale,
//     theme: ThemeData(
//         fontFamily: 'jareda',
//         unselectedWidgetColor: Colors.white,
//         canvasColor: Colors.white),
//   ));
// }

void main() {
  // ignore: invalid_use_of_visible_for_testing_member
  SharedPreferences.setMockInitialValues({});

  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale newLocale) async {
    print('setLocale()');
    final _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    // _MyAppState state = context.ancestorStateOfType(TypeMatcher<_MyAppState>());
    state.setState(() {
      state.locale = newLocale;
    });
  }

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  void setLocale(BuildContext context, Locale newLocale) async {
    print('setLocale()');
    // _MyAppState state = context.ancestorStateOfType(TypeMatcher<_MyAppState>());
    final _MyAppState state = context.findAncestorStateOfType<_MyAppState>();


    state.setState(() {
      state.locale = newLocale;
    });
  }

  Locale locale;
  bool localeLoaded = false;

  @override
  void initState() {
    super.initState();
    print('initState()');
    this._fetchLocale().then((locale) {
      this.localeLoaded = true;
      this.locale = locale;
      print("#################$locale");

    });

  }

  @override
  Widget build(BuildContext context) {
    // if (this.localeLoaded == false) {
    //   return CircularProgressIndicator();
    // }
      return MaterialApp(
        title: 'Tabdeel',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
            fontFamily: 'jareda',
            unselectedWidgetColor: Colors.white,
            canvasColor: Colors.white
        ),
        home: new Splash(),
        localizationsDelegates: [
          AppLocalizationsDelegate(),
          // const TranslationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''), // English
          const Locale('ar', ''), // arabi
        ],
        locale: locale,
      );

  }

  _fetchLocale() async {
    var prefs = await SharedPreferences.getInstance();
    print(prefs.getString('languageCode'));

    if (prefs.getString('languageCode') == null) {
      return Locale('ar', '');
    }

    print('_fetchLocale():' +
        (prefs.getString('languageCode') +
            ':' +
            prefs.getString('countryCode')));

    return Locale(
        prefs.getString('languageCode'), prefs.getString('countryCode'));
  }
}