import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:rinjani/bloc/rank/activity_bloc.dart';
import 'package:rinjani/models/visit.dart';
import 'package:rinjani/views/page/list_customer.dart';
import 'package:rinjani/views/page/list_pic.dart';
import 'package:rinjani/views/page/list_reports.dart';
import 'package:rinjani/widget/rank.dart';

import '../../bloc/branch/branch_bloc.dart';
import '../../bloc/ranking/ranking_bloc.dart';
import '../../bloc/visit/visit_bloc.dart';
import '../../models/branch.dart';
import 'package:intl/intl.dart';
import '../../models/ranking.dart';
import '../../utils/global.dart';
import '../../utils/global_state.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'list_visit.dart';

import '../../utils/mobile.dart';

class Report extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _Report();
  }
}

final GlobalState store = GlobalState.instance;

class _Report extends State<Report> {
  late List<String> custName = [];
  late List<String> finalCustName = [];
  late List<Visit> visitRealById = [];

  List<String>? branchName;
  List<String>? branchId;
  List<BranchOp>? branch;

  String? _selectedBranchName;
  String _selectedBranchId = "0";
  String? foundKey;

  late List<Ranking> ranking;

  @override
  void initState() {
    super.initState();
    branchName = [];
    branchId = [];
    branch = [];
    foundKey = "";
    BlocProvider.of<VisitBloc>(context).add(GetRealizationEvent("year"));
    BlocProvider.of<BranchBloc>(context).add(GetBranchOpEvent());
  }

