import 'package:flutter/material.dart';
import 'package:projekt_grupp34/startsida.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
            width: 275,
            child:
            ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            child: Text('Logo', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),),
    );
  }
}