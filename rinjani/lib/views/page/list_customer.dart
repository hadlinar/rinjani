
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/visit/visit_bloc.dart';
import '../../utils/global.dart';
import '../../utils/global_state.dart';

class ListCustomer extends StatefulWidget {
  String id;
  BackReportOp? backReportOp;

  ListCustomer(this.id, {this.backReportOp});

  @override
  State<StatefulWidget> createState() {
    return _ListCustomer();
  }
}

final GlobalState store = GlobalState.instance;

typedef BackReportOp = void Function(int resultMessage, BuildContext context, String id);

class _ListCustomer extends State<ListCustomer> {
  String? defaultType;

  List typeVal = [
    "Today",
    "All time",
    "Last 7 days",
    "Last 30 days"
  ];

  @override
  void initState() {
    super.initState();
    if(store.get("role_id") == "2") {
      BlocProvider.of<VisitBloc>(context).add(GetRealizationOpEvent(widget.id, "day"));
    } else {
      BlocProvider.of<VisitBloc>(context).add(GetRealizationEvent("day"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: false,
              leading: IconButton(
                  onPressed: () {
                    return widget.backReportOp!(1, context, widget.id);
                  },
                  icon: ImageIcon(
                    const AssetImage(Global.BACK_ICON),
                    color: Color(Global.BLUE),
                    size: 18,
                  )
              ),
              title: Text(
                  "Report",
                  style: Global.getCustomFont(Global.BLUE, 18, 'medium')
              ),
            ),
            body: SingleChildScrollView(
                reverse: false,
                child: Container(
                  padding: const EdgeInsets.only(top: 17, left: 21, right: 21),
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: <Widget> [
                      Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'List of customers',
                            style: TextStyle(color: Color(Global.BLACK), fontSize: 20, fontFamily: 'medium'),
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget> [
                          Container(
                              padding: const EdgeInsets.only(top: 17, left: 14),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Filter :',
                                    style: Global.getCustomFont(Global.BLACK, 14, 'book')
                                ),
                              )
                          ),
                          Container(
                              width: 200,
                              padding: const EdgeInsets.only(top: 17, left: 12),
                              child: DropdownButtonFormField<String>(
                                dropdownColor: Colors.white,
                                style: Global.getCustomFont(Global.BLACK, 15, 'medium'),
                                value: "Today",
                                items: typeVal.map((e) {
                                  return DropdownMenuItem<String>(
                                    value: e,
                                    child: Text(e),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    defaultType = value;
                                    if(store.get("role_id") == "2") {
                                      if(defaultType == "Today") {
                                        BlocProvider.of<VisitBloc>(context).add(GetRealizationOpEvent(widget.id, "day"));
                                      } else if (defaultType == "Last 7 days") {
                                        BlocProvider.of<VisitBloc>(context).add(GetRealizationOpEvent(widget.id, "week"));
                                      } else if(defaultType == "Last 30 days") {
                                        BlocProvider.of<VisitBloc>(context).add(GetRealizationOpEvent(widget.id, "month"));
                                      } else if(defaultType == "All time") {
                                        BlocProvider.of<VisitBloc>(context).add(GetRealizationOpEvent(widget.id, "year"));
                                      }
                                    } else {
                                      if(defaultType == "Today") {
                                        BlocProvider.of<VisitBloc>(context).add(GetRealizationEvent("day"));
                                      } else if (defaultType == "Last 7 days") {
                                        BlocProvider.of<VisitBloc>(context).add(GetRealizationEvent("week"));
                                      } else if(defaultType == "Last 30 days") {
                                        BlocProvider.of<VisitBloc>(context).add(GetRealizationEvent("month"));
                                      } else if(defaultType == "All time") {
                                        BlocProvider.of<VisitBloc>(context).add(GetRealizationEvent("year"));
                                      }
                                    }
                                  });
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only( top: 10, bottom: 10, left: 12, right: 12),
                                  labelText: "Sort by",
                                  labelStyle: const TextStyle(
                                      color: Color(0xff757575),
                                      fontSize: 15,
                                      fontFamily: 'medium'),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                      borderSide: const BorderSide()
                                  ),
                                ),
                              )
                          ),
                        ],
                      ),
                      BlocBuilder<VisitBloc, VisitBlocState> (
                          builder: (context, state) {
                            print(state.toString());
                            if(state is LoadingVisitState) {
                              return Container(
                                  padding: const EdgeInsets.only(top: 100),
                                  child: const Center(
                                      child: CircularProgressIndicator()
                                  )
                              );
                            } else if(state is GetRealizationState) {
                              late List<String> custName = [];
                              late List<String> finalCustName = [];

                              for (int i=0; i<state.getRealization.length; i++) {
                                custName.add(state.getRealization[i].customer);
                              }
                              finalCustName = custName.toSet().toList();
                              return Container(
                                  padding: const EdgeInsets.only(top: 17),
                                  child: state.getRealization.isNotEmpty ? Container(
                                      child: ListView.builder(
                                          itemCount: finalCustName.length,
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, i){
                                            return ListTile(
                                                title: Container(
                                                  child: Column(
                                                      children: <Widget> [
                                                        Row(
                                                            children: <Widget>[
                                                              Align(
                                                                alignment: Alignment.centerLeft,
                                                                child: Text('${i+1}', style: Global.getCustomFont(Global.BLACK, 14, 'bold')),
                                                              ),
                                                              Container(
                                                                padding: const EdgeInsets.only(left: 17),
                                                                child: Text(finalCustName[i], style: Global.getCustomFont(Global.BLACK, 14, 'bold')),
                                                              ),
                                                            ]
                                                        ),
                                                        const Divider()
                                                      ]
                                                  ),
                                                )
                                            );
                                          }
                                      )
                                  ) : Container(
                                    padding: const EdgeInsets.only(top: 17),
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Column(
                                            children: <Widget> [
                                              Image.asset(
                                                Global.EMPTY_ICON,
                                                height: 60,
                                              ),
                                              Container(
                                                  padding: const EdgeInsets.only(top: 35),
                                                  child: Global.getDefaultText("No customer yet", Global.GREY)
                                              )
                                            ]
                                        )
                                    ),
                                  )
                              );
                            } else if(state is GetRealizationOpState) {
                              late List<String> custName = [];
                              late List<String> finalCustName = [];

                              for (int i=0; i<state.getRealizationOp.length; i++) {
                                custName.add(state.getRealizationOp[i].customer);
                              }
                              finalCustName = custName.toSet().toList();
                              return Container(
                                  padding: const EdgeInsets.only(top: 17),
                                  child: state.getRealizationOp.isNotEmpty ? Container(
                                      child: ListView.builder(
                                          itemCount: finalCustName.length,
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, i){
                                            return ListTile(
                                                title: Container(
                                                  child: Column(
                                                      children: <Widget> [
                                                        Row(
                                                            children: <Widget>[
                                                              Align(
                                                                alignment: Alignment.centerLeft,
                                                                child: Text('${i+1}', style: Global.getCustomFont(Global.BLACK, 14, 'bold')),
                                                              ),
                                                              Container(
                                                                padding: const EdgeInsets.only(left: 17),
                                                                child: Text(finalCustName[i], style: Global.getCustomFont(Global.BLACK, 14, 'bold')),
                                                              ),
                                                            ]
                                                        ),
                                                        const Divider()
                                                      ]
                                                  ),
                                                )
                                            );
                                          }
                                      )
                                  ) : Container(
                                    padding: const EdgeInsets.only(top: 17),
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Column(
                                            children: <Widget> [
                                              Image.asset(
                                                Global.EMPTY_ICON,
                                                height: 60,
                                              ),
                                              Container(
                                                  padding: const EdgeInsets.only(top: 35),
                                                  child: Global.getDefaultText("No customer yet", Global.GREY)
                                              )
                                            ]
                                        )
                                    ),
                                  )
                              );
                            } else {
                              return Container();
                            }
                          }
                      )
                    ],
                  ),
                )
            )
        )
    );
  }
}