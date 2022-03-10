import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rinjani/bloc/visit/visit_bloc.dart';
import 'package:rinjani/views/page/realization.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../utils/event.dart';
import '../utils/global.dart';
import '../views/page/plan.dart';

class Visit{
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
    required this.visit_no,
    required this.visit_cat,
    required this.branch_id,
    required this.cust_id,
    required this.time_start,
    required this.time_finish,
    required this.user_id,
    required this.description,
    required this.pic_position ,
    required this.pic_name,
    required this.status_visit,
  });

  factory Visit.fromJson(Map<String, dynamic> json) => Visit(
    visit_no: json["visit_no"],
    visit_cat: json["visit_cat"],
    branch_id: json["branch_id"],
    cust_id: json["cust_id"],
    time_start: DateTime.parse(json["time_start"]),
    time_finish: DateTime.parse(json["time_finish"]),
    user_id: json["user_id"],
    description: json["description"],
    pic_position: json["pic_position"],
    pic_name: json["pic_name"],
    status_visit: json["status_visit"],
  );

  Map<String, dynamic> toJson() => {
    "visit_no": visit_no,
    "visit_cat": visit_cat,
    "branch_id": branch_id,
    "cust_id": cust_id,
    "time_start": "${time_start.year.toString().padLeft(4, '0')}-${time_start.month.toString().padLeft(2, '0')}-${time_start.day.toString().padLeft(2, '0')}",
    "time_finish": "${time_finish.year.toString().padLeft(4, '0')}-${time_finish.month.toString().padLeft(2, '0')}-${time_finish.day.toString().padLeft(2, '0')}",
    "user_id": user_id,
    "description": description,
    "pic_position": pic_position,
    "pic_name": pic_name,
    // "status_visit": createTime.toIso8601String(),
    "status_visit": status_visit,
  };
}

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> with TickerProviderStateMixin{
  late List _selectedEvents;
  int _counter = 0;
  late Map<DateTime, List> _events;
  late CalendarController _calendarController;
  late AnimationController _animationController;

  // late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  // DateTime _focusedDay = DateTime.now().add(const Duration(days: 1));
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future<List<VisitModel>> getVisitAll() async {
    try {
      final response = await http.get(Uri.parse(Global.baseURL+"/visit"));

      final Map<String, dynamic> responseJson = json.decode(response.body);
      List eventList = responseJson['data'];
      final result = eventList
          .map<VisitModel>((json) => VisitModel.fromJson(json))
          .toList();
      return result;

    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<Map<DateTime, List>> getTask1() async {
    Map<DateTime, List> mapFetch = {};
    List<VisitModel> event = await getVisitAll();
    for (int i = 0; i < event.length; i++) {
      var createTime = DateTime(event[i].time_start.year,
          event[i].time_start.month, event[i].time_start.day);
      var original = mapFetch[createTime];
      if (original == null) {
        print("null");
        mapFetch[createTime] = [event[i].time_start];
      } else {
        print(event[i].time_start);
        mapFetch[createTime] = List.from(original)
          ..addAll([event[i].time_start]);
      }
    }
    return mapFetch;
  }

  var _visit;

  Future<Map<DateTime, List>> getTask() async {
    Map<DateTime, List> mapFetch = {};

    await Future.delayed(const Duration(seconds: 3), () {});

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
    }

    VisitResponse visitResponse = visitResponseFromJson(_visit);

    for (int i = 0; i < visitResponse.result.length; i++) {
      var createTime = DateTime(visitResponse.result[i].time_start.year,
          visitResponse.result[i].time_start.month, visitResponse.result[i].time_start.day);
      var original = mapFetch[createTime];
      if (original == null) {
        print("null");
        mapFetch[createTime] = [visitResponse.result[i].time_start];
      } else {
        print(visitResponse.result[i].time_start);
        mapFetch[createTime] = List.from(original)
          ..addAll([visitResponse.result[i].time_start]);
      }
    }

    return mapFetch;
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = [];
    BlocProvider.of<VisitBloc>(context).add(GetVisitEvent());
    _calendarController = CalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      getTask1().then((val) => setState(() {
        _events = val;
      }));
      //print( ' ${_events.toString()} ');
    });
  }

  void _onVisibleDaysChanged(DateTime first, DateTime last, CalendarFormat format) {
        print('CALLBACK: _onVisibleDaysChanged');
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date)
            ? Colors.brown[300]
            : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

  Widget _buildEventList() {
    return ListView(
      shrinkWrap: true,
      children: _selectedEvents
          .map((event) => Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.8),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin:
        const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: ListTile(
          title: Text(event.toString()),
          onTap: () => print('$event tapped!'),
        ),
      ))
          .toList(),
    );
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: BlocBuilder<VisitBloc, VisitBlocState>(
        builder: (context, state) {
          if(state is VisitList) {

            return SingleChildScrollView(
              reverse: false,
              child: Container(
                padding: const EdgeInsets.only(left: 21, right: 21, bottom: 20),
                color: Colors.white,
                // height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    // _buildTableCalendarWithBuilders(),
                    Container(
                      padding: const EdgeInsets.only(bottom: 17),
                      color: Colors.white,
                      child: TableCalendar(
                        //locale: 'pl_PL',
                        calendarController: _calendarController,
                        events:_visit,
                        //holidays: _holidays,
                        initialCalendarFormat: CalendarFormat.month,
                        formatAnimation: FormatAnimation.slide,
                        startingDayOfWeek: StartingDayOfWeek.sunday,
                        availableGestures: AvailableGestures.all,
                        availableCalendarFormats: const {
                          CalendarFormat.month: '',
                          CalendarFormat.week: '',
                        },
                        calendarStyle: CalendarStyle(
                          outsideDaysVisible: false,
                          weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
                          holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
                        ),
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
                        ),
                        headerStyle: HeaderStyle(
                          centerHeaderTitle: true,
                          formatButtonVisible: false,
                        ),
                        builders: CalendarBuilders(
                          selectedDayBuilder: (context, date, _) {
                            return FadeTransition(
                              opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
                              child: Container(
                                margin: const EdgeInsets.all(4.0),
                                padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                                color: Colors.deepOrange[300],
                                width: 100,
                                height: 100,
                                child: Text(
                                  '${date.day}',
                                  style: TextStyle().copyWith(fontSize: 16.0),
                                ),
                              ),
                            );
                          },
                          todayDayBuilder: (context, date, _) {
                            return Container(
                              margin: const EdgeInsets.all(4.0),
                              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                              color: Colors.amber[400],
                              width: 100,
                              height: 100,
                              child: Text(
                                '${date.day}',
                                style: TextStyle().copyWith(fontSize: 16.0),
                              ),
                            );
                          },
                          markersBuilder: (context, date, events, holidays) {
                            final children = <Widget>[];

                            if (events.isNotEmpty) {
                              children.add(
                                Positioned(
                                  right: 1,
                                  bottom: 1,
                                  child: _buildEventsMarker(date, events),
                                ),
                              );
                            }

                            if (holidays.isNotEmpty) {
                              children.add(
                                Positioned(
                                  right: -2,
                                  top: -2,
                                  child: _buildHolidaysMarker(),
                                ),
                              );
                            }

                            return children;
                          },
                        ),
                        onDaySelected: (date, visits, _) {
                          _onDaySelected(date, visits);
                          _animationController.forward(from: 0.0);
                        },
                        onVisibleDaysChanged: _onVisibleDaysChanged,
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: double.infinity,
                          color: Colors.white,
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
                                            builder: (context) => Plan(_focusedDay)
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
                    Divider(
                      height: 8,
                    ),
                    Container(
                      child: _buildEventList()
                    )
                    // Container(
                    //   child: ValueListenableBuilder<List<Event>>(
                    //     valueListenable: _selectedEvents,
                    //     builder: (context, value, _) {
                    //       return Container(
                    //         // padding: const EdgeInsets.only(bottom: 17),
                    //         child: ListView.builder(
                    //           itemCount: value.length,
                    //           shrinkWrap: true,
                    //           physics: const NeverScrollableScrollPhysics(),
                    //           itemBuilder: (context, index) {
                    //             return Container(
                    //               margin: const EdgeInsets.only(top: 17),
                    //               height: 70,
                    //               decoration: BoxDecoration(
                    //                 border: Border.all(),
                    //                 borderRadius: BorderRadius.circular(10),
                    //               ),
                    //               child: ListTile(
                    //                 // onTap: () => print('${value[index]}'),
                    //                   onTap: () {
                    //                     Navigator.push(context, MaterialPageRoute(
                    //                         builder: (context) => Realization()
                    //                     ));
                    //                   },
                    //                   title: Container(
                    //                       child: Column(
                    //                           children: <Widget> [
                    //                             Container(
                    //                               margin: const EdgeInsets.only(top: 6),
                    //                               child: Align(
                    //                                 alignment: Alignment.topLeft,
                    //                                 child: Text('${value[index]}', style: Global.getCustomFont(Global.BLACK, 16, 'bold')),
                    //                               ),
                    //                             ),
                    //                             Container(
                    //                                 margin: const EdgeInsets.only(top:8),
                    //                                 child: Align(
                    //                                   alignment: Alignment.topLeft,
                    //                                   child: Text('${value[index]}', style: Global.getCustomFont(Global.BLACK, 16, 'book')),
                    //                                 )
                    //                             )
                    //                           ]
                    //                       )
                    //                   )
                    //               ),
                    //             );
                    //           },
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
            );
          } else {
              return Container(
                padding: const EdgeInsets.only(top: 30),
                child: CircularProgressIndicator()
              );
          }
        }
      )
    );
  }
}

class VisitModel {
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

  VisitModel({
    required this.visit_no,
    required this.visit_cat,
    required this.branch_id,
    required this.cust_id,
    required this.time_start,
    required this.time_finish,
    required this.user_id,
    required this.description,
    required this.pic_position,
    required this.pic_name,
    required this.status_visit,
  });

  factory VisitModel.fromJson(Map<String, dynamic> json) =>
      VisitModel(
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
}