

import 'package:flutter/material.dart';
import 'package:projekt_grupp34/pages/startsida.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: HomePage()),);
  }
}