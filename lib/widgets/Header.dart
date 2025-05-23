import 'package:flutter/material.dart';
import 'package:projekt_grupp34/app_theme.dart';
import 'package:projekt_grupp34/pages/kontosida.dart';
import 'package:projekt_grupp34/pages/leveranstider.dart';
import 'package:projekt_grupp34/pages/listor.dart';
import 'package:projekt_grupp34/widgets/Kundvagn.dart';
import 'package:projekt_grupp34/widgets/Logo.dart';

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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.ligtblue,
                        side: BorderSide(width: 0.5, color: AppTheme.white),
                        elevation: 8,
                        shadowColor: Colors.black54,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        foregroundColor: Colors.white.withOpacity(0.1),
                        ),
                      onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LeveranstiderPage()));
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.ligtblue,
                        side: BorderSide(width: 0.5, color: AppTheme.white),
                        elevation: 8,
                        shadowColor: Colors.black54,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        foregroundColor: Colors.white.withOpacity(0.1),
                      ),

                      onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Kontosida()));
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.ligtblue,
                        side: BorderSide(width: 0.5, color: AppTheme.white),
                        elevation: 8,
                        shadowColor: Colors.black54,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        foregroundColor: Colors.white.withOpacity(0.1),                        ),
                      onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ListorPage()));
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.ligtblue,
                        side: BorderSide(width: 0.5, color: AppTheme.white),
                        elevation: 8,
                        shadowColor: Colors.black54,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        foregroundColor: Colors.white.withOpacity(0.1),
                        ),
                      onPressed: () {
  showDialog(
    context: context,
    barrierDismissible: true, // Klick utanför stänger panelen
    builder: (context) {
      return Stack(
        children: [
          // Transparent bakgrund
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              color: Colors.black54, // Mörk bakgrund, valfritt
            ),
          ),
          // Själva panelen
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 400, // Justera bredd efter behov
              height: double.infinity,
              color: Colors.white,
              child: KundvagnView(),
            ),
          ),
        ],
      );
    },
  );
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