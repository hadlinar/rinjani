import 'package:flutter/foundation.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../models/visit.dart';

class EventProvider extends ChangeNotifier {
  final List<Visit> _events = [];
  final List<Appointment> appointments = <Appointment>[];

  List<Visit> get events => _events;

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime date) => _selectedDate = date;

  void addEvent(Visit event) {
    _events.add(Visit(
      visit_no: event.visit_no,
      visit_id: event.visit_id,
      branch_id: event.branch_id,
      cust_name: event.cust_name,
      cust_id: event.cust_id,
      time_start: event.time_start,
      time_finish: event.time_finish,
      user_id: event.user_id,
      description: event.description,
      pic_position: event.pic_position,
      pic_name: event.pic_name,
      status_visit: event.status_visit
    ));
    notifyListeners();
  }


}