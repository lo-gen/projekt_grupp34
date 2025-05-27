import 'package:flutter/material.dart';
import 'package:projekt_grupp34/app_theme.dart';
import 'package:projekt_grupp34/model/imat/product.dart';
import 'package:projekt_grupp34/model/imat/shopping_item.dart';
import 'package:projekt_grupp34/model/imat_data_handler.dart';
import 'package:provider/provider.dart';

class ShoppingLists extends StatelessWidget {
  final Product selectedItemProduct;

  const ShoppingLists({super.key, required this.selectedItemProduct});

  @override
  Widget build(BuildContext context) {
    var lists = Provider.of<ImatDataHandler>(context).getExtras();
    var imat = Provider.of<ImatDataHandler>(context);
    print('ShoppingLists: $lists');

    final newShoppingItem = ShoppingItem(selectedItemProduct, amount: 1);

    selectedItemProduct;

    ProductCategory parseProductCategory(String? category) {
      if (category == null) {
        throw ArgumentError('Category cannot be null');
      }
      switch (category.toUpperCase()) {
        case 'BREAD':
          return ProductCategory.BREAD;
        case 'POD':
          return ProductCategory.POD;
        case 'BERRY':
          return ProductCategory.BERRY;
        case 'CITRUS_FRUIT':
          return ProductCategory.CITRUS_FRUIT;
        case 'HOT_DRINKS':
          return ProductCategory.HOT_DRINKS;
        case 'COLD_DRINKS':
          return ProductCategory.COLD_DRINKS;
        case 'EXOTIC_FRUIT':
          return ProductCategory.EXOTIC_FRUIT;
        case 'FISH':
          return ProductCategory.FISH;
        case 'VEGETABLE_FRUIT':
          return ProductCategory.VEGETABLE_FRUIT;
        case 'CABBAGE':
          return ProductCategory.CABBAGE;
        case 'MEAT':
          return ProductCategory.MEAT;
        case 'DAIRIES':
          return ProductCategory.DAIRIES;
        case 'MELONS':
          return ProductCategory.MELONS;
        case 'FLOUR_SUGAR_SALT':
          return ProductCategory.FLOUR_SUGAR_SALT;
        case 'NUTS_AND_SEEDS':
          return ProductCategory.NUTS_AND_SEEDS;
        case 'PASTA':
          return ProductCategory.PASTA;
        case 'POTATO_RICE':
          return ProductCategory.POTATO_RICE;
        case 'ROOT_VEGETABLE':
          return ProductCategory.ROOT_VEGETABLE;
        case 'FRUIT':
          return ProductCategory.FRUIT;
        case 'SWEET':
          return ProductCategory.SWEET;
        case 'HERB':
          return ProductCategory.HERB;
        case 'UNDEFINED':
          return ProductCategory.UNDEFINED;
        default:
          throw ArgumentError('Unknown category: $category');
      }
    }

    return Column (children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Text(
          'Välj inköpslista att lägga till ${selectedItemProduct.name} i:',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppTheme.darkestblue,
          ),
        ),
      ),
      Column(
      children: 
          lists.entries.map<Widget>((entry) {
            final listName = entry.key;
            print('entries: $entry');
            print('entry.value: ${entry.value}');

            // Convert items by MANUALLY creating ShoppingItem objects
            final List<ShoppingItem> items = [];
            if (entry.value is List) {
              final jsonItems = entry.value as List;

              for (int i = 0; i < jsonItems.length; i++) {
                try {
                  if (jsonItems[i] is ShoppingItem) {
                    // Already a ShoppingItem (happens during hot reload)
                    items.add(jsonItems[i]);
                  } else if (jsonItems[i] is Map) {
                    final itemMap = jsonItems[i] as Map;

                    if (itemMap['product'] is Map) {
                      try {
                        final productMap = Map<String, dynamic>.from(
                          itemMap['product'],
                        );
                        print(
                          'productMap: $productMap',
                        ); // Debug print to inspect the productMap

                        // Manually create a Product object
                        final product = Product(
                          productMap['productId'] ?? 0,
                          parseProductCategory(productMap['category']),
                          productMap['name'] ?? 'Unknown',
                          productMap['isEcological'] ?? false,

                          productMap['price'],
                          productMap['unit'] ?? '',
                          productMap['imageName'] ?? '',
                        );

                        // Manually create a ShoppingItem with the product
                        final amount =
                            (itemMap['amount'] is int)
                                ? (itemMap['amount'] as int).toDouble()
                                : itemMap['amount']?.toDouble() ?? 1.0;

                        final shoppingItem = ShoppingItem(
                          product,
                          amount: amount,
                        );
                        items.add(shoppingItem);
                      } catch (e) {
                        print('Error manually creating item at index $i: $e');
                        if (itemMap['product'] is Map) {
                          print(
                            'Problematic productMap: ${itemMap['product']}',
                          );
                        }
                      }
                    }
                  }
                } catch (e) {
                  print('Error manually creating item at index $i: $e');
                  if (jsonItems[i] is Map) {
                    print('Problematic item: ${jsonItems[i]}');
                  }
                }
              }
            }

            print('listName: $listName');
            print('items: $items');

            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppTheme.darkblue.withOpacity(0.05),
                    radius: 32,
                    child: Icon(
                      Icons.assignment,
                      color: AppTheme.darkblue,
                      size: 36,
                    ),
                  ),
                  title: Text(
                    listName, // Use the map key as the title
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.darkestblue,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${items.length} olika varor',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppTheme.darkestblue,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Totalkostnad: ${items.fold<double>(0, (sum, item) => sum + (item.product.price * item.amount)).toStringAsFixed(2)} kr',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppTheme.darkestblue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          final List<ShoppingItem> allItems =
                              List<ShoppingItem>.from(items);
                          allItems.add(newShoppingItem);
                          imat.addExtra(listName, allItems);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${newShoppingItem.product.name} har lagts till i listan "$listName"!',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: AppTheme.white,
                                ),
                              ),
                              duration: Duration(seconds: 2),
                              backgroundColor: AppTheme.darkblue,
                              behavior: SnackBarBehavior.fixed,

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                          Navigator.of(context).pop();
                          // Now you can use itemsToAdd as a list of ShoppingItem
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.darkblue,
                          foregroundColor: AppTheme.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 24,
                              
                              color: AppTheme.white,
                            ),
                            children: [
                              TextSpan(text: 'Lägg till '),
                              TextSpan(
                                text: '${selectedItemProduct.name}',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: ' i listan '),
                              TextSpan(
                                text: listName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                ),
              ),
            );
          }).toList(),
    ),],
      );
  }
}
