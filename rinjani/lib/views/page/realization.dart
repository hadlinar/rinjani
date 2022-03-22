
import 'package:dropdown_search/dropdown_search.dart';
// import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rinjani/widget/custom_text_field.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

import '../../bloc/visit/visit_bloc.dart';
import '../../models/customer.dart';
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

  String Address = '';
  Position? _position;

  void getCurrentLocation() async {
    Position position = await _determinePosition();

    setState(() {
      _position = position;
      // GetAddressFromLatLong(_position);
    });
  }

  // Future<void> GetAddressFromLatLong(Position? position)async {
  //   List<Placemark> placemarks = await placemarkFromCoordinates(position!.latitude, position!.longitude);
  //   print(placemarks);
  //   Placemark place = placemarks[0];
  //   Address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
  //   setState(()  {
  //   });
  // }

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

  void googleMap() async {
    String googleUrl = "https://www.google.com/maps/search/?api=1&query=${_position!.latitude.toString()},${_position!.longitude.toString()}";

    if(await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw "Couldn't open Google Maps";
    }

  }

  List<VisitById> visit=[];
  List<String> custName = [];
  List<String> custPos = [];

  @override
  void initState() {
    super.initState();
    cust = [];
    position = [];
    BlocProvider.of<VisitBloc>(context).add(GetVisitByIdEvent(store.get("nik")));
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
                    else if (state is VisitByIdList) {
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
                                          // dropdownSearchBaseStyle: TextStyle(fontSize: 15, fontFamily: 'medium'),
                                          label: "Customer",
                                          showSearchBox: true,
                                          onChanged: (val) {
                                            print(val);
                                            setState(() {
                                              custPos = [];
                                              _selectedCust = val;
                                              for(int i=0; i<visit.length; i++) {
                                                if(visit[i].cust_name == _selectedCust) {
                                                  custPos.add(visit[i].pic_position);
                                                  custId = visit[i].cust_id;
                                                }
                                              }
                                            });
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
                                          items: custPos,
                                          // dropdownSearchBaseStyle: TextStyle(fontSize: 15, fontFamily: 'medium'),
                                          label: "Position",
                                          showSearchBox: true,
                                          onChanged: (val) {
                                            print(val);
                                            setState(() {
                                              nameController.text = "";
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
                                            });
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
                                                  padding: EdgeInsets.only(left: 21, top: 9, bottom: 9),
                                                  child: _position != null ? Global.getDefaultText("Current location: " + _position.toString(), Global.BLACK) : Global.getDefaultText("No location data", Global.BLACK)
                                                  // child: Address != null ? Global.getDefaultText("Current location: " + Address.toString(), Global.BLACK) : Global.getDefaultText("No location data", Global.BLACK)
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(top: 17, bottom: 9),
                                                  width: 220,
                                                  height: 65,
                                                  color: Colors.white,
                                                  child: RaisedButton(
                                                      shape: RoundedRectangleBorder(
                                                          side: BorderSide(color: Color(Global.BLUE)),
                                                          borderRadius: BorderRadius.circular(20)
                                                      ),
                                                      color: Color(Global.BLUE),
                                                      onPressed: () {
                                                        googleMap();
                                                      },
                                                      child: const Text(
                                                        "Open Google Maps",
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
                            var foundKey = 0;
                            for(int i=0; i<cust.length;i++) {
                              if(cust[i] == _selectedCust) {
                                foundKey = i;
                                break;
                              }
                            }

                            // print(visitNo);
                            // print(branchId);
                            // print(_selectedCust);
                            // print(timeStart);
                            // print(timeFinish);
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
                                  timeStart.toString(),
                                  timeFinish.toString(),
                                  store.get("nik"),
                                  descriptionController.text,
                                  _selectedPIC,
                                  nameController.text,
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