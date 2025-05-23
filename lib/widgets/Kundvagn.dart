import 'package:flutter/material.dart';
import 'package:projekt_grupp34/model/imat/shopping_item.dart';
import 'package:projekt_grupp34/model/imat_data_handler.dart';
import 'package:projekt_grupp34/pages/betalsida.dart';
import 'package:provider/provider.dart';
import 'delete_button.dart';
import 'package:projekt_grupp34/app_theme.dart'; // Lägg till denna import högst upp

class KundvagnView extends StatelessWidget {
  const KundvagnView({super.key});

  @override
  Widget build(BuildContext context) {
    var dataHandler = context.watch<ImatDataHandler>();
    var items = dataHandler.getShoppingCart().items;

    return Column(
      children: [
        // Header med titel och stäng-knapp
        Container(
          color: AppTheme.darkblue, // Ändrad till mörkblå
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Kundvagn (${items.fold<int>(0, (sum, item) => sum + (item.amount as int))} varor)',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Gör rubriken vit för kontrast
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                tooltip: 'Stäng',
                color: Colors.white, // Gör även krysset vitt
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: Scrollbar(
            thumbVisibility: true, // Gör scrollbaren alltid synlig (valfritt)
            child: ListView(
              children: [
                for (final item in items)
                  Card(
                    child: ListTile(
                      leading: SizedBox(
                        width: 48,
                        height: 48,
                        child: dataHandler.getImage(item.product),
                      ),
                      title: Text(item.product.name),
                      subtitle: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              dataHandler.shoppingCartUpdate(
                                item,
                                delta: -1,
                              );
                            },
                          ),
                          Text('${item.amount}'),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              dataHandler.shoppingCartAdd(
                                ShoppingItem(item.product, amount: 1)
                              );
                            },
                          ),
                        ],
                      ),
                      trailing: DeleteButton(
                        onPressed: () {
                          dataHandler.shoppingCartRemove(item);
                        },
                      ),
                    ),
                  ),
                if (items.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Kundvagnen är tom.'),
                    ),
                  ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.ligtblue,
                foregroundColor: AppTheme.white, // Gör texten vit
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Betalsida()));
              },
              child: const Text('Gå till kassan'),
            ),
          ),
        ),
      ],
    );
  }
}