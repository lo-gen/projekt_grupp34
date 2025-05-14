

import 'package:flutter/material.dart';
import 'package:projekt_grupp34/app_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
          color: Color.fromARGB(255, 255, 255, 255),
          width: screenwidth,
          height: 1972,
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: AppTheme.darkblue,  //header
                width: screenwidth, 
                height: 130,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: 
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 275,
                      child:
                      ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                      },
                      child: Text('Logo', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),),
                    ),

                    SizedBox(width: AppTheme.paddingMedium,),
                    
                    Expanded(
                      child: SearchBar(hintText: 'Sök efter produkter här',),
                      ),
                      
                    SizedBox(width: 100,),

                    Expanded(       //Varukorg, listor, m.m knappar
                      child: Column(
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
                  ],)
              ),], ),),

              SizedBox(height: 20,),
              
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Container(    //kategorier på vänstra sidan
                width: 120,
                height: 600,
                color: Colors.grey,
                margin: const EdgeInsets.only(left: 16),
                padding: EdgeInsets.all(8),
                child: Column(     
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                      Text('Kategorier', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                      SizedBox(height: 8),
                      Text('Kött +', style: TextStyle(fontSize: 12),),
                      Text('Fisk +', style: TextStyle(fontSize: 12),),
                      Text('Yap +', style: TextStyle(fontSize: 12),),
                      Text('Erbjudanden +', style: TextStyle(fontSize: 12),),
                    
                  ],
              ),
            ),], ),
          ],
        ),),],
      ),
    );

    return SingleChildScrollView(
      child: Scaffold(
        body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Vänstermeny
          Container(
            width: 120,
            color: Colors.white,
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Kategorier', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Kött +'),
                Text('Fisk +'),
                Text('Yap +'),
                Text('Erbjudanden +'),
              ],
            ),
          ),

          // Huvudinnehåll
          Expanded(
            child: Column(
              children: [
                // Topprad
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(Icons.shopping_basket, size: 32),
                      SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Klicka här för att söka',
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      ElevatedButton(onPressed: () {}, child: Text('Lev. tider')),
                      SizedBox(width: 6),
                      ElevatedButton(onPressed: () {}, child: Text('Konto')),
                      SizedBox(width: 6),
                      ElevatedButton(onPressed: () {}, child: Text('Listor')),
                      SizedBox(width: 6),
                      ElevatedButton(onPressed: () {}, child: Text('Varukorg')),
                    ],
                  ),
                ),

                // Banner
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  padding: EdgeInsets.all(16),
                  height: 160,
                  //decoration: BoxDecoration(
                    //image: DecorationImage(
                      //image: AssetImage('assets/images/banner.jpg'), // <-- byt till din banner
                      //fit: BoxFit.cover,),
                
                  
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Till dina inköpslistor'),
                  ),
                ),

                // Kategoriknappar
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: ['Kött', 'Fisk', 'Grönt'].map((label) {
                      return Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: 
                            //Image.asset('assets/images/$label.jpg', // tex: Kött.jpg
                              SizedBox(
                              width: 100,
                              height: 80,
                              //fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      );
                    }).toList(),
                  ),
                ),

                // Produktgrid
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: GridView.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      children: List.generate(9, (index) {
                        return Container(
                          color: Colors.white,
                          child: Center(child: Text('Produkt ${index + 1}')),
                        );
                      }),
                    ),
                  ),
                ),

                // Footer
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text('Köpvillkor', style: TextStyle(decoration: TextDecoration.underline)),
                      Text('Kundtjänst', style: TextStyle(decoration: TextDecoration.underline)),
                      Text('Om Oss', style: TextStyle(decoration: TextDecoration.underline)),
                    ],
                  ),
                )
              ],
            ),
          ),

          // Högerkolumn (Erbjudanden)
          Container(
            width: 100,
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(height: 12),
                Text('Erbjudanden', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 12),
                Text('Bild här')
                //Image.asset('assets/images/erbjudande.jpg'), // byt ut mot korrekt bild
              ],
            ),
          ),
        ],
      ),),
    );
  }
}