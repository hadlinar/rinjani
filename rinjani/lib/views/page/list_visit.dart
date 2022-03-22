import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/visit/visit_bloc.dart';
import '../../models/visit.dart';
import '../../utils/global.dart';
import '../../utils/global_state.dart';

class ListVisit extends StatefulWidget {
  List<VisitRealById> visit;

  ListVisit(this.visit);

  @override
  State<StatefulWidget> createState() {
    return _ListVisit();
  }
}
final GlobalState store = GlobalState.instance;

class _ListVisit extends State<ListVisit> {

  String? defaultType;

  List typeVal = [
    "Today",
    "All time",
    "Last 7 days",
    "Last 30 days"
  ];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<VisitBloc>(context).add(GetVisitRealizationByIdEvent(store.get("nik")));
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
                    const AssetImage(Global.BACK_ICON),
                    color: Color(Global.BLUE),
                    size: 18,
                  )
              ),
              title: Text(
                  "Report",
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
                    children: <Widget>[
                      Container(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'List of Visits',
                            style: TextStyle(color: Color(Global.BLACK),
                                fontSize: 20,
                                fontFamily: 'medium'),
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                              padding: const EdgeInsets.only(top: 17, left: 14),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Filter :',
                                    style: Global.getCustomFont(Global.BLACK,
                                        14, 'book')
                                ),
                              )
                          ),
                          Container(
                              width: 200,
                              padding: const EdgeInsets.only(top: 17, left: 12),
                              child: DropdownButtonFormField<String>(
                                dropdownColor: Colors.white,
                                style: Global.getCustomFont(
                                    Global.BLACK, 15, 'medium'),
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
                                    if(defaultType == "Today") {
                                      BlocProvider.of<VisitBloc>(context).add(GetVisitFilterEvent(store.get("nik"), "daily"));
                                    } else if (defaultType == "Last 7 days") {
                                      BlocProvider.of<VisitBloc>(context).add(GetVisitFilterEvent(store.get("nik"), "weekly"));
                                    } else if(defaultType == "Last 30 days") {
                                      BlocProvider.of<VisitBloc>(context).add(GetVisitFilterEvent(store.get("nik"), "monthly"));
                                    }
                                  });
                                },
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 12),
                                  labelText: "Sort by",
                                  labelStyle: const TextStyle(color: Color(0xff757575), fontSize: 15, fontFamily: 'medium'),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide()
                                  ),
                                ),
                              )
                          ),
                        ],
                      ),
                      BlocListener<VisitBloc, VisitBlocState> (
                        listener: (context, state) {
                          print(state.toString());
                          if(state is LoadingVisitState) {
                            Container(
                              padding: const EdgeInsets.only(top: 20),
                              child: const Center(
                                child: CircularProgressIndicator()
                              )
                            );
                          } else if(state is VisitRealizationByIdList) {

                          } else {
                            Container();
                          }
                        },
                        child: Container(
                            padding: const EdgeInsets.only(top: 17),
                            child: ListView.builder(
                                itemCount: widget.visit.length,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, i) {
                                  return ListTile(
                                      title: Container(
                                        alignment: Alignment.topLeft,
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets.only(right: 17, top: 8),
                                                    child: Align(
                                                      alignment: Alignment.topLeft,
                                                      child: Text('${i + 1}.',
                                                          style: Global.getCustomFont(Global.BLACK, 14, 'bold')
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        padding: const EdgeInsets.only(top: 5),
                                                        child: Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(
                                                              widget.visit[i].cust_name == null ? "null" : widget.visit[i].cust_name,
                                                              style: Global.getCustomFont(Global.BLACK, 14, 'bold')
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                          alignment: Alignment.centerLeft,
                                                          child: widget.visit[i].pic_name.contains(",") ? Container(
                                                              child: SizedBox(
                                                                  width: 300,
                                                                  child: ListView.builder(
                                                                      itemCount: widget.visit[i].pic_name.split(", ").length,
                                                                      scrollDirection: Axis.vertical,
                                                                      shrinkWrap: true,
                                                                      physics: NeverScrollableScrollPhysics(),
                                                                      itemBuilder: (context, j){
                                                                        return Container(
                                                                          padding: const EdgeInsets.only(top: 5),
                                                                          child: Text("${widget.visit[i].pic_name.split(", ")[j]} - ${widget.visit[i].pic_position.split(", ")[j]}", style: Global.getCustomFont(Global.BLACK, 14, 'medium')),
                                                                        );
                                                                      }
                                                                  )
                                                              )
                                                          ) : Container(
                                                            child: Text("${widget.visit[i].pic_name} - ${widget.visit[i].pic_position}",
                                                                style: Global.getCustomFont(Global.BLACK, 14, 'bold')
                                                            ),
                                                          )
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Divider()
                                            ]
                                        ),
                                      )
                                  );
                                }
                            )
                        )
                      )
                    ],
                  ),
                )
            )
        )
    );
  }
}
