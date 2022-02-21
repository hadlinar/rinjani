import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils/global.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  DateTime? rangeStartDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        leading: IconButton(
            onPressed: Navigator.of(context).pop,
            icon: ImageIcon(
              AssetImage(Global.BACK_ICON),
              color: Color(Global.BLUE),
              size: 18,
            )
        ),
        title: Text(
            "Back",
            style: Global.getCustomFont(Global.BLUE, 18, 'medium')
        ),
      ),
      body: TableCalendar(
        focusedDay: focusedDay,
        firstDay: DateTime(2000),
        lastDay: DateTime(2050),
        calendarFormat: format,
        onFormatChanged: (CalendarFormat _format) {
          setState(() {
            format = _format;
          });
        },
        startingDayOfWeek: StartingDayOfWeek.sunday,
        daysOfWeekVisible: true,
        onDaySelected: (DateTime selectDay, DateTime focusDay) {
          setState(() {
            selectedDay = selectDay;
            focusedDay = focusDay;
          });
          print(focusedDay);
        },
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(color: Color(Global.BLACK), fontFamily: 'medium'),
          weekendStyle: TextStyle(color: Color(Global.GREY), fontFamily: 'medium'),
        ),
        calendarStyle: CalendarStyle(
          isTodayHighlighted: true,
          selectedDecoration: BoxDecoration(
            color: Color(Global.BLUE),
            shape: BoxShape.circle,
          ),
          weekendTextStyle: TextStyle(color: Color(Global.GREY), fontFamily: 'medium'),
          selectedTextStyle: TextStyle(color: Colors.white, fontFamily: 'medium'),
          todayTextStyle: TextStyle(color: Colors.white, fontFamily: 'medium'),
          todayDecoration: BoxDecoration(
            color: Color(0xff7AC8B5),
            shape: BoxShape.circle,
          ),
        ),
        selectedDayPredicate: (DateTime date) {
          return isSameDay(selectedDay, date);
        },
      )
    );
  }
}