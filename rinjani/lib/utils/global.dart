import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Global {

  static const String baseURL = "http://172.20.30.22:3000";
  // static const String baseURL = "http://172.20.30.22:4000";
  static int BLACK = 0xff333333;
  static int BLUE = 0xff2F80ED;
  static int GREY = 0xff828282;
  static int WHITE = 0xffffffff;

  static const BACK_ICON = "assets/icon/ic_back.png";
  static const CALENDAR_ICON = "assets/icon/ic_calendar.png";
  static const CLOCK_ICON = "assets/icon/ic_clock.png";
  static const ADD_ICON = "assets/icon/ic_add.png";
  static const CUSTOMER_ICON = "assets/icon/ic_customer.png";
  static const PIC_ICON = "assets/icon/ic_pic.png";
  static const RESULT_ICON = "assets/icon/ic_result.png";
  static const VISIT_ICON = "assets/icon/ic_visit.png";
  static const ARROW_ICON = "assets/icon/ic_arrow.png";
  static const CANCEL_ICON = "assets/icon/ic_cancel.png";
  static const CHECK_ICON = "assets/icon/ic_check.png";

  static void setState(Null Function() param0) {}

  static TextStyle getCustomFont(int color, double fontSize, String fontName) {
    return TextStyle(
        color: Color(color),
        fontFamily: fontName,
        fontSize: fontSize);
  }

  static Text getDefaultText(String textToShown, int color) {
    return Text(
      textToShown,
      style: TextStyle(
          color: Color(color),
          fontFamily: 'medium',
          fontSize: 15
      )
    );
  }

  static Text getMenuText(String textToShown) {
    return Text(
      textToShown,
      style: Global.getCustomFont(Global.BLACK, 15, 'medium'),
    );
  }

  static getReportCard(String text, int baseColor, int circleColor, String icon) {
    return Container(
      width: 151,
      height: 72,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage("assets/images/bg_$icon.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 17, left: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                'assets/icon/ic_$icon.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // db customer
          Container(
            padding: const EdgeInsets.only(top: 5, left: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                text,
                style: TextStyle(color: Color(BLACK), fontSize: 14, fontFamily: 'medium'),
              ),
            )
          )
        ],
      )
    );
  }

  static Card getMenuCard(String imageCard, int color) {
    return Card(
        elevation: 0,
        color: Color(color),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)
        ),
        child: SizedBox(
            width: 80,
            height: 80,
            child: Container(
              padding: EdgeInsets.all(13),
              child: Image.asset(
                'assets/images/${imageCard}',
                fit: BoxFit.cover,
              ),
            )
        )
    );
  }

  static AlertDialog defaultModal(
      VoidCallback action,
      BuildContext context,
      String iconPath,
      String titleModal,
      String positiveBtnText,
      bool isShowingNegativeButton) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      title: Image.asset(
        iconPath,
        height: 50,
        width: 50,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: Center(
              child: Text(
                titleModal,
                style: getCustomFont(BLACK, 16, 'bold'),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              isShowingNegativeButton
                  ? Expanded(
                  flex: 1,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                              color: Theme.of(context).accentColor,
                              width: 3)),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Ok",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'bold',
                            fontSize: 15
                        ),
                      )))
                  : Container(),
              isShowingNegativeButton
                  ? Container(
                width: 20,
              )
                  : Container(),
              Expanded(
                  flex: 1,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          side:
                          BorderSide(color: Theme.of(context).accentColor),
                          borderRadius: BorderRadius.circular(10)),
                      color: Theme.of(context).accentColor,
                      onPressed: action,
                      child: Text(
                        positiveBtnText,
                        style: getCustomFont(WHITE, 14, 'bold'),
                      ))),
            ],
          )
        ],
      ),
    );
  }

} 