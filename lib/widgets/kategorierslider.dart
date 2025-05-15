import 'package:flutter/material.dart';
import 'package:projekt_grupp34/app_theme.dart';

class Kategorierslider extends StatelessWidget {
  const Kategorierslider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Container(    //kategorier på vänstra sidan
              width: 220,
              height: 600,
              color: Colors.grey,
              margin: const EdgeInsets.only(left: 16),
              padding: EdgeInsets.all(8),
              child: Column(     
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                    Text('Kategorier', style: AppTheme.smallheader,),
                    SizedBox(height: AppTheme.paddingTiny),
                    Text('Kött +', style: TextStyle(fontSize: 12),),
                    Text('Fisk +', style: TextStyle(fontSize: 12),),
                    Text('Yap +', style: TextStyle(fontSize: 12),),
                    Text('Erbjudanden +', style: TextStyle(fontSize: 12),),
                  
                  ],
              ),
            ),], );
  }
}