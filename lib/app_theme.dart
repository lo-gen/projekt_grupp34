
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
    //Colors
    static const Color darkblue = Color.fromARGB(255, 40, 80, 119);
    static const Color ligtblue = Color.fromARGB(255, 31, 111, 139);
    static const Color white = Color.fromARGB(255, 255, 255, 255);
    
    //paddings
    static const double paddingTiny = 10;
    static const double paddingSmall = 20;
    static const double paddingMedium = 30;
    static const double paddingLarge= 40;
    static const double paddingHuge = 50;

    //different rounded edges


    //different google fonts
    static TextTheme nunito = GoogleFonts.nunitoTextTheme();
    static TextTheme sans = GoogleFonts.dmSansTextTheme();

    static const TextStyle smallheader = TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
    );



}