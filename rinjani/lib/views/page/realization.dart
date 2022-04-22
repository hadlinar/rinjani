import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rinjani/widget/custom_text_field.dart';

import '../../bloc/visit/visit_bloc.dart';
import '../../models/visit.dart';
import '../../utils/global.dart';
import '../../utils/global_state.dart';
import 'package:intl/intl.dart';

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

  bool locationClicked = false;

  final descriptionController = TextEditingController();
  final nameController = TextEditingController();
  final picController = TextEditingController();
  late List<TextEditingController> listNameController = [];
  late List<TextEditingController> listPicController = [];

  String? _selectedType;
  String? _selectedTime;

  List typeVal = [
    "In-office",
    "Out-office"
  ];

  String Address = '';
  Position? _position;

  void getCurrentLocation() async {
    Position position = await _determinePosition();

    setState(() {
      _position = position;
      GetAddressFromLatLong(position);
    });
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    setState(()  {
      locationClicked = true;
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

  List<Visit> visit=[];
  List<String> custName = [];
  List<String> custPos = [];
  List<String> time = [];

  @override
  void initState() {
    super.initState();
    _selectedType = "In-office";
    cust = [];
    position = [];
    BlocProvider.of<VisitBloc>(context).add(GetVisitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector (
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
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
              if (state is GetVisitState) {
                for(int i=0; i<state.getVisit.length; i++) {
                  if(state.getVisit[i].visit_id == "02") {
                    cust.add(state.getVisit[i].cust_name);
                  } else if(state.getVisit[i].visit_id == "01") {
                    time.add(state.getVisit[i].time_start.toLocal().toString());
                  }
                }
                setState(() {
                  visit = state.getVisit;
                  cust;
                  time;
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
                                    child: DropdownButtonFormField<String>(
                                      hint: const Text("Choose type of plan"),
                                      dropdownColor: Colors.white,
                                      style: Global.getCustomFont(Global.BLACK, 15, 'medium'),
                                      value: _selectedType,
                                      items: typeVal.map((e) {
                                        return DropdownMenuItem<String>(
                                          value: e,
                                          child: Text(e),
                                        );
                                      }).toList(),
                                      onChanged: (String? value) {
                                        setState(() {
                                          _selectedType = value;
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

                                _selectedType == "" ? Container() : Container(
                                  child: Column(
                                    children: <Widget> [
                                      _selectedType == "In-office" ? Container() : Container(
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
                                                picController.text = "";
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
                                      _selectedType == "In-office" ? Container(
                                          padding: const EdgeInsets.only(top: 22),
                                          child: DropdownButtonFormField<String>(
                                            hint: const Text("Time"),
                                            dropdownColor: Colors.white,
                                            style: Global.getCustomFont(Global.BLACK, 15, 'medium'),
                                            value: _selectedTime,
                                            items: time.map((e) {
                                              return DropdownMenuItem<String>(
                                                value: e,
                                                child: Text(DateFormat("HH:mm").format(DateFormat("yyyy-MM-dd HH:mm").parse(e))),
                                              );
                                            }).toList(),
                                            onChanged: (String? value) {
                                              setState(() {
                                                _selectedTime = value;
                                                print(_selectedTime);
                                                for(int i=0; i<visit.length; i++) {
                                                  if(visit[i].time_start.toString() == _selectedTime) {
                                                    descriptionController.text = visit[i].description;
                                                    visitNo = visit[i].visit_no;
                                                    branchId = visit[i].branch_id;
                                                    timeFinish = visit[i].time_finish.toString();
                                                  }
                                                }
                                              });
                                            },
                                            decoration: InputDecoration(
                                              contentPadding: const EdgeInsets.only( top: 10, bottom: 10, left: 12, right: 12),
                                              labelText: "Time",
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
                                      ) : Container(
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
                                                        // showSearchBox: true,
                                                        onChanged: (String? value) {
                                                          setState(() {
                                                            _selectedPIC = value;
                                                            nameController.text = "";
                                                            listNameController = [];
                                                            listPicController = [];
                                                            for(int i=0; i<visit.length; i++) {
                                                              if(visit[i].pic_position == _selectedPIC) {
                                                                nameController.text = visit[i].pic_name;
                                                                picController.text = _selectedPIC;
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

                                                            listPicController = [
                                                              for (int i = 0; i < _selectedPIC.split(', ').length; i++)
                                                                TextEditingController()
                                                            ];

                                                            for(int i = 0; i < nameController.text.split(', ').length; i++){
                                                              listNameController[i].text = nameController.text.split(', ')[i];
                                                            }

                                                            for(int i = 0; i < _selectedPIC.split(', ').length; i++){
                                                              listPicController[i].text = picController.text.split(', ')[i];
                                                            }
                                                          });
                                                        },
                                                        dropdownSearchDecoration: InputDecoration(
                                                          labelText: "PIC",
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
                                                      padding: const EdgeInsets.only(bottom: 17),
                                                      child: Divider()
                                                  ),
                                                  _selectedPIC != null ? Container(
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
                                                                          Container(
                                                                            child: CustomTextField(label: 'PIC ${j+1}', controller: listPicController[j]),
                                                                          ),
                                                                          Container(
                                                                            child: CustomTextField(label: 'Name', controller: listNameController[j]),
                                                                          ),
                                                                        ]
                                                                    )

                                                                );
                                                              }
                                                          )
                                                      ) : Container(
                                                          child: Column(
                                                              children: <Widget> [
                                                                Container(
                                                                  child: CustomTextField(label: 'PIC', controller: listPicController[0]),
                                                                ),
                                                                Container(
                                                                  child: CustomTextField(label: 'Name', controller: listNameController[0]),
                                                                ),
                                                              ]
                                                          )
                                                      )
                                                  ) :
                                                  Container(
                                                      child: Column(
                                                          children: <Widget> [
                                                            Container(
                                                              child: CustomTextField(label: 'PIC', controller: picController),
                                                            ),
                                                            Container(
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
                                        padding: _selectedType == "In-office" ? const EdgeInsets.only(top: 17) : const EdgeInsets.all(0),
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
                                                ]
                                            ),
                                          )
                                      ),
                                    ]
                                  )
                                )
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
                  padding: const EdgeInsets.only(left: 18, right: 18, top: 9, bottom: 9),
                  margin: const EdgeInsets.only(bottom: 20),
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

                        List<String> pos = [];
                        for(int i=0; i<listPicController.length; i++) {
                          pos.add(listPicController[i].text);
                        }
                        String picPos = pos.join(", ");

                        _selectedType == "In-office" ?
                            (descriptionController.text != "" && locationClicked == true ? BlocProvider.of<VisitBloc>(context).add(
                                AddRealizationEvent(
                                  visitNo,
                                  branchId,
                                  "",
                                  _selectedTime!,
                                  DateTime.now().toString(),
                                  store.get("nik"),
                                  descriptionController.text,
                                  "",
                                  "",
                                  "y",
                                  _position!.latitude.toString(),
                                  _position!.longitude.toString(),
                                )
                            ) : showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Global.defaultModal(() {
                                    Navigator.pop(context);
                                  }, context, Global.WARNING_ICON, "Please fill all the required form", "Ok", false);
                                }
                            ))
                            : (descriptionController.text != "" && locationClicked == true && picPos != "" && picName != "" && custId != ""? BlocProvider.of<VisitBloc>(context).add(
                            AddRealizationEvent(
                              visitNo,
                              branchId,
                              custId,
                              DateFormat("yyyy-MM-dd HH:mm:ss").parse(timeStart).toString(),
                              DateTime.now().toString(),
                              store.get("nik"),
                              descriptionController.text,
                              picPos,
                              picName,
                              "y",
                              _position!.latitude.toString(),
                              _position!.longitude.toString(),
                            )
                        ) : showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Global.defaultModal(() {
                                Navigator.pop(context);
                              }, context, Global.WARNING_ICON, "Please fill all the required form", "Ok", false);
                            }
                        ));


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