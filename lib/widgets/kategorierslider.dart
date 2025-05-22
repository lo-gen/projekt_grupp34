import 'package:flutter/material.dart';
import 'package:projekt_grupp34/app_theme.dart';

class Kategorierslider extends StatefulWidget {
  const Kategorierslider({super.key});

  @override
  State<Kategorierslider> createState() => _KategoriersliderState();
}

class _KategoriersliderState extends State<Kategorierslider> {
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 220,
          height: 600,
          margin: const EdgeInsets.only(left: 16, top: AppTheme.paddingSmall),
          padding: EdgeInsets.only(top: AppTheme.paddingSmall),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppTheme.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.20),
                blurRadius: 15,
                offset: Offset(0, 4)
              )
            ]
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: AppTheme.paddingTiny,),
                  Text(
                    'Kategorier',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                  ),
                ]
              ),
              SizedBox(height: AppTheme.paddingTiny),

              _buildCategoryRow(
                context,
                title: 'Kött',
                showDropdown: selectedCategory == 'Kött',
                onTextTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => KöttPage()));
                },
                onPlusTap: () {
                  setState(() {
                    selectedCategory = selectedCategory == 'Kött' ? null : 'Kött';
                  });
                },
                subcategories: ['Nöt', 'Fläsk', 'Kyckling'],
              ),

              _buildCategoryRow(
                context,
                title: 'Fisk',
                showDropdown: selectedCategory == 'Fisk',
                onTextTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => FiskPage()));
                },
                onPlusTap: () {
                  setState(() {
                    selectedCategory = selectedCategory == 'Fisk' ? null : 'Fisk';  
                  });
                },
                subcategories: ['Lax', 'Torsk', 'Räkor'],
              ),

              _buildCategoryRow(
                context,
                title: 'Frukt & Grönt',
                showDropdown: selectedCategory == 'Grönt',
                onTextTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => GrontPage()));
                },
                onPlusTap: () {
                  setState(() {
                    selectedCategory = selectedCategory == 'Grönt' ? null : 'Grönt';  
                  });
                },
                subcategories: ['Sallad', 'Tomat', 'Gurka'],
              ),

              _buildCategoryRow(
                context, 
                title: 'Dryck', 
                showDropdown: selectedCategory == 'Dryck', 
                onTextTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => DryckPage()));
                },
                 onPlusTap: () {
                  setState(() {
                    selectedCategory = selectedCategory == 'Dryck' ? null : 'Dryck';  
                  });
                 }, 
                 subcategories: ['Vatten', 'Läsk', 'Öl'],
                 ),

              _buildCategoryRow(
                context, 
                title: 'Bröd', 
                showDropdown: selectedCategory == 'Bröd', 
                onTextTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => BrödPage()));
                },
                onPlusTap: () {
                  setState(() {
                    selectedCategory = selectedCategory == 'Bröd' ? null : 'Bröd';  
                  });
                }, 
                subcategories: ['Surdeg', 'Fikabröd'],
                ),

              _buildCategoryRow(
                context, 
                title: 'Mejeri', 
                showDropdown: selectedCategory == 'Mejeri', 
                onTextTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => MejeriPage()));
                },
                 onPlusTap: () {
                  setState(() {
                    selectedCategory = selectedCategory == 'Mejeri' ? null : 'Mejeri';  
                  });
                 }, 
                 subcategories: ['Mjölk', 'Ost', 'Ägg', 'Laktosfritt'],
                 ),

              _buildCategoryRow(
                context, 
                title: 'Skafferi', 
                showDropdown: selectedCategory == 'Skafferi', 
                onTextTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => DryckPage()));
                },
                 onPlusTap: () {
                  setState(() {
                    selectedCategory = selectedCategory == 'Skafferi' ? null : 'Skafferi';  
                  });
                 }, 
                 subcategories: ['Bakingredienser', 'Godis', 'Snacks'],
                 ),

              _buildCategoryRow(
                context, 
                title: 'Kolhydrater',
                showDropdown: selectedCategory == 'Kolhydrater', 
                onTextTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => DryckPage()));
                },
                 onPlusTap: () {
                  setState(() {
                    selectedCategory = selectedCategory == 'Kolhydrater' ? null : 'Kolhydrater';  
                  });
                 }, 
                 subcategories: ['Pasta', 'Ris', 'Potatis'],
                 ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryRow(
    BuildContext context, {
    required String title,
    required bool showDropdown,
    required VoidCallback onTextTap,
    required VoidCallback onPlusTap,
    required List<String> subcategories,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(width: AppTheme.paddingTiny),
            GestureDetector(
              onTap: onTextTap,
              child: Text(title, style: TextStyle(fontSize: 26)),
            ),
            Spacer(),
            IconButton(
              icon: Icon(showDropdown ? Icons.remove : Icons.add),
              onPressed: onPlusTap,
              splashRadius: 18,
            ),
          ],
        ),
        if (showDropdown)
          Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: subcategories
                  .map((sub) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Text(sub, style: TextStyle(fontSize: 16)),
                      ))
                  .toList(),
            ),
          ),
      ],
    );
  }
}