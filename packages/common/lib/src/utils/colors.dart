import 'package:flutter/material.dart';

class ColorsPalette {
  ColorsPalette();
  //button
  static Color primaryButton = getColor('#CAFF33');
}

Color getColor(String colorValue) {
  if (colorValue == "transparent") {
    return const Color(0x00000000);
  } else if (colorValue.startsWith("#")) {
    String hex = colorValue.substring(1);
    if (hex.length == 6) {
      hex = "FF$hex";
    }
    return Color(int.parse(hex, radix: 16));
  } else {
    return Color(int.parse(colorValue));
  }
}
