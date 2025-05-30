import 'package:flutter/material.dart';
import 'package:projekt_grupp34/app_theme.dart';
import 'package:projekt_grupp34/widgets/Header.dart';
import 'package:projekt_grupp34/widgets/footer.dart';
import 'package:projekt_grupp34/widgets/kategorierslider.dart';
import 'package:projekt_grupp34/widgets/startsida_bild_och_kategorier.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

    //Borde vara klar nu (förutom bilder)

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppTheme.white,
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
                    ],
                  ),
                  SizedBox(height: 100,),
                  Footer(),
                    ],
                  )
                
              ),
            ),
        ],
      ),
    );
  }
}
