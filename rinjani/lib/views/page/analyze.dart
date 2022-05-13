import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/monitor/monitor_bloc.dart';
import '../../bloc/ranking/ranking_bloc.dart';
import '../../models/monitor.dart';
import '../../models/ranking.dart';
import '../../utils/global.dart';
import '../../utils/global_state.dart';

class Analyze extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _Analyze();
  }
}

final GlobalState store = GlobalState.instance;

class _Analyze extends State<Analyze> {
  late List<Ranking> ranking;
  late List<Monitor> monitor;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<RankingBloc>(context).add(GetRankingEvent());
    BlocProvider.of<MonitorBloc>(context).add(GetMonitorEvent());
  }

  DataTable _createDataTable() {
    return DataTable(
      columns: _createColumns(),
      rows: _createRows(),
      columnSpacing: 18.0,
      // dataRowColor: MaterialStateProperty.all(Colors.green)
    );
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('Name', style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'bold'))),
      DataColumn(label: Text('In', style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'bold'))),
      DataColumn(label: Text('Out', style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'bold'))),
      DataColumn(label: Text('Off', style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'bold')))
    ];
  }

  List<DataRow> _createRows() {
    return ranking.map((rank) => DataRow(cells: [
      DataCell(Text(
        rank.name_emp,
        style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'medium'),
      )),
      DataCell(Text(
        rank.in_office,
        style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'book'),
      )),
      DataCell(Text(
        rank.out_office,
        style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'book'),
      )),
      DataCell(Text(
        rank.off_act,
        style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'book'),
      ))
    ])).toList();
  }


  DataTable _createMonDataTable() {
    return DataTable(
      columns: _createMonColumns(),
      rows: _createMonRows(),
      columnSpacing: 18.0,
      // dataRowColor: MaterialStateProperty.all(Colors.green)
    );
  }

  List<DataColumn> _createMonColumns() {
    return [
      DataColumn(label: Text('Branch', style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'bold'))),
      DataColumn(label: Text('In', style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'bold'))),
      DataColumn(label: Text('Out', style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'bold'))),
      DataColumn(label: Text('Off', style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'bold'))),
      DataColumn(label: Text('Sign', style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'bold')))
    ];
  }

  List<DataRow> _createMonRows() {
    return monitor.map((monitor) => DataRow(cells: [
      DataCell(Text(
        monitor.branch_name,
        style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'medium'),
      )),
      DataCell(Text(
        monitor.in_office,
        style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'book'),
      )),
      DataCell(Text(
        monitor.out_office,
        style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'book'),
      )),
      DataCell(Text(
        monitor.off_act,
        style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'book'),
      )),
      DataCell(
        int.parse(monitor.all_act) > 0 ? Container(
          child: const Padding(
            padding: EdgeInsets.only(top: 4, left: 10),
            child: ImageIcon(
              AssetImage(Global.GREEN_ICON),
              size: 8,
            ),
          )
        ) : Container(
            child: const Padding(
              padding: EdgeInsets.only(top: 4, left: 10),
              child: ImageIcon(
                AssetImage(Global.RED_ICON),
                size: 8,
              ),
            )
        )
      //     Text(
      //   monitor.all_act,
      //   style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'book'),
      // )
      )
    ])).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: false,
              iconTheme: IconThemeData(
                color: Color(Global.BLUE),
              ),
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
            body: SingleChildScrollView(
                reverse: false,
                child: Container(
                    child: Column(
                        children: [
                          BlocBuilder<RankingBloc, RankingBlocState> (
                              builder: (context, state) {
                                if (state is InitialRankingBlocState || state is LoadingRankingState) {
                                  return const Center(
                                      child: CircularProgressIndicator()
                                  );
                                } else if (state is GetRankingState) {
                                  ranking = state.getRanking;
                                  return Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(left: 21, right: 21, top: 21),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'User monitoring',
                                              style: TextStyle(color: Color(Global.BLACK),
                                                  fontSize: 20,
                                                  fontFamily: 'medium'),
                                            ),
                                          ),
                                        ),
                                        Container(
                                            padding: const EdgeInsets.only(right: 10, left: 10),
                                            height: 300,
                                            // color: Colors.yellow,
                                            child: ListView(
                                                children: [
                                                  _createDataTable()
                                                ]
                                            )
                                        ),
                                        InkWell(
                                            onTap: (){
                                              // Navigator.push(context, MaterialPageRoute(
                                              //     builder: (context) => ListVisit(
                                              //       _selectedBranchId,
                                              //       backReportOp: (int resMessage, BuildContext ctx, String id) {
                                              //         if (resMessage == 1) {
                                              //           Navigator.of(ctx).pop();
                                              //           if(store.get("role_id") == "2") {
                                              //             reportOp(ctx, id);
                                              //           } else {
                                              //             BlocProvider.of<VisitBloc>(context).add(GetRealizationEvent("year"));
                                              //           }
                                              //         }
                                              //       },
                                              //     ))
                                              // );
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.only(bottom: 10, right: 21),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget> [
                                                  Align(
                                                    alignment: Alignment.centerRight,
                                                    child: Text(
                                                      'See all',
                                                      style: TextStyle(color: Color(Global.BLUE), fontSize: 15, fontFamily: 'book'),
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(top: 4, left: 10),
                                                    child: ImageIcon(
                                                      AssetImage(Global.ARROW_ICON),
                                                      size: 18,
                                                    ),
                                                  )

                                                ],
                                              ),
                                            )
                                        ),
                                      ]
                                  );
                                } else {
                                  return Container();
                                }
                              }
                          ),
                          Container(
                            height: 20
                          ),
                          BlocBuilder<MonitorBloc, MonitorBlocState> (
                              builder: (context, state) {
                                if (state is InitialMonitorBlocState || state is LoadingMonitorState) {
                                  return const Center(
                                      child: CircularProgressIndicator()
                                  );
                                } else if (state is GetMonitorState) {
                                  monitor = state.getMonitor;
                                  return Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(left: 21, right: 21, top: 21),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Branch monitoring',
                                              style: TextStyle(color: Color(Global.BLACK),
                                                  fontSize: 20,
                                                  fontFamily: 'medium'),
                                            ),
                                          ),
                                        ),
                                        Container(
                                            padding: const EdgeInsets.only(right: 10, left: 10),
                                            height: 300,
                                            // color: Colors.yellow,
                                            child: ListView(
                                                children: [
                                                  _createMonDataTable()
                                                ]
                                            )
                                        ),
                                        InkWell(
                                            onTap: (){
                                              // Navigator.push(context, MaterialPageRoute(
                                              //     builder: (context) => ListVisit(
                                              //       _selectedBranchId,
                                              //       backReportOp: (int resMessage, BuildContext ctx, String id) {
                                              //         if (resMessage == 1) {
                                              //           Navigator.of(ctx).pop();
                                              //           if(store.get("role_id") == "2") {
                                              //             reportOp(ctx, id);
                                              //           } else {
                                              //             BlocProvider.of<VisitBloc>(context).add(GetRealizationEvent("year"));
                                              //           }
                                              //         }
                                              //       },
                                              //     ))
                                              // );
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.only(bottom: 10, right: 21),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget> [
                                                  Align(
                                                    alignment: Alignment.centerRight,
                                                    child: Text(
                                                      'See all',
                                                      style: TextStyle(color: Color(Global.BLUE), fontSize: 15, fontFamily: 'book'),
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(top: 4, left: 10),
                                                    child: ImageIcon(
                                                      AssetImage(Global.ARROW_ICON),
                                                      size: 18,
                                                    ),
                                                  )

                                                ],
                                              ),
                                            )
                                        ),
                                      ]
                                  );
                                } else {
                                  return Container();
                                }
                              }
                          ),
                        ]
                    )
                )
            )
        )
    );
  }
}