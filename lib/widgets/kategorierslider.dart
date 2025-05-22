import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projekt_grupp34/app_theme.dart';
import 'package:projekt_grupp34/model/imat/product.dart';
import 'package:projekt_grupp34/model/imat_data_handler.dart';
import 'package:projekt_grupp34/pages/kategorisida.dart';

class Kategorierslider extends StatelessWidget {
  const Kategorierslider({super.key});

  @override
  Widget build(BuildContext context) {
    var imat = context.watch<ImatDataHandler>();
    final categories = imat.products
        .map((p) => p.category)
        .toSet()
        .where((cat) => cat != ProductCategory.UNDEFINED)
        .toList()
      ..sort((a, b) => a.index.compareTo(b.index));

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
    };

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 220,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: AppTheme.paddingTiny,),
                  Text(
                    'Kategorier',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                  ),
                ]
              ),
              SizedBox(height: AppTheme.paddingTiny),
              if (categories.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                )
              else
                ...categories.map((cat) => InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Kategorisida(categoryNames[cat] ?? cat.name),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                    child: Text(
                      categoryNames[cat] ?? cat.name,
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                )),
            ],
          ),
        ),
      ],
    );
  }
}