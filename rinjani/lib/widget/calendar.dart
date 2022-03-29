import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../bloc/visit/visit_bloc.dart';
import '../models/visit.dart';
import '../utils/global.dart';
import '../views/page/plan.dart';
import '../views/page/realization.dart' as real;
import 'event_data_source.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  List<Visit> visit = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<VisitBloc>(context).add(GetVisitEvent());
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
            } if (state is GetVisitState) {
              setState(() {
                visit = state.getVisit;
              });
            } else {
              Container();
            }
          },
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 21, right: 21, top: 21),
            child: SfCalendar(
              view: CalendarView.month,
              dataSource: EventDataSource(visit),
              initialSelectedDate: DateTime.now(),
              cellBorderColor: Colors.transparent,
              monthViewSettings: const MonthViewSettings(
                showAgenda: true,
                agendaItemHeight: 70,
                monthCellStyle: MonthCellStyle(
                  textStyle: TextStyle(color: Colors.black, fontSize: 12, fontFamily: 'medium'),
                  todayTextStyle: TextStyle(color: Colors.black, fontSize: 12, fontFamily: 'medium'),
                  trailingDatesTextStyle: TextStyle(color: Colors.grey, fontSize: 12, fontFamily: 'medium'),
                  leadingDatesTextStyle: TextStyle(color: Colors.grey, fontSize: 12, fontFamily: 'medium'),
                ),
                agendaStyle: AgendaStyle(
                  appointmentTextStyle: TextStyle(
                      fontSize: 14,
                      fontFamily: 'bold',
                      color: Colors.white),
                  dateTextStyle: TextStyle(
                      fontFamily: 'medium',
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.black),
                  dayTextStyle: TextStyle(
                      fontFamily: 'bold',
                      fontSize: 17,
                      color: Colors.black),
                ),
              ),
              onTap: calendarTapped
            ),
          )
        ),
        floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Color(Global.BLUE),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => Plan(
                successAddVisit: (int resMessage, BuildContext ctx) {
                  if (resMessage == 200) {
                    Navigator.of(ctx).pop();
                    Navigator.of(ctx).pop();
                    BlocProvider.of<VisitBloc>(context).add(GetVisitEvent());
                  }
                },
              ))
          );

        },
      ),
    );
  }

  void calendarTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment ||
        details.targetElement == CalendarElement.agenda) {
      final Visit _visit = details.appointments![0];

      Navigator.push(context, MaterialPageRoute(
          builder: (context) => real.Realization(visit: _visit, fromCal: true)
      ));
      }
    }
  }