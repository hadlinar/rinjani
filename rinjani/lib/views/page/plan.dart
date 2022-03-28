import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rinjani/bloc/visit/visit_bloc.dart';
import 'package:rinjani/views/page/plan_in_office.dart';
import 'package:rinjani/views/page/plan_off.dart';
import 'package:rinjani/views/page/plan_out_office.dart';
import 'package:intl/intl.dart';

import '../../models/visit.dart';
import '../../utils/global.dart';
import '../../utils/global_state.dart';

class Plan extends StatefulWidget {
  SuccessAddVisit? successAddVisit;

  Plan({this.successAddVisit});

  @override
  State<StatefulWidget> createState() {
    return _Plan();
  }
}

typedef SuccessAddVisit = void Function(int resultMessage, BuildContext context);

final GlobalState store = GlobalState.instance;

class _Plan extends State<Plan> {
  String? defaultType;
  List<String>? visitName;

  @override
  void initState() {
    super.initState();
    visitName  = [];
    BlocProvider.of<VisitBloc>(context).add(GetVisitCategoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VisitBloc, VisitBlocState>(
        listener: (context, state) {
          print(state.toString());
          if (state is InitialVisitBlocState || state is LoadingVisitState) {
            const Center(
                child: CircularProgressIndicator()
            );
          }
          if(state is SuccessAddVisitState) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Global.defaultModal(() {
                    widget.successAddVisit!(200, context);
                  }, context, Global.CHECK_ICON, "Visit saved", "Ok", false);
                }
            );

          } if(state is VisitCategoryList) {
            for(int i=0; i < 3; i++) {
              visitName?.add(state.getVisitCategory[i].visit_name);
            }
            setState(() {
              visitName;
            });
          }
          else {
            Container();
          }
        },
        child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: SafeArea(
              top: false,
              bottom: false,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  centerTitle: false,
                  leading: IconButton(
                      onPressed: Navigator.of(context).pop,
                      icon: ImageIcon(
                        const AssetImage(Global.BACK_ICON),
                        color: Color(Global.BLUE),
                        size: 18,
                      )
                  ),
                  title: Text(
                      "Back",
                      style: Global.getCustomFont(Global.BLUE, 18, 'medium')
                  ),
                ),
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                    reverse: false,
                    child: Column(
                      children: <Widget> [
                        Container(
                            padding: const EdgeInsets.only(top: 22, right: 21, left: 21),
                            child: DropdownButtonFormField<String>(
                              hint: const Text("Choose type of plan"),
                              dropdownColor: Colors.white,
                              style: Global.getCustomFont(Global.BLACK, 15, 'medium'),
                              value: defaultType,
                              items: visitName?.map((e) {
                                return DropdownMenuItem<String>(
                                  value: e,
                                  child: Text(e),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  defaultType = value;
                                });
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only( top: 10, bottom: 10, left: 12, right: 12),
                                labelText: "Type",
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
                        defaultType == "in-office" ? Container(
                            child: InOffice(
                                defaultType!
                            )
                        )
                            : (defaultType == "out-office" ? Container(
                            child: OutOffice()
                        )
                            : (defaultType == "off" ? Container(
                            child: Off()
                        ) : Container()))
                      ],
                    )
                ),
                bottomNavigationBar: Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 18, right: 18, top: 9, bottom: 9),
                        width: double.infinity,
                        height: 56,
                        color: Colors.white,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Color(Global.BLUE)),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            color: Color(Global.BLUE),
                            onPressed: () {
                              String timeStart = store.get("timeStart").toString();
                              String timeEnd = store.get("timeEnd").toString();
                              String desc = store.get("desc").toString();
                              if(defaultType == "in-office") {
                                BlocProvider.of<VisitBloc>(context).add(
                                    AddVisitEvent(
                                      "01",
                                      store.get("branch_id"),
                                      "",
                                      timeStart,
                                      timeEnd,
                                      store.get("nik"),
                                      desc,
                                      "",
                                      "",
                                      "y"
                                    )
                                );

                              }
                              else if(defaultType == "off") {
                                String type = store.get("offType");
                                String desc = type != "Other" ? type : store.get("descOff");
                                print(desc);
                                // print(type);
                                var hourPagi = 8;
                                var hourSore = 17;
                                var newMin = 0;
                                var newSec = 0;
                                var timeStart, timeFinish;
                                timeStart = DateTime.now();
                                timeFinish = DateTime.now();
                                timeStart = new DateTime(timeStart.year, timeStart.month, timeStart.day, hourPagi, newMin, newSec).toString();
                                timeFinish = new DateTime(timeFinish.year, timeFinish.month, timeFinish.day, hourSore, newMin, newSec).toString();

                                BlocProvider.of<VisitBloc>(context).add(
                                    AddVisitEvent(
                                      "03",
                                      store.get("branch_id"),
                                      "",
                                      timeStart,
                                      timeFinish,
                                      store.get("nik"),
                                      desc,
                                      "",
                                      "",
                                      "y",
                                    )
                                );
                              }
                              else {
                                List<Map<String, dynamic>> res = store.get("result");
                                List<String> pos = [];
                                List<String> name = [];

                                for(int i=0; i<res.length; i++ ){
                                  pos.add(res[i]['pic']['position']);
                                  name.add(res[i]['pic']['name']);
                                }

                                String position = pos.join(", ");
                                String name1 = name.join(", ");

                                // String timeStart = store.get("startTime").toString();
                                DateTime timeStart = store.get("startTime");
                                DateTime timeEnd = store.get("endTime");
                                String cust_id = store.get("cust_id").toString();
                                print(timeStart.toLocal());
                                print(timeEnd.toLocal());

                                BlocProvider.of<VisitBloc>(context).add(
                                    AddVisitEvent(
                                      "02",
                                      store.get("branch_id"),
                                      cust_id,
                                      timeStart.toLocal().toString(),
                                      timeEnd.toLocal().toString(),
                                      store.get("nik"),
                                      "",
                                      position,
                                      name1,
                                      "n",
                                    )
                                );
                              }
                            },
                            child: const Text(
                              "Submit",
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
              ),
            )
        )
    );
  }
}