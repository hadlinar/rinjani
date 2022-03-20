
import 'package:dropdown_search/dropdown_search.dart';
// import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rinjani/widget/custom_text_field.dart';
// import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

import '../../bloc/visit/visit_bloc.dart';
import '../../utils/global.dart';
import '../../utils/global_state.dart';

class Realization extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _Realization();
  }
}

typedef SuccessAddRealization = void Function(int resultMessage, BuildContext context);
final GlobalState store = GlobalState.instance;

class _Realization extends State<Realization> {
  var _selectedCust = null;
  var _selectedPIC = null;

  List<String>? cust;
  List<String>? position;
  String visitNo = "";
  String branchId = "";
  DateTime timeStart = DateTime.now();
  DateTime timeFinish = DateTime.now();


  final descriptionController = TextEditingController();
  // final positionController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cust = [];
    position = [];
    BlocProvider.of<VisitBloc>(context).add(GetVisitByIdEvent(store.get("nik")));
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
          body: BlocListener<VisitBloc, VisitBlocState>(
              listener: (context, state) {
                print(state.toString());
                if (state is InitialVisitBlocState || state is LoadingVisitState) {
                  const Center(
                      child: CircularProgressIndicator()
                  );
                } if (state is VisitByIdList) {
                  for(int i=0; i<state.getVisit.length;i++) {
                    print(state.getVisit[i].visit_no);
                    setState(() {
                      visitNo = state.getVisit[i].visit_no;
                      branchId = state.getVisit[i].branch_id;
                      timeStart = state.getVisit[i].time_start;
                      timeFinish = state.getVisit[i].time_finish;

                      cust?.add(state.getVisit[i].cust_name);
                      position?.add(state.getVisit[i].pic_position);
                    });
                  }
                } if(state is SuccessAddRealizationState){
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Global.defaultModal(() {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }, context, Global.CHECK_ICON, "Saved", "Ok", false);
                      }
                  );
                }
                else {
                  Container();
                }
              },
              child: Column(
                  children: <Widget> [
                    Container(
                        padding: const EdgeInsets.only(top: 17, left: 21, right: 21),
                        child: Column(
                            children: <Widget> [
                              Container(
                                  padding: const EdgeInsets.only(top: 22),
                                  child: DropdownSearch<String>(
                                    mode: Mode.MENU,
                                    showClearButton: true,
                                    selectedItem: _selectedCust,
                                    items: cust,
                                    // dropdownSearchBaseStyle: TextStyle(fontSize: 15, fontFamily: 'medium'),
                                    label: "Customer",
                                    showSearchBox: true,
                                    onChanged: (val) {
                                      print(val);
                                      _selectedCust = val;
                                    },
                                    // selectedItem: _selectedCust,
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
                                  padding: const EdgeInsets.only(top: 22),
                                  child: DropdownSearch<String>(
                                    mode: Mode.MENU,
                                    showClearButton: true,
                                    selectedItem: _selectedPIC,
                                    items: position,
                                    // dropdownSearchBaseStyle: TextStyle(fontSize: 15, fontFamily: 'medium'),
                                    label: "Position",
                                    showSearchBox: true,
                                    onChanged: (val) {
                                      print(val);
                                      _selectedPIC = val;
                                    },
                                    // selectedItem: _selectedPIC,
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
                                padding: const EdgeInsets.only(top: 22),
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
                        print(visitNo);
                        print(branchId);
                        print(_selectedCust);
                        print(timeStart);
                        print(timeFinish);
                        print("1991412003");
                        print(descriptionController.text);
                        print(_selectedPIC);
                        print(nameController.text);
                        print('y');
                        print("0.7893");
                        print("113.9213");
                        BlocProvider.of<VisitBloc>(context).add(
                            AddRealizationEvent(
                              visitNo,
                              branchId,
                              _selectedCust,
                              timeStart.toString(),
                              timeFinish.toString(),
                              "2014457001",
                              descriptionController.text,
                              _selectedPIC,
                              nameController.text,
                              "y",
                              "0.7893",
                              "113.9213",
                            )
                        );

                      },
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