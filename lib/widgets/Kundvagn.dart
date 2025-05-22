import 'package:flutter/material.dart';
import 'package:projekt_grupp34/model/imat_data_handler.dart';
import 'package:provider/provider.dart';
import 'delete_button.dart';

class KundvagnView extends StatelessWidget {
  const KundvagnView({super.key});

  @override
  Widget build(BuildContext context) {
    var dataHandler = context.watch<ImatDataHandler>();
    var items = dataHandler.getShoppingCart().items;

    return Column(
      children: [
        Expanded(
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
                          onPressed: item.amount > 1
                              ? () {
                                  dataHandler.shoppingCartRemove(item);
                                }
                              : null,
                        ),
                        Text('${item.amount}'),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            dataHandler.shoppingCartAdd(item);
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
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Navigera till betalsidan när den finns
                // Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutPage()));
              },
              child: const Text('Gå till kassan'),
            ),
          ),
        ),
      ],
    );
  }
}