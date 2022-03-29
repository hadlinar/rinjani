import 'package:flutter/material.dart';

import 'router.dart' as r;

class RinjaniApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          backgroundColor: Color(0xFFffffff),
          primaryColor: Color(0xFF008ECC),
          accentColor: Color(0xFF008ECC),
          canvasColor: Colors.transparent,
          textTheme: TextTheme(
              bodyText1: TextStyle(
                  fontFamily: "CircularStd-Bold", fontWeight: FontWeight.bold),
              bodyText2: TextStyle(fontFamily: "CircularStd-Medium"),
              caption: TextStyle(
                  fontFamily: "CircularStd-Bold", fontWeight: FontWeight.w400),
              headline1: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Circular Std"),
              headline2: TextStyle(fontSize: 14),
              button: TextStyle(
                  fontSize: 14, color: Theme.of(context).accentColor))),
      onGenerateRoute: r.Router.generateRouter,
      initialRoute: r.Router.home,
    );
  }
}
