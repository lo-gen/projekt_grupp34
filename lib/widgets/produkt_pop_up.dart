import 'package:flutter/material.dart';
import 'package:projekt_grupp34/app_theme.dart';
import 'package:projekt_grupp34/model/imat/product.dart';
import 'package:projekt_grupp34/model/imat/shopping_item.dart';
import 'package:projekt_grupp34/widgets/shoppingLists.dart';
import 'package:provider/provider.dart';
import 'package:projekt_grupp34/model/imat_data_handler.dart';
import 'package:projekt_grupp34/model/imat/product_detail.dart';

class ProduktPopUp extends StatefulWidget {
  final Product product;
  const ProduktPopUp({super.key, required this.product});

  @override
  State<ProduktPopUp> createState() => _ProduktPopUpState();
}

class _ProduktPopUpState extends State<ProduktPopUp> {
  @override
  Widget build(BuildContext context) {
    var iMat = Provider.of<ImatDataHandler>(context);
    final ProductDetail? detail = iMat.getDetail(widget.product);

    return Container(
      width: 650,
      height: 450,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Make the whole popup scrollable
          SingleChildScrollView(
            child: Column(
              
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: AppTheme.paddingSmall),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: AppTheme.paddingTiny),
                    // Bilden till vänster
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox(
                        width: 200,
                        height: 200,
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
                          //const SizedBox(height: 24),
                          Text(widget.product.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text(
                            detail != null && detail.brand.isNotEmpty
                                ? 'Produkt från ${detail.brand}'
                                : 'Inget varumärke tillgänglig',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Text('Pris: ${widget.product.price.toStringAsFixed(2)} ${widget.product.unit}', style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 4),
                          if (widget.product.isEcological)
                            Text('${widget.product.name} är ekologisk', style: const TextStyle(fontSize: 16))
                          else
                            Text('${widget.product.name} är inte ekologisk', style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 4),
                          Text(
                            detail != null && detail.origin.isNotEmpty
                                ? 'Ursprung: ${detail.origin}'
                                : 'Ursprung saknas',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 100),
                          Row(
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.darkblue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {
                                  final item = ShoppingItem(widget.product);
                                  iMat.shoppingCartAdd(item);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('${widget.product.name} har lagts till i din inköpslista!'),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                },
                                child: const Text(
                                  '    Lägg till    ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: AppTheme.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 130),
                              IconButton(
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
                              SizedBox(width: AppTheme.paddingTiny),
                              // Knapp för att lägga till i inköpslista
                              IconButton(
                                icon: const Icon(Icons.assignment, size: 32, color: AppTheme.darkblue),
                                tooltip: 'Lägg till i inköpslista',
                                onPressed: () {
                                  // Lägg till funktionalitet här om det behövs
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      content: SingleChildScrollView( child: SizedBox(
                                        width: 1000,
                                        child: ShoppingLists(selectedItemProduct: widget.product),
                                      ), )
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ],
                ),
                //const SizedBox(height: 16),
                // ExpansionTiles under raden men i samma column


                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Innehållsförteckning
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Innehållsförteckning', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(
                              detail != null && detail.contents.isNotEmpty
                                  ? detail.contents
                                  : 'Innehållsförteckning saknas',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Produktbeskrivning
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Produktbeskrivning', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(
                              detail != null && detail.description.isNotEmpty
                                  ? detail.description
                                  : 'Beskrivning saknas',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppTheme.paddingMedium),
              ],
            ),
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