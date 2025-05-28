import 'package:flutter/material.dart';
import 'package:projekt_grupp34/model/imat/product.dart';
import 'package:projekt_grupp34/model/imat/shopping_item.dart';
import 'package:projekt_grupp34/model/imat_data_handler.dart';
import 'package:projekt_grupp34/app_theme.dart';
import 'package:projekt_grupp34/widgets/produkt_pop_up.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  const ProductCard(this.product, {super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int quantity = 0;

  void _showProductPopUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: const EdgeInsets.all(24),
        child: ProduktPopUp(product: widget.product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var iMat = Provider.of<ImatDataHandler>(context);
    final isFavorite = iMat.isFavorite(widget.product);
    final item = ShoppingItem(widget.product, amount: 1);


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
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      alignment: Alignment.center,
                      height: 125,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: iMat.getImage(widget.product),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: AppTheme.paddingTiny),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () => _showProductPopUp(context),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Text(
                        widget.product.name.isNotEmpty ? widget.product.name : 'Okänd produkt',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.product.name.isNotEmpty ? '${widget.product.price.toStringAsFixed(2)} ${widget.product.unit}' : 'Okänt pris',
                        style: const TextStyle(fontSize: 14),
                        textAlign: TextAlign.center,
                  ),
                      IconButton(
                        icon: Icon(Icons.info_rounded, color: Colors.black),
                        onPressed: () => _showProductPopUp(context),
                        iconSize: 16,
                        )
                    ],
                  ),
                ),
                SizedBox(height: AppTheme.paddingTiny),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    if (quantity == 0)
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
                            setState(() {
                              quantity = 1;
                            });
                            iMat.shoppingCartAdd(item);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${widget.product.name} har lagts till i din inköpslista!'),
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
                      )
                    else
                      Container(
                        width: 160,
                        height: 32,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppTheme.darkblue,

                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove, color: AppTheme.white),
                              onPressed: () {
                                setState(() {
                                  if (quantity > 1) {
                                    quantity--;
                                    iMat.shoppingCartUpdate(item, delta: -1);
                                  } else {
                                    quantity = 0;
                                    iMat.shoppingCartRemove(item);
                                  }
                                });
                              },
                            ),
                            SizedBox(width: 30,),
                            
                           Text(
                                '$quantity',
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white),
                              ),
                            SizedBox(width: 30,),
                            IconButton(
                              icon: const Icon(Icons.add, color: AppTheme.white),
                              onPressed: () {
                                setState(() {
                                  quantity++;
                                  iMat.shoppingCartAdd(item);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                  ],
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
                Icon(
                  isFavorite ? Icons.star : Icons.star,
                  color: Colors.white,
                  size: 32,
                ),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.star : Icons.star_border,
                    color: isFavorite ? Colors.amber : Colors.black,
                    size: 32,
                  ),
                  tooltip: isFavorite ? 'Ta bort från favoriter' : 'Lägg till som favorit',
                  onPressed: () {
                    iMat.toggleFavorite(widget.product);
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
