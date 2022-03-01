import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/global.dart';
import '../../utils/global_state.dart';
import 'package:intl/intl.dart';

import '../../widget/custom_text_field.dart';

class OutOffice extends StatefulWidget {
  final List<String>? autoCompletion;
  OutOffice(this.autoCompletion);

  @override
  State<StatefulWidget> createState() {
    return _OutOffice();
  }
}

final GlobalState store = GlobalState.instance;

class _OutOffice extends State<OutOffice> {
  var visitCard = <Column>[];

  int _count = 1;

  void _addCount() {
    setState((){
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _container = List.generate(_count, (int i) {
      return AddPlan(widget.autoCompletion, _count-1);
    });
    return GestureDetector (
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
            child: Column(
                children: <Widget> [
                  Column(
                    children: _container,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: const Divider(),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: double.infinity,
                        color: Colors.white,
                        child: Stack(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(left: 18, right: 18, top: 9, bottom: 9),
                                width: 153,
                                height: 56,
                                color: Colors.white,
                                child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(color: Color(Global.BLUE)),
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    color: Color(Global.BLUE),
                                    onPressed: _addCount,
                                    child: const Text(
                                      "Add visit",
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
                      )
                  ),
                ]
            )
        )
    );
  }
}

class AddPlan extends StatefulWidget {
  final List<String>? autoCompletion;
  final int indexVisit;
  AddPlan(this.autoCompletion, this.indexVisit);

  @override
  State<StatefulWidget> createState() => _AddPlan();
}

class _AddPlan extends State<AddPlan> {
  late List<Map<String, dynamic>> _values;
  late List<Map<String, dynamic>> value;

  var positionTextEditing = <TextEditingController>[];
  var nameTextEditing = <TextEditingController>[];
  var positionPIC = <String>[];
  var namePIC = <String>[];
  var cards = <Column>[];
  var _selectedCust = null;


  // bool isLoading = false;
  DateTime timeStart = DateTime.now();
  DateTime timeEnd = DateTime.now();

  int indexCard = 0;
  int indexPIC = 0;

  late String _result;
  late String result;

  Column createCard(int key) {
    String pos = '';
    String name = '';
    var positionController = TextEditingController();
    var nameController = TextEditingController();
    positionTextEditing.add(positionController);
    nameTextEditing.add(nameController);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
            children: <Widget> [
              Container(
                padding: const EdgeInsets.only(left: 21, right: 21, bottom: 17),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Person in Charge",
                    style: TextStyle(color: Color(Global.BLACK), fontSize: 15, fontFamily: 'medium'),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ]
        ),
        Container(
          padding: const EdgeInsets.only(left: 21, right: 21),
          child: CustomTextField(
            label: 'Position',
            controller: positionController,
            onChange: (val) {
              pos = val;
              if(name == null) {
                _onUpdate(indexPIC: indexPIC, valPos: val, valName: '');
              } else {
                _onUpdate(indexPIC: indexPIC, valPos: val, valName: name);
              }
            },
          ),
        ),
        Container(
            padding: const EdgeInsets.only(left: 21, right: 21),
            child: CustomTextField(
              label: 'Name',
              controller: nameController,
              onChange: (val) {
                name = val;
                if(pos == null) {
                  _onUpdate(indexPIC: indexPIC, valPos: '', valName: val);
                } else {
                  _onUpdate(indexPIC: indexPIC, valPos: pos, valName: val);
                }
              },
            )
        )
      ],
    );
  }


