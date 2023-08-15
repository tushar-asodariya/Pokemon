import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {

  static Color snowColor = fromHex("#F8FAF9");
  static Color isabelline = fromHex("#EDF6EC");
  static Color darkCharcoal = fromHex("#333333");






  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}