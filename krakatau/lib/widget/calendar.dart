import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils/global.dart';
import '../views/page/planning.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime? focusedDay = DateTime.now();
  bool isLoading = false;
  late List<String>? autoCompletion;

  Future fetchAutoCompleteData() async {
    setState(() {
      isLoading = true;
    });

    final String stringData = await rootBundle.loadString("assets/dummy.json");
    final List<dynamic> json = jsonDecode(stringData);
    final List<String> jsonStringData = json.cast<String>();

    setState((){
      isLoading = false;
      autoCompletion = jsonStringData;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAutoCompleteData();
  }

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
            "Home",
            style: Global.getCustomFont(Global.BLUE, 18, 'medium')
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 21, right: 21),
            color: Colors.white,
            child: TableCalendar(
              focusedDay: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1),
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
                defaultTextStyle: TextStyle(color: Color(Global.BLACK), fontFamily: 'medium'),
                weekendTextStyle: TextStyle(color: Color(Global.GREY), fontFamily: 'medium'),
                selectedTextStyle: TextStyle(color: Colors.white, fontFamily: 'medium'),
                todayTextStyle: const TextStyle(color: Colors.white, fontFamily: 'medium'),
                todayDecoration: const BoxDecoration(
                  color: Color(0xff7AC8B5),
                  shape: BoxShape.circle,
                ),
              ),
              selectedDayPredicate: (DateTime date) {
                return isSameDay(selectedDay, date);
              },
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.only(left: 21),
              child: Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 18, right: 18, top: 9, bottom: 9),
                      width: 153,
                      height: 56,
                      color: Colors.white,
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Color(Global.BLUE)),
                              borderRadius: BorderRadius.circular(20)
                          ),
                          color: Color(Global.BLUE),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => Planning(focusedDay: focusedDay, autoCompletion: autoCompletion)
                            ));
                          },
                          child: const Text(
                            "Add plan",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'bold',
                                fontSize: 15
                            ),
                          )
                      ),
                    ),
                  ]
              ),
            )
          ),
          Container(
            color: Colors.white
          )
        ],
      )
    );
  }
}