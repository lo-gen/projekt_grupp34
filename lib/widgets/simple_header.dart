import 'package:flutter/material.dart';
import 'package:projekt_grupp34/app_theme.dart';
import 'package:projekt_grupp34/widgets/Logo.dart';

class SimpleHeader extends StatelessWidget {
  const SimpleHeader({super.key});

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(
      color: AppTheme.darkblue,
      width: screenwidth,
      height: 130,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Logo(),
        ],
      ),
    );
  }
}