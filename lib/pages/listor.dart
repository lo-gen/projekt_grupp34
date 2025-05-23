import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:projekt_grupp34/model/imat/order.dart';
import 'package:projekt_grupp34/model/imat/product.dart';
import 'package:projekt_grupp34/model/imat_data_handler.dart';
import 'package:projekt_grupp34/pages/kategorisida.dart';
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
          color: isSelected ? Colors.black : Colors.black.withOpacity(0.4),
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

  Widget favorites(List<Product> products) {
    // Show a grid of ProductCards (Should only be displayed for favorites)
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 0.7,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(products[index]);
        },
      ),
    );
  }

  Widget _buildItemsGrid(String listType) {
    var imat = context.watch<ImatDataHandler>();

    // Choose the correct list based on listType
    List<Product> products = [];
    List<Order> orders = [];

    if (listType == 'Favoriter') {
      products = imat.favorites;
      orders = []; // No orders for favorites
      if (products.isEmpty && orders.isEmpty) {
        return Center(child: Text('Det finns inga $listType sparade.'));
      }

      return favorites(products);
    } else if (listType == 'Inköpslistor') {
      products = [];
      //TODO - Byt ut imat.orders till sätt att ta inköpslistor
      orders = imat.orders;

      return Padding(
        //TEMPORARY THINGY!!!!!!!!!
        //TODO - skapa widget för att visa ordrar och
        //inköpslistor (kan vara samma widget)
        //Tänker sedan att man gör en popup som innehåller
        //lista med varje produkt som finns med i ordern
        //och med en knapp för att lägga till i varukorg (också knapp för
        //att lägga till hela order i varukorg)

        //TODO - Se till att nedan Padding bara visas när Favorites är selectad.
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
        child: Text("Temporary thingy for orders"),
      );
    } else if (listType == 'Tidigare köp') {
      orders = imat.orders;
      products = [];

      return Padding(
        //TEMPORARY THINGY!!!!!!!!!
        //TODO - skapa widget för att visa ordrar och
        //inköpslistor (kan vara samma widget)
        //Tänker sedan att man gör en popup som innehåller
        //lista med varje produkt som finns med i ordern
        //och med en knapp för att lägga till i varukorg (också knapp för
        //att lägga till hela order i varukorg)

        //TODO - Se till att nedan Padding bara visas när Favorites är selectad.
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
        child: Text("Temporary thingy for orders"),
      );
    } else {
      products = []; // Default case
      orders = []; // Default case
      return Padding(
        //TEMPORARY THINGY!!!!!!!!!
        //TODO - skapa widget för att visa ordrar och
        //inköpslistor (kan vara samma widget)
        //Tänker sedan att man gör en popup som innehåller
        //lista med varje produkt som finns med i ordern
        //och med en knapp för att lägga till i varukorg (också knapp för
        //att lägga till hela order i varukorg)

        //TODO - Se till att nedan Padding bara visas när Favorites är selectad.
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
        child: Text("Temporary thingy for nothing selected"),
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
            // Tabs
            Padding(
              padding: const EdgeInsets.only(
                top: 32.0,
                left: 32.0,
                bottom: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 100,
                children: [
                  _buildTab('Favoriter', ListType.favoriter),
                  _buildTab('Inköpslistor', ListType.inkopslistor),
                  _buildTab('Tidigare Köp', ListType.tidigareKop),
                ],
              ),
            ),
            const Divider(thickness: 1),
            // List content
            Expanded(child: SingleChildScrollView(child: _buildListContent())),
          ],
        ),
      ),
    );
  }
}
