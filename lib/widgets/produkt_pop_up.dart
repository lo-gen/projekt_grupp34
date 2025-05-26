import 'package:flutter/material.dart';
import 'package:projekt_grupp34/app_theme.dart';
import 'package:projekt_grupp34/model/imat/product.dart';
import 'package:projekt_grupp34/model/imat/shopping_item.dart';
import 'package:provider/provider.dart';
import 'package:projekt_grupp34/model/imat_data_handler.dart';

class ProduktPopUp extends StatefulWidget {
  final Product product;
  const ProduktPopUp({super.key, required this.product});

  @override
  State<ProduktPopUp> createState() => _ProduktPopUpState();
}

class _ProduktPopUpState extends State<ProduktPopUp> {
  @override
  Widget build(BuildContext context) {
    final iMat = Provider.of<ImatDataHandler>(context); // listen: true by default

    return Container(
      width: 600,
      height: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              SizedBox(width: AppTheme.paddingTiny),
              // Bilden till vänster
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 140,
                  height: 140,
                  child: iMat.getImage(widget.product),
                ),
              ),
              const SizedBox(width: 32),
              // Info och knapp till höger
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    Text(widget.product.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Text('Pris: ${widget.product.price} kr', style: const TextStyle(fontSize: 18)),
                    if (widget.product.isEcological) 
                      Text('${widget.product.name} är ekologisk', style: const TextStyle(fontSize: 16))
                    else
                      Text('${widget.product.name} är inte ekologisk', style: const TextStyle(fontSize: 16)),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(widget.product.category.name.toLowerCase(), style: const TextStyle(fontSize: 15)),
                    ),
                    // Favoritstjärna
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: IconButton(
                        icon: Icon(
                          iMat.isFavorite(widget.product) ? Icons.star : Icons.star_border,
                          color: iMat.isFavorite(widget.product) ? Colors.amber : Colors.black,
                          size: 32,
                        ),
                        tooltip: iMat.isFavorite(widget.product) ? 'Ta bort från favoriter' : 'Lägg till som favorit',
                        onPressed: () {
                          iMat.toggleFavorite(widget.product);
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        final item = ShoppingItem(widget.product);
                        iMat.shoppingCartAdd(item);
                        Navigator.pop(context);
                      },
                      child: const Text('Lägg till'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Stäng-kryss uppe till höger
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: const Icon(Icons.close, size: 28),
              onPressed: () => Navigator.pop(context),
              tooltip: 'Stäng',
            ),
          ),
        ],
      ),
    );
  }
}