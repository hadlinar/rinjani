// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
//
// class OSM extends StatefulWidget{
//   @override
//   State<StatefulWidget> createState() {
//     return _OSM();
//   }
// }
//
// class _OSM extends State<OSM> {
//   late MapController controller;
//
//   @override
//   void initState() {
//     super.initState();
//     controller = MapController(
//       initMapWithUserPosition: true,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return OSMFlutter(
//       controller: controller,
//       markerOption: MarkerOption(
//         defaultMarker: const MarkerIcon(
//           icon: Icon(
//             Icons.person_pin_circle,
//             color: Colors.blue,
//             size: 56,
//           ),
//         ),
//       ),
//       trackMyPosition: false,
//     );
//   }
// }