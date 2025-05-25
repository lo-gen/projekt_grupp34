import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:projekt_grupp34/app_theme.dart';
import 'package:projekt_grupp34/model/imat/order.dart';
import 'package:projekt_grupp34/model/imat/product.dart';
import 'package:projekt_grupp34/model/imat_data_handler.dart';
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

  Widget _buildListContent() {
    // Replace with your own logic for fetching items for each list type
    switch (selectedList) {
      case ListType.favoriter:
        return _buildItemsGrid('Favoriter');
      case ListType.inkopslistor:
        return _buildItemsGrid('Inköpslistor');
      case ListType.tidigareKop:
        return _buildItemsGrid('Tidigare köp');
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

  Widget showPreviousOrders(List<Order> orders) {
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
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: AppTheme.darkblue,
                      size: 28,
                    ),
                    onPressed: () {
                      setState(() {
                        orders.remove(order);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Order ${order.date.day} ${_monthName(order.date.month)} raderad!',
                            ),
                          ),
                        );
                        // NOTE!!! This does not delete the order from the database,
                        // it only removes it from the local list.
                      });
                    },
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
                            width: 300,
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
                                            trailing: Text(
                                              '${(item.product.price * item.amount).toStringAsFixed(2)} kr',
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


  Widget showPurchaseList(List<Order> orders) {
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
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: AppTheme.darkblue,
                      size: 28,
                    ),
                    onPressed: () {
                      setState(() {
                        orders.remove(order);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Order ${order.date.day} ${_monthName(order.date.month)} raderad!',
                            ),
                          ),
                        );
                        // NOTE!!! This does not delete the order from the database,
                        // it only removes it from the local list.
                      });
                    },
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
                            width: 300,
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
                                            trailing: Text(
                                              '${(item.product.price * item.amount).toStringAsFixed(2)} kr',
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

  Widget _buildItemsGrid(String listType) {
    var imat = context.watch<ImatDataHandler>();

    // Choose the correct list based on listType
    List<Product> products = [];
    List<Order> orders = [];

    //Main function to show the different lists
    if (listType == 'Favoriter') {
      products = imat.favorites;
      orders = []; // No orders for favorites
      if (products.isEmpty && orders.isEmpty) {
        return Center(child: Text('Det finns inga $listType sparade.'));
      }
      return showFavorites(products);
    } else if (listType == 'Inköpslistor') {
      products = [];
      //TODO - Byt ut imat.orders till sätt att ta inköpslistor!!
      //Se även till att "ta bort" knappen inom showPurchaseList
      //faktiskt gör detta i backend också!!!
      orders = imat.orders;

      return Column(
        children: [showPurchaseList(orders), SizedBox(height: 14)],
      );
    } else if (listType == 'Tidigare köp') {
      orders = imat.orders;
      products = [];

      return Column(
        children: [showPreviousOrders(orders), SizedBox(height: 14)],
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
                        children: [_buildListContent(), Footer()],
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
