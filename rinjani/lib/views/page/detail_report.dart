import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/global.dart';

class DetailReport extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DetailReport();
  }
}

class _DetailReport extends State<DetailReport> {

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
                            'Customer',
                            style: TextStyle(color: Color(Global.BLACK), fontSize: 15, fontFamily: 'book'),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text(
                              'Customer 1',
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
                              'PIC',
                              style: TextStyle(color: Color(Global.BLACK), fontSize: 15, fontFamily: 'book'),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 74),
                              child: Text(
                                'PIC 1',
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
                              'Date',
                              style: TextStyle(color: Color(Global.BLACK), fontSize: 15, fontFamily: 'book'),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 64),
                              child: Text(
                                'dd/mm/yyyy',
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget> [
                            Text(
                              'Report',
                              style: TextStyle(color: Color(Global.BLACK), fontSize: 15, fontFamily: 'book'),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 24, top: 17, bottom: 17),
                              child: Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                                style: TextStyle(color: Color(Global.BLACK), fontSize: 15, fontFamily: 'book'),
                              ),
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