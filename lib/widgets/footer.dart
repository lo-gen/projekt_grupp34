import 'package:flutter/material.dart';
import 'package:projekt_grupp34/app_theme.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    return Container(      //Footer
      width: screenwidth,
      height: 130,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(width: AppTheme.paddingHuge,),
          Column(
            children: [
              Text('Om oss', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              SizedBox(height: AppTheme.paddingTiny,),
              Text('Vi är roliga'),
              SizedBox(height: AppTheme.paddingTiny,),
              Text('Vi levererar snabbt'),
            ],
          ),
          SizedBox(width: 70,),
          Column(
            children: [
              Text('Kontakta oss', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              SizedBox(height: AppTheme.paddingTiny,),
              Text('070-1234567'),
              SizedBox(height: AppTheme.paddingTiny,),
              Text('Swish: 123456, kung e du'),
            ],
          ),
        ],
      ),
    );
  }
}