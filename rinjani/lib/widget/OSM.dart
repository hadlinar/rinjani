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
//   late MapController mapController;
//
//   @override
//   void initState() {
//     super.initState();
//     mapController = MapController(
//       initMapWithUserPosition: false,
//       initPosition: GeoPoint(latitude: 47.4358055, longitude: 8.4737324),
//     );
//   }
//
//   @override
//   void dispose() {
//     mapController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return OSMFlutter(
//       controller: mapController,
//       trackMyPosition: false,
//       initZoom: 12,
//       minZoomLevel: 8,
//       maxZoomLevel: 14,
//       stepZoom: 1.0,
//       userLocationMarker: UserLocationMaker(
//         personMarker: MarkerIcon(
//           icon: Icon(
//             Icons.location_history_rounded,
//             color: Colors.red,
//             size: 48,
//           ),
//         ),
//         directionArrowMarker: MarkerIcon(
//           icon: Icon(
//             Icons.double_arrow,
//             size: 48,
//           ),
//         ),
//       ),
//       road: Road(
//         startIcon: MarkerIcon(
//           icon: Icon(
//             Icons.person,
//             size: 64,
//             color: Colors.brown,
//           ),
//         ),
//         roadColor: Colors.yellowAccent,
//       ),
//       markerOption: MarkerOption(
//           defaultMarker: MarkerIcon(
//             icon: Icon(
//               Icons.person_pin_circle,
//               color: Colors.blue,
//               size: 56,
//             ),
//           )
//       ),
//     );
//   }
// }