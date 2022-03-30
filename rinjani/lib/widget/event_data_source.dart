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
  DateTime getStartTime(int index) => getEvent(index).time_start;

  @override
  DateTime getEndTime(int index) => getEvent(index).time_finish;

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
      return Color(0xffffe57373);
    } else if(getEvent(index).visit_id == "01") {
      return Color(0xffff66bb6a);
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