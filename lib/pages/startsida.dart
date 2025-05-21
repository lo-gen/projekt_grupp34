import 'package:flutter/material.dart';
import 'package:projekt_grupp34/app_theme.dart';
import 'package:projekt_grupp34/widgets/Header.dart';
import 'package:projekt_grupp34/widgets/Headertest.dart';
import 'package:projekt_grupp34/widgets/kategorierslider.dart';
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
                      Kategorierslider(),
                      Column(
                        children: [
                          SizedBox(height: AppTheme.paddingSmall),
                          Container(
                            //Main bild
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            height: screenheight - 400,
                            width: screenwidth - 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/Kött.jpg',
                                ), //kom ihåg att ändra bild här vid copy pasting
                                fit: BoxFit.cover,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'För att alla ska kunna handla online!',
                                    style: TextStyle(
                                      color: AppTheme.white,
                                      fontSize: 40,
                                    ),
                                  ),
                                  SizedBox(height: AppTheme.paddingMedium),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppTheme.ligtblue,
                                    ),
                                    onPressed: () {
                                      //Navigator.push(context, MaterialPageRoute(builder: (context) => Listor()));
                                    },
                                    child: Text(
                                      'Till dina inköpslistor',
                                      style: TextStyle(
                                        color: AppTheme.white,
                                        fontSize: 40,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: AppTheme.paddingMedium),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: AppTheme.paddingLarge),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      //Navigator.push(context, MaterialPageRoute(builder: (context) => Kött()));
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      overlayColor: Colors.transparent,
                                      foregroundColor: Colors.transparent,
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 150,
                                          width: 280,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                'assets/images/Kött.jpg',
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),

                                        Text(
                                          'Kött',
                                          style: AppTheme.smallheader,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: AppTheme.paddingTiny),
                              Column(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      //Navigator.push(context, MaterialPageRoute(builder: (context) => Fisk()));
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      overlayColor: Colors.transparent,
                                      foregroundColor: Colors.transparent,
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 150,
                                          width: 280,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                'assets/images/Kött.jpg',
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),

                                        Text(
                                          'Fisk',
                                          style: AppTheme.smallheader,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: AppTheme.paddingTiny),
                              Column(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      //Navigator.push(context, MaterialPageRoute(builder: (context) => Grönt()));
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      overlayColor: Colors.transparent,
                                      foregroundColor: Colors.transparent,
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 150,
                                          width: 280,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                'assets/images/Kött.jpg',
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),

                                        Text(
                                          'Grönt',
                                          style: AppTheme.smallheader,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: AppTheme.paddingTiny),

                              Column(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      //Navigator.push(context, MaterialPageRoute(builder: (context) => Dryck()));
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      overlayColor: Colors.transparent,
                                      foregroundColor: Colors.transparent,
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 150,
                                          width: 280,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                'assets/images/Kött.jpg',
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),

                                        Text(
                                          'Dryck',
                                          style: AppTheme.smallheader,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          SizedBox(height: AppTheme.paddingLarge),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      //Navigator.push(context, MaterialPageRoute(builder: (context) => Bröd()));
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      overlayColor: Colors.transparent,
                                      foregroundColor: Colors.transparent,
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 150,
                                          width: 280,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                'assets/images/Kött.jpg',
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),

                                        Text(
                                          'Bröd',
                                          style: AppTheme.smallheader,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: AppTheme.paddingTiny),
                              Column(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      //Navigator.push(context, MaterialPageRoute(builder: (context) => Mejer()));
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      overlayColor: Colors.transparent,
                                      foregroundColor: Colors.transparent,
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 150,
                                          width: 280,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                'assets/images/Kött.jpg',
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),

                                        Text(
                                          'Mejeri',
                                          style: AppTheme.smallheader,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: AppTheme.paddingTiny),
                              Column(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      //Navigator.push(context, MaterialPageRoute(builder: (context) => Skafferi()));
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      overlayColor: Colors.transparent,
                                      foregroundColor: Colors.transparent,
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 150,
                                          width: 280,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                'assets/images/Kött.jpg',
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),

                                        Text(
                                          'Skafferi',
                                          style: AppTheme.smallheader,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: AppTheme.paddingTiny),

                              Column(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      //Navigator.push(context, MaterialPageRoute(builder: (context) => Kolhydrater()));
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      overlayColor: Colors.transparent,
                                      foregroundColor: Colors.transparent,
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 150,
                                          width: 280,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                'assets/images/Kött.jpg',
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),

                                        Text(
                                          'Kolhydrater',
                                          style: AppTheme.smallheader,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),

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
