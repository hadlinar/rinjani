import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

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
  List<Visit> visit = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<VisitBloc>(context).add(GetVisitForRealizationEvent());
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
            } if (state is SuccessDeleteVisitState) {
              setState(() {
                BlocProvider.of<VisitBloc>(context).add(GetVisitForRealizationEvent());
              });
            } else {
              Container();
            }
          },
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 21, right: 21, top: 21),
            child:
            SfCalendar(
                view: CalendarView.month,
                showNavigationArrow: true,
                headerStyle: const CalendarHeaderStyle(
                  textAlign: TextAlign.center,
                ),
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
                    BlocProvider.of<VisitBloc>(context).add(GetVisitForRealizationEvent());
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

      var time = DateFormat("yyyy-MM-dd HH:mm:ss").parse(_visit.time_finish.toLocal().toString());

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)
                )
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: Text(
                    _visit.visit_id == "01" ? "In-Office" : (_visit.visit_id == "03" ? "Off" : _visit.cust_name),
                    style: Global.getCustomFont(Global.BLACK, 15, 'medium'),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 17),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${DateFormat("HH:mm").format(_visit.time_start.toLocal())} - ${DateFormat("HH:mm").format(_visit.time_finish.toLocal())}",
                      style: Global.getCustomFont(Global.BLACK, 15, 'medium'),
                      textAlign: TextAlign.left,
                    ),
                  )
                ),
                _visit.visit_id == "02" ?
                Container(
                  padding: const EdgeInsets.only(top: 5),
                  height:  _visit.pic_name.contains(",") ? 150 : 50,
                  width: MediaQuery.of(context).size.width*0.75,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: _visit.pic_name.contains(",") ? Container (
                          child: ListView.builder(
                              itemCount: _visit.pic_name.split(", ").length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              // physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, j){
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.only(top: 5, left: 3),
                                      child: Text("${_visit.pic_name.split(", ")[j]} - ${_visit.pic_position.split(", ")[j]}", style: Global.getCustomFont(Global.BLACK, 14, 'medium')),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 3),
                                      child: Text("${_visit.description.split(", ")[j]}", style: Global.getCustomFont(Global.BLACK, 14, 'medium')),
                                    ),
                                    j == _visit.pic_name.split(", ").length-1 ? Container() :
                                    const Divider(
                                      height: 10,
                                      thickness: 0.5,
                                      color: Colors.grey,
                                    )
                                  ],
                                );
                              }
                          )
                      ) : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(top: 5, left: 3),
                            child: Text("${_visit.pic_name} - ${_visit.pic_position}", style: Global.getCustomFont(Global.BLACK, 14, 'medium')),
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 5, left: 3),
                            child: Text(_visit.description, style: Global.getCustomFont(Global.BLACK, 14, 'medium')),
                          )

                        ],
                      )
                  ),
                )
                : Container(
                  padding: const EdgeInsets.only(top: 5),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _visit.description,
                      style: Global.getCustomFont(Global.BLACK, 15, 'medium'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  height: 17,
                ),
                DateTime.now().isAfter(time) ?
                Container(
                  child: Container(
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                  color: Theme
                                      .of(context)
                                      .accentColor,
                                  width: 3
                              )
                          ),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "Ok",
                            style: TextStyle(
                                color: Color(Global.BLUE),
                                fontFamily: 'bold',
                                fontSize: 15
                            ),
                          )
                      )
                  ),
                ):Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                    color: Theme
                                        .of(context)
                                        .accentColor,
                                    width: 3
                                )
                            ),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Ok",
                              style: TextStyle(
                                  color: Color(Global.BLUE),
                                  fontFamily: 'bold',
                                  fontSize: 15
                              ),
                            )
                        )
                    ),
                    Container(
                      width: 20,
                    ),
                    Expanded(
                        flex: 1,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                side:
                                BorderSide(color: Colors.redAccent),
                                borderRadius: BorderRadius.circular(10)),
                            color: Colors.redAccent,
                            onPressed: () {
                              Navigator.pop(context);
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Global.defaultModal(() {
                                      Navigator.pop(context);
                                      BlocProvider.of<VisitBloc>(context).add(DeleteVisitEvent(_visit.visit_no));
                                    }, context, Global.WARNING_ICON, "Are you sure you want to delete this plan?", "Yes", true);
                                  }
                              );
                            },
                            child: Text(
                              "Delete",
                              style: Global.getCustomFont(Global.WHITE, 14,
                                  'bold'),
                            )
                        )
                    ),
                  ],
                )
              ],
            ),
          );
        }
      );
    }
  }
}