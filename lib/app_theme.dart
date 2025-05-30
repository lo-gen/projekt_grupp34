
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
    //Colors
    static const Color darkestblue = Color.fromARGB(255, 22, 29, 74);
    static const Color darkblue = Color.fromARGB(255, 40, 80, 119);
    static const Color ligtblue = Color.fromARGB(255, 31, 111, 139);
    static const Color white = Color.fromARGB(250, 247, 247, 247);
    static const Color selectedGreen = Color.fromARGB(255, 97, 242, 101);

    
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
        color: Colors.black
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




class HoverableCategory extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  const HoverableCategory({required this.text, required this.onTap});

  @override
  State<HoverableCategory> createState() => _HoverableCategoryState();
}

class _HoverableCategoryState extends State<HoverableCategory> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: widget.onTap,
        child: Container(
          color: _hovering ? Colors.black.withOpacity(0.2) : Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
          alignment: Alignment.centerLeft,
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: 22,
              color: _hovering ? Colors.black : Colors.black,
              fontWeight: _hovering ? FontWeight.bold : FontWeight.normal,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }
}

