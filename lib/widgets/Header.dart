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
    double screenheight = MediaQuery.of(context).size.height;
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
                        side: const BorderSide(width: 2, color: Colors.white),
                        elevation: 8,
                        shadowColor: Colors.black54,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LeveranstiderPage()));
                      }, 
                      child: const Text('Lev. tider', style: TextStyle(fontSize: 26, color: Colors.white)),
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
                        side: const BorderSide(width: 2, color: Colors.white),
                        elevation: 8,
                        shadowColor: Colors.black54,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Kontosida()));
                      }, 
                      child: const Text('Konto', style: TextStyle(fontSize: 26, color: Colors.white)),
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
                        side: const BorderSide(width: 2, color: Colors.white),
                        elevation: 8,
                        shadowColor: Colors.black54,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
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
                        side: const BorderSide(width: 2, color: Colors.white),
                        elevation: 8,
                        shadowColor: Colors.black54,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierLabel: "Varukorg",
                          barrierColor: Colors.black54,
                          transitionDuration: const Duration(milliseconds: 200),
                          pageBuilder: (context, animation, secondaryAnimation) {
                            double screenHeight = MediaQuery.of(context).size.height;
                            return Align(
                              alignment: Alignment.centerRight,
                              child: Material(
                                color: Colors.transparent,
                                child: SizedBox(
                                  width: 400,
                                  height: screenHeight,
                                  child: Container(
                                    color: Colors.white,
                                    child: KundvagnView(),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: const Text('Varukorg', style: TextStyle(fontSize: 26, color: Colors.white)),
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