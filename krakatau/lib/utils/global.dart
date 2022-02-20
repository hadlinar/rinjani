import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';

class Global {
  static int BLACK = 0xff333333;

  
  static TextStyle getCustomFont(int color, double fontSize, String fontName) {
    return TextStyle(
        color: Color(color),
        fontFamily: fontName,
        fontSize: fontSize);
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

} 