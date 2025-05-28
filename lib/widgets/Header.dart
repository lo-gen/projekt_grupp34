import 'package:flutter/material.dart';
import 'package:projekt_grupp34/app_theme.dart';
import 'package:projekt_grupp34/pages/kontosida.dart';
import 'package:projekt_grupp34/pages/leveranstider.dart';
import 'package:projekt_grupp34/pages/listor.dart';
import 'package:projekt_grupp34/widgets/Kundvagn.dart';
import 'package:projekt_grupp34/widgets/Logo.dart';
import 'package:provider/provider.dart';
import 'package:projekt_grupp34/model/imat_data_handler.dart';
import 'package:projekt_grupp34/pages/sökresultat.dart'; // <-- Lägg till denna import

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  final TextEditingController _searchController = TextEditingController();

  void _onSearch(String query) {
    if (query.trim().isEmpty) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Searchresult(query: query),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Container(
      color: AppTheme.darkblue,  //header
      width: screenwidth, 
      height: 130,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Logo(),
          const SizedBox(width: 100),
          Expanded(
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Sök efter produkter här',
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _onSearch(_searchController.text),
                ),
              ),
              onSubmitted: _onSearch,
            ),
          ),
          const SizedBox(width: 100),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 170,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.ligtblue,
                        side: const BorderSide(width: 0.5, color: Colors.white),
                        elevation: 8,
                        shadowColor: Colors.black54,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LeveranstiderPage()));
                      }, 
                      child: const Text('Lev. tider', style: TextStyle(fontSize: 26, color: Colors.white)),
                    ), 
                  ),
                  SizedBox(width: AppTheme.paddingSmall,), 
                  SizedBox(
                    width: 170,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.ligtblue,
                        side: const BorderSide(width: 0.5, color: Colors.white),
                        elevation: 8,
                        shadowColor: Colors.black54,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Kontosida()));
                      }, 
                      child: const Text('Konto', style: TextStyle(fontSize: 26, color: Colors.white)),
                    ), 
                  ),
                ],
              ),
              SizedBox(height: AppTheme.paddingSmall,),
              Row(
                children: [
                  SizedBox(
                    width: 170,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.ligtblue,
                        side: const BorderSide(width: 0.5, color: Colors.white),
                        elevation: 8,
                        shadowColor: Colors.black54,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ListorPage()));
                      }, 
                      child: Text('Listor & Köp', style: TextStyle(fontSize: 26, color: AppTheme.white)),
                    ), 
                  ), 
                  SizedBox(width: AppTheme.paddingSmall,), 
                  SizedBox(
                    width: 170,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.ligtblue,
                        side: const BorderSide(width: 0.5, color: Colors.white),
                        elevation: 8,
                        shadowColor: Colors.black54,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (dialogContext) {
                            double screenHeight = MediaQuery.of(context).size.height;
                            return Align(
                              alignment: Alignment.centerRight,
                              child: Material(
                                color: Colors.transparent,
                                child: SizedBox(
                                  width: 400,
                                  height: screenHeight,
                                  child: Container(
                                    color: Colors.white,
                                    child: KundvagnView(),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: const Text('Varukorg', style: TextStyle(fontSize: 26, color: Colors.white)),
                    ), 
                  ),                       
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}