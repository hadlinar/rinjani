import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rinjani/bloc/customer/customer_bloc.dart';
import 'package:rinjani/models/customer.dart';

import '../../utils/global.dart';
import '../../utils/global_state.dart';
import 'package:intl/intl.dart';

import '../../widget/custom_text_field.dart';

class OutOffice extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _OutOffice();
  }
}

final GlobalState store = GlobalState.instance;

class _OutOffice extends State<OutOffice> {
  var visitCard = <Column>[];

  int _count = 1;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CustomerBloc>(context).add(GetCustomerEvent(store.get("branch_id")));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _container = List.generate(_count, (int i) {
      return AddPlan(_count);
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
                ]
            )
        )
    );
  }
}

class AddPlan extends StatefulWidget {
  final int count;
  AddPlan(this.count);

  @override
  State<StatefulWidget> createState() => _AddPlan();
}

class _AddPlan extends State<AddPlan> {
  late List<Map<String, dynamic>> _values;

  List<String> customerName = [];
  List<Customer> customer = [];

  var positionTextEditing = <TextEditingController>[];
  var nameTextEditing = <TextEditingController>[];
  var positionPIC = <String>[];
  var namePIC = <String>[];
  var cards = <Column>[];
  var _selectedCust = null;

  var newCustomerController = TextEditingController();

  DateTime timeStart = DateTime.now();
  DateTime timeEnd = DateTime.now();

  DateTime initialDate = DateTime.now();

  DateTime start = DateTime.now();
  DateTime end = DateTime.now();

  int indexCard = 0;
  int indexPIC = 0;

  bool clicked = false;
  bool clickedStart = false;
  bool clickedEnd = false;

  bool savedCust = false;

  late String result;
  late String initDate;

