import 'package:flutter/material.dart';
import 'package:projekt_grupp34/app_theme.dart';
import 'package:projekt_grupp34/model/imat/product.dart';
import 'package:projekt_grupp34/model/imat/shopping_item.dart';
import 'package:projekt_grupp34/model/imat_data_handler.dart';
import 'package:projekt_grupp34/pages/startsida.dart';
import 'package:projekt_grupp34/widgets/Header.dart';
import 'package:projekt_grupp34/widgets/footer.dart';
import 'package:projekt_grupp34/widgets/showfavorites.dart';
import 'package:provider/provider.dart';

class FavoriterPage extends StatelessWidget {
  const FavoriterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var imat = context.watch<ImatDataHandler>();
    List<Product> products = imat.favorites;

    return Scaffold(
      backgroundColor: AppTheme.white,
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
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.darkestblue,
                            decoration: TextDecoration.underline,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 8.0,
                            ),
                            child: Text("Favoriter"),
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

            // Only this part scrolls
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ShowFavorites(products: products),

                    Footer(), // This stays at the bottom
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
