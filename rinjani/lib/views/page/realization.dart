import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rinjani/widget/OSM.dart';
import 'package:rinjani/widget/custom_text_field.dart';
// import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

import '../../bloc/visit/visit_bloc.dart';
import '../../utils/global.dart';

class Realization extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _Realization();
  }
}

// GlobalKey<OSMFlutterState> mapKey = GlobalKey<OSMFlutterState>();

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
    BlocProvider.of<VisitBloc>(context).add(GetVisitRealizationByIdEvent('1985417002'));
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
        body:
        // BlocBuilder<VisitBloc, VisitBlocState> (
        //   builder: (context, state) {
        //     if( state is InitialVisitBlocState) {
        //       return Center(child: CircularProgressIndicator());
        //     }
        //     else if (state is VisitRealizationByIdList) {
        //       print(state.getVisitRealization);
        //       return
                Column(
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
                                  child: DropdownSearch<String>(
                                    mode: Mode.MENU,
                                    showClearButton: true,
                                    showSelectedItems: true,
                                    items: ["PIC 1", "PIC 2", "PIC 3"],
                                    dropdownSearchBaseStyle: TextStyle(fontSize: 15, fontFamily: 'medium'),
                                    label: "Position",
                                    showSearchBox: true,
                                    onChanged: (val) {
                                      print(val);
                                      _selectedPIC = val;
                                    },
                                    selectedItem: _selectedPIC,
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
                              // Container(
                              //   padding: const EdgeInsets.only(top: 30),
                              //   child: CustomTextField(label: 'Position', controller: positionController),
                              // ),
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
                                                onPressed: () {
                                                  // OSM();
                                                },
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
                            ]
                        )
                    ),
                  ]
              ),
          //   } else {
          //     return Center(child: CircularProgressIndicator());
          //   }
          // },

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