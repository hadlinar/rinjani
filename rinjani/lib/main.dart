// @dart=2.9
import 'package:flutter/material.dart';
import 'package:rinjani/utils/global.dart';
import 'package:rinjani/views/home.dart';

import 'app_module.dart';

final dependency = AppModule(Global.baseURL);

void main() {
  print("launch app");

  dependency.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return dependency.configureBloc(
        MaterialApp(
          title: 'Rinjani',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Home(),
        )
    );
  }
}
