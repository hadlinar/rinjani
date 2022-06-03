import 'dart:core';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

import '../models/visit.dart';

class EventDataSource extends CalendarDataSource{
  EventDataSource(List<Visit> appointments) {
    this.appointments = appointments;
  }

  Visit getEvent(int index) => appointments![index] as Visit;

  @override
  DateTime getStartTime(int index) {
    var time = DateFormat("yyyy-MM-dd HH:mm:ss").parse(getEvent(index).time_finish.toString());
    int newHourStart = getEvent(index).time_start.hour+0;
    // int newHourEnd = getEvent(index).time_finish.hour-7;

    var timeStart = DateTime(time.year, time.month, time.day, newHourStart, time.minute, time.second);
    // var timeFinish = DateTime(time.year, time.month, time.day, newHourEnd, time.minute, time.second);

    // String startTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(getEvent(index).time_start);
    DateTime time1 = DateFormat('yyyy-MM-dd HH:mm:ss').parse(timeStart.toString());
    return time1;
  }


  @override
  DateTime getEndTime(int index) {
    var time = DateFormat("yyyy-MM-dd HH:mm:ss").parse(getEvent(index).time_finish.toString());
    // int newHourStart = getEvent(index).time_start.hour-7;
    int newHourEnd = getEvent(index).time_finish.hour+0;

    // var timeStart = DateTime(time.year, time.month, time.day, newHourStart, time.minute, time.second);
    var timeFinish = DateTime(time.year, time.month, time.day, newHourEnd, time.minute, time.second);

    // String startTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(getEvent(index).time_start);
    DateTime time1 = DateFormat('yyyy-MM-dd HH:mm:ss').parse(timeFinish.toString());
    return time1;
  }

  @override
  String getSubject(int index) {
    if(getEvent(index).visit_id != "02") {
      getEvent(index).cust_name = getEvent(index).description;
      return getEvent(index).cust_name;
    }
    return getEvent(index).cust_name;
  }

  @override
  Color getColor(int index) {
    if(getEvent(index).visit_id == "03") {
      return const Color(0xffffe57373);
    } else if(getEvent(index).visit_id == "01") {
      return const Color(0xffff66bb6a);
    }
    return Colors.lightBlue;
  }

  @override
  String getCustomerName(int index) => getEvent(index).cust_name;

  @override
  String getCustomerId(int index) => getEvent(index).cust_id;

  @override
  String getVisitNo(int index) => getEvent(index).visit_no;

  @override
  String getBranchId(int index) => getEvent(index).branch_id;

  @override
  String getPicName(int index) => getEvent(index).pic_name;

  @override
  String getPicPos(int index) => getEvent(index).pic_position;

}