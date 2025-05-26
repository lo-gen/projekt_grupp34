import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:projekt_grupp34/app_theme.dart';
import 'package:projekt_grupp34/model/imat/order.dart';
import 'package:projekt_grupp34/model/imat/product.dart';
import 'package:projekt_grupp34/model/imat/shopping_item.dart';
import 'package:projekt_grupp34/model/imat_data_handler.dart';
import 'package:projekt_grupp34/model/internet_handler.dart';
import 'package:projekt_grupp34/pages/kategorisida.dart';
import 'package:projekt_grupp34/pages/startsida.dart';
import 'package:projekt_grupp34/widgets/Header.dart';
import 'package:projekt_grupp34/widgets/footer.dart';
import 'package:projekt_grupp34/widgets/kategorierslider.dart';
import 'package:projekt_grupp34/widgets/product_card.dart';
import 'package:projekt_grupp34/widgets/startsida_bild_och_kategorier.dart';
import 'package:provider/provider.dart';

class ListorPage extends StatefulWidget {
  const ListorPage({Key? key}) : super(key: key);

  @override
  State<ListorPage> createState() => _ListorPageState();
}

enum ListType { favoriter, inkopslistor, tidigareKop }

class _ListorPageState extends State<ListorPage> {
  ListType selectedList = ListType.favoriter;

