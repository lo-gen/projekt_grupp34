import 'package:flutter/material.dart';
import 'package:projekt_grupp34/app_theme.dart';
import 'package:projekt_grupp34/model/imat_data_handler.dart';
import 'package:projekt_grupp34/pages/startsida.dart';
import 'package:provider/provider.dart';
import '../widgets/Header.dart'; // Lägg till denna import

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

    // Generera tider: 08:00-08:30, 08:30-09:00, ..., 17:30-18:00
    List<String> timeIntervals = [];
    for (int h = 10; h < 17; h++) {
      timeIntervals.add('${h.toString().padLeft(2, '0')}:00-${h.toString().padLeft(2, '0')}:30');
      timeIntervals.add('${h.toString().padLeft(2, '0')}:30-${(h+1).toString().padLeft(2, '0')}:00');
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
                  onPressed: _showPreviousDays,
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
            // Nu är bara tabellen horisontellt skrollbar, hela sidan är vertikalt skrollbar
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Table(
                border: TableBorder.all(),
                defaultColumnWidth: const FixedColumnWidth(140.0),
                children: [
                  TableRow(
                    children: [
                      const TableCell(
                        child: Center(child: Text('Tid', style: TextStyle(fontWeight: FontWeight.bold))),
                      ),
                      for (int day = 0; day < 3; day++)
                        TableCell(
                          child: Center(
                            child: Text(
                              "${weekdays[(startDate.add(Duration(days: day)).weekday - 1) % 7]} "
                              "${startDate.add(Duration(days: day)).day.toString().padLeft(2, '0')}/"
                              "${startDate.add(Duration(days: day)).month.toString().padLeft(2, '0')}",
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                    ],
                  ),
                  for (int i = 0; i < timeIntervals.length; i++)
                    TableRow(
                      children: [
                        TableCell(
                          child: Center(child: Text(timeIntervals[i])),
                        ),
                        for (int day = 0; day < 3; day++)
                          TableCell(
                            child: Center(
                              child: slots[day][i]['ledig']
                                  ? InkWell(
                                      borderRadius: BorderRadius.circular(8),
                                      onTap: () {
                                        String slotValue =
                                            "${startDate.add(Duration(days: day)).toIso8601String()} ${timeIntervals[i]}";
                                        imat.setSelectedDeliveryTime(slotValue);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text("Leveranstid vald!")),
                                        );
                                        setState(() {});
                                      },
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            imat.selectedDeliveryTime ==
                                                    "${startDate.add(Duration(days: day)).toIso8601String()} ${timeIntervals[i]}"
                                                ? Icons.check_circle
                                                : Icons.radio_button_unchecked,
                                            color: imat.selectedDeliveryTime ==
                                                    "${startDate.add(Duration(days: day)).toIso8601String()} ${timeIntervals[i]}"
                                                ? Colors.amber
                                                : Colors.green,
                                          ),
                                          Text('${slots[day][i]['pris']} kr'),
                                        ],
                                      ),
                                    )
                                  : const Icon(Icons.cancel, color: Colors.red),
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}