import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krakatau/utils/global_state.dart';

import '../../utils/global.dart';
import 'package:intl/intl.dart';

class InOffice extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _InOffice();
  }
}

final GlobalState store = GlobalState.instance;

class _InOffice extends State<InOffice> {
  final descriptionController = TextEditingController();
  DateTime timeStart = DateTime.now();
  DateTime timeEnd = DateTime.now();

  void startTime(ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
          height: 300,
          color: const Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                    initialDateTime: DateTime.now().add(
                      Duration(minutes: 60 - DateTime.now().minute % 30),
                    ),
                    mode: CupertinoDatePickerMode.time,
                    minuteInterval: 15,
                    use24hFormat: true,
                    onDateTimeChanged: (val) {
                      setState(() {
                        timeStart = val;
                      });
                    }),
              ),
              CupertinoButton(
                child: Text("Save",
                  style: TextStyle(color: Color(Global.BLUE), fontSize: 18, fontFamily: 'medium'),
                ),
                onPressed: () => Navigator.of(ctx).pop(),
              )
            ],
          ),
        )
    );
  }

  void endTime(ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
          height: 300,
          color: const Color.fromARGB(255, 255, 255, 255),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                    initialDateTime: DateTime.now().add(
                      Duration(minutes: 60 - DateTime.now().minute % 30),
                    ),
                    mode: CupertinoDatePickerMode.time,
                    minuteInterval: 15,
                    minimumDate: timeStart,
                    use24hFormat: true,
                    onDateTimeChanged: (val) {
                      setState(() {
                        timeEnd = val;
                      });
                    }),
              ),
              CupertinoButton(
                child: Text("Save",
                  style: TextStyle(color: Color(Global.BLUE), fontSize: 18, fontFamily: 'medium'),
                ),
                onPressed: () => Navigator.of(ctx).pop(),
              )
            ],
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    store.set("desc", descriptionController.text);
    store.set("timeStart", DateFormat("HH:mm").format(timeStart));
    store.set("timeEnd", DateFormat("HH:mm").format(timeEnd));
    return GestureDetector (
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Container(
          padding: const EdgeInsets.only(top: 17, left: 21, right: 21),
          child: Column(
              children: <Widget> [
                Container(
                    padding: const EdgeInsets.only(right: 21, left: 21, bottom: 17),
                    child:
                    Column(
                      children: <Widget> [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Time",
                            style: TextStyle(color: Color(Global.BLACK), fontSize: 15, fontFamily: 'medium'),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Row(
                            children: <Widget> [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: CupertinoButton(
                                  child: Row(
                                      children: <Widget> [
                                        Padding(
                                          padding: const EdgeInsets.only(right: 22),
                                          child: Global.getDefaultText(DateFormat("HH:mm").format(timeStart), Global.GREY),
                                        ),
                                        ImageIcon(
                                          AssetImage(Global.CLOCK_ICON),
                                          color: Color(Global.BLUE),
                                          size: 18,
                                        )
                                      ]
                                  ),
                                  onPressed: () => startTime(context),
                                ),
                              ),
                              Global.getDefaultText("-", Global.BLACK),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: CupertinoButton(
                                  child: Row(
                                      children: <Widget> [
                                        Padding(
                                          padding: const EdgeInsets.only(right: 22),
                                          child: Global.getDefaultText(DateFormat("HH:mm").format(timeEnd), Global.GREY),
                                        ),
                                        ImageIcon(
                                          AssetImage(Global.CLOCK_ICON),
                                          color: Color(Global.BLUE),
                                          size: 18,
                                        )
                                      ]
                                  ),
                                  onPressed: () => endTime(context),
                                ),
                              ),
                            ]
                        )
                      ],
                    )
                ),
                TextFormField(
                  style: Global.getCustomFont(Global.BLACK, 15, 'medium'),
                  controller: descriptionController,
                  maxLines: 5,
                  maxLength: 200,
                  decoration: InputDecoration(
                    labelText: "Description",
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius .circular(10),
                        borderSide: BorderSide()),
                  ),
                ),
              ]
          )
      )
    );
  }
}