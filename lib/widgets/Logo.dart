import 'package:flutter/material.dart';
import 'package:projekt_grupp34/pages/startsida.dart';

class Logo extends StatelessWidget {
  const Logo({super.key,});

  final double logowidth = 200;
  final double logoheight = 150;

  @override
  Widget build(BuildContext context) {
  
    return SizedBox(
            width: logowidth,
            height: logoheight,
            child:
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: EdgeInsets.zero,
              ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            child:
              Image(image: AssetImage('assets/images/IMat_logo_basket_right.png')),
            ),
    );
  }
}