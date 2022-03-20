import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rinjani/bloc/customer/customer_bloc.dart';
import 'package:rinjani/models/visit.dart';
import 'package:rinjani/views/page/list_customer.dart';
import 'package:rinjani/views/page/list_pic.dart';
import 'package:rinjani/views/page/list_reports.dart';

import '../../bloc/visit/visit_bloc.dart';
import '../../utils/global.dart';
import '../../utils/global_state.dart';
import 'list_visit.dart';

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
  late List<VisitRealById> visitRealById = [];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<VisitBloc>(context).add(GetVisitRealizationByIdEvent(store.get("nik")));
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
              body: BlocBuilder<VisitBloc, VisitBlocState> (
                builder: (context, state) {
                  if (state is InitialVisitBlocState || state is LoadingVisitState) {
                    print(state.toString());
                    return const Center(
                        child: CircularProgressIndicator()
                    );
                  } if(state is VisitRealizationByIdList) {
                    var realization = state.getVisitRealization;
                    for (int i=0; i<state.getVisitRealization.length; i++) {
                      custName.add(state.getVisitRealization[i].cust_name);
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
                                                  builder: (context) => ListCustomer(finalCustName)
                                              ));
                                            },
                                            child: Global.getReportCard('Customer', 0xff7DE0B3, 0xff6ECCA1, 'customer')
                                        ),
                                        InkWell(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(
                                                  builder: (context) => ListPIC(realization)
                                              ));
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
                                                  builder: (context) => ListVisit(realization)
                                              ));
                                            },
                                            child: Global.getReportCard('Visits', 0xffFA898D, 0xffD1777A, 'visit')
                                        ),
                                        InkWell(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(
                                                  builder: (context) => ListReport(realization)
                                              ));
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
                                        'Visit done within a month',
                                        style: TextStyle(color: Color(Global.BLACK), fontSize: 15, fontFamily: 'medium'),
                                      ),
                                    ),
                                    Container(
                                        padding: const EdgeInsets.only(top: 7),
                                        child: ListView.builder(
                                            itemCount: 3,
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
                                                            child: Text(realization[i].cust_name.toString(), style: Global.getCustomFont(Global.BLACK, 14, 'bold')),
                                                          ),
                                                          Container(
                                                            padding: const EdgeInsets.only(top: 5),
                                                            child: Align(
                                                              alignment: Alignment.centerLeft,
                                                              child: Text(realization[i].pic_name.toString(), style: Global.getCustomFont(Global.BLACK, 14, 'medium')),
                                                            ),
                                                          ),
                                                          Divider()
                                                        ]
                                                    ),
                                                  )
                                              );
                                            }
                                        )
                                    ),
                                    InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => ListVisit(realization)
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
                                    )
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
                                    Container(
                                        padding: const EdgeInsets.only(top: 7),
                                        child: ListView.builder(
                                            itemCount: 3,
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
                                                            child: Text(realization[i].pic_name.toString() + " - " + realization[i].pic_name.toString(), style: Global.getCustomFont(Global.BLACK, 14, 'bold')),
                                                          ),
                                                          Container(
                                                            padding: const EdgeInsets.only(top: 5),
                                                            child: Align(
                                                              alignment: Alignment.centerLeft,
                                                              child: Text(realization[i].cust_name.toString(), style: Global.getCustomFont(Global.BLACK, 14, 'medium')),
                                                            ),
                                                          ),
                                                          Divider()
                                                        ]
                                                    ),
                                                  )
                                              );
                                            }
                                        )
                                    ),
                                    InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => ListPIC(realization)
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
                                    )
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
                                    Container(
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
                                    ),
                                    InkWell(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => ListCustomer(finalCustName)
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
                                    )
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
              )
            )
        // )
    );
  }
}