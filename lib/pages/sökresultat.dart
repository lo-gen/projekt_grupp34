import 'package:flutter/material.dart';
import 'package:projekt_grupp34/app_theme.dart';
import 'package:projekt_grupp34/model/imat/product.dart';
import 'package:projekt_grupp34/pages/startsida.dart';
import 'package:projekt_grupp34/widgets/Header.dart';
import 'package:projekt_grupp34/widgets/footer.dart';
import 'package:projekt_grupp34/widgets/product_card.dart';
import 'package:projekt_grupp34/model/imat_data_handler.dart';
import 'package:provider/provider.dart';
import 'package:projekt_grupp34/widgets/kategorierslider.dart';

class Searchresult extends StatelessWidget {
  final String query;
  const Searchresult({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    final imat = Provider.of<ImatDataHandler>(context);
    final List<Product> products = imat.findProducts(query);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: StickyHeaderDelegate(
              child: Header(),
              height: 130,
              width: screenwidth,
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    SizedBox(height: 20,),
                    Container(
                      width: 200,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppTheme.darkblue,
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                        },
                        child: Center(
                          child: Text(
                            'Tillbaka till Startsida',
                            style: TextStyle(
                              fontSize: 28,
                              color: AppTheme.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Kategorierslider(),
                  ],
                ),
                
                SizedBox(width: 16), // Liten mellanrum mellan slider och produkter
                // Produkter och rubrik
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16, left: 0, bottom: 16),
                        child: Text(
                          "Sökresultat för: \"$query\"",
                          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                      ),
                      products.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(top: 40, left: 16),
                              child: Text('Inga produkter matchar din sökning.'),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(16),
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 6,
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
            ),
          ),
          SliverToBoxAdapter(child: const SizedBox(height: 100)),
          SliverToBoxAdapter(child: Footer()),
        ],
      ),
    );
  }
}

// StickyHeaderDelegate för att kunna använda Header som sliver
class StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double height;
  final double width;

  StickyHeaderDelegate({
    required this.child,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      width: width,
      height: height,
      child: child,
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}