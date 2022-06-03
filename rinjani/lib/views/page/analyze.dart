import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/monitor/monitor_bloc.dart';
import '../../bloc/ranking/ranking_bloc.dart';
import '../../models/monitor.dart';
import '../../models/ranking.dart';
import '../../utils/global.dart';
import '../../utils/global_state.dart';

class Analyze extends StatefulWidget {
  List<Ranking> rank;
  List<Monitor> mon;

  Analyze(this.rank, this.mon);

  @override
  State<StatefulWidget> createState() {
    return _Analyze();
  }
}

final GlobalState store = GlobalState.instance;

class _Analyze extends State<Analyze> {
  late List<Ranking> ranking;
  late List<Monitor> monitor;

  TextEditingController controller = TextEditingController();
  TextEditingController controllerMonitor = TextEditingController();

  late List<Ranking> usersFiltered;
  late List<Monitor> usersFilteredMon;
  String _searchResult = '';
  String _searchResultMon = '';
  final int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  final int _rowsPerPageMon = PaginatedDataTable.defaultRowsPerPage;

  late DataTableSource _data;
  late DataTableSource _dataMon;

  @override
  void initState() {
    super.initState();
    print(widget.rank.length);
    print(widget.mon.length);
    BlocProvider.of<RankingBloc>(context).add(GetRankingEvent());
    BlocProvider.of<MonitorBloc>(context).add(GetMonitorEvent());
    _data = MyData(widget.rank);
    _dataMon = MonitorData(widget.mon);
    usersFiltered = [];
    usersFilteredMon = [];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: GestureDetector (
            onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
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
                    const AssetImage(Global.BACK_ICON),
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
                          BlocListener<RankingBloc, RankingBlocState> (
                              listener: (context, state) {
                                if (state is InitialRankingBlocState || state is LoadingRankingState) {
                                  const Center(
                                      child: CircularProgressIndicator()
                                  );
                                } else if (state is GetRankingState) {
                                  setState(() {
                                    ranking = state.getRanking;
                                  });
                                } else {
                                  Container();
                                }
                            },
                            child: Column(
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
                                    padding: const EdgeInsets.only(left: 17, right: 17),
                                    child: Card(
                                      child: ListTile(
                                        leading: const Icon(Icons.search),
                                        title: TextField(
                                            controller: controller,
                                            style: TextStyle(color: Color(Global.BLACK),
                                                fontSize: 16,
                                                fontFamily: 'book'
                                            ),
                                            decoration: InputDecoration(
                                                hintText: 'Search name', border: InputBorder.none, hintStyle: TextStyle(color: Color(Global.GREY),
                                                fontSize: 16,
                                                fontFamily: 'book')),
                                            onChanged: (value) {
                                              setState(() {
                                                _searchResult = value;
                                                usersFiltered = ranking.where((user) => user.name_emp.toLowerCase().contains(_searchResult)).toList();
                                                print(usersFiltered.length);
                                                _data = MyData(usersFiltered);
                                              });
                                            }),
                                        trailing: IconButton(
                                          icon: _searchResult == '' ? Container() : const Icon(Icons.cancel),
                                          onPressed: () {
                                            setState(() {
                                              controller.clear();
                                              _searchResult = '';
                                              _data = MyData(ranking);
                                              usersFiltered = ranking;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.only(right: 10, left: 10),
                                      child: PaginatedDataTable(
                                        rowsPerPage: _rowsPerPage,
                                        columns: <DataColumn>[
                                          DataColumn(
                                            label: Text('No', style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'medium')),
                                          ),
                                          DataColumn(
                                            label: Text('Name', style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'medium')),
                                          ),
                                          DataColumn(
                                            label: Text('In', style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'medium')),
                                          ),
                                          DataColumn(
                                            label: Text('Out', style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'medium')),
                                          ),
                                          DataColumn(
                                            label: Text('Off', style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'medium')),
                                          ),
                                        ],
                                        source: _data,
                                        columnSpacing: 20,
                                        horizontalMargin: 10,
                                      )
                                  ),
                                ]
                            ),
                          ),
                          Container(
                            height: 20
                          ),
                          BlocListener<MonitorBloc, MonitorBlocState> (
                            listener: (context, state) {
                              if (state is InitialMonitorBlocState || state is LoadingMonitorState) {
                                const Center(
                                    child: CircularProgressIndicator()
                                );
                              } else if (state is GetMonitorState) {
                                monitor = state.getMonitor;
                              } else {
                                Container();
                              }
                            },
                            child: Column(
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
                                    padding: const EdgeInsets.only(left: 17, right: 17),
                                    child: Card(
                                      child: ListTile(
                                        leading: const Icon(Icons.search),
                                        title: TextField(
                                            controller: controllerMonitor,
                                            style: TextStyle(color: Color(Global.BLACK),
                                                fontSize: 16,
                                                fontFamily: 'book'
                                            ),
                                            decoration: InputDecoration(
                                                hintText: 'Search branch', border: InputBorder.none, hintStyle: TextStyle(color: Color(Global.GREY),
                                                fontSize: 16,
                                                fontFamily: 'book')),
                                            onChanged: (value) {
                                              setState(() {
                                                _searchResultMon = value;
                                                usersFilteredMon = monitor.where((user) => user.branch_name.toLowerCase().contains(_searchResultMon)).toList();
                                                _dataMon = MonitorData(usersFilteredMon);
                                              });
                                            }),
                                        trailing: IconButton(
                                          icon: _searchResultMon == '' ? Container() : const Icon(Icons.cancel),
                                          onPressed: () {
                                            setState(() {
                                              controllerMonitor.clear();
                                              _searchResultMon = '';
                                              _dataMon = MonitorData(monitor);
                                              usersFilteredMon = monitor;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.only(right: 10, left: 10),
                                      child: PaginatedDataTable(
                                        rowsPerPage: _rowsPerPageMon,
                                        columns: <DataColumn>[
                                          DataColumn(
                                            label: Text('No', style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'medium')),
                                          ),
                                          DataColumn(
                                            label: Text('Branch', style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'medium')),
                                          ),
                                          DataColumn(
                                            label: Text('In', style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'medium')),
                                          ),
                                          DataColumn(
                                            label: Text('Out', style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'medium')),
                                          ),
                                          DataColumn(
                                            label: Text('Off', style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'medium')),
                                          ),
                                          DataColumn(
                                            label: Text('Sign', style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'medium')),
                                          ),
                                        ],
                                        source: _dataMon,
                                        columnSpacing: 25,
                                        horizontalMargin: 10,
                                      )
                                  ),
                                ]
                            )
                          ),
                        ]
                    )
                )
            )
        )
      )
    );
  }
}