  Column createCard(int key) {
    String pos = '';
    String name = '';
    String desc = '';
    var positionController = TextEditingController();
    var nameController = TextEditingController();
    var descriptionController = TextEditingController();
    positionTextEditing.add(positionController);
    nameTextEditing.add(nameController);
    nameTextEditing.add(descriptionController);

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
                _onUpdate(indexPIC: indexPIC, valPos: val, valName: '', valDesc: desc);
              } else if (desc == null) {
                _onUpdate(indexPIC: indexPIC, valPos: val, valName: name, valDesc: '');
              } else {
                _onUpdate(indexPIC: indexPIC, valPos: val, valName: name, valDesc: desc);
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
                  _onUpdate(indexPIC: indexPIC, valPos: '', valName: val, valDesc: desc);
                } else if (desc == null) {
                  _onUpdate(indexPIC: indexPIC, valPos: pos, valName: val, valDesc: '');
                } else {
                  _onUpdate(indexPIC: indexPIC, valPos: pos, valName: val, valDesc: desc);
                }
              },
            )
        ),
        Container(
          padding: const EdgeInsets.only(left: 21, right: 21, bottom: 17),
          child: TextFormField(
            style: Global.getCustomFont(Global.BLACK, 15, 'medium'),
            controller: descriptionController,
            autofocus: true,
            maxLines: 5,
            maxLength: 200,
            onChanged: (val) {
              desc = val;
              if(pos == null) {
                _onUpdate(indexPIC: indexPIC, valPos: '', valName: name, valDesc: val);
              } else if (name == null) {
                _onUpdate(indexPIC: indexPIC, valPos: pos, valName: '', valDesc: val);
              } else {
                _onUpdate(indexPIC: indexPIC, valPos: pos, valName: name, valDesc: val);
              }
            },
            decoration: InputDecoration(
              labelText: "Description",
              alignLabelWithHint: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius .circular(10),
                  borderSide: BorderSide()),
            ),
          ),
        )
      ],
    );
  }

  _onUpdate({int? indexPIC, String? valPos, String? valName, String? valDesc}){
    int? foundKey = -1;

    for(var map in _values) {
      if(map.containsKey('id')) {
        foundKey = indexPIC;
        break;
      }
    }

    if(-1 != foundKey) {
      _values.removeWhere((map) {
        return map['id'] == foundKey;
      });
    }

    Map<String, dynamic> json = {
      'id' : indexPIC,
      'pic': {
        'position': valPos,
        'name': valName,
        'description': valDesc
      }
    };

    _values.add(json);
    store.set("result", _values);

    setState(() {
      start = DateTime(initialDate.year, initialDate.month, initialDate.day, timeStart.hour, timeStart.minute, timeStart.second, timeStart.millisecond, timeStart.microsecond);
      end = DateTime(initialDate.year, initialDate.month, initialDate.day, timeEnd.hour, timeEnd.minute, timeEnd.second, timeEnd.millisecond, timeEnd.microsecond);

      store.set("savedCust", savedCust);
      store.set("startTime", start);
      store.set("endTime", end);
      store.set("customer", _selectedCust);
      store.set("result", _values);
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
      store.set("result", _values);
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CustomerBloc>(context).add(GetCustomerEvent(store.get("branch_id")));
    cards.add(createCard(indexPIC));
    _values = [];
    result = '';
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
        initialDate = date!;
        initDate = initialDate.toString();
      });
    });
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
                onPressed: () {
                  clickedStart = true;
                  Navigator.of(ctx).pop();
                  store.set("clickedStart", clickedStart);
                }
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
                  onPressed: () {
                    clickedEnd = true;
                    Navigator.of(ctx).pop();
                    store.set("clickedEnd", clickedEnd);
                  }
              )
            ],
          ),
        )
    );
  }

  void dialogNewCust () {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)
                )
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                    child: Text("Add new customer",
                      style: Global.getCustomFont(Global.BLACK, 15, 'medium'),
                      textAlign: TextAlign.left,
                    )
                ),
                Container(
                  height: 17,
                ),
                Container(
                  child: CustomTextField(label: "Enter new customer's name", controller: newCustomerController),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                    color: Theme
                                        .of(context)
                                        .accentColor,
                                    width: 3
                                )
                            ),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  color: Color(Global.BLUE),
                                  fontFamily: 'bold',
                                  fontSize: 15
                              ),
                            )
                        )
                    ),
                    Container(
                      width: 25,
                    ),
                    Expanded(
                        flex: 1,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                side:
                                BorderSide(color: Color(Global.BLUE)),
                                borderRadius: BorderRadius.circular(10)),
                            color: Color(Global.BLUE),
                            onPressed: () {
                              setState(() {
                                savedCust = true;
                              });
                              store.set("cust_name", newCustomerController.text );
                              Navigator.pop(context);
                            },
                            child: Text("Add", style: Global.getCustomFont(Global.WHITE, 14, 'bold'))
                        )
                    ),
                  ],
                )
              ],
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {


    return BlocBuilder<CustomerBloc, CustomerBlocState>(
      builder: (context, state){
        if(state is CustomerList) {
          customer = state.getCustomer;
          for(int i=0; i < customer.length; i++) {
            customerName.add(customer[i].cust_name);
          }

          return Column(
              children: <Widget> [
                Container(
                    padding: const EdgeInsets.only(right: 21, left: 42, bottom: 17, top: 17),
                    child:
                    Column(
                      children: <Widget> [
                        Row(
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
                                            AssetImage(Global.CALENDAR_ICON),
                                            color: Color(Global.BLUE),
                                            size: 18,
                                          )
                                      )
                                  )
                              )
                            ]
                        ),
                        Container(
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: initDate != "" ? Container(
                                  margin: const EdgeInsets.only(bottom: 30, top: 17),
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
                savedCust ? Container(
                  padding: const EdgeInsets.only(left: 21, right: 21, bottom: 17),
                  child: TextField(
                    controller: newCustomerController,
                    onTap: () {
                      dialogNewCust();
                    },
                    decoration: InputDecoration(
                      labelText: 'New customer',
                      contentPadding: EdgeInsets.only(bottom: 5,left: 7,top: 5),
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(),
                      ),
                      suffixIcon: newCustomerController.text.isEmpty
                          ? null // Show nothing if the text field is empty
                          : IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            savedCust = false;
                          });
                          newCustomerController.clear();
                        },
                      ), // Show the clear button if the text field has something
                    ),
                  ),
                ) : Container(
                    padding: const EdgeInsets.only(right: 21, left: 21, bottom: 17),
                    child: DropdownSearch<String>(
                      mode: Mode.MENU,
                      showClearButton: true,
                      showSelectedItems: true,
                      items: customerName,
                      dropdownSearchBaseStyle: const TextStyle(fontSize: 15, fontFamily: 'medium'),
                      label: "Customer",
                      showSearchBox: true,
                      onChanged: (val) {
                        setState(() {
                          _selectedCust = val;
                          _onUpdate(indexPIC: indexPIC);
                          for(int i=0;  i< customer.length; i++) {
                            if(customer[i].cust_name == val) {
                              store.set("cust_id", customer[i].cust_id);
                            }
                          }
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
                savedCust ? Container() : Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        width: 200,
                        padding: const EdgeInsets.only(left: 21),
                        margin: const EdgeInsets.only(bottom: 30),
                        child: InkWell(
                            onTap: () {
                              dialogNewCust();
                            },
                            child: Container(
                                child: Row(
                                    children: <Widget> [
                                      const ImageIcon(
                                        AssetImage(Global.ADD_ICON),
                                        size: 18,
                                      ),
                                      Container(
                                          padding: const EdgeInsets.only(left: 17),
                                          child: const Text('Add new customer',
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
        else if(state is LoadingCustomerState) {
          return Container(
              padding: const EdgeInsets.only(top: 30),
              child: CircularProgressIndicator()
          );
        }
        else {
          return Container();
        }
      },
    );
  }
}