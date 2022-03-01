import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rinjani/views/page/list_customer.dart';
import 'package:rinjani/views/page/list_pic.dart';
import 'package:rinjani/views/page/list_reports.dart';

import '../../utils/global.dart';
import 'list_visit.dart';

class Report extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Report();
  }
}

class _Report extends State<Report> {

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
        body: SingleChildScrollView(
            reverse: false,
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 17, right: 21, left: 21, bottom: 17),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => ListCustomer()
                              ));
                            },
                            child: Global.getReportCard('Customer', 0xff7DE0B3, 0xff6ECCA1, 'customer')
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => ListPIC()
                              ));
                            },
                            child: Global.getReportCard('PICs', 0xffFFC17E, 0xffECA85E, 'pic')
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 17),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => ListVisit()
                              ));
                            },
                              child: Global.getReportCard('Visits', 0xffFA898D, 0xffD1777A, 'visit')
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => ListReport()
                              ));
                            },
                            child: Global.getReportCard('Result', 0xff73C6F2, 0xff5894B4, 'result')
                          )
                        ],
                      )
                    ],
                  )
                ),
                const Divider(
                  height: 12,
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(top: 17, right: 21, left: 21, bottom: 17),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Visit done within a month',
                          style: TextStyle(color: Color(Global.BLACK), fontSize: 15, fontFamily: 'medium'),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 7),
                        child: ListView.builder(
                            itemCount: 3,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, i){
                              return ListTile(
                                  title: Container(
                                    child: Column(
                                        children: <Widget>[
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text('Customer ${i+1}', style: Global.getCustomFont(Global.BLACK, 14, 'bold')),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(top: 5),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text('PIC ${i+1}', style: Global.getCustomFont(Global.BLACK, 14, 'medium')),
                                            ),
                                          ),
                                          Divider()
                                        ]
                                    ),
                                  )
                              );
                            }
                        )
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ListVisit()
                          ));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget> [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'More',
                                style: TextStyle(color: Color(Global.BLUE), fontSize: 15, fontFamily: 'book'),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 4, left: 10),
                              child: ImageIcon(
                                AssetImage(Global.ARROW_ICON),
                                size: 18,
                              ),
                            )

                          ],
                        )
                      )
                    ],
                  )
                ),
                const Divider(
                  height: 12,
                ),
                Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(top: 17, right: 21, left: 21, bottom: 17),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'List of Person in Charge',
                            style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'medium'),
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.only(top: 7),
                            child: ListView.builder(
                                itemCount: 3,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, i){
                                  return ListTile(
                                      title: Container(
                                        child: Column(
                                            children: <Widget>[
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
                                              Divider()
                                            ]
                                        ),
                                      )
                                  );
                                }
                            )
                        ),
                        InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => ListPIC()
                              ));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget> [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'More',
                                    style: TextStyle(color: Color(Global.BLUE), fontSize: 15, fontFamily: 'book'),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 4, left: 10),
                                  child: ImageIcon(
                                    AssetImage(Global.ARROW_ICON),
                                    size: 18,
                                  ),
                                )

                              ],
                            )
                        )

                      ],
                    )
                ),
                const Divider(
                  height: 12,
                ),
                Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(top: 17, right: 21, left: 21, bottom: 17),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'List of customer',
                            style: TextStyle(color: Color(Global.BLACK), fontSize: 14, fontFamily: 'medium'),
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.only(top: 7),
                            child: ListView.builder(
                                itemCount: 3,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, i){
                                  return ListTile(
                                      title: Container(
                                        child: Column(
                                            children: <Widget>[
                                              Container(
                                                padding: const EdgeInsets.only(top: 5),
                                                child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text('Customer ${i+1}', style: Global.getCustomFont(Global.BLACK, 14, 'medium')),
                                                ),
                                              ),
                                              Divider()
                                            ]
                                        ),
                                      )
                                  );
                                }
                            )
                        ),
                        InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => ListCustomer()
                              ));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget> [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'More',
                                    style: TextStyle(color: Color(Global.BLUE), fontSize: 15, fontFamily: 'book'),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 4, left: 10),
                                  child: ImageIcon(
                                    AssetImage(Global.ARROW_ICON),
                                    size: 18,
                                  ),
                                )

                              ],
                            )
                        )
                      ],
                    )
                ),
              ],
            )
        ),
      )
    );
  }
}