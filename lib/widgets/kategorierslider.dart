import 'package:flutter/material.dart';
import 'package:projekt_grupp34/app_theme.dart';

class Kategorierslider extends StatelessWidget {
  const Kategorierslider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(    //kategorier på vänstra sidan
                  width: 220,
                  height: 600,
                  margin: const EdgeInsets.only(left: 16, top: AppTheme.paddingSmall),
                  padding: EdgeInsets.only(top: AppTheme.paddingSmall),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16), 
                    color: AppTheme.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.20),
                        blurRadius: 15,
                        offset: Offset(0, 4)
                      )
                    ]
                    ),
                    child: Column(     
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text('Kategorier', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),),
                          ]),
                        SizedBox(height: AppTheme.paddingTiny),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: AppTheme.paddingTiny,),
                            Text('Kött', style: TextStyle(fontSize: 30),),
                            Column(
                              children: [
                                //DropdownButton()     + knappen med subkategorier
                                  
                              ],
                            )
                          ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: AppTheme.paddingTiny,),
                            Text('Fisk', style: TextStyle(fontSize: 30),),
                            Column(
                              children: [
                                //DropdownButton()     + knappen med subkategorier
                                  
                              ],
                            )
                          ]),                          
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: AppTheme.paddingTiny,),
                            Text('Grönt', style: TextStyle(fontSize: 30),),
                            Column(
                              children: [
                                //DropdownButton()     + knappen med subkategorier
                                  
                              ],
                            )
                          ]),                          
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: AppTheme.paddingTiny,),
                            Text('Yap', style: TextStyle(fontSize: 30),),
                            Column(
                              children: [
                                //DropdownButton()     + knappen med subkategorier
                                  
                              ],
                            )
                          ]),                      
                      ],
                  ),
                ),], );
  }
}