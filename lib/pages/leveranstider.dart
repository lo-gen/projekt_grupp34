import 'package:flutter/material.dart';

class LeveranstiderPage extends StatefulWidget {
  const LeveranstiderPage({super.key});

  @override
  State<LeveranstiderPage> createState() => _LeveranstiderPageState();
}

class _LeveranstiderPageState extends State<LeveranstiderPage> {
  DateTime startDate = DateTime.now();

  // Exempeldata: lediga tider och priser
  final List<List<Map<String, dynamic>>> slots = List.generate(
    3, // 3 dagar
    (_) => [
      {'ledig': true, 'pris': 49},
      {'ledig': false, 'pris': 49},
      {'ledig': true, 'pris': 59},
      {'ledig': true, 'pris': 59},
      {'ledig': false, 'pris': 69},
    ],
  );

  final List<String> timeIntervals = [
    '08:00-10:00',
    '10:00-12:00',
    '12:00-14:00',
    '14:00-16:00',
    '16:00-18:00',
  ];

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
    // Byt ut mot din vanliga header om du har en separat widget för det!
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // Ersätt med din logga om du har en bild
            const Icon(Icons.local_shipping),
            const SizedBox(width: 8),
            const Text('Leveranstider'),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text('Tillbaka till startsidan'),
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
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Table(
                border: TableBorder.all(),
                defaultColumnWidth: const FixedColumnWidth(120.0),
                children: [
                  // Header-rad med datum
                  TableRow(
                    children: [
                      const TableCell(
                        child: Center(child: Text('Tid', style: TextStyle(fontWeight: FontWeight.bold))),
                      ),
                      for (int day = 0; day < 3; day++)
                        TableCell(
                          child: Center(
                            child: Text(
                              // Formatera datum: t.ex. "Mån 27/05"
                              "${weekdays[(startDate.add(Duration(days: day)).weekday - 1) % 7]} "
                              "${startDate.add(Duration(days: day)).day.toString().padLeft(2, '0')}/"
                              "${startDate.add(Duration(days: day)).month.toString().padLeft(2, '0')}",
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                    ],
                  ),
                  // Rader för varje tidsintervall
                  for (int i = 0; i < timeIntervals.length; i++)
                    TableRow(
                      children: [
                        TableCell(
                          child: Center(child: Text(timeIntervals[i])),
                        ),
                        for (int day = 0; day < 3; day++)
                          TableCell(
                            child: Center(
                              child: slots[day][i % 5]['ledig']
                                  ? Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.check_circle, color: Colors.green),
                                        Text('${slots[day][i % 5]['pris']} kr'),
                                      ],
                                    )
                                  : const Icon(Icons.cancel, color: Colors.red),
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}