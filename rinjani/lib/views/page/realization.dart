
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rinjani/widget/custom_text_field.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../bloc/visit/visit_bloc.dart';
import 'package:intl/intl.dart';
import '../../models/visit.dart';
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

  late List<String> cust = [];
  String custId = "";
  late List<String> position = [];
  String visitNo = "";
  String branchId = "";
  String timeStart = "";
  String timeFinish = "";

  final descriptionController = TextEditingController();
  final nameController = TextEditingController();
  late List<TextEditingController> listNameController = [];

  String Address = '';
  Position? _position;

  void getCurrentLocation() async {
    Position position = await _determinePosition();

    setState(() {
      _position = position;
      GetAddressFromLatLong(position);
    });
  }

  Future<void> GetAddressFromLatLong(Position position)async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    setState(()  {
      Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    });
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied) {
        return Future.error("Location permission is denied");
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  // void googleMap() async {
  //   String googleUrl = "https://www.google.com/maps/search/?api=1&query=${_position.latitude.toString()},${_position.longitude.toString()}";
  //
  //   if(await canLaunch(googleUrl)) {
  //     await launch(googleUrl);
  //   } else {
  //     throw "Couldn't open Google Maps";
  //   }
  //
  // }

  List<Visit> visit=[];
  List<String> custName = [];
  List<String> custPos = [];

  @override
  void initState() {
    super.initState();
    cust = [];
    position = [];
    BlocProvider.of<VisitBloc>(context).add(GetVisitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector (
            onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
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
                    }
                    else if (state is GetVisitState) {
                      for(int i=0; i<state.getVisit.length; i++) {
                        cust.add(state.getVisit[i].cust_name);
                      }

                      setState(() {
                        visit = state.getVisit;
                        cust;
                        custName = cust.toSet().toList();
                      });
                    }
                    if(state is SuccessAddRealizationState){
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
                child: SingleChildScrollView(
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
                                          items: custName,
                                          label: "Customer",
                                          showSearchBox: true,
                                          onChanged: (val) {
                                            setState(() {
                                              custPos = [];
                                              _selectedPIC = null;
                                              listNameController = [];
                                              _selectedCust = val;
                                              nameController.text = "";
                                              for(int i=0; i<visit.length; i++) {
                                                if(visit[i].cust_name == _selectedCust) {
                                                  custPos.add(visit[i].pic_position);
                                                  custId = visit[i].cust_id;
                                                }
                                              }
                                            });
                                          },
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
                                      child: Container(
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              padding: const EdgeInsets.only(top: 22, bottom: 17),
                                              child: DropdownSearch<String>(
                                                mode: Mode.MENU,
                                                showClearButton: true,
                                                selectedItem: _selectedPIC,
                                                items: custPos,
                                                label: "PIC",
                                                showSearchBox: true,
                                                onChanged: (val) {
                                                  setState(() {
                                                    nameController.text = "";
                                                    listNameController = [];
                                                    _selectedPIC = val;
                                                    for(int i=0; i<visit.length; i++) {
                                                      if(visit[i].pic_position == _selectedPIC) {
                                                        nameController.text = visit[i].pic_name;
                                                        visitNo = visit[i].visit_no;
                                                        branchId = visit[i].branch_id;
                                                        timeStart = visit[i].time_start.toString();
                                                        timeFinish = visit[i].time_finish.toString();
                                                      }
                                                    }

                                                    listNameController = [
                                                      for (int i = 0; i < nameController.text.split(', ').length; i++)
                                                        TextEditingController()
                                                    ];

                                                    for(int i = 0; i < nameController.text.split(', ').length; i++){
                                                      listNameController[i].text = nameController.text.split(', ')[i];
                                                    }
                                                  });
                                                },
                                                // selectedItem: _selectedPIC,
                                                dropdownSearchDecoration: InputDecoration(
                                                  labelStyle: const TextStyle(fontSize: 15, fontFamily: 'medium'),
                                                  alignLabelWithHint: true,
                                                  contentPadding: const EdgeInsets.only(left: 12),
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius .circular(10),
                                                      borderSide: const BorderSide()),
                                                ),
                                              )
                                            ),
                                            _selectedPIC != null ? Container(
                                              // padding: const EdgeInsets.only(left: 74),
                                                child: _selectedPIC.contains(",") ? Container(
                                                    child: ListView.builder(
                                                        itemCount:_selectedPIC.split(", ").length,
                                                        scrollDirection: Axis.vertical,
                                                        shrinkWrap: true,
                                                        physics: const NeverScrollableScrollPhysics(),
                                                        itemBuilder: (context, j){
                                                          return Container(
                                                            child: Column(
                                                                children: <Widget> [
                                                                  Align(
                                                                    alignment: Alignment.centerLeft,
                                                                    child: Text("PIC position ${j + 1}: ${_selectedPIC.split(", ")[j]}", style: Global.getCustomFont(Global.BLACK, 15, 'bold')),
                                                                  ),
                                                                  Container(
                                                                    padding: const EdgeInsets.only(top: 17),
                                                                    child: CustomTextField(label: 'Name', controller: listNameController[j]),
                                                                  ),
                                                                ]
                                                            )

                                                          );
                                                        }
                                                    )
                                                ) : Container(
                                                  padding: const EdgeInsets.only(top: 17),
                                                  child: Column(
                                                      children: <Widget> [
                                                        Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text("PIC position: ${_selectedPIC}", style: Global.getCustomFont(Global.BLACK, 15, 'bold')),
                                                        ),
                                                        Container(
                                                          padding: const EdgeInsets.only(top: 22),
                                                          child: CustomTextField(label: 'Name', controller: listNameController[0]),
                                                        ),
                                                      ]
                                                  )
                                                )
                                            ) : Container(
                                              padding: const EdgeInsets.only(top: 17, left: 5),
                                              child: Column(
                                                children: <Widget> [
                                                  Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text("PIC position: ",
                                                        style: Global.getCustomFont(Global.BLACK, 15, 'bold')
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets.only(top: 22),
                                                    child: CustomTextField(label: 'Name', controller: nameController),
                                                  ),
                                                ]
                                              )
                                            )
                                          ],
                                        )
                                      )
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
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          // width: double.infinity,
                                          color: Colors.white,
                                          child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  padding: EdgeInsets.only(top: 9, bottom: 9),
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
                                                        getCurrentLocation();
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
                                                Container(
                                                  padding: EdgeInsets.only(left: 21, top: 9, bottom: 17),
                                                  child: _position != null ? Global.getDefaultText(Address, Global.BLACK) : Global.getDefaultText("No location data", Global.BLACK)
                                                  // child: Address != null ? Global.getDefaultText("Current location: " + Address.toString(), Global.BLACK) : Global.getDefaultText("No location data", Global.BLACK)
                                                ),
                                                // Container(
                                                //   padding: EdgeInsets.only(top: 17, bottom: 9),
                                                //   width: 220,
                                                //   height: 65,
                                                //   color: Colors.white,
                                                //   child: RaisedButton(
                                                //       shape: RoundedRectangleBorder(
                                                //           side: BorderSide(color: Color(Global.BLUE)),
                                                //           borderRadius: BorderRadius.circular(20)
                                                //       ),
                                                //       color: Color(Global.BLUE),
                                                //       onPressed: () {
                                                //         googleMap();
                                                //       },
                                                //       child: const Text(
                                                //         "Open Google Maps",
                                                //         style: TextStyle(
                                                //             color: Colors.white,
                                                //             fontFamily: 'bold',
                                                //             fontSize: 15
                                                //         ),
                                                //       )
                                                //   ),
                                                // ),
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
                            List<String> name = [];
                            for(int i=0; i<listNameController.length; i++) {
                              name.add(listNameController[i].text);
                            }
                            String picName = name.join(", ");
                            // print(picName);
                            // print(visitNo);
                            // print(branchId);
                            // print(_selectedCust);
                            // print(_position!.longitude.toString(),);
                            // print(store.get("nik"));
                            // print(descriptionController.text);
                            // print(_selectedPIC);
                            // print(nameController.text);
                            // print('y');
                            // print("0.7893");
                            // print("113.9213");
                            BlocProvider.of<VisitBloc>(context).add(
                                AddRealizationEvent(
                                  visitNo,
                                  branchId,
                                  custId,
                                  DateFormat("yyyy-MM-dd HH:mm:ss").parse(timeStart).toLocal().toString(),
                                  DateFormat("yyyy-MM-dd HH:mm:ss").parse(timeFinish).toLocal().toString(),
                                  store.get("nik"),
                                  descriptionController.text,
                                  _selectedPIC,
                                  picName,
                                  "y",
                                  _position!.latitude.toString(),
                                  _position!.longitude.toString(),
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