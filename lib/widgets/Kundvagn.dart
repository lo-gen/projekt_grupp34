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
          height: 130,
          color: AppTheme.darkblue, // Ändrad till mörkblå
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Kundvagn (${items.fold<int>(0, (sum, item) => sum + (item.amount as int))} varor)',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    tooltip: 'Stäng',
                    color: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                style: ButtonStyle(
                  mouseCursor: MaterialStateProperty.resolveWith<MouseCursor>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered)) {
                        return SystemMouseCursors.click;
                      }
                      return SystemMouseCursors.basic;
                    },
                  ),
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered)) {
                        return AppTheme.darkblue; // Färg vid hover
                      }
                      return AppTheme.ligtblue; // Standardfärg
                    },
                  ),
                  foregroundColor: MaterialStateProperty.all(AppTheme.white),
                  padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 24, vertical: 10)),
                  textStyle: MaterialStateProperty.all(const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
                onPressed: () {
                  dataHandler.addExtra("shoppinglist", List<ShoppingItem>.from(items));
                },
                child: const Text('Lägg till som inköpslista'),
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10), // Justera värdet för mer/mindre rundning
                          child: dataHandler.getImage(item.product),
                        ),
                      ),
                      title: Text(
                        item.product.name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '${(item.product.price * item.amount).toStringAsFixed(2)} kr',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 16), // Luft till höger om priset
                              ],
                            ),
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
        // Lägg till detta innan Padding med knappen
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Totalt:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${items.fold<double>(0, (sum, item) => sum + (item.product.price * item.amount)).toStringAsFixed(2)} kr',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.ligtblue,
                foregroundColor: AppTheme.white,
                minimumSize: const Size(0, 56), // Gör knappen högre (t.ex. 56 px)
                textStyle: const TextStyle(
                  fontSize: 20, // Större text
                  fontWeight: FontWeight.bold,
                ),
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