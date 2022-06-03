import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'router.dart' as r;

class RinjaniApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          backgroundColor: const Color(0xFFffffff),
          primaryColor: const Color(0xFF008ECC),
          canvasColor: Colors.transparent,
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.dark, // 2
          ),
          textTheme: TextTheme(
              bodyText1: const TextStyle(
                  fontFamily: "CircularStd-Bold", fontWeight: FontWeight.bold),
              bodyText2: const TextStyle(fontFamily: "CircularStd-Medium"),
              caption: const TextStyle(
                  fontFamily: "CircularStd-Bold", fontWeight: FontWeight.w400),
              headline1: const TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Circular Std"),
              headline2: const TextStyle(fontSize: 14),
              button: TextStyle(
                  fontSize: 14, color: Theme.of(context).colorScheme.secondary)), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFF008ECC))),
      onGenerateRoute: r.Router.generateRouter,
      initialRoute: r.Router.home,
    );
  }
}
