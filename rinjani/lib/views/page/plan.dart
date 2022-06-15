import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rinjani/bloc/customer/customer_bloc.dart';
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
                    store.set("clicked", false);
                    store.set("clickedStart", false);
                    store.set("clickedEnd", false);
                    store.set("savedCust", false);
                  }, context, Global.CHECK_ICON, "Visit saved", "Ok", false);
                }
            );

          }
          if(state is VisitCategoryList) {
            for(int i=0; i < 3; i++) {
              visitName?.add(state.getVisitCategory[i].visit_name);
            }
            setState(() {
              visitName;
            });
          }
          if(state is FailedAddCustVisitState) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Global.defaultModal(() {
                    Navigator.pop(context);
                  }, context, Global.WARNING_ICON, "Customer is already exist", "Ok", false);
                }
            );
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
                        defaultType == "In-office" ? Container(
                            child: InOffice(
                                defaultType!
                            )
                        )
                            : (defaultType == "Out-office" ? Container(
                            child: OutOffice()
                        )
                            : (defaultType == "Off" ? Container(
                            child: Off()
                        ) : Container()))
                      ],
                    )
                ),
                bottomNavigationBar: Stack(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(left: 18, right: 18, top: 9, bottom: 9),
                        margin: const EdgeInsets.only(bottom: 20),
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
                              if(defaultType == "In-office") {
                                String timeStart = store.get("timeStart").toString();
                                String timeEnd = store.get("timeEnd").toString();
                                String desc = store.get("desc").toString();
                                String clicked = store.get("clicked").toString();
                                String clickedStart = store.get("clickedStart").toString();
                                String clickedEnd = store.get("clickedEnd").toString();

                                if(clicked == "false") {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Global.defaultModal(() {
                                          Navigator.pop(context);
                                        }, context, Global.WARNING_ICON, "Please pick a date", "Ok", false);
                                      }
                                  );
                                } else {
                                  if(clickedStart == "null" && clickedEnd == "null") {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Global.defaultModal(() {
                                            Navigator.pop(context);
                                          }, context, Global.WARNING_ICON, "Please pick start and end time", "Ok", false);
                                        }
                                    );
                                  } else {
                                    if(desc == "") {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Global.defaultModal(() {
                                              Navigator.pop(context);
                                            }, context, Global.WARNING_ICON, "Please fill the description", "Ok", false);
                                          }
                                      );
                                    } else {
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
                                              "n"
                                          )
                                      );
                                      store.set("desc", "");
                                      store.set("clicked", "false");
                                      store.set("clickedStart", "null");
                                      store.set("clickedEnd", "null");
                                    }
                                  }
                                }
                              }
                              else if(defaultType == "Off") {
                                String type = store.get("offType");
                                String desc = type != "Other" ? type : store.get("descOff");
                                var hourPagi = 8;
                                var hourSore = 17;
                                var newMin = 0;
                                var newSec = 0;
                                DateTime date = store.get("date");
                                String clicked = store.get("clicked").toString();
                                var timeStart, timeFinish;
                                timeStart = DateTime.now();
                                timeFinish = DateTime.now();
                                timeStart = DateTime(date.year, date.month, date.day, hourPagi, newMin, newSec).toString();
                                timeFinish = DateTime(date.year, date.month, date.day, hourSore, newMin, newSec).toString();

                                if(clicked != "false") {
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
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Global.defaultModal(() {
                                          Navigator.pop(context);
                                        }, context, Global.WARNING_ICON, "Please fill all the required form", "Ok", false);
                                      }
                                  );
                                }
                              }
                              else {
                                List<Map<String, dynamic>> res = store.get("result");
                                List<String> pos = [];
                                List<String> name = [];
                                List<String> desc = [];

                                DateTime timeStart = store.get("startTime");
                                DateTime timeEnd = store.get("endTime");
                                String cust_id = store.get("cust_id").toString();

                                String clicked = store.get("clicked").toString();
                                String clickedStart = store.get("clickedStart").toString();
                                String clickedEnd = store.get("clickedEnd").toString();

                                bool savedCust = store.get("savedCust");
                                String newCust = store.get("cust_name").toString();
                                String catId = store.get("cat_id").toString();

                                if(clicked == "null" || clicked == "" || clicked == "false" || clicked == false) {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Global.defaultModal(() {
                                          Navigator.pop(context);
                                        }, context, Global.WARNING_ICON, "Please pick a date", "Ok", false);
                                      }
                                  );
                                } else {
                                  if(clickedStart != "true" && clickedEnd != "true") {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Global.defaultModal(() {
                                            Navigator.pop(context);
                                          }, context, Global.WARNING_ICON, "Please pick start and end time", "Ok", false);
                                        }
                                    );
                                  } else {
                                    if(cust_id == "null" && newCust == "null") {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Global.defaultModal(() {
                                              Navigator.pop(context);
                                            }, context, Global.WARNING_ICON, "Please select or add customer", "Ok", false);
                                          }
                                      );
                                    }
                                    else {
                                      if(res == null) {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Global.defaultModal(() {
                                                Navigator.pop(context);
                                              }, context, Global.WARNING_ICON, "Please fill all PIC data", "Ok", false);
                                            }
                                        );
                                      } else {
                                        for(int i=0; i<res.length; i++ ){
                                          pos.add(res[i]['pic']['position']);
                                          name.add(res[i]['pic']['name']);
                                          desc.add(res[i]['pic']['description']);
                                        }

                                        String position = pos.join(", ");
                                        String name1 = name.join(", ");
                                        String description = desc.join(", ");
                                        if(position == "null" || name1 == "null" || description == "null" || name.contains("") || pos.contains("") || desc.contains("")) {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Global.defaultModal(() {
                                                  Navigator.pop(context);
                                                }, context, Global.WARNING_ICON, "Please fill all required data for PIC", "Ok", false);
                                              }
                                          );
                                        } else {
                                          if(savedCust) {
                                            BlocProvider.of<VisitBloc>(context).add(
                                                AddCustomerEvent(
                                                  store.get("branch_id"),
                                                  newCust,
                                                  catId,
                                                  "02",
                                                  "",
                                                  timeStart.toString(),
                                                  timeEnd.toString(),
                                                  store.get("user_id"),
                                                  description,
                                                  position,
                                                  name1,
                                                  "n",
                                                )
                                            );
                                          } else {
                                            BlocProvider.of<VisitBloc>(context).add(
                                                AddVisitEvent(
                                                  "02",
                                                  store.get("branch_id"),
                                                  cust_id,
                                                  timeStart.toString(),
                                                  timeEnd.toString(),
                                                  store.get("user_id"),
                                                  description,
                                                  position,
                                                  name1,
                                                  "n",
                                                )
                                            );
                                            List<Map<String, dynamic>> res = store.get("result");
                                            List<String> pos = [];
                                            List<String> name = [];
                                            List<String> desc = [];
                                            store.set("result", "");
                                            store.set("clickedStart", "false");
                                            store.set("clickedEnd", "false");
                                            store.set("cust_id", "null");
                                            store.set("clicked", "false");
                                            store.set("newCust", "null");
                                            store.set("savedCust", false);
                                          }
                                        }
                                      }
                                    }
                                  }
                                }
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