import 'package:flutter/material.dart';
import 'package:projekt_grupp34/app_theme.dart';
import 'package:projekt_grupp34/pages/kategorisida.dart';
import 'package:projekt_grupp34/model/imat/product.dart';
import 'package:projekt_grupp34/pages/listor.dart';

class StartsidaBildOchKategorier extends StatelessWidget {
  const StartsidaBildOchKategorier({super.key});

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    // Hämta alla kategorier från enum och visa dem
    final List<ProductCategory> categories = ProductCategory.values
        .where((cat) => cat != ProductCategory.UNDEFINED)
        .toList();

    // För demo: mappa kategori till bild (lägg till fler bilder om du har)
    final Map<ProductCategory, String> categoryImages = {
      ProductCategory.MEAT: 'assets/images/Kött.jpg',
      ProductCategory.FISH: 'assets/images/Fisk.jpg',
      ProductCategory.VEGETABLE_FRUIT: 'assets/images/Frukt & Grönt.jpg',
      ProductCategory.COLD_DRINKS: 'assets/images/Dryck.jpg',
      ProductCategory.BREAD: 'assets/images/Bröd.jpg',
      ProductCategory.DAIRIES: 'assets/images/Mejeri.jpg',
      ProductCategory.FLOUR_SUGAR_SALT: 'assets/images/Skafferi.jpg',
      ProductCategory.POTATO_RICE: 'assets/images/Kolhydrater.jpg',
      ProductCategory.PASTA: 'assets/images/Pasta.jpg',
      ProductCategory.ROOT_VEGETABLE: 'assets/images/Rotfrukter.jpg',
      ProductCategory.BERRY: 'assets/images/Bär.jpg',
      ProductCategory.CITRUS_FRUIT: 'assets/images/Citrus.jpg',
      ProductCategory.NUTS_AND_SEEDS: 'assets/images/Nötter.jpg',
      ProductCategory.SWEET: 'assets/images/Sött.jpg',
      ProductCategory.CABBAGE: 'assets/images/Kål.jpg',
      ProductCategory.MELONS: 'assets/images/Frukt.jpg', // Ingen Melon-bild, använder Frukt
      ProductCategory.EXOTIC_FRUIT: 'assets/images/Exotisk frukt.jpg',
      ProductCategory.POD: 'assets/images/Baljväxter.jpg',
      ProductCategory.HERB: 'assets/images/Ört.jpg',
      ProductCategory.HOT_DRINKS: 'assets/images/Varm dryck.jpg',
      ProductCategory.FRUIT: 'assets/images/Frukt.jpg',
      // Lägg till fler om du har fler kategorier/bilder
    };

    // Mappa enum till svenska namn
    final Map<ProductCategory, String> categoryNames = {
      ProductCategory.MEAT: 'Kött',
      ProductCategory.FISH: 'Fisk',
      ProductCategory.VEGETABLE_FRUIT: 'Frukt & Grönt',
      ProductCategory.COLD_DRINKS: 'Dryck',
      ProductCategory.BREAD: 'Bröd',
      ProductCategory.DAIRIES: 'Mejeri',
      ProductCategory.FLOUR_SUGAR_SALT: 'Skafferi',
      ProductCategory.POTATO_RICE: 'Kolhydrater',
      ProductCategory.PASTA: 'Pasta',
      ProductCategory.ROOT_VEGETABLE: 'Rotfrukt',
      ProductCategory.BERRY: 'Bär',
      ProductCategory.CITRUS_FRUIT: 'Citrus',
      ProductCategory.NUTS_AND_SEEDS: 'Nötter',
      ProductCategory.SWEET: 'Sött',
      ProductCategory.CABBAGE: 'Kål',
      ProductCategory.MELONS: 'Melon',
      ProductCategory.EXOTIC_FRUIT: 'Exotisk frukt',
      ProductCategory.POD: 'Baljväxter',
      ProductCategory.HERB: 'Ört',
      ProductCategory.HOT_DRINKS: 'Varm dryck',
      ProductCategory.FRUIT: 'Frukt',
      // Lägg till fler om du vill
    };

    // Skapa rader med 4 kategorier per rad
    List<Widget> categoryRows = [];
    for (int i = 0; i < categories.length; i += 4) {
      final rowCategories = categories.skip(i).take(4).toList();
      categoryRows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: rowCategories.map((cat) {
            return Padding(
              padding: EdgeInsets.only(
                  right: rowCategories.last == cat ? 0 : AppTheme.paddingHuge),
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Kategorisida(categoryNames[cat] ?? cat.name),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      overlayColor: Colors.transparent,
                      foregroundColor: Colors.transparent,
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 180,
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                            image: DecorationImage(
                              image: AssetImage(
                                categoryImages[cat] ??
                                    'assets/images/$cat.jpg', // fallback
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Text(
                          categoryNames[cat] ?? cat.name,
                          style: AppTheme.smallheader,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      );
      categoryRows.add(SizedBox(height: AppTheme.paddingLarge));
    }

    return Column(
      children: [
        SizedBox(height: AppTheme.paddingSmall),
        Container(
          //Main bild
          margin: EdgeInsets.symmetric(horizontal: 30),
          height: screenheight - 400,
          width: screenwidth - 315,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
            image: DecorationImage(
              image: AssetImage(
                'assets/images/glada_pension--rer.jpg',
              ),
              fit: BoxFit.cover,
            ),
          ),
          alignment: Alignment.center,
          child: Container(
            alignment: Alignment.bottomCenter,
            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'För att alla ska kunna handla online!',
                  style: TextStyle(
                    color: AppTheme.white,
                    fontSize: 40,
                  ),
                ),
                SizedBox(height: AppTheme.paddingMedium),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.ligtblue,
                    side: BorderSide(width: 0.5, color: Colors.black),
                    
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ListorPage()));
                  },
                  child: Text(
                    'Till dina listor',
                    style: TextStyle(
                      color: AppTheme.white,
                      fontSize: 40,
                    ),
                  ),
                ),
                SizedBox(height: AppTheme.paddingMedium),
              ],
            ),
          ),
        ),
        SizedBox(height: AppTheme.paddingLarge),
        ...categoryRows,
      ],
    );
  }
}