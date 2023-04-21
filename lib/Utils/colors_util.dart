import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

const Map<int, Color> color = {
  50: Color.fromRGBO(37, 72, 183, .1),
  100: Color.fromRGBO(37, 72, 183, .2),
  200: Color.fromRGBO(37, 72, 183, .3),
  300: Color.fromRGBO(37, 72, 183, .4),
  400: Color.fromRGBO(37, 72, 183, .5),
  500: Color.fromRGBO(37, 72, 183, .6),
  600: Color.fromRGBO(37, 72, 183, .7),
  700: Color.fromRGBO(37, 72, 183, .8),
  800: Color.fromRGBO(37, 72, 183, .9),
  900: Color.fromRGBO(37, 72, 183, 1),
};
const AppPrimaryColor = MaterialColor(0xFFFD5722, color);

const AppGradientColor = LinearGradient(colors: [
  AppPrimaryColor,
  AppPrimaryColor,
]);
