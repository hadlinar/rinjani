import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rinjani/views/page/detail_report.dart';

import '../../bloc/visit/visit_bloc.dart';
import '../../utils/global.dart';

class ListReport extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListReport();
  }
}

class _ListReport extends State<ListReport> {

  String defaultType;
  String defaultSort;

  List showOnly = [
    "Today",
    "All time",
    "Yesterday",
    "Last 7 days",
    "Last 30 days"
  ];

  List sortBy = [
    "Customer",
    "PIC"
  ];

  @override
  void initState() {
    super.initState();
    BlocProvider.of<VisitBloc>(context).add(GetVisitRealizationByIdEvent('1985417002'));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder <VisitBloc, VisitBlocState> (
      builder: (context, state) {
        if(state is InitialVisitBlocState || state is LoadingVisitState) {
          return const Center(
            child: CircularProgressIndicator()
          );
        } else if(state is VisitRealizationByIdList){
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
                        children: <Widget> [
                          Container(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Reports',
                                style: TextStyle(color: Color(Global.BLACK), fontSize: 20, fontFamily: 'medium'),
                              ),
                            ),
                          ),
                          Row(
                            children: <Widget> [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                    padding: const EdgeInsets.only(top: 17, left: 14, bottom: 65, right: 17),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Filter :',
                                          style: Global.getCustomFont(Global.BLACK, 14, 'book')
                                      ),
                                    )
                                ),
                              ),
                              Column(
                                children: <Widget> [
                                  Container(
                                      width: 200,
                                      padding: const EdgeInsets.only(top: 17, left: 12),
                                      child: DropdownButtonFormField<String>(
                                        dropdownColor: Colors.white,
                                        style: Global.getCustomFont(Global.BLACK, 15, 'medium'),
                                        value: defaultType,
                                        items: sortBy.map((e) {
                                          return DropdownMenuItem<String>(
                                            value: e,
                                            child: Text(e),
                                          );
                                        }).toList(),
                                        onChanged: (String value) {
                                          setState(() {
                                            defaultType = value;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.only( top: 10, bottom: 10, left: 12, right: 12),
                                          labelText: "Sort by",
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
                                  Container(
                                      width: 200,
                                      padding: const EdgeInsets.only(top: 17, left: 12),
                                      child: DropdownButtonFormField<String>(
                                        dropdownColor: Colors.white,
                                        style: Global.getCustomFont(Global.BLACK, 15, 'medium'),
                                        value: defaultSort,
                                        items: showOnly.map((e) {
                                          return DropdownMenuItem<String>(
                                            value: e,
                                            child: Text(e),
                                          );
                                        }).toList(),
                                        onChanged: (String value) {
                                          setState(() {
                                            defaultType = value;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.only( top: 10, bottom: 10, left: 12, right: 12),
                                          labelText: "Show only",
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
                                ],
                              )
                            ],
                          ),
                          Container(
                              padding: const EdgeInsets.only(top: 17),
                              child: ListView.builder(
                                  itemCount: state.getVisitRealization.length,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, i){
                                    return ListTile(
                                        title: Container(
                                          alignment: Alignment.topLeft,
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                InkWell(
                                                  onTap: (){
                                                    Navigator.push(context, MaterialPageRoute(
                                                        builder: (context) => DetailReport(state.getVisitRealization[i])
                                                    ));
                                                  },
                                                  child: Column(
                                                    children: <Widget> [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            margin: const EdgeInsets.only(right: 17, bottom: 24),
                                                            child: Align(
                                                              alignment: Alignment.topLeft,
                                                              child: Text('${i+1}.', style: Global.getCustomFont(Global.BLACK, 14, 'bold')),
                                                            ),
                                                          ),
                                                          Column(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Align(
                                                                alignment: Alignment.centerLeft,
                                                                child: Text("${state.getVisitRealization[i].pic_name} - ${state.getVisitRealization[i].pic_position}", style: Global.getCustomFont(Global.BLACK, 14, 'bold')),
                                                              ),
                                                              Container(
                                                                padding: const EdgeInsets.only(top: 5),
                                                                child: Align(
                                                                  alignment: Alignment.centerLeft,
                                                                  child: Text(state.getVisitRealization[i].cust_id, style: Global.getCustomFont(Global.BLACK, 14, 'medium')),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets.only(right: 17, left: 30, top: 5),
                                                        child: Align(
                                                          alignment: Alignment.topLeft,
                                                          child: Text(state.getVisitRealization[i].description, style: Global.getCustomFont(Global.GREY, 14, 'book')),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Divider()
                                              ]
                                          ),
                                        )
                                    );
                                  }
                              )
                          )
                        ],
                      ),
                    )
                )
            ),
          );
        } else {
          return Container();
        }
      }
    );
  }
}