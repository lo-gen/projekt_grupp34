import 'package:flutter/material.dart';
import 'package:projekt_grupp34/app_theme.dart';
import 'package:projekt_grupp34/widgets/Header.dart';
import 'package:projekt_grupp34/widgets/Headertest.dart';
import 'package:projekt_grupp34/widgets/kategorierslider.dart';
import 'package:projekt_grupp34/widgets/startsida_bild_och_kategorier.dart';
import 'package:sticky_headers/sticky_headers.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: StickyHeaderDelegate(
              child: Header(),
              height: 130,
              width: screenwidth,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: screenwidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Kategorierslider(),
                      StartsidaBildOchKategorier(),
                      

                      // Forstätt
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
