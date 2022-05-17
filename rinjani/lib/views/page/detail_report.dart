import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../models/visit.dart';
import '../../utils/global.dart';

class DetailReport extends StatefulWidget {
  Realization realization;

  DetailReport(this.realization);

  @override
  State<StatefulWidget> createState() {
    return _DetailReport();
  }
}

class _DetailReport extends State<DetailReport> {
  String address = '';

  @override
  void initState(){
    super.initState();
    GetAddressFromLatLong(widget.realization.latitude, widget.realization.longitude);
  }

  Future<void> GetAddressFromLatLong(double lat, double long) async {
    double latitude = lat;
    double longitude = long;
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placemarks[0];
    setState(()  {
      address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    });
  }


  @override
  Widget build(BuildContext context) {
    String date = DateFormat("EEEE, dd MMM yyyy").format(widget.realization.time_finish);
    String dateStart = DateFormat("EEEE, dd MMM yyyy").format(widget.realization.time_start);
    String time = DateFormat("HH:mm").format(widget.realization.time_finish);
    String timeStart = DateFormat("HH:mm").format(widget.realization.time_start);
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
                  "Back",
                  style: Global.getCustomFont(Global.BLUE, 18, 'medium')
              ),
            ),
            body: SingleChildScrollView(
                reverse: false,
                child: Container(
                    padding: const EdgeInsets.only(top: 17, left: 21, right: 21),
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget> [
                        Container(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Detail',
                              style: TextStyle(color: Color(Global.BLACK), fontSize: 20, fontFamily: 'medium'),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 17),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: <Widget> [
                                  Text(
                                    'Visit No.',
                                    style: TextStyle(color: Color(Global.BLACK), fontSize: 15, fontFamily: 'book'),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 38),
                                    child: Text(
                                      widget.realization.visit_no,
                                      style: TextStyle(color: Color(Global.BLACK), fontSize: 15, fontFamily: 'medium'),
                                    ),
                                  )
                                ],
                              )
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 17),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: <Widget> [
                                  Text(
                                    'Customer',
                                    style: TextStyle(color: Color(Global.BLACK), fontSize: 15, fontFamily: 'book'),
                                  ),
                                  Flexible(
                                    child: Container(
                                      padding: const EdgeInsets.only(left: 30),
                                      child: Text(
                                        widget.realization.customer,
                                        style: TextStyle(color: Color(Global.BLACK), fontSize: 15, fontFamily: 'medium'),
                                      ),
                                    )
                                  )
                                ],
                              )
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 17),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Row(
                                children: <Widget> [
                                  Container(
                                    child: Text(
                                      'PIC',
                                      style: TextStyle(color: Color(Global.BLACK), fontSize: 15, fontFamily: 'book'),
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.only(left: 73),
                                      child: widget.realization.pic_name.contains(",") ? Container(
                                          child: SizedBox(
                                              width: 200,
                                              child: ListView.builder(
                                                  itemCount: widget.realization.pic_name.split(", ").length,
                                                  scrollDirection: Axis.vertical,
                                                  shrinkWrap: true,
                                                  physics: NeverScrollableScrollPhysics(),
                                                  itemBuilder: (context, j){
                                                    return Container(
                                                      padding: const EdgeInsets.only(top: 5),
                                                      child: Text("${widget.realization.pic_name.split(", ")[j]} - ${widget.realization.pic_position.split(", ")[j]}", style: Global.getCustomFont(Global.BLACK, 15, 'bold')),
                                                    );
                                                  }
                                              )
                                          )
                                      ) : Container(
                                        child: Text("${widget.realization.pic_name} - ${widget.realization.pic_position}",
                                            style: Global.getCustomFont(Global.BLACK, 15, 'bold')
                                        ),
                                      )
                                  )
                                ],
                              )
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 17),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: <Widget> [
                                  Text(
                                    'Time start',
                                    style: TextStyle(color: Color(Global.BLACK), fontSize: 15, fontFamily: 'book'),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 29),
                                    child: Text(
                                      "$timeStart, $dateStart",
                                      style: TextStyle(color: Color(Global.BLACK), fontSize: 15, fontFamily: 'medium'),
                                    ),
                                  )
                                ],
                              )
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 17),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: <Widget> [
                                  Text(
                                    'Time end',
                                    style: TextStyle(color: Color(Global.BLACK), fontSize: 15, fontFamily: 'book'),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 34),
                                    child: Text(
                                      "$time, $date",
                                      style: TextStyle(color: Color(Global.BLACK), fontSize: 15, fontFamily: 'medium'),
                                    ),
                                  )
                                ],
                              )
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 17),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: <Widget> [
                                  Text(
                                    'Location',
                                    style: TextStyle(color: Color(Global.BLACK), fontSize: 15, fontFamily: 'book'),
                                  ),
                                  Flexible(
                                    child: Container(
                                      padding: const EdgeInsets.only(left: 38),
                                      child: Text(
                                        address,
                                        style: TextStyle(color: Color(Global.BLACK), fontSize: 15, fontFamily: 'medium'),
                                      ),
                                    )
                                  )
                                ],
                              )
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 17),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget> [
                                  Text(
                                    'Planned description',
                                    style: TextStyle(color: Color(Global.BLACK), fontSize: 15, fontFamily: 'book'),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 24, top: 17, bottom: 17),
                                    child: widget.realization.description.contains(",") ? Container(
                                        child: SizedBox(
                                            width: 300,
                                            child: ListView.builder(
                                                itemCount: widget.realization.description.split(", ").length,
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                physics: NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, j){
                                                  return Container(
                                                    padding: const EdgeInsets.only(top: 5),
                                                    child: Text("-  ${widget.realization.description.split(", ")[j]}", style: Global.getCustomFont(Global.BLACK, 15, 'book')),
                                                  );
                                                }
                                            )
                                        )
                                    ) : Container(
                                      child: Text(widget.realization.description,
                                          style: TextStyle(color: Color(Global.BLACK), fontSize: 15, fontFamily: 'book'),
                                        ),
                                    )
                                  )
                                ],
                              )
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 17),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget> [
                                  Text(
                                    'Realization description',
                                    style: TextStyle(color: Color(Global.BLACK), fontSize: 15, fontFamily: 'book'),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(left: 24, top: 17, bottom: 17),
                                    child: widget.realization.description_real.contains(",") ? Container(
                                        child: SizedBox(
                                            width: 300,
                                            child: ListView.builder(
                                                itemCount: widget.realization.description_real.split(", ").length,
                                                scrollDirection: Axis.vertical,
                                                shrinkWrap: true,
                                                physics: NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, j){
                                                  return Container(
                                                    padding: const EdgeInsets.only(top: 5),
                                                    child: Text("-  ${widget.realization.description_real.split(", ")[j]}", style: Global.getCustomFont(Global.BLACK, 15, 'book')),
                                                  );
                                                }
                                            )
                                        )
                                    ) : Container(
                                      child: Text(widget.realization.description_real,
                                        style: TextStyle(color: Color(Global.BLACK), fontSize: 15, fontFamily: 'book'),
                                      ),
                                    )
                                    // Text(
                                    //   widget.realization.description_real,
                                    //   style: TextStyle(color: Color(Global.BLACK), fontSize: 15, fontFamily: 'book'),
                                    // ),
                                  )
                                ],
                              )
                          ),
                        ),
                      ],
                    )
                )
            )
        )
    );
  }
}