  Widget reportOp(BuildContext context, String id){
    BlocProvider.of<VisitBloc>(context).add(GetRealizationOpEvent(id, "year"));

    return BlocBuilder<VisitBloc, VisitBlocState> (
        builder: (context, state) {
          if (state is InitialVisitBlocState || state is LoadingVisitState) {
            return Container(
              padding: const EdgeInsets.only(top: 100),
              child: const Center(
                  child: CircularProgressIndicator()
              ),
            );
          } if(state is GetRealizationOpState) {
            var realization = state.getRealizationOp;
            for (int i=0; i<state.getRealizationOp.length; i++) {
              custName.add(state.getRealizationOp[i].customer);
            }
            finalCustName = custName.toSet().toList();
            return SingleChildScrollView(
                reverse: false,
                child: Column(
                  children: <Widget>[
                    Container(
                        padding: const EdgeInsets.only(top: 17, right: 21, left: 21, bottom: 17),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => ListCustomer(
                                            _selectedBranchId,
                                            backReportOp: (int resMessage, BuildContext ctx, String id) {
                                              if (resMessage == 1) {
                                                Navigator.of(ctx).pop();
                                                if(store.get("role_id") == "2") {
                                                  reportOp(ctx, id);
                                                } else {
                                                  BlocProvider.of<VisitBloc>(context).add(GetRealizationEvent("year"));
                                                }
                                              }
                                            },
                                          ))
                                      );
                                    },
                                    child: Global.getReportCard('Customer', 0xff7DE0B3, 0xff6ECCA1, 'customer')
                                ),
                                InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => ListPIC(
                                            _selectedBranchId,
                                            backReportOp: (int resMessage, BuildContext ctx, String id) {
                                              if (resMessage == 1) {
                                                Navigator.of(ctx).pop();
                                                if(store.get("role_id") == "2") {
                                                  reportOp(ctx, id);
                                                } else {
                                                  BlocProvider.of<VisitBloc>(context).add(GetRealizationEvent("year"));
                                                }
                                              }
                                            },
                                          ))
                                      );
                                    },
                                    child: Global.getReportCard('PICs', 0xffFFC17E, 0xffECA85E, 'pic')
                                )
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 17),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => ListVisit(
                                            _selectedBranchId,
                                            backReportOp: (int resMessage, BuildContext ctx, String id) {
                                              if (resMessage == 1) {
                                                Navigator.of(ctx).pop();
                                                if(store.get("role_id") == "2") {
                                                  reportOp(ctx, id);
                                                } else {
                                                  BlocProvider.of<VisitBloc>(context).add(GetRealizationEvent("year"));
                                                }
                                              }
                                            },
                                          ))
                                      );
                                    },
                                    child: Global.getReportCard('Visits', 0xffFA898D, 0xffD1777A, 'visit')
                                ),
                                InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => ListReport(
                                            _selectedBranchId,
                                            backReportOp: (int resMessage, BuildContext ctx, String id) {
                                              if (resMessage == 1) {
                                                Navigator.of(ctx).pop();
                                                if(store.get("role_id") == "2") {
                                                  reportOp(ctx, id);
                                                } else {
                                                  BlocProvider.of<VisitBloc>(context).add(GetRealizationEvent("year"));
                                                }
                                              }
                                            },
                                          ))
                                      );
                                    },
                                    child: Global.getReportCard('Result', 0xff73C6F2, 0xff5894B4, 'result')
                                )
                              ],
                            )
                          ],
                        )
                    ),
                    // ),
                    const Divider(
                      height: 12,
                    ),
                    Container(
                        color: Colors.white,
                        padding: const EdgeInsets.only(top: 17, right: 21, left: 21, bottom: 17),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'List of visits',
                                style: TextStyle(color: Color(Global.BLACK), fontSize: 15, fontFamily: 'medium'),
                              ),
                            ),
                            realization.length != 0 ? Container(
                                padding: const EdgeInsets.only(top: 7),
                                child: ListView.builder(
                                    itemCount: realization.length < 3 ? realization.length : 3,
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, i){
                                      return ListTile(
                                          title: Container(
                                            child: Column(
                                                children: <Widget>[
                                                  Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(realization[i].customer.toString(), style: Global.getCustomFont(Global.BLACK, 14, 'bold')),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets.only(top: 5),
                                                    child: Align(
                                                        alignment: Alignment.centerLeft,
                                                        child: realization[i].pic_name.contains("%2C") ? Container (
                                                            child: ListView.builder(
                                                                itemCount: realization[i].pic_name.split("%2C").length,
                                                                scrollDirection: Axis.vertical,
                                                                shrinkWrap: true,
                                                                physics: NeverScrollableScrollPhysics(),
                                                                itemBuilder: (context, j){
                                                                  return Container(
                                                                    padding: const EdgeInsets.only(top: 5),
                                                                    child: Text("${realization[i].pic_name.split("%2C")[j]} - ${realization[i].pic_position.split("%2C")[j]}", style: Global.getCustomFont(Global.GREY, 14, 'medium')),
                                                                  );
                                                                }
                                                            )
                                                        ) : Container(
                                                          child: Text("${realization[i].pic_name} - ${realization[i].pic_position}", style: Global.getCustomFont(Global.GREY, 14, 'medium')),
                                                        )
                                                    ),
                                                  ),
                                                  Divider()
                                                ]
                                            ),
                                          )
                                      );
                                    }
                                )
                            ) :
                            Container(
                              padding: const EdgeInsets.only(top: 17, left: 12),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                      children: <Widget> [
                                        Image.asset(
                                          Global.EMPTY_ICON,
                                          height: 60,
                                        ),
                                        Container(
                                            padding: const EdgeInsets.only(top: 17),
                                            child: Global.getDefaultText("No visits done", Global.GREY)
                                        )
                                      ]
                                  )
                              ),
                            ),
                            realization.length != 0 ? InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => ListVisit(
                                        _selectedBranchId,
                                        backReportOp: (int resMessage, BuildContext ctx, String id) {
                                          if (resMessage == 1) {
                                            Navigator.of(ctx).pop();
                                            if(store.get("role_id") == "2") {
                                              reportOp(ctx, id);
                                            } else {
                                              BlocProvider.of<VisitBloc>(context).add(GetRealizationEvent("year"));
                                            }
                                          }
                                        },
                                      )
                                  ));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget> [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'More',
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
                                )
                            ) : Container()
                          ],
                        )
                    ),
                    const Divider(
                      height: 12,
                    ),
                    Container(
                        color: Colors.white,
                        padding: const EdgeInsets.only(top: 17, right: 21, left: 21, bottom: 17),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'List of Person in Charge',
                                style: TextStyle(color: Color(Global.BLACK), fontSize: 15, fontFamily: 'medium'),
                              ),
                            ),
                            realization.length != 0 ? Container(
                                padding: const EdgeInsets.only(top: 7),
                                child: ListView.builder(
                                    itemCount: realization.length < 3 ? realization.length : 3,
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, i){
                                      return ListTile(
                                          title: Container(
                                            child: Column(
                                                children: <Widget>[
                                                  Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: realization[i].pic_name.contains("%2C") ? Container (
                                                          child: ListView.builder(
                                                              itemCount: realization[i].pic_name.split("%2C").length,
                                                              scrollDirection: Axis.vertical,
                                                              shrinkWrap: true,
                                                              physics: NeverScrollableScrollPhysics(),
                                                              itemBuilder: (context, j){
                                                                return Container(
                                                                  padding: const EdgeInsets.only(top: 5),
                                                                  child: Text("${realization[i].pic_name.split("%2C")[j]} - ${realization[i].pic_position.split("%2C")[j]}", style: Global.getCustomFont(Global.BLACK, 14, 'medium')),
                                                                );
                                                              }
                                                          )
                                                      ) : Container(
                                                        child: Text("${realization[i].pic_name} - ${realization[i].pic_position}", style: Global.getCustomFont(Global.BLACK, 14, 'medium')),
                                                      )
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets.only(top: 5),
                                                    child: Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Text(realization[i].customer.toString(), style: Global.getCustomFont(Global.GREY, 14, 'medium')),
                                                    ),
                                                  ),
                                                  Divider()
                                                ]
                                            ),
                                          )
                                      );
                                    }
                                )
                            ) :
                            Container(
                              padding: const EdgeInsets.only(top: 17, left: 12),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                      children: <Widget> [
                                        Image.asset(
                                          Global.EMPTY_ICON,
                                          height: 60,
                                        ),
                                        Container(
                                            padding: const EdgeInsets.only(top: 17),
                                            child: Global.getDefaultText("No PIC yet", Global.GREY)
                                        )
                                      ]
                                  )
                              ),
                            ),
                            realization.length != 0 ? InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => ListPIC(
                                        _selectedBranchId,
                                        backReportOp: (int resMessage, BuildContext ctx, String id) {
                                          if (resMessage == 1) {
                                            Navigator.of(ctx).pop();
                                            if(store.get("role_id") == "2") {
                                              reportOp(ctx, id);
                                            } else {
                                              BlocProvider.of<VisitBloc>(context).add(GetRealizationEvent("year"));
                                            }
                                          }
                                        },
                                      ))
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget> [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'More',
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
                                )
                            ) : Container()
                          ],
                        )
                    ),
                    const Divider(
                      height: 12,
                    ),
                    Container(
                        color: Colors.white,
                        padding: const EdgeInsets.only(top: 17, right: 21, left: 21, bottom: 17),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'List of customer',
                                style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'medium'),
                              ),
                            ),
                            finalCustName.length != 0 ? Container(
                                padding: const EdgeInsets.only(top: 7),
                                child: ListView.builder(
                                    itemCount: finalCustName.length < 3 ? finalCustName.length : 3,
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, i){
                                      return ListTile(
                                          title: Container(
                                            child: Column(
                                                children: <Widget>[
                                                  Container(
                                                    padding: const EdgeInsets.only(top: 5),
                                                    child: Align(
                                                      alignment: Alignment.centerLeft,
                                                      child: Text(finalCustName[i].toString(), style: Global.getCustomFont(Global.BLACK, 14, 'medium')),
                                                    ),
                                                  ),
                                                  Divider()
                                                ]
                                            ),
                                          )
                                      );
                                    }
                                )
                            ) : Container(
                              padding: const EdgeInsets.only(top: 17, left: 12),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                      children: <Widget> [
                                        Image.asset(
                                          Global.EMPTY_ICON,
                                          height: 60,
                                        ),
                                        Container(
                                            padding: const EdgeInsets.only(top: 17),
                                            child: Global.getDefaultText("No customer yet", Global.GREY)
                                        )
                                      ]
                                  )
                              ),
                            ),
                            realization.length != 0 ? InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => ListPIC(
                                        _selectedBranchId,
                                        backReportOp: (int resMessage, BuildContext ctx, String id) {
                                          if (resMessage == 1) {
                                            Navigator.of(ctx).pop();
                                            if(store.get("role_id") == "2") {
                                              reportOp(ctx, id);
                                            } else {
                                              BlocProvider.of<VisitBloc>(context).add(GetRealizationEvent("year"));
                                            }
                                          }
                                        },
                                      ))
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget> [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'More',
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
                                )
                            ) : Container()
                          ],
                        )
                    ),
                  ],
                )
            );
          } else {
            return Container();
          }
        }
    );
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
              // actions:
              // [
              //   PopupMenuButton(
              //       itemBuilder: (context){
              //         return [
              //           PopupMenuItem<int>(
              //             value: 0,
              //             child: Row(
              //               children: [
              //                 Icon(
              //                   Icons.download_rounded,
              //                   color: Color(Global.BLUE),
              //                   size: 28,
              //                 ),
              //                 Container(
              //                   padding: const EdgeInsets.only(left: 10),
              //                   child: Text("Download report as PDF", style: TextStyle(
              //                       color: Color(Global.BLACK),
              //                       fontFamily: 'meidum',
              //                       fontSize: 15
              //                   )),
              //                 ),
              //               ],
              //             )
              //           ),
              //         ];
              //       },
              //       onSelected:(value){
              //         if(value == 0){
              //           showDialog(
              //               context: context,
              //               builder: (BuildContext context) {
              //
              //                 DateTime initialDateStart = DateTime.now();
              //                 DateTime initialDateEnd = DateTime.now();
              //
              //                 var nHour = 23;
              //                 var nMin = 0;
              //                 var nSec = 0;
              //                 var newTime = DateTime.now();
              //                 String finalDateEnd = "";
              //
              //                 return StatefulBuilder(
              //                   builder: (context, setState) {
              //                     return AlertDialog(
              //                       shape: const RoundedRectangleBorder(
              //                           borderRadius: BorderRadius.all(Radius.circular(10)
              //                           )
              //                       ),
              //                       content: Column(
              //                         mainAxisSize: MainAxisSize.min,
              //                         children: <Widget>[
              //                           Container(
              //                               child: Text("Download report as PDF",
              //                                 style: Global.getCustomFont(Global.BLACK, 15, 'medium'),
              //                                 textAlign: TextAlign.left,
              //                               )
              //                           ),
              //                           Container(
              //                             height: 17,
              //                           ),
              //                           Row(
              //                               children: <Widget> [
              //                                 Align(
              //                                   alignment: Alignment.centerLeft,
              //                                   child: Text("Start date: ",
              //                                     style: TextStyle(color: Color(Global.BLACK), fontSize: 15, fontFamily: 'medium'),
              //                                     textAlign: TextAlign.left,
              //                                   ),
              //                                 ),
              //                                 Container(
              //                                     child: InkWell(
              //                                         onTap: () {
              //                                           setState(() {
              //                                             showDatePicker(
              //                                                 context: context,
              //                                                 initialDate: DateTime.now(),
              //                                                 firstDate: DateTime(2010),
              //                                                 lastDate: DateTime(2050)
              //                                             ).then((date) {
              //                                               setState((){
              //                                                 initialDateStart = date!;
              //                                               });
              //                                             });
              //                                           });
              //                                         },
              //                                         child: Container(
              //                                             padding: const EdgeInsets.only(left: 17),
              //                                             child: ImageIcon(
              //                                               const AssetImage(Global.CALENDAR_ICON),
              //                                               color: Color(Global.BLUE),
              //                                               size: 18,
              //                                             )
              //                                         )
              //                                     )
              //                                 )
              //                               ]
              //                           ),
              //                           Container(
              //                             child: Align(
              //                                 alignment: Alignment.centerLeft,
              //                                 child: Container(
              //                                     margin: const EdgeInsets.only(bottom: 30, top: 10),
              //                                     child: Container(
              //                                         padding: const EdgeInsets.only(left: 17),
              //                                         child: Text(DateFormat('EEEE, dd MMMM yyy').format(initialDateStart).toString(),
              //                                             style: const TextStyle(
              //                                               color: Color(0xff4F4F4F),
              //                                               fontFamily: 'book',
              //                                               fontSize: 15,
              //                                             )
              //                                         )
              //                                     )
              //                                 )
              //                             ),
              //                           ),
              //                           Row(
              //                               children: <Widget> [
              //                                 Align(
              //                                   alignment: Alignment.centerLeft,
              //                                   child: Text("End date: ",
              //                                     style: TextStyle(color: Color(Global.BLACK), fontSize: 15, fontFamily: 'medium'),
              //                                     textAlign: TextAlign.left,
              //                                   ),
              //                                 ),
              //                                 Container(
              //                                     child: InkWell(
              //                                         onTap: () {
              //                                           showDatePicker(
              //                                               context: context,
              //                                               initialDate: DateTime.now(),
              //                                               firstDate: DateTime(2010),
              //                                               lastDate: DateTime(2050)
              //                                           ).then((date) {
              //                                             setState((){
              //                                               initialDateEnd = date!;
              //                                               newTime = DateTime(date.year, date.month, date.day, nHour, nMin, nSec);
              //                                               finalDateEnd = newTime.toString();
              //                                             });
              //                                           });
              //                                         },
              //                                         child: Container(
              //                                             padding: const EdgeInsets.only(left: 17),
              //                                             child: ImageIcon(
              //                                               const AssetImage(Global.CALENDAR_ICON),
              //                                               color: Color(Global.BLUE),
              //                                               size: 18,
              //                                             )
              //                                         )
              //                                     )
              //                                 )
              //                               ]
              //                           ),
              //                           Container(
              //                             child: Align(
              //                                 alignment: Alignment.centerLeft,
              //                                 child: Container(
              //                                     margin: const EdgeInsets.only(bottom: 30, top: 10),
              //                                     child: Container(
              //                                         padding: const EdgeInsets.only(left: 17),
              //                                         child: Text(DateFormat('EEEE, dd MMMM yyy').format(initialDateEnd).toString(),
              //                                             style: const TextStyle(
              //                                               color: Color(0xff4F4F4F),
              //                                               fontFamily: 'book',
              //                                               fontSize: 15,
              //                                             )
              //                                         )
              //                                     )
              //                                 )
              //                             ),
              //                           ),
              //                           Row(
              //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                             children: <Widget>[
              //                               Expanded(
              //                                   flex: 1,
              //                                   child: RaisedButton(
              //                                       shape: RoundedRectangleBorder(
              //                                           borderRadius: BorderRadius.circular(10),
              //                                           side: BorderSide(
              //                                               color: Theme
              //                                                   .of(context)
              //                                                   .accentColor,
              //                                               width: 3
              //                                           )
              //                                       ),
              //                                       color: Colors.white,
              //                                       onPressed: () {
              //                                         Navigator.of(context).pop();
              //                                       },
              //                                       child: Text(
              //                                         "Cancel",
              //                                         style: TextStyle(
              //                                             color: Color(Global.BLUE),
              //                                             fontFamily: 'bold',
              //                                             fontSize: 15
              //                                         ),
              //                                       )
              //                                   )
              //                               ),
              //                               Container(
              //                                 width: 25,
              //                               ),
              //                               Expanded(
              //                                   flex: 1,
              //                                   child: RaisedButton(
              //                                       shape: RoundedRectangleBorder(
              //                                           side:
              //                                           BorderSide(color: Color(Global.BLUE)),
              //                                           borderRadius: BorderRadius.circular(10)),
              //                                       color: Color(Global.BLUE),
              //                                       onPressed: () {
              //                                         setState(() {
              //                                           _createPDF();
              //                                         });
              //                                       },
              //                                        child: Text("Download", style: Global.getCustomFont(Global.WHITE, 14, 'bold'))
              //                                   )
              //                               ),
              //                             ],
              //                           )
              //                         ],
              //                       ),
              //                     );
              //                   }
              //                 );
              //               }
              //           );
              //         }
              //       }
              //   ),
              // ],
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
            body: store.get("role_id") == '2' ? Container(
                child: BlocListener<BranchBloc, BranchBlocState>(
                    listener: (context, state) {
                      if(state is InitialBranchBlocState || state is LoadingBranchState) {
                        Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: const Center(child: CircularProgressIndicator())
                        );
                      } if (state is BranchOpList) {
                        setState(() {
                          branch = state.getBranchOp;
                        });
                      } else {
                        Container();
                      }
                    },
                    child: SingleChildScrollView(
                      reverse: false,
                      child: Column(
                        children: <Widget>[
                          Container(
                              padding: const EdgeInsets.only(top: 22, right: 21, left: 21),
                              child: DropdownButtonFormField<String>(
                                hint: const Text("Choose branch"),
                                dropdownColor: Colors.white,
                                style: Global.getCustomFont(Global.BLACK, 15, 'medium'),
                                value: _selectedBranchName,
                                items: branch?.map((e) {
                                  return DropdownMenuItem<String>(
                                    value: e.branch_id + ", " + e.branch_name,
                                    child: Text(e.branch_name),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    _selectedBranchName = value;
                                    _selectedBranchId = value!.split(", ")[0];
                                  });
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only( top: 10, bottom: 10, left: 12, right: 12),
                                  labelText: "Branch",
                                  labelStyle: const TextStyle(
                                      color: Color(0xff757575),
                                      fontSize: 15,
                                      fontFamily: 'medium'),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                      borderSide: BorderSide()
                                  ),
                                ),
                              )
                          ),
                          _selectedBranchName != null ?
                          Container(
                            child: SingleChildScrollView(
                                reverse: false,
                                child: reportOp(context, _selectedBranchId)
                            ),
                          ):
                          Container()
                        ],
                      ),
                    )
                )
            ) :
            SingleChildScrollView(
                reverse: false,
                child: Container(
                    child: Column(
                        children: [
                          BlocBuilder<VisitBloc, VisitBlocState> (
                              builder: (context, state) {
                                if (state is InitialVisitBlocState || state is LoadingVisitState) {
                                  return Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height,
                                      child: const Center(child: CircularProgressIndicator())
                                  );
                                } if(state is GetRealizationState) {
                                  var realization = state.getRealization;
                                  for (int i=0; i<state.getRealization.length; i++) {
                                    custName.add(state.getRealization[i].customer);
                                  }
                                  finalCustName = custName.toSet().toList();

                                  return Column(
                                    children: <Widget>[
                                      Container(
                                      ),
                                      Container(
                                          padding: const EdgeInsets.only(top: 17, right: 21, left: 21, bottom: 17),
                                          color: Colors.white,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  InkWell(
                                                      onTap: (){
                                                        Navigator.push(context, MaterialPageRoute(
                                                            builder: (context) => ListCustomer(
                                                              _selectedBranchId,
                                                              backReportOp: (int resMessage, BuildContext ctx, String id) {
                                                                if (resMessage == 1) {
                                                                  Navigator.of(ctx).pop();
                                                                  if(store.get("role_id") == "2") {
                                                                    reportOp(ctx, id);
                                                                  } else {
                                                                    BlocProvider.of<VisitBloc>(context).add(GetRealizationEvent("year"));
                                                                  }
                                                                }
                                                              },
                                                            ))
                                                        );
                                                      },
                                                      child: Global.getReportCard('Customer', 0xff7DE0B3, 0xff6ECCA1, 'customer')
                                                  ),
                                                  InkWell(
                                                      onTap: (){
                                                        Navigator.push(context, MaterialPageRoute(
                                                            builder: (context) => ListPIC(
                                                              _selectedBranchId,
                                                              backReportOp: (int resMessage, BuildContext ctx, String id) {
                                                                if (resMessage == 1) {
                                                                  Navigator.of(ctx).pop();
                                                                  if(store.get("role_id") == "2") {
                                                                    reportOp(ctx, id);
                                                                  } else {
                                                                    BlocProvider.of<VisitBloc>(context).add(GetRealizationEvent("year"));
                                                                  }
                                                                }
                                                              },
                                                            ))
                                                        );
                                                      },
                                                      child: Global.getReportCard('PICs', 0xffFFC17E, 0xffECA85E, 'pic')
                                                  )
                                                ],
                                              ),
                                              const Padding(
                                                padding: EdgeInsets.only(top: 17),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  InkWell(
                                                      onTap: (){
                                                        Navigator.push(context, MaterialPageRoute(
                                                            builder: (context) => ListVisit(
                                                              _selectedBranchId,
                                                              backReportOp: (int resMessage, BuildContext ctx, String id) {
                                                                if (resMessage == 1) {
                                                                  Navigator.of(ctx).pop();
                                                                  if(store.get("role_id") == "2") {
                                                                    reportOp(ctx, id);
                                                                  } else {
                                                                    BlocProvider.of<VisitBloc>(context).add(GetRealizationEvent("year"));
                                                                  }
                                                                }
                                                              },
                                                            ))
                                                        );
                                                      },
                                                      child: Global.getReportCard('Visits', 0xffFA898D, 0xffD1777A, 'visit')
                                                  ),
                                                  InkWell(
                                                      onTap: (){
                                                        Navigator.push(context, MaterialPageRoute(
                                                            builder: (context) => ListReport(
                                                              _selectedBranchId,
                                                              backReportOp: (int resMessage, BuildContext ctx, String id) {
                                                                if (resMessage == 1) {
                                                                  Navigator.of(ctx).pop();
                                                                  if(store.get("role_id")== "2") {
                                                                    reportOp(ctx, id);
                                                                  } else {
                                                                    BlocProvider.of<VisitBloc>(context).add(GetRealizationEvent("year"));
                                                                  }
                                                                }
                                                              },
                                                            ))
                                                        );
                                                      },
                                                      child: Global.getReportCard('Result', 0xff73C6F2, 0xff5894B4, 'result')
                                                  )
                                                ],
                                              )
                                            ],
                                          )
                                      ),
                                      // ),
                                      const Divider(
                                        height: 12,
                                      ),
                                      Container(
                                          color: Colors.white,
                                          padding: const EdgeInsets.only(top: 17, right: 21, left: 21, bottom: 17),
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'List of visits',
                                                  style: TextStyle(color: Color(Global.BLACK), fontSize: 15, fontFamily: 'medium'),
                                                ),
                                              ),
                                              realization.length != 0 ? Container(
                                                  padding: const EdgeInsets.only(top: 7),
                                                  child: ListView.builder(
                                                      itemCount: realization.length < 3 ? realization.length : 3,
                                                      scrollDirection: Axis.vertical,
                                                      shrinkWrap: true,
                                                      physics: const NeverScrollableScrollPhysics(),
                                                      itemBuilder: (context, i){
                                                        return ListTile(
                                                            title: Container(
                                                              child: Column(
                                                                  children: <Widget>[
                                                                    Align(
                                                                      alignment: Alignment.centerLeft,
                                                                      child: Text(realization[i].customer.toString(), style: Global.getCustomFont(Global.BLACK, 14, 'bold')),
                                                                    ),
                                                                    Container(
                                                                      padding: const EdgeInsets.only(top: 5),
                                                                      child: Align(
                                                                          alignment: Alignment.centerLeft,
                                                                          child: realization[i].pic_name.contains("%2C") ? Container (
                                                                              child: ListView.builder(
                                                                                  itemCount: realization[i].pic_name.split("%2C").length,
                                                                                  scrollDirection: Axis.vertical,
                                                                                  shrinkWrap: true,
                                                                                  physics: const NeverScrollableScrollPhysics(),
                                                                                  itemBuilder: (context, j){
                                                                                    return Container(
                                                                                      padding: const EdgeInsets.only(top: 5),
                                                                                      child: Text("${realization[i].pic_name.split("%2C")[j]} - ${realization[i].pic_position.split("%2C")[j]}", style: Global.getCustomFont(Global.GREY, 14, 'medium')),
                                                                                    );
                                                                                  }
                                                                              )
                                                                          ) : Container(
                                                                            child: Text("${realization[i].pic_name} - ${realization[i].pic_position}", style: Global.getCustomFont(Global.GREY, 14, 'medium')),
                                                                          )
                                                                      ),
                                                                    ),
                                                                    Divider()
                                                                  ]
                                                              ),
                                                            )
                                                        );
                                                      }
                                                  )
                                              ) :
                                              Container(
                                                padding: const EdgeInsets.only(top: 17, left: 12),
                                                child: Align(
                                                    alignment: Alignment.center,
                                                    child: Column(
                                                        children: <Widget> [
                                                          Image.asset(
                                                            Global.EMPTY_ICON,
                                                            height: 60,
                                                          ),
                                                          Container(
                                                              padding: const EdgeInsets.only(top: 17),
                                                              child: Global.getDefaultText("No visits done", Global.GREY)
                                                          )
                                                        ]
                                                    )
                                                ),
                                              ),
                                              realization.length != 0 ? InkWell(
                                                  onTap: (){
                                                    Navigator.push(context, MaterialPageRoute(
                                                        builder: (context) => ListVisit(
                                                          _selectedBranchId,
                                                          backReportOp: (int resMessage, BuildContext ctx, String id) {
                                                            if (resMessage == 1) {
                                                              Navigator.of(ctx).pop();
                                                              if(store.get("role_id") == "2") {
                                                                reportOp(ctx, id);
                                                              } else {
                                                                BlocProvider.of<VisitBloc>(context).add(GetRealizationEvent("year"));
                                                              }
                                                            }
                                                          },
                                                        ))
                                                    );
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: <Widget> [
                                                      Align(
                                                        alignment: Alignment.centerRight,
                                                        child: Text(
                                                          'More',
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
                                                  )
                                              ) : Container()
                                            ],
                                          )
                                      ),
                                      const Divider(
                                        height: 12,
                                      ),
                                      Container(
                                          color: Colors.white,
                                          padding: const EdgeInsets.only(top: 17, right: 21, left: 21, bottom: 17),
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'List of Person in Charge',
                                                  style: TextStyle(color: Color(Global.BLACK), fontSize: 15, fontFamily: 'medium'),
                                                ),
                                              ),
                                              realization.length != 0 ? Container(
                                                  padding: const EdgeInsets.only(top: 7),
                                                  child: ListView.builder(
                                                      itemCount: realization.length < 3 ? realization.length : 3,
                                                      scrollDirection: Axis.vertical,
                                                      shrinkWrap: true,
                                                      physics: NeverScrollableScrollPhysics(),
                                                      itemBuilder: (context, i){
                                                        return ListTile(
                                                            title: Container(
                                                              child: Column(
                                                                  children: <Widget>[
                                                                    Align(
                                                                        alignment: Alignment.centerLeft,
                                                                        child: realization[i].pic_name.contains("%2C") ? Container (
                                                                            child: ListView.builder(
                                                                                itemCount: realization[i].pic_name.split("%2C").length,
                                                                                scrollDirection: Axis.vertical,
                                                                                shrinkWrap: true,
                                                                                physics: NeverScrollableScrollPhysics(),
                                                                                itemBuilder: (context, j){
                                                                                  return Container(
                                                                                    padding: const EdgeInsets.only(top: 5),
                                                                                    child: Text("${realization[i].pic_name.split("%2C")[j]} - ${realization[i].pic_position.split("%2C")[j]}", style: Global.getCustomFont(Global.BLACK, 14, 'medium')),
                                                                                  );
                                                                                }
                                                                            )
                                                                        ) : Container(
                                                                          child: Text("${realization[i].pic_name} - ${realization[i].pic_position}", style: Global.getCustomFont(Global.BLACK, 14, 'medium')),
                                                                        )
                                                                    ),
                                                                    Container(
                                                                      padding: const EdgeInsets.only(top: 5),
                                                                      child: Align(
                                                                        alignment: Alignment.centerLeft,
                                                                        child: Text(realization[i].customer.toString(), style: Global.getCustomFont(Global.GREY, 14, 'medium')),
                                                                      ),
                                                                    ),
                                                                    Divider()
                                                                  ]
                                                              ),
                                                            )
                                                        );
                                                      }
                                                  )
                                              ) :
                                              Container(
                                                padding: const EdgeInsets.only(top: 17, left: 12),
                                                child: Align(
                                                    alignment: Alignment.center,
                                                    child: Column(
                                                        children: <Widget> [
                                                          Image.asset(
                                                            Global.EMPTY_ICON,
                                                            height: 60,
                                                          ),
                                                          Container(
                                                              padding: const EdgeInsets.only(top: 17),
                                                              child: Global.getDefaultText("No PIC yet", Global.GREY)
                                                          )
                                                        ]
                                                    )
                                                ),
                                              ),
                                              realization.length != 0 ? InkWell(
                                                  onTap: (){
                                                    Navigator.push(context, MaterialPageRoute(
                                                        builder: (context) => ListPIC(
                                                          _selectedBranchId,
                                                          backReportOp: (int resMessage, BuildContext ctx, String id) {
                                                            if (resMessage == 1) {
                                                              Navigator.of(ctx).pop();
                                                              if(store.get("role_id") == "2") {
                                                                reportOp(ctx, id);
                                                              } else {
                                                                BlocProvider.of<VisitBloc>(context).add(GetRealizationEvent("year"));
                                                              }
                                                            }
                                                          },
                                                        ))
                                                    );
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: <Widget> [
                                                      Align(
                                                        alignment: Alignment.centerRight,
                                                        child: Text(
                                                          'More',
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
                                                  )
                                              ) : Container()
                                            ],
                                          )
                                      ),
                                      const Divider(
                                        height: 12,
                                      ),
                                      Container(
                                          color: Colors.white,
                                          padding: const EdgeInsets.only(top: 17, right: 21, left: 21, bottom: 17),
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'List of customer',
                                                  style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'medium'),
                                                ),
                                              ),
                                              finalCustName.length != 0 ? Container(
                                                  padding: const EdgeInsets.only(top: 7),
                                                  child: ListView.builder(
                                                      itemCount: finalCustName.length < 3 ? finalCustName.length : 3,
                                                      scrollDirection: Axis.vertical,
                                                      shrinkWrap: true,
                                                      physics: NeverScrollableScrollPhysics(),
                                                      itemBuilder: (context, i){
                                                        return ListTile(
                                                            title: Container(
                                                              child: Column(
                                                                  children: <Widget>[
                                                                    Container(
                                                                      padding: const EdgeInsets.only(top: 5),
                                                                      child: Align(
                                                                        alignment: Alignment.centerLeft,
                                                                        child: Text(finalCustName[i].toString(), style: Global.getCustomFont(Global.BLACK, 14, 'medium')),
                                                                      ),
                                                                    ),
                                                                    Divider()
                                                                  ]
                                                              ),
                                                            )
                                                        );
                                                      }
                                                  )
                                              ) : Container(
                                                padding: const EdgeInsets.only(top: 17, left: 12),
                                                child: Align(
                                                    alignment: Alignment.center,
                                                    child: Column(
                                                        children: <Widget> [
                                                          Image.asset(
                                                            Global.EMPTY_ICON,
                                                            height: 60,
                                                          ),
                                                          Container(
                                                              padding: const EdgeInsets.only(top: 17),
                                                              child: Global.getDefaultText("No customer yet", Global.GREY)
                                                          )
                                                        ]
                                                    )
                                                ),
                                              ),
                                              finalCustName.length != 0 ? InkWell(
                                                  onTap: (){
                                                    Navigator.push(context, MaterialPageRoute(
                                                        builder: (context) => ListCustomer(
                                                          _selectedBranchId,
                                                          backReportOp: (int resMessage, BuildContext ctx, String id) {
                                                            if (resMessage == 1) {
                                                              Navigator.of(ctx).pop();
                                                              if(store.get("role_id") == "2") {
                                                                reportOp(ctx, id);
                                                              } else {
                                                                BlocProvider.of<VisitBloc>(context).add(GetRealizationEvent("year"));
                                                              }
                                                            }
                                                          },
                                                        ))
                                                    );
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: <Widget> [
                                                      Align(
                                                        alignment: Alignment.centerRight,
                                                        child: Text(
                                                          'More',
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
                                                  )
                                              ) : Container()
                                            ],
                                          )
                                      ),
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              }
                          )
                        ]
                    )
                )
            )
        )
    );
  }
}