import 'package:flutter/material.dart';
import 'package:projekt_grupp34/model/imat/product.dart';
import 'package:projekt_grupp34/model/imat/shopping_item.dart';
import 'package:projekt_grupp34/model/imat_data_handler.dart';
import 'package:projekt_grupp34/app_theme.dart';
import 'package:projekt_grupp34/widgets/produkt_pop_up.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard(this.product, {super.key});

  void _showProductPopUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(24),
        child: ProduktPopUp(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var iMat = Provider.of<ImatDataHandler>(context);

    final isFavorite = iMat.isFavorite(product);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => _showProductPopUp(context),
                  child: 
                  MouseRegion(
                  cursor: SystemMouseCursors.click,
                    child: 
                Container(
                  alignment: Alignment.center,
                  height: 125,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: iMat.getImage(product),
                  ),
                ),
                  ),
                ),
                SizedBox(height: AppTheme.paddingSmall),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: 
                  GestureDetector(
                    onTap: () => _showProductPopUp(context),
                    child:
                    MouseRegion(
                    cursor: SystemMouseCursors.click,
                      child:  
                  Text(
                    product.name.isNotEmpty ? product.name : 'Okänd produkt',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                    ),
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
          // FAVORITKNAPP UPPE HÖGER
          Positioned(
            top: 4,
            right: 4,
            child: Stack(
              alignment: Alignment.center,
              children: [
              // Background icon (not a button)
              Icon(
                isFavorite ? Icons.star : Icons.star,
                color: Colors.white,
                size: 32,
              ),
              // Foreground icon button
              IconButton(
                icon: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                color: isFavorite ? Colors.amber : Colors.black,
                size: 32,
                ),
                tooltip: isFavorite ? 'Ta bort från favoriter' : 'Lägg till som favorit',
                onPressed: () {
                iMat.toggleFavorite(product);
                },
              ),
              ],
            ),
            ),
          
        ],
      ),
    );
  }
}
