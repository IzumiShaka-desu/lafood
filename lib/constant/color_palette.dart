import 'package:flutter/material.dart';

abstract class ColorPalette {
  static const primaryYellow = Color.fromRGBO(232, 187, 33, 1);
  static const secondaryYellow = Color.fromRGBO(254, 225, 114, 1);
  static const lightYellow=Color.fromRGBO(252, 244, 211, 1);
  static const primaryWhite = Colors.white;
  static const primaryDark=Color.fromRGBO(85, 85, 85, 1);
  static const backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      primaryWhite,
      secondaryYellow,
      
    ],
  );
}
