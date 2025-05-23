import 'package:flutter/material.dart';
import 'package:projekt_grupp34/model/imat/product.dart';
import 'package:projekt_grupp34/model/imat/shopping_item.dart';
import 'package:projekt_grupp34/model/imat_data_handler.dart';
import 'package:projekt_grupp34/app_theme.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    var iMat = Provider.of<ImatDataHandler>(context);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.only(bottom: 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: 125,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: iMat.getImage(product),
              ),
            ),
            SizedBox(height: AppTheme.paddingSmall),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                product.name.isNotEmpty ? product.name : 'Okänd produkt',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: AppTheme.paddingTiny),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                product.name.isNotEmpty ? '${product.price.toStringAsFixed(2)} ${product.unit}' : 'Okänt pris',
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: AppTheme.paddingTiny),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.darkblue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  final item = ShoppingItem(product);
                  iMat.shoppingCartAdd(item);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product.name} har lagts till i din inköpslista!'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                child: Text(
                  '    Lägg till    ',
                  style: TextStyle(
                    fontSize: 20,
                    color: AppTheme.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
