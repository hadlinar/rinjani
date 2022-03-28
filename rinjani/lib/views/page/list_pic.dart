import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/visit/visit_bloc.dart';
import '../../models/user.dart';
import '../../models/visit.dart';
import '../../utils/global.dart';
import '../../utils/global_state.dart';

class ListPIC extends StatefulWidget {
  String id;
  BackReportOp? backReportOp;

  ListPIC(this.id, {this.backReportOp});

  @override
  State<StatefulWidget> createState() {
    return _ListPIC();
  }
}

final GlobalState store = GlobalState.instance;

typedef BackReportOp = void Function(int resultMessage, BuildContext context, String id);

class _ListPIC extends State<ListPIC> {
  String? defaultType;

  @override
  void initState() {
    super.initState();
    if(store.get("role_id") == "2") {
      BlocProvider.of<VisitBloc>(context).add(GetRealizationOpEvent(widget.id, "day"));
    } else {
      BlocProvider.of<VisitBloc>(context).add(GetRealizationEvent("day"));
    }
  }

  List typeVal = [
    "Today",
    "All time",
    "Last 7 days",
    "Last 30 days"
  ];

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
                    children: <Widget>[
                      Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'List of PICs',
                            style: TextStyle(color: Color(Global.BLACK),
                                fontSize: 20,
                                fontFamily: 'medium'),
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                              padding: const EdgeInsets.only(top: 17, left: 14),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Filter :',
                                    style: Global.getCustomFont(Global.BLACK,
                                        14, 'book')
                                ),
                              )
                          ),
                          Container(
                              width: 200,
                              padding: const EdgeInsets.only(top: 17, left: 12),
                              child: DropdownButtonFormField<String>(
                                dropdownColor: Colors.white,
                                style: Global.getCustomFont(
                                    Global.BLACK, 15, 'medium'),
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
                                  contentPadding: const EdgeInsets.only(top: 10,
                                      bottom: 10,
                                      left: 12,
                                      right: 12),
                                  labelText: "Sort by",
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
                        ],
                      ),
                      BlocBuilder<VisitBloc, VisitBlocState> (
                        builder: (context, state) {
                          print(state.toString());
                          if (state is LoadingVisitState) {
                            return Container(
                                padding: const EdgeInsets.only(top: 20),
                                child: const Center(
                                    child: CircularProgressIndicator()
                                )
                            );
                          } else if (state is GetRealizationState) {
                            return Container(
                                  padding: const EdgeInsets.only(top: 17),
                                  child: state.getRealization.length != 0 ?
                                    Container(
                                      child: ListView.builder(
                                          itemCount: state.getRealization.length,
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, i) {
                                            return ListTile(
                                                title: Container(
                                                  alignment: Alignment.topLeft,
                                                  child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Container(
                                                              margin: const EdgeInsets.only(right: 17, top: 8),
                                                              child: Align(
                                                                alignment: Alignment.topLeft,
                                                                child: Text('${i + 1}.',
                                                                    style: Global.getCustomFont(Global.BLACK, 14, 'bold')
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Align(
                                                                      alignment: Alignment.centerLeft,
                                                                      child: state.getRealization[i].pic_name.contains(",") ? Container(
                                                                          child: SizedBox(
                                                                              width: 300,
                                                                              child: ListView.builder(
                                                                                  itemCount: state.getRealization[i].pic_name.split(", ").length,
                                                                                  scrollDirection: Axis.vertical,
                                                                                  shrinkWrap: true,
                                                                                  physics: NeverScrollableScrollPhysics(),
                                                                                  itemBuilder: (context, j){
                                                                                    return Container(
                                                                                      padding: const EdgeInsets.only(top: 5),
                                                                                      child: Text("${state.getRealization[i].pic_name.split(", ")[j]} - ${state.getRealization[i].pic_position.split(", ")[j]}", style: Global.getCustomFont(Global.BLACK, 14, 'medium')),
                                                                                    );
                                                                                  }
                                                                              )
                                                                          )
                                                                      ) : Container(
                                                                        child: Text("${state.getRealization[i].pic_name} - ${state.getRealization[i].pic_position}",
                                                                            style: Global.getCustomFont(Global.BLACK, 14, 'bold')
                                                                        ),
                                                                      )
                                                                  ),
                                                                  Container(
                                                                    padding: const EdgeInsets.only(top: 5),
                                                                    child: Align(
                                                                      alignment: Alignment.centerLeft,
                                                                      child: Text(state.getRealization[i].customer,
                                                                          style: Global.getCustomFont(Global.BLACK, 14, 'medium')
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Divider()
                                                      ]
                                                  ),
                                                )
                                            );
                                          }
                                      )
                                    )
                                  : Container(
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
                                                  child: Global.getDefaultText("No PIC yet", Global.GREY)
                                              )
                                            ]
                                        )
                                    ),
                                  )
                              );
                          } else if (state is GetRealizationOpState) {
                            return Container(
                                padding: const EdgeInsets.only(top: 17),
                                child: state.getRealizationOp.length != 0 ?
                                Container(
                                    child: ListView.builder(
                                        itemCount: state.getRealizationOp.length,
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, i) {
                                          return ListTile(
                                              title: Container(
                                                alignment: Alignment.topLeft,
                                                child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Container(
                                                            margin: const EdgeInsets.only(right: 17, top: 8),
                                                            child: Align(
                                                              alignment: Alignment.topLeft,
                                                              child: Text('${i + 1}.',
                                                                  style: Global.getCustomFont(Global.BLACK, 14, 'bold')
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Align(
                                                                    alignment: Alignment.centerLeft,
                                                                    child: state.getRealizationOp[i].pic_name.contains(",") ? Container(
                                                                        child: SizedBox(
                                                                            width: 300,
                                                                            child: ListView.builder(
                                                                                itemCount: state.getRealizationOp[i].pic_name.split(", ").length,
                                                                                scrollDirection: Axis.vertical,
                                                                                shrinkWrap: true,
                                                                                physics: NeverScrollableScrollPhysics(),
                                                                                itemBuilder: (context, j){
                                                                                  return Container(
                                                                                    padding: const EdgeInsets.only(top: 5),
                                                                                    child: Text("${state.getRealizationOp[i].pic_name.split(", ")[j]} - ${state.getRealizationOp[i].pic_position.split(", ")[j]}", style: Global.getCustomFont(Global.BLACK, 14, 'medium')),
                                                                                  );
                                                                                }
                                                                            )
                                                                        )
                                                                    ) : Container(
                                                                      child: Text("${state.getRealizationOp[i].pic_name} - ${state.getRealizationOp[i].pic_position}",
                                                                          style: Global.getCustomFont(Global.BLACK, 14, 'bold')
                                                                      ),
                                                                    )
                                                                ),
                                                                Container(
                                                                  padding: const EdgeInsets.only(top: 5),
                                                                  child: Align(
                                                                    alignment: Alignment.centerLeft,
                                                                    child: Text(state.getRealizationOp[i].customer,
                                                                        style: Global.getCustomFont(Global.BLACK, 14, 'medium')
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Divider()
                                                    ]
                                                ),
                                              )
                                          );
                                        }
                                    )
                                )
                                    : Container(
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
                                                child: Global.getDefaultText("No PIC yet", Global.GREY)
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