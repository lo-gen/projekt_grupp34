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
    const weekdays = ['Mån', 'Tis', 'Ons', 'Tor', 'Fre', 'Lör', 'Sön'];
    final imat = Provider.of<ImatDataHandler>(context);

    // Generera tider: 08:00-10:00, 10:00-12:00, ..., 14:00-16:00
    List<String> timeIntervals = [];
    for (int h = 8; h < 16; h += 2) {
      timeIntervals.add('${h.toString().padLeft(2, '0')}:00-${(h + 2).toString().padLeft(2, '0')}:00');
    }

    final List<List<Map<String, dynamic>>> slots = List.generate(
      3,
      (_) => List.generate(
        timeIntervals.length,
        (i) => {
          'ledig': true,
          'pris': 39 + (i % 3) * 10,
        },
      ),
    );

    // Lägg till denna logik innan du bygger Row med pilarna:
    final newStartDate = startDate.subtract(const Duration(days: 3));
    final today = DateTime.now();
    final newStartDateDateOnly = DateTime(newStartDate.year, newStartDate.month, newStartDate.day);
    final todayDateOnly = DateTime(today.year, today.month, today.day);
    final canGoBack = !newStartDateDateOnly.isBefore(todayDateOnly);

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: canGoBack ? _showPreviousDays : null, // <-- Viktigt!
                ),
                const SizedBox(width: 8),
                const Text('Välj leveranstid', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: _showNextDays,
                ),
              ],
            ),
            const SizedBox(height: 16),
            LeveranstiderGrid(
              startDate: startDate,
              timeIntervals: timeIntervals,
              slots: slots,
              onSelectSlot: (String slotValue) {
                final imat = Provider.of<ImatDataHandler>(context, listen: false);
                imat.setSelectedDeliveryTime(slotValue);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Leveranstid vald!")),
                );
                setState(() {});
              },
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}