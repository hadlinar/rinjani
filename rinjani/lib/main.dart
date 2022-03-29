// //@dart=2.9
// import 'package:flutter/material.dart';
// import 'app_module.dart';
// import 'router.dart' as r;
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   print("launch app");
//
//   await AppModule.setup();
//
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return AppModule.configureBloc(MaterialApp(
//       theme: ThemeData(
//           backgroundColor: Color(0xFFffffff),
//           primaryColor: Color(0xFF008ECC),
//           accentColor: Color(0xFF008ECC),
//           canvasColor: Colors.transparent,
//           textTheme: TextTheme(
//               bodyText1: const TextStyle(
//                   fontFamily: "CircularStd-Bold", fontWeight: FontWeight.bold),
//               bodyText2: const TextStyle(fontFamily: "CircularStd-Medium"),
//               caption: const TextStyle(
//                   fontFamily: "CircularStd-Bold", fontWeight: FontWeight.w400),
//               headline1: const TextStyle(
//                   color: Colors.black,
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: "Circular Std"),
//               headline2: TextStyle(fontSize: 14),
//               button: TextStyle(
//                   fontSize: 14, color: Theme.of(context).accentColor))),
//       onGenerateRoute: r.Router.generateRouter,
//       initialRoute: r.Router.home,
//     ));
//   }
// }
