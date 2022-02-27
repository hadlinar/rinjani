import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:krakatau/widget/custom_text_field.dart';

import '../../utils/global.dart';

class Realization extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _Realization();
  }
}

class _Realization extends State<Realization> {
  bool isLoading = false;
  late List<String> autoCompletion;
  var _selectedCust = null;
  var _selectedPIC = null;


  final descriptionController = TextEditingController();
  final positionController = TextEditingController();
  final nameController = TextEditingController();

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
      child: Scaffold(
        appBar:AppBar(
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
        body: Column(
          children: <Widget> [
            Container(
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
                        padding: const EdgeInsets.only(top: 30),
                        child: CustomTextField(label: 'Position', controller: positionController),
                      ),
                      Container(
                        child: CustomTextField(label: 'Name', controller: nameController),
                      ),
                      Container(
                        child: TextFormField(
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
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Container(
                            width: double.infinity,
                            color: Colors.white,
                            child: Stack(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(left: 18, right: 18, top: 9, bottom: 9),
                                    width: 163,
                                    height: 56,
                                    color: Colors.white,
                                    child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(color: Color(Global.BLUE)),
                                            borderRadius: BorderRadius.circular(20)
                                        ),
                                        color: Color(Global.BLUE),
                                        onPressed: () {},
                                        child: const Text(
                                          "Set location",
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
                      // Container(
                      //     padding: const EdgeInsets.only(top: 17),
                      //     child: Column(
                      //       children: <Widget> [
                      //
                      //       ],
                      //     )
                      //     DropdownSearch<String>(
                      //       mode: Mode.MENU,
                      //       showClearButton: true,
                      //       showSelectedItems: true,
                      //       items: ["PIC1", "PIC2", "PIC3", "PIC4"],
                      //       dropdownSearchBaseStyle: TextStyle(fontSize: 15, fontFamily: 'medium'),
                      //       label: "Person in Charge",
                      //       showSearchBox: true,
                      //       onChanged: (val) {
                      //         print(val);
                      //         _selectedPIC = val;
                      //       },
                      //       selectedItem: _selectedPIC,
                      //       dropdownSearchDecoration: InputDecoration(
                      //         labelText: "Select a PIC",
                      //         labelStyle: TextStyle(fontSize: 15, fontFamily: 'medium'),
                      //         alignLabelWithHint: true,
                      //         contentPadding: EdgeInsets.only(left: 12),
                      //         border: OutlineInputBorder(
                      //             borderRadius: BorderRadius .circular(10),
                      //             borderSide: BorderSide()),
                      //       ),
                      //     )
                      // ),
                    ]
                )
            ),
          ]
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
                    onPressed: () {},
                    child: const Text(
                      "Save",
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
    );
  }
}