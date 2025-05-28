import 'package:flutter/material.dart';
import 'package:projekt_grupp34/app_theme.dart';
import 'package:projekt_grupp34/model/imat/product.dart';
import 'package:projekt_grupp34/widgets/product_card.dart';

class ShowFavorites extends StatelessWidget {
   ShowFavorites({
    super.key,
    required this.products,
  });

   List<Product> products;

  @override
  Widget build(BuildContext context) {
    // Show a grid of ProductCards (Should only be displayed for favorites)
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(children: [SizedBox(height: AppTheme.paddingSmall)]),

              Padding(
                padding: EdgeInsets.all(16),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ProductCard(products[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}