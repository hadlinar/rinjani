import 'package:flutter/material.dart';

import '../../utils/global.dart';
import '../../utils/global_state.dart';
import 'package:intl/intl.dart';

class Off extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _Off();
  }
}

final GlobalState store = GlobalState.instance;

class _Off extends State<Off> {
  String? offType;
  String? descFilled;

  late String initDate;
  DateTime initialDate = DateTime.now();
  DateTime timeStart = DateTime.now();
  DateTime timeEnd = DateTime.now();

  DateTime start = DateTime.now();
  DateTime end = DateTime.now();

  bool clicked = false;

  @override
  void initState() {
    super.initState();
    store.set("clicked", false);
    initDate = "";
  }

  void datePicker(ctx) {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2050)
    ).then((date) {
      setState((){
        store.set("clicked", true);
        store.set("date", date);
        initialDate = date!;
        initDate = initialDate.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    store.set("descOff", descFilled);
    store.set("offType", offType);
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
            padding: const EdgeInsets.only(top: 17, right: 21, left: 21, bottom: 17),
            child: Column(
                children: <Widget> [
                  Container(
                    margin: const EdgeInsets.only(bottom: 30, top: 10),
                    child: Row(
                        children: <Widget> [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Pick a date: ",
                              style: TextStyle(color: Color(Global.BLACK), fontSize: 15, fontFamily: 'medium'),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                              child: InkWell(
                                  onTap: () {
                                    datePicker(context);
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.only(left: 17),
                                      child: ImageIcon(
                                        const AssetImage(Global.CALENDAR_ICON),
                                        color: Color(Global.BLUE),
                                        size: 18,
                                      )
                                  )
                              )
                          )
                        ]
                    ),
                  ),
                  Container(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: initDate != "" ? Container(
                            margin: const EdgeInsets.only(bottom: 30),
                            child: InkWell(
                                onTap: () => datePicker(context),
                                child: Container(
                                    padding: const EdgeInsets.only(left: 17),
                                    child: Text(DateFormat('EEEE, dd MMMM yyy').format(initialDate).toString(),
                                        style: const TextStyle(
                                          color: Color(0xff4F4F4F),
                                          fontFamily: 'book',
                                          fontSize: 15,
                                        )
                                    )
                                )
                            )
                        ) : Container()
                    ),
                  ),
                  DropdownButtonFormField<String>(
                    hint: const Text("Choose"),
                    dropdownColor: Colors.white,
                    style: Global.getCustomFont(Global.BLACK, 15, 'medium'),
                    value: offType,
                    items: ["Izin", "Sakit", "Other"].map((e) {
                      return DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        offType = value;
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
                          borderSide: const BorderSide()
                      ),
                    ),
                  ),
                  offType == "Other" ? Container(
                    padding: const EdgeInsets.only(top: 17),
                    child: TextFormField(
                      style: Global.getCustomFont(Global.BLACK, 15, 'medium'),
                      maxLines: 4,
                      maxLength: 150,
                      onChanged: (text) {
                        setState(() {
                          descFilled = text;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: "Description",
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius .circular(10),
                            borderSide: const BorderSide()),
                      ),
                    ),
                  ) : Container()
                ]
            )
        )
    );
  }
}