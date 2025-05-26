import 'package:flutter/material.dart';
import 'package:projekt_grupp34/app_theme.dart';
import 'package:projekt_grupp34/model/imat_data_handler.dart';
import 'package:projekt_grupp34/pages/startsida.dart';
import 'package:provider/provider.dart';
import '../widgets/Header.dart'; // Lägg till denna import
import '../widgets/LeveranstiderGrid.dart';

class LeveranstiderPage extends StatefulWidget {
  const LeveranstiderPage({super.key});

  @override
  State<LeveranstiderPage> createState() => _LeveranstiderPageState();
}

class _LeveranstiderPageState extends State<LeveranstiderPage> {
  DateTime startDate = DateTime.now();

  void _showPreviousDays() {
    setState(() {
      startDate = startDate.subtract(const Duration(days: 3));
    });
  }

  void _showNextDays() {
    setState(() {
      startDate = startDate.add(const Duration(days: 3));
    });
  }

  @override
  Widget build(BuildContext context) {
    final imat = Provider.of<ImatDataHandler>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Header(),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 200,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppTheme.darkblue,
                  ),
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
              ),
            ),
            const SizedBox(height: 16),
            // Lägg till Center och Container här:
            Center(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 1000,
                ),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: LeveranstiderGrid(
                  onSelectSlot: (String slotValue) {
                    final imat = Provider.of<ImatDataHandler>(context, listen: false);
                    imat.setSelectedDeliveryTime(slotValue);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Leveranstid vald!")),
                    );
                    setState(() {});
                  },
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}