  _onUpdate({int? indexPIC, String? valPos, String? valName}){
    int? foundKey = -1;

    for(var map in _values) {
      if(map.containsKey('id_customer')) {
        if(map['list_pic']['id'] == indexPIC) {
          foundKey = indexPIC;
          break;
        }
      }
    }

    if(-1 != foundKey) {
      _values.removeWhere((map) {
        return map['list_pic']['id'] == foundKey;
      });
    }

    Map<String, dynamic> jsonPIC = {
      'id' : indexPIC,
      'pic': {
        'position': valPos,
        'name': valName
      }
    };

    Map<String, dynamic> json = {
      'id_customer': widget.indexVisit,
      'startTime': DateFormat("HH:mm").format(timeStart).toString(),
      'endTime': DateFormat("HH:mm").format(timeEnd).toString(),
      'customer': _selectedCust,
      'list_pic': {
        'id' : indexPIC,
        'pic': {
          'position': valPos,
          'name': valName
        }
      }
    };

    _values.add(json);

    setState(() {
      _result = printJson(_values);
    });
  }

  _onRemove(int key){
    setState(() {
      _values.removeWhere((e) => e.values.first == key);
      for(var map in _values) {
        if(map.containsKey('id')) {
          if(map['id'] > key) {
            map['id'] -= 1;
          }
        }
      }
      _result = printJson(_values);
      store.set("positionPIC", _result);
    });
  }

  String printJson(jsonObject) {
    var encoder = const JsonEncoder.withIndent('      ');
    return encoder.convert(jsonObject);
  }


  @override
  void initState() {
    super.initState();
    cards.add(createCard(indexPIC));
    _values = [];
    _result = '';
    // value = [];
    // result = '';
  }

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

    store.set("result", _result);
    return Column(
        children: <Widget> [
          Container(
              padding: const EdgeInsets.only(right: 21, left: 21, bottom: 17, top: 17),
              child:
              Column(
                children: <Widget> [
                  Container(
                    padding: const EdgeInsets.only(right: 21, left: 21),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Time",
                        style: TextStyle(color: Color(Global.BLACK), fontSize: 15, fontFamily: 'medium'),
                        textAlign: TextAlign.left,
                      ),
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
          Container(
              padding: const EdgeInsets.only(right: 21, left: 21, bottom: 17),
              child: DropdownSearch<String>(
                mode: Mode.MENU,
                showClearButton: true,
                showSelectedItems: true,
                items: widget.autoCompletion,
                dropdownSearchBaseStyle: TextStyle(fontSize: 15, fontFamily: 'medium'),
                label: "Customer",
                showSearchBox: true,
                onChanged: (val) {
                  setState(() {
                    _selectedCust = val;
                    _onUpdate(indexPIC: indexPIC);
                  });
                },
                selectedItem: _selectedCust,
                dropdownSearchDecoration: InputDecoration(
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
            child: Column(
              children: <Widget>[
                ListView.builder(
                  itemCount: cards.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                        children: <Widget> [
                          cards[index],
                          cards.length > 1 ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  indexPIC--;
                                  cards.removeAt(index);
                                  _onUpdate(indexPIC: index);
                                  _onRemove(index);
                                });
                              },
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    padding: const EdgeInsets.only(right: 21),
                                    child: ImageIcon(
                                      AssetImage(Global.CANCEL_ICON),
                                      size: 18,
                                      color: Color(Global.GREY),
                                    ),
                                  )
                              )
                          ) : Container()
                        ]
                    );
                  },
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                        width: 130,
                        padding: const EdgeInsets.only(left: 21, right: 21),
                        margin: const EdgeInsets.only(bottom: 30),
                        child: InkWell(
                            onTap: () => setState(() {
                              indexPIC++;
                              cards.add(createCard(indexPIC));
                            }),
                            child: Container(
                                child: Row(
                                    children: <Widget> [
                                      const ImageIcon(
                                        AssetImage(Global.ADD_ICON),
                                        size: 18,
                                      ),
                                      Container(
                                          padding: const EdgeInsets.only(left: 17),
                                          child: const Text('Add PIC',
                                              style: TextStyle(
                                                color: Color(0xff4F4F4F),
                                                fontFamily: 'book',
                                                fontSize: 13,
                                                decoration: TextDecoration.underline,
                                              )
                                          )
                                      )
                                    ]
                                )
                            )
                        )
                    )
                ),
              ],
            ),
          ),
        ]
    );
  }
}