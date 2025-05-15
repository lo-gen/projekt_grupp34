

import 'package:flutter/material.dart';
import 'package:projekt_grupp34/app_theme.dart';
import 'package:projekt_grupp34/widgets/Header.dart';
import 'package:projekt_grupp34/widgets/Headertest.dart';
import 'package:projekt_grupp34/widgets/kategorier.dart';
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
                    children: [
                      Kategorier(),
                      Container(       //Main bild
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        padding: EdgeInsets.all(16),
                        height: 200,
                        width: 400,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/Kött.jpg'),
                            fit: BoxFit.cover)
                        ),
                        alignment: Alignment.center,
                        child: Container( 
                          alignment: Alignment.bottomCenter,
                          child: Text('Till dina inköpslistor', style: TextStyle(color: AppTheme.white),)     
                          )                    
                      ),
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.asset('assets/images/Kött.jpg'),
                      )
                ],
              ),
              ]
            ),
          ), )
        ]
      )
    );
    
  }
}