class MyData extends DataTableSource {
  List<Ranking> ranking;

  MyData(this.ranking);

  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(index: index, cells: [
        DataCell(Align(
            alignment: Alignment.center,
            child: Text('${index+1}', style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'book'))
        )),
        DataCell(Text(ranking[index].name_emp, style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'medium'))),
        DataCell(
            Align(
                alignment: Alignment.center,
                child: Text(ranking[index].in_office, style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'book'))
            )
        ),
        DataCell(
            Align(
                alignment: Alignment.center,
                child: Text(ranking[index].out_office, style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'book'))
            )
        ),
        DataCell(
            Align(
                alignment: Alignment.center,
                child: Text(ranking[index].off_act, style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'book'))
            )
        ),
      ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => ranking.length;

  @override
  int get selectedRowCount => 0;
}

class MonitorData extends DataTableSource {
  List<Monitor> monitor;

  MonitorData(this.monitor);

  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(index: index, cells: [
      DataCell(
          Align(
              alignment: Alignment.center,
              child: Text('${index+1}', style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'book')))
      ),
      DataCell(Text(monitor[index].branch_name, style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'medium'))
      ),
      DataCell(
          Align(
              alignment: Alignment.center,
              child: Text(monitor[index].in_office, style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'book')))
      ),
      DataCell(
          Align(
              alignment: Alignment.center,
              child: Text(monitor[index].out_office, style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'book')))
      ),
      DataCell(
          Align(
            alignment: Alignment.center,
            child: Text(monitor[index].off_act, style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'book'))
          )
      ),
      DataCell(
        int.parse(monitor[index].all_act) > 0 ?  Container(
            child: Align(
                alignment: Alignment.center,
                child: Image.asset('assets/icon/ic_green.png', width: 20, height: 20))
        ) :  Container(
            child:Align(
                alignment: Alignment.center,
                child: Image.asset('assets/icon/ic_red.png', width: 20, height: 20))
        )
          // Text(monitor[index].all_act, style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'book'))
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => monitor.length;

  @override
  int get selectedRowCount => 0;
}