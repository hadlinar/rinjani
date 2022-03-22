// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:rinjani/views/page/realization.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// import '../utils/event.dart';
// import '../utils/global.dart';
// import '../views/page/plan.dart';
//
// class Calendar extends StatefulWidget {
//   @override
//   _CalendarState createState() => _CalendarState();
// }
//
// class _CalendarState extends State<Calendar> {
//   late final ValueNotifier<List<Event>> _selectedEvents;
//   CalendarFormat _calendarFormat = CalendarFormat.month;
//   // DateTime _focusedDay = DateTime.now().add(const Duration(days: 1));
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;
//
//   @override
//   void initState() {
//     super.initState();
//     _selectedDay = _focusedDay;
//     _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
//   }
//
//   @override
//   void dispose() {
//     _selectedEvents.dispose();
//     super.dispose();
//   }
//
//   List<Event> _getEventsForDay(DateTime day) {
//     return kEvents[day] ?? [];
//   }
//
//   void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
//     if (!isSameDay(_selectedDay, selectedDay)) {
//       setState(() {
//         _selectedDay = selectedDay;
//         _focusedDay = focusedDay;
//       });
//
//       _selectedEvents.value = _getEventsForDay(selectedDay);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         centerTitle: false,
//         leading: IconButton(
//             onPressed: Navigator.of(context).pop,
//             icon: ImageIcon(
//               AssetImage(Global.BACK_ICON),
//               color: Color(Global.BLUE),
//               size: 18,
//             )
//         ),
//         title: Text(
//             "Home",
//             style: Global.getCustomFont(Global.BLUE, 18, 'medium')
//         ),
//       ),
//       body: SingleChildScrollView(
//         reverse: false,
//         child: Container(
//           padding: const EdgeInsets.only(left: 21, right: 21, bottom: 20),
//           color: Colors.white,
//           // height: MediaQuery.of(context).size.height,
//           child: Column(
//             children: [
//               Container(
//                 padding: const EdgeInsets.only(bottom: 17),
//                 color: Colors.white,
//                 child: TableCalendar<Event>(
//                   firstDay: kFirstDay,
//                   lastDay: kLastDay,
//                   daysOfWeekVisible: true,
//                   focusedDay: _focusedDay,
//                   selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
//                   calendarFormat: _calendarFormat,
//                   eventLoader: _getEventsForDay,
//                   startingDayOfWeek: StartingDayOfWeek.sunday,
//                   daysOfWeekStyle: DaysOfWeekStyle(
//                     weekdayStyle: TextStyle(color: Color(Global.BLACK), fontFamily: 'medium'),
//                     weekendStyle: TextStyle(color: Color(Global.GREY), fontFamily: 'medium'),
//                   ),
//                   calendarStyle: CalendarStyle(
//                     isTodayHighlighted: true,
//                     outsideDaysVisible: false,
//                     selectedDecoration: BoxDecoration(
//                       color: Color(Global.BLUE),
//                       shape: BoxShape.circle,
//                     ),
//                     defaultTextStyle: TextStyle(color: Color(Global.BLACK), fontFamily: 'medium'),
//                     weekendTextStyle: TextStyle(color: Color(Global.GREY), fontFamily: 'medium'),
//                     selectedTextStyle: const TextStyle(color: Colors.white, fontFamily: 'medium'),
//                     todayTextStyle: const TextStyle(color: Colors.white, fontFamily: 'medium'),
//                     todayDecoration: const BoxDecoration(
//                       color: Color(0xff7AC8B5),
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                   onDaySelected: _onDaySelected,
//                   onFormatChanged: (format) {
//                     if (_calendarFormat != format) {
//                       setState(() {
//                         _calendarFormat = format;
//                       });
//                     }
//                   },
//                   onPageChanged: (focusedDay) {
//                     _focusedDay = focusedDay;
//                   },
//                 ),
//               ),
//               Align(
//                   alignment: Alignment.centerLeft,
//                   child: Container(
//                     width: double.infinity,
//                     color: Colors.white,
//                     child: Stack(
//                         children: <Widget>[
//                           Container(
//                             padding: EdgeInsets.only(left: 18, right: 18, top: 9, bottom: 9),
//                             width: 153,
//                             height: 56,
//                             color: Colors.white,
//                             child: RaisedButton(
//                                 shape: RoundedRectangleBorder(
//                                     side: BorderSide(color: Color(Global.BLUE)),
//                                     borderRadius: BorderRadius.circular(20)
//                                 ),
//                                 color: Color(Global.BLUE),
//                                 onPressed: () {
//                                   Navigator.push(context, MaterialPageRoute(
//                                       builder: (context) => Plan()
//                                   ));
//                                 },
//                                 child: const Text(
//                                   "Add plan",
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontFamily: 'bold',
//                                       fontSize: 15
//                                   ),
//                                 )
//                             ),
//                           ),
//                         ]
//                     ),
//                   )
//               ),
//               Divider(
//                 height: 8,
//               ),
//               Container(
//                 child: ValueListenableBuilder<List<Event>>(
//                   valueListenable: _selectedEvents,
//                   builder: (context, value, _) {
//                     return Container(
//                       // padding: const EdgeInsets.only(bottom: 17),
//                       child: ListView.builder(
//                         itemCount: value.length,
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemBuilder: (context, index) {
//                           return Container(
//                             margin: const EdgeInsets.only(top: 17),
//                             height: 70,
//                             decoration: BoxDecoration(
//                               border: Border.all(),
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: ListTile(
//                               // onTap: () => print('${value[index]}'),
//                                 onTap: () {
//                                   Navigator.push(context, MaterialPageRoute(
//                                       builder: (context) => Realization()
//                                   ));
//                                 },
//                                 title: Container(
//                                     child: Column(
//                                         children: <Widget> [
//                                           Container(
//                                             margin: const EdgeInsets.only(top: 6),
//                                             child: Align(
//                                               alignment: Alignment.topLeft,
//                                               child: Text('${value[index]}', style: Global.getCustomFont(Global.BLACK, 16, 'bold')),
//                                             ),
//                                           ),
//                                           Container(
//                                               margin: const EdgeInsets.only(top:8),
//                                               child: Align(
//                                                 alignment: Alignment.topLeft,
//                                                 child: Text('${value[index]}', style: Global.getCustomFont(Global.BLACK, 16, 'book')),
//                                               )
//                                           )
//                                         ]
//                                     )
//                                 )
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../bloc/visit/visit_bloc.dart';
import '../models/visit.dart';
import '../utils/global.dart';
import '../views/page/plan.dart';
import 'event_data_source.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  List<VisitById> visit = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<VisitBloc>(context).add(GetVisitByIdEvent(store.get("nik")));
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
        body: BlocListener<VisitBloc, VisitBlocState>(
          listener: (context, state) {
            if (state is InitialVisitBlocState || state is LoadingVisitState) {
              Container(
                child: const Center(
                    child: CircularProgressIndicator()
                ),
              );
            } if (state is VisitByIdList) {
              setState(() {
                visit = state.getVisit;
              });
            } else {
              Container();
            }
          },
          child:  SingleChildScrollView(
              reverse: false,
              child: Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    SfCalendar(
                      view: CalendarView.month,
                      dataSource: EventDataSource(visit),
                      initialSelectedDate: DateTime.now(),
                      cellBorderColor: Colors.transparent,
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
                                            builder: (context) => Plan()
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
                  ],
                ),
              )
          )
        )
    );
  }
}