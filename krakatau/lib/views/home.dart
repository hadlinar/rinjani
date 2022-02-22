// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:krakatau/utils/global.dart';
import 'package:krakatau/views/page/planning.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
                  Color(0xFFF3FCFF),
                  Color(0xFF32BFFC),
                ],
                begin: Alignment.topCenter,
                end: Alignment.center,
          )
        ),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 52, left: 22, right: 22),
              child: Align(
                alignment: Alignment.centerLeft,
                  child: Text(
                  "Name",
                  style: Global.getCustomFont(Global.BLACK, 22, 'bold')
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.only(top: 12, left: 22, right: 22, bottom: 32),
              child: Align(
                alignment: Alignment.centerLeft,
                  child: Text(
                  "NIK",
                  style: Global.getCustomFont(Global.BLACK, 22, 'book')
                ),
              )
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.white,
                  ]
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30)
                )
              ),
              child: Container(
                padding: EdgeInsets.only(top: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Planning()
                            ));
                          },
                          child: Global.getMenuCard("planning.png", 0xffE1BBBB)
                        ),
                        Global.getMenuText("Planning")
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        GestureDetector(
                            onTap: (){},
                            child: Global.getMenuCard("realization.png", 0xffDAC2ED)
                        ),
                        Global.getMenuText("Realization")
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        GestureDetector(
                            onTap: (){},
                            child: Global.getMenuCard("report.png", 0xffF2EFA7)
                        ),
                        Global.getMenuText("Report")
                      ],
                    )
                  ],
                ),
              )
            ),
          ],
        ),
      )
    );
  }
}