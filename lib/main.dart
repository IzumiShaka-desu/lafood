import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lafoody/constant/color_palette.dart';
import 'package:lafoody/presentation/view/screens/splashscreen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: ColorPalette.primaryYellow,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      defaultTransition: Transition.rightToLeft,
      home: Splashscreen(),
    );
  }
}