  Widget _buildTab(String title, ListType type) {
    final bool isSelected = selectedList == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedList = type;
        });
      },
      child: AnimatedDefaultTextStyle(
        duration: const Duration(milliseconds: 200),
        style: TextStyle(
          fontSize: isSelected ? 36 : 28,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color:
              isSelected
                  ? AppTheme.darkestblue
                  : AppTheme.darkestblue.withOpacity(0.4),
          decoration:
              isSelected ? TextDecoration.underline : TextDecoration.none,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Text(title),
        ),
      ),
    );
  }

  Widget _buildListContent(ImatDataHandler imat) {
    // Replace with your own logic for fetching items for each list type
    switch (selectedList) {
      case ListType.favoriter:
        return _buildItemsGrid('Favoriter', imat);
      case ListType.inkopslistor:
        return _buildItemsGrid('Inköpslistor', imat);
      case ListType.tidigareKop:
        return _buildItemsGrid('Tidigare köp', imat);
    }
  }

  Widget showFavorites(List<Product> products) {
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
    );
  }

  Widget showPreviousOrders(List<Order> orders, ImatDataHandler imat) {
    return Column(
      children:
          orders.map((order) {
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
                    '${order.date.day} ${_monthName(order.date.month)}',
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
                          '${order.items.length} varor',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppTheme.darkestblue,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          style: TextStyle(
                            fontSize: 18,
                            color: AppTheme.darkestblue,
                          ),
                          '${order.items.fold<double>(0, (sum, item) => sum + (item.product.price * item.amount)).toStringAsFixed(2)} kr',
                        ),
                      ],
                    ),
                  ),

                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  onTap: () {
                    showDialog(
                      context: context,

                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: AppTheme.white,
                          title: Text(
                            'Köp ifrån den ${order.date.day} ${_monthName(order.date.month)}:',
                            textAlign: TextAlign.center,
                          ),
                          content: SizedBox(
                            width: 450,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: order.items.length,
                                    itemBuilder: (context, idx) {
                                      final item = order.items[idx];
                                      return Column(
                                        children: [
                                          ListTile(
                                            title: Text(item.product.name),
                                            subtitle: Text('${item.amount} st'),
                                            trailing: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  '${(item.product.price * item.amount).toStringAsFixed(2)} kr',
                                                ),
                                                SizedBox(width: 16),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    imat.shoppingCartAdd(item);
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        AppTheme.darkblue,
                                                    foregroundColor:
                                                        AppTheme.white,
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 16,
                                                          vertical: 8,
                                                        ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            8,
                                                          ),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    'lägg till',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          // Add a Divider below each ListTile
                                          Divider(
                                            thickness: 1,
                                            color: Colors.grey[300],
                                            height: 1,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'Total kostnad: ${order.items.fold<double>(0, (sum, item) => sum + (item.product.price * item.amount)).toStringAsFixed(2)} kr',
                                  ),
                                ],
                              ),
                            ),
                          ),

                          actions: [
                            TextButton(
                              child: Text('Stäng'),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget inkapsLista(listName, items, imat, context) {
    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: AppTheme.white,
                          title: Text(
                            'Inköpslista: $listName',
                            textAlign: TextAlign.center,
                          ),
                          content: SizedBox(
                            width: 450,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: items.length,
                                    itemBuilder: (context, idx) {
                                      final item = items[idx];
                                      return Column(
                                        children: [
                                          ListTile(
                                            title: Text(item.product.name),
                                            subtitle: Text('${item.amount} st'),
                                            trailing: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  '${(item.product.price * item.amount).toStringAsFixed(2)} kr',
                                                ),
                                                SizedBox(width: 16),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    imat.shoppingCartAdd(item);
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        AppTheme.darkblue,
                                                    foregroundColor:
                                                        AppTheme.white,
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 16,
                                                          vertical: 8,
                                                        ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            8,
                                                          ),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    'lägg till',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.delete, color: Colors.red),
                                                  tooltip: 'Ta bort vara',
                                                  onPressed: () {
                                                    items.removeAt(idx);
                                                    imat.addExtra(listName, List<ShoppingItem>.from(items));
                                                    setState(() {});
                                                    
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          Divider(
                                            thickness: 1,
                                            color: Colors.grey[300],
                                            height: 1,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'Total kostnad: ${items.fold<double>(0, (sum, item) => sum + (item.product.price * item.amount)).toStringAsFixed(2)} kr',
                                  ),
                                ],
                              ),
                            ),
                          ),
                            actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              TextButton(
                                child: Text('Stäng'),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                              TextButton(
                                child: Text('Byt namn'),
                                onPressed: () {
                                final renameController =
                                  TextEditingController(text: listName);
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                  title: Text('Byt namn på inköpslista'),
                                  content: TextField(
                                    controller: renameController,
                                    autofocus: true,
                                  ),
                                  actions: [
                                    TextButton(
                                    onPressed: () =>
                                      Navigator.of(context).pop(),
                                    child: Text('Avbryt'),
                                    ),
                                    ElevatedButton(
                                    onPressed: () {
                                      final newName =
                                        renameController.text.trim();
                                      if (newName.isNotEmpty &&
                                        newName != listName) {
                                      final items =
                                        imat.getExtras()[listName];
                                      if (items != null) {
                                        imat.removeExtra(listName);
                                        imat.addExtra(
                                        newName,
                                        items,
                                        );
                                      }
                                      }
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Spara'),
                                    ),
                                  ],
                                  ),
                                );
                                },
                              ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                    return Container(); // Return an empty container if this function is called
  }


  Widget showPurchaseList(Map<String, dynamic> lists, ImatDataHandler imat) {
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

    return Column(
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
                          '${items.length} varor',
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
                          for (var item in items) {
                            imat.shoppingCartAdd(item);
                          }
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
                        child: const Text(
                          'lägg till listan i kundvagn',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        tooltip: 'Ta bort listan',
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder:
                                (context) => AlertDialog(
                                  title: Text('Ta bort inköpslista'),
                                  content: Text(
                                    'Är du säker på att du vill ta bort listan "$listName"?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed:
                                          () => Navigator.of(context).pop(),
                                      child: Text('Avbryt'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        imat.removeExtra(listName);
                                        Navigator.of(context).pop();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                      ),
                                      child: Text('Ta bort'),
                                    ),
                                  ],
                                ),
                          );
                        },
                      ),
                    ],
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 16,
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: AppTheme.white,
                          title: Text(
                            'Inköpslista: $listName',
                            textAlign: TextAlign.center,
                          ),
                          content: SizedBox(
                            width: 450,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: items.length,
                                    itemBuilder: (context, idx) {
                                      final item = items[idx];
                                      return Column(
                                        children: [
                                          ListTile(
                                            title: Text(item.product.name),
                                            subtitle: Text('${item.amount} st'),
                                            trailing: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  '${(item.product.price * item.amount).toStringAsFixed(2)} kr',
                                                ),
                                                SizedBox(width: 16),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    imat.shoppingCartAdd(item);
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        AppTheme.darkblue,
                                                    foregroundColor:
                                                        AppTheme.white,
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 16,
                                                          vertical: 8,
                                                        ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            8,
                                                          ),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    'lägg till',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.delete, color: Colors.red),
                                                  tooltip: 'Ta bort vara',
                                                  onPressed: () {
                                                    items.removeAt(idx);
                                                    imat.addExtra(listName, List<ShoppingItem>.from(items));
                                                    setState(() {});
                                                    //TODO Eventuellt försöka få listan att förbli öppen
                                                    Navigator.of(context).pop(); 
                                                    
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          Divider(
                                            thickness: 1,
                                            color: Colors.grey[300],
                                            height: 1,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'Total kostnad: ${items.fold<double>(0, (sum, item) => sum + (item.product.price * item.amount)).toStringAsFixed(2)} kr',
                                  ),
                                ],
                              ),
                            ),
                          ),
                            actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              TextButton(
                                child: Text('Stäng'),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                              TextButton(
                                child: Text('Byt namn'),
                                onPressed: () {
                                final renameController =
                                  TextEditingController(text: listName);
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                  title: Text('Byt namn på inköpslista'),
                                  content: TextField(
                                    controller: renameController,
                                    autofocus: true,
                                  ),
                                  actions: [
                                    TextButton(
                                    onPressed: () =>
                                      Navigator.of(context).pop(),
                                    child: Text('Avbryt'),
                                    ),
                                    ElevatedButton(
                                    onPressed: () {
                                      final newName =
                                        renameController.text.trim();
                                      if (newName.isNotEmpty &&
                                        newName != listName) {
                                      final items =
                                        imat.getExtras()[listName];
                                      if (items != null) {
                                        imat.removeExtra(listName);
                                        imat.addExtra(
                                        newName,
                                        items,
                                        );
                                      }
                                      }
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Spara'),
                                    ),
                                  ],
                                  ),
                                );
                                },
                              ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            );
          }).toList(),
    );
  }

  // Helper to get Swedish month name
  String _monthName(int month) {
    const months = [
      '',
      'jan',
      'feb',
      'mar',
      'apr',
      'maj',
      'jun',
      'jul',
      'aug',
      'sep',
      'okt',
      'nov',
      'dec',
    ];
    return months[month];
  }

  Widget _buildItemsGrid(String listType, ImatDataHandler imat) {
    // Choose the correct list based on listType
    List<Product> products = [];
    List<Order> orders = [];

    //Main function to show the different lists
    if (listType == 'Favoriter') {
      products = imat.favorites;
      orders = []; // No orders for favorites
      if (products.isEmpty && orders.isEmpty) {
        return Center(
          child: Text(
            'Det finns inga $listType sparade',
            style: TextStyle(fontSize: 24, color: AppTheme.darkestblue),
          ),
        );
      }
      return showFavorites(products);
    } else if (listType == 'Inköpslistor') {
      products = [];
      orders = imat.orders.reversed.toList();
      var extras = imat.getExtras();
      print('Extras: $extras');

      if (products.isEmpty && extras.isEmpty) {
        return Center(
          child: Text(
            'Det finns inga $listType sparade',
            style: TextStyle(fontSize: 24, color: AppTheme.darkestblue),
          ),
        );
      }

      return Column(
        children: [showPurchaseList(extras, imat), SizedBox(height: 14)],
      );
    } else if (listType == 'Tidigare köp') {
      orders = imat.orders.reversed.toList();
      products = [];

      if (products.isEmpty && orders.isEmpty) {
        return Center(
          child: Text(
            'Det finns inga $listType',
            style: TextStyle(fontSize: 24, color: AppTheme.darkestblue),
          ),
        );
      }

      return Column(
        children: [showPreviousOrders(orders, imat), SizedBox(height: 14)],
      );
    } else {
      products = []; // Default case
      orders = []; // Default case
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
        child: Text("If you see this, something went wrong!"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var imat = context.watch<ImatDataHandler>();

    return Scaffold(
      backgroundColor: const Color(0xFAF7F7F7),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SizedBox(
                width: double.infinity,
                height: 100,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Centered tabs
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: _buildTab(
                            'Inköpslistor',
                            ListType.inkopslistor,
                          ),
                        ),
                        SizedBox(width: 40),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: _buildTab('Favoriter', ListType.favoriter),
                        ),
                        SizedBox(width: 40),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: _buildTab(
                            'Tidigare Köp',
                            ListType.tidigareKop,
                          ),
                        ),
                      ],
                    ),
                    // Left-aligned back button
                    Positioned(
                      left: 16,
                      child: Container(
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
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
                    ),
                    Positioned(
                      right: 16,
                      child: Container(
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
                            final controller = TextEditingController();
                            showDialog(
                              context: context,
                              builder:
                                  (context) => AlertDialog(
                                    //Ändra titel och innehåll i dialogrutan
                                    title: Text('Namn på inköpslista:'),
                                    content: TextField(
                                      controller: controller,
                                      autofocus: true,
                                    ),
                                    actions: [
                                      //Avbryt och spara knappar
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Avbryt'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          
                                          imat.addExtra(controller.text, []);
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Spara'),
                                      ),
                                    ],
                                  ),
                            );
                          },
                          child: Center(
                            child: Text(
                              'Skapa ny inköpslista',
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
                    ),
                  ],
                ),
              ),
            ),
            const Divider(thickness: 1),
            // Rest of the page content & footer
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [_buildListContent(imat), Footer()],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
