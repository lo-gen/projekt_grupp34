import 'package:flutter/material.dart';
import 'package:projekt_grupp34/app_theme.dart';
import 'package:projekt_grupp34/model/imat/product.dart';
import 'package:projekt_grupp34/pages/startsida.dart';
import 'package:projekt_grupp34/widgets/Header.dart';
import 'package:projekt_grupp34/widgets/footer.dart';
import 'package:projekt_grupp34/widgets/product_card.dart';
import 'package:projekt_grupp34/model/imat_data_handler.dart';
import 'package:projekt_grupp34/widgets/kategorierslider.dart';
import 'package:provider/provider.dart';

class Kategorisida extends StatefulWidget {
  final String category;

  const Kategorisida(this.category, {super.key});

  @override
  State<Kategorisida> createState() => _KategorisidaState();
}

class _KategorisidaState extends State<Kategorisida> {
  ProductCategory? _productCategory;
  List<Product> _products = [];
  bool _loading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final imat = Provider.of<ImatDataHandler>(context);
    _productCategory = _mapCategoryName(widget.category);

    if (_productCategory != null && imat.products.isNotEmpty) {
      setState(() {
        _products = imat.findProductsByCategory(_productCategory!);
        _loading = false;
      });
    } else if (imat.products.isEmpty) {
      setState(() {
        _loading = true;
      });
    }
  }

  // Mappa sträng till rätt ProductCategory
  ProductCategory? _mapCategoryName(String name) {
    final lower = name.toLowerCase();
    for (final cat in ProductCategory.values) {
      if (cat.name.toLowerCase() == lower) return cat;
    }
    // Manuella alias för svenska namn
    switch (lower) {
      case 'kött':
        return ProductCategory.MEAT;
      case 'fisk':
        return ProductCategory.FISH;
      case 'grönt':
      case 'frukt & grönt':
        return ProductCategory.VEGETABLE_FRUIT;
      case 'dryck':
        return ProductCategory.COLD_DRINKS;
      case 'bröd':
        return ProductCategory.BREAD;
      case 'mejeri':
        return ProductCategory.DAIRIES;
      case 'skafferi':
        return ProductCategory.FLOUR_SUGAR_SALT;
      case 'kolhydrater':
        return ProductCategory.POTATO_RICE;
      case 'pasta':
        return ProductCategory.PASTA;
      case 'rotfrukt':
        return ProductCategory.ROOT_VEGETABLE;
      case 'bär':
        return ProductCategory.BERRY;
      case 'citrus':
        return ProductCategory.CITRUS_FRUIT;
      case 'nötter':
        return ProductCategory.NUTS_AND_SEEDS;
      case 'sött':
        return ProductCategory.SWEET;
      case 'kål':
        return ProductCategory.CABBAGE;
      case 'melon':
        return ProductCategory.MELONS;
      case 'exotisk frukt':
        return ProductCategory.EXOTIC_FRUIT;
      case 'pod':
        return ProductCategory.POD;
      case 'ört':
        return ProductCategory.HERB;
      case 'varm dryck':
        return ProductCategory.HOT_DRINKS;
      case 'frukt':
        return ProductCategory.FRUIT;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;

    if (_productCategory == null) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.category)),
        body: Center(child: Text('Ingen sådan kategori!')),
      );
    }
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.category)),
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: StickyHeaderDelegate(
              child: Header(),
              height: 130,
              width: screenwidth,
            ),
          ),
          _products.isEmpty
              ? SliverToBoxAdapter(
                  child: Center(
                      child: Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Text('Inga produkter i denna kategori.'),
                  )),
                )
              : SliverToBoxAdapter(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: AppTheme.paddingSmall,
                          ),
                          Container(
                            width: 200,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: AppTheme.darkblue,
                            ),
                            alignment: Alignment.center,
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
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 6,
                              childAspectRatio: 0.75,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                            ),
                            itemCount: _products.length,
                            itemBuilder: (context, index) {
                              return ProductCard(_products[index]);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          SliverToBoxAdapter(child: Footer()),
        ],
      ),
    );
  }
}