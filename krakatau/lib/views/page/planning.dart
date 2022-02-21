import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:substring_highlight/substring_highlight.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../../utils/global.dart';
import '../../widget/calendar.dart';
import 'package:intl/intl.dart';

class Planning extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Planning();
  }
}

class _Planning extends State<Planning> {
  String? defaultType;
  String? offType;
  DateTime timeStart = DateTime.now();
  DateTime timeEnd = DateTime.now();
  bool isLoading = false;
  late List<String> autoCompletion;
  var _selectedCust = null;
  var _selectedPIC = null;
  // late TextEditingController controller;



  List typeVal = [
    "In-office",
    "Out-office",
    "Off"
  ];

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

  Future fetchAutoCompleteData() async {
    setState(() {
      isLoading = true;
    });

    final String stringData = await rootBundle.loadString("assets/dummy.json");
    final List<dynamic> json = jsonDecode(stringData);
    final List<String> jsonStringData = json.cast<String>();

    setState((){
      isLoading = false;
      autoCompletion = jsonStringData;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAutoCompleteData();
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
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          reverse: false,
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 26, right: 21, left: 21, bottom: 17),
                child: DropdownButtonFormField<String>(
                    hint: Text("Choose type of plan"),
                    dropdownColor: Colors.white,
                    style: Global.getCustomFont(Global.BLACK, 15, 'medium'),
                    value: defaultType,
                    items: typeVal.map((e) {
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
              Row(
                children: <Widget> [
                  Container(
                    padding: const EdgeInsets.only(right: 21, left: 21),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Start date",
                              style: TextStyle(color: Color(Global.BLACK), fontSize: 15, fontFamily: 'medium'),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => Calendar()
                                ));
                              },
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 6, right: 22),
                                    child: Global.getDefaultText(DateFormat('dd - MM - yyyy').format(DateTime.now()), Global.GREY),
                                  ),
                                  ImageIcon(
                                    AssetImage(Global.CALENDAR_ICON),
                                    color: Color(Global.BLUE),
                                    size: 18,
                                  )
                                ],
                              )
                          ),
                        ],
                      ),
                    )
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 21, left: 21),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("End date",
                              style: TextStyle(color: Color(Global.BLACK), fontSize: 15, fontFamily: 'medium'),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => Calendar()
                                ));
                              },
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 6, right: 22),
                                    child: Global.getDefaultText(DateFormat('dd - MM - yyyy').format(DateTime.now()), Global.GREY),
                                  ),
                                  ImageIcon(
                                    AssetImage(Global.CALENDAR_ICON),
                                    color: Color(Global.BLUE),
                                    size: 18,
                                  )
                                ],
                              )
                          ),
                        ],
                      ),
                    )
                  )
                ]
              ),
              Container(
                padding: const EdgeInsets.only(top: 26, right: 21, left: 21),
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
                      ],
                    )
                  ],
                )
              ),
              defaultType == "In-office" ? Container(
                padding: const EdgeInsets.only(top: 17, left: 21, right: 21),
                child: TextFormField(
                  style:
                  Global.getCustomFont(Global.BLACK, 15, 'medium'),
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
              ) : (
                defaultType == "Out-office" ? (isLoading ? const Center(
                  child: CircularProgressIndicator()
                ) : Container(
                    padding: const EdgeInsets.only(top: 17, left: 21, right: 21),
                    child: Column(
                      children: <Widget> [
                        Container(
                          child: DropdownSearch<String>(
                            mode: Mode.MENU,
                            showClearButton: true,
                            showSelectedItems: true,
                            items: autoCompletion,
                            dropdownSearchBaseStyle: TextStyle(fontSize: 15, fontFamily: 'medium'),
                            label: "Customer",
                            showSearchBox: true,
                            onChanged: (val) {
                              print(val);
                              _selectedCust = val;
                            },
                            selectedItem: _selectedCust,
                            dropdownSearchDecoration: InputDecoration(
                              labelText: "Select a customer",
                              labelStyle: TextStyle(fontSize: 15, fontFamily: 'medium'),
                              alignLabelWithHint: true,
                              contentPadding: EdgeInsets.only(left: 12),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius .circular(10),
                                  borderSide: BorderSide()),
                            ),
                          )
                        ),
                        Container(
                            padding: const EdgeInsets.only(top: 17),
                            child: DropdownSearch<String>(
                              mode: Mode.MENU,
                              showClearButton: true,
                              showSelectedItems: true,
                              items: ["PIC1", "PIC2", "PIC3", "PIC4"],
                              dropdownSearchBaseStyle: TextStyle(fontSize: 15, fontFamily: 'medium'),
                              label: "Person in Charge",
                              showSearchBox: true,
                              onChanged: (val) {
                                print(val);
                                _selectedPIC = val;
                              },
                              selectedItem: _selectedPIC,
                              dropdownSearchDecoration: InputDecoration(
                                labelText: "Select a PIC",
                                labelStyle: TextStyle(fontSize: 15, fontFamily: 'medium'),
                                alignLabelWithHint: true,
                                contentPadding: EdgeInsets.only(left: 12),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius .circular(10),
                                    borderSide: BorderSide()),
                              ),
                            )
                        ),
                      ]
                    )
                  )
                ) : (
                  defaultType == "Off" ? Container(
                    padding: const EdgeInsets.only(top: 17, right: 21, left: 21, bottom: 17),
                    child: Column(
                      children: <Widget> [
                        DropdownButtonFormField<String>(
                          hint: Text("Choose"),
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
                                borderSide: BorderSide()
                            ),
                          ),
                        ),
                        offType == "Other" ? Container(
                          padding: const EdgeInsets.only(top: 17),
                          child: TextFormField(
                            style:
                            Global.getCustomFont(Global.BLACK, 15, 'medium'),
                            maxLines: 4,
                            maxLength: 150,
                            decoration:
                            InputDecoration(
                              labelText: "Description",
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius .circular(10),
                                  borderSide: BorderSide()),
                            ),
                          ),
                        ) : Container()
                      ]
                    )
                  ) : Container()
                )
              ),
            ],
          )
        )
      )
    );
  }
}