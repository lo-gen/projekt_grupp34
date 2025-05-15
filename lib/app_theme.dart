
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

    static const TextStyle mediumheader = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold
    );

}
  
class StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  
  final Widget child;
  final double height;
  final double width;

  StickyHeaderDelegate({required this.child, required this.height, required this.width});

  @override
  double get minExtent => height;
  @override
  double get maxExtent => height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      elevation: overlapsContent ? 4 : 0,
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant StickyHeaderDelegate oldDelegate) {
    return oldDelegate.child != child || oldDelegate.height != height;
  }
}


