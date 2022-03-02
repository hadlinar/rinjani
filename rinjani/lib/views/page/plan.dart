import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rinjani/bloc/visit/visit_bloc.dart';
import 'package:rinjani/views/page/plan_in_office.dart';
import 'package:rinjani/views/page/plan_off.dart';
import 'package:rinjani/views/page/plan_out_office.dart';

import '../../models/visit.dart';
import '../../utils/global.dart';
import '../../utils/global_state.dart';
import 'package:intl/intl.dart';

class Plan extends StatefulWidget {
  final DateTime focusedDay;
  final List<String>? autoCompletion;

  Plan(this.focusedDay,{this.autoCompletion});

  @override
  State<StatefulWidget> createState() {
    return _Plan();
  }
}

final GlobalState store = GlobalState.instance;

class _Plan extends State<Plan> {
  String? defaultType;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<VisitBloc>(context).add(GetVisitCategoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VisitBloc, VisitBlocState>(
        builder: (context, state) {
          if(state is VisitCategoryList) {
            List<String> visitName = [];

            for(int i=0; i < 3; i++) {
              visitName.add(state.getVisitCategory[i].visit_name);
            }

            return GestureDetector(
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
                                  items: visitName.map((e) {
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
                                child: InOffice()
                            )
                                : (defaultType == "out-office" ? Container(
                                child: OutOffice(widget.autoCompletion)
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
                                  print(defaultType);
                                  print(DateFormat("dd/MM/yyyy").format(widget.focusedDay));
                                  if(defaultType == "In-office") {
                                    print(store.get("desc"));
                                    print(store.get("timeStart"));
                                    print(store.get("timeEnd"));
                                  } else if(defaultType == "Off") {
                                    print(store.get("descOff"));
                                    print(store.get("offType"));
                                  } else {
                                    print(store.get("result"));
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
            );
          }
          else {
            return Container();
          }
        },
    );
  }
}