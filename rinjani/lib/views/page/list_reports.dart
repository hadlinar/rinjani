import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rinjani/views/page/detail_report.dart';

import '../../utils/global.dart';

class ListReport extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListReport();
  }
}

class _ListReport extends State<ListReport> {

  String? defaultType;
  String? defaultSort;

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
                                  onChanged: (String? value) {
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
                                  onChanged: (String? value) {
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
                            itemCount: 10,
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
                                                  builder: (context) => DetailReport()
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
                                                          child: Text('PIC ${i+1}', style: Global.getCustomFont(Global.BLACK, 14, 'bold')),
                                                        ),
                                                        Container(
                                                          padding: const EdgeInsets.only(top: 5),
                                                          child: Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Text('Customer ${i+1}', style: Global.getCustomFont(Global.BLACK, 14, 'medium')),
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
                                                    child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', style: Global.getCustomFont(Global.GREY, 14, 'book')),
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
  }
}