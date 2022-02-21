import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';

class Global {
  static int BLACK = 0xff333333;
  static int BLUE = 0xff2F80ED;
  static int GREY = 0xff828282;

  static const BACK_ICON = "assets/icon/ic_back.png";
  static const CALENDAR_ICON = "assets/icon/ic_calendar.png";
  static const CLOCK_ICON = "assets/icon/ic_clock.png";

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

  static void setState(Null Function() param0) {}

} 