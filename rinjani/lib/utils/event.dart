import 'dart:collection';
import 'dart:convert';
import 'dart:core';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rinjani/utils/global.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;

import '../models/visit.dart';

/// Example event class.

VisitResponse visitResponseFromJson(String str) => VisitResponse.fromJson(json.decode(str));

String visitResponseToJson(Visit data) => json.encode(data.toJson());

class Visit {
  String visit_no;
  String visit_cat;
  String branch_id;
  String cust_id;
  DateTime time_start;
  DateTime time_finish;
  String user_id;
  String description;
  String pic_position;
  String pic_name;
  String status_visit;

  Visit({
    this.visit_no,
    this.visit_cat,
    this.branch_id,
    this.cust_id,
    this.time_start,
    this.time_finish,
    this.user_id,
    this.description,
    this.pic_position,
    this.pic_name,
    this.status_visit,
  });

  factory Visit.fromJson(Map<String, dynamic> json) =>
      Visit(
        visit_no: json['visit_no'] as String,
        visit_cat: json['visit_cat'] as String,
        branch_id: json['branch_id'] as String,
        cust_id: json['cust_id'] as String,
        time_start: DateTime.parse(json['time_start'] as String),
        time_finish: DateTime.parse(json['time_finish'] as String),
        user_id: json['user_id'] as String,
        description: json['description'] as String,
        pic_position: json['pic_position'] as String,
        pic_name: json['pic_name'] as String,
        status_visit: json['status_visit'] as String,
      );

  Map<String, dynamic> toJson() =>
      {
        "visit_no": visit_no,
        "visit_cat": visit_cat,
        "branch_id": branch_id,
        "cust_id": cust_id,
        'time_start': time_start.toIso8601String(),
        'time_finish': time_finish.toIso8601String(),
        'user_id': user_id,
        'description': description,
        'pic_position': pic_position,
        'pic_name': pic_name,
        'status_visit': status_visit,
      };
}

class VisitResponse{
  String message;
  List<Visit> result;

  VisitResponse(this.message, this.result);

  factory VisitResponse.fromJson(Map<String, dynamic> json) => VisitResponse(
    json['message'] as String,
    (json['result'] as List<dynamic>)
        .map((e) => Visit.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}


List<Visit> _visit;

Future<List<Visit>> fetchPost() async {
  final response = await http.get(Uri.parse(Global.baseURL+"/visit"));
  await http.get(Uri.parse(Global.baseURL+"/visit")).then((response) {
    var data = json.decode(response.body);

    setState(() {
      _visit = data['result'];
    });
  });

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<Visit>((json) => Visit.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}

void setState(Null Function() param0) {
}



/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
// final kEvents = LinkedHashMap<DateTime, List<Visit>>(
//   equals: isSameDay,
//   hashCode: getHashCode,
// )..addAll(_kEventSource);
// //
// final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
//     key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
//     value: (item) => List.generate(
//         item % 4 + 1, (index) => Event('Customer ${index + 1} | ${index + 1}'))
// )
//   ..addAll({
//     kToday: [
//       Event('Customer 1'),
//       Event('Customer 2'),
//     ],
//   });
//
// // final _kEventSource = Map.fromIterable(_visit,
// //   key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
// //   value: (item) => _visit.forEach((e) {
// //     Visit(
// //         visit_no: e.visit_no,
// //         visit_cat: e.visit_cat,
// //         branch_id: e.branch_id,
// //         cust_id: e.cust_id,
// //         time_start: e.time_start,
// //         time_finish: e.time_finish,
// //         user_id: e.user_id,
// //         description: e.description,
// //         pic_position: e.pic_position,
// //         pic_name: e.pic_name,
// //         status_visit: e.status_visit
// //       );
// //   })
// // );
//
// int getHashCode(DateTime key) {
//   return key.day * 1000000 + key.month * 10000 + key.year;
// }
//
// /// Returns a list of [DateTime] objects from [first] to [last], inclusive.
// List<DateTime> daysInRange(DateTime first, DateTime last) {
//   final dayCount = last.difference(first).inDays + 1;
//   return List.generate(
//     dayCount,
//         (index) => DateTime.utc(first.year, first.month, first.day + index),
//   );
// }
//
// final kToday = DateTime.now();
// final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
// final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);