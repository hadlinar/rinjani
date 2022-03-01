import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../utils/global.dart';

class ListCustomer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListCustomer();
  }
}

class _ListCustomer extends State<ListCustomer> {
  var _filter = null;
  String? defaultType;

  List typeVal = [
    "Today",
    "All time",
    "Yesterday",
    "Last 7 days",
    "Last 30 days"
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
                      'List of customers',
                      style: TextStyle(color: Color(Global.BLACK), fontSize: 20, fontFamily: 'medium'),
                    ),
                  ),
                ),
                Row(
                  children: <Widget> [
                    Container(
                        padding: const EdgeInsets.only(top: 17, left: 14),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Filter :',
                              style: Global.getCustomFont(Global.BLACK, 14, 'book')
                          ),
                        )
                    ),
                    Container(
                        width: 200,
                        padding: const EdgeInsets.only(top: 17, left: 12),
                        child: DropdownButtonFormField<String>(
                          dropdownColor: Colors.white,
                          style: Global.getCustomFont(Global.BLACK, 15, 'medium'),
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
                            child: Column(
                              children: <Widget> [
                                Row(
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text('${i+1}', style: Global.getCustomFont(Global.BLACK, 14, 'bold')),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(left: 17),
                                        child: Text('Customer ${i+1}', style: Global.getCustomFont(Global.BLACK, 14, 'bold')),
                                      ),
                                    ]
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
      )
    );
  }
}