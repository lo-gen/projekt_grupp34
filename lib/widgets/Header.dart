import 'package:flutter/material.dart';
import 'package:projekt_grupp34/app_theme.dart';
import 'package:projekt_grupp34/pages/Startsida.dart';
import 'package:projekt_grupp34/widgets/Logo.dart';
import 'package:sticky_headers/sticky_headers.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
                color: AppTheme.darkblue,  //header
                width: screenwidth, 
                height: 130,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: 
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Logo(),

                    SizedBox(width: 100,),
                    
                    Expanded(
                      child: SearchBar(hintText: 'Sök efter produkter här',),
                      ),
                      
                    SizedBox(width: 100,),

                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Row(
                        children: [
                          SizedBox(
                            width: 170,
                            height: 40,
                            child: 
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.ligtblue),
                                onPressed: () {
                                //Navigator.push(context, MaterialPageRoute(builder: (context) => LeveransTider()));
                              }, 
                                child: Text('Lev. tider', style: TextStyle(fontSize: 26, color: AppTheme.white)),
                            ), 
                          ),
                          SizedBox(width: AppTheme.paddingSmall,), 
                          SizedBox(
                            width: 170,
                            height: 40,
                            child: 
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.ligtblue,),
                                onPressed: () {
                                //Navigator.push(context, MaterialPageRoute(builder: (context) => Konto()));
                              }, 
                                child: Text('Konto', style: TextStyle(fontSize: 26, color: AppTheme.white)),
                          ), 
                          ),],),
                      SizedBox(height: AppTheme.paddingSmall,),
                        Row(
                          children: [
                          SizedBox(
                            width: 170,
                            height: 40,
                            child: 
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.ligtblue),
                                onPressed: () {
                                //Navigator.push(context, MaterialPageRoute(builder: (context) => Listor()));
                              }, 
                                child: Text('Listor', style: TextStyle(fontSize: 26, color: AppTheme.white)),
                          ), 
                          ), 
                          SizedBox(width: AppTheme.paddingSmall,), 
                          SizedBox(
                            width: 170,
                            height: 40,
                            child: 
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.ligtblue),
                                onPressed: () {
                                //Navigator.push(context, MaterialPageRoute(builder: (context) => Varukorg()));
                              }, 
                                child: Text('Varukorg', style: TextStyle(fontSize: 26, color: AppTheme.white)),
                          ), 
                          ),                       
                        ],
                      ),
                      
                  ],
              ),
            ], 
          ),
        );
  }
}