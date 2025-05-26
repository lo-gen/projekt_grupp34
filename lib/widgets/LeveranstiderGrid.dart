import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/imat_data_handler.dart';
import '../app_theme.dart';

class LeveranstiderGrid extends StatefulWidget {
  final Function(String) onSelectSlot;

  const LeveranstiderGrid({
    super.key,
    required this.onSelectSlot,
  });

  @override
  State<LeveranstiderGrid> createState() => _LeveranstiderGridState();
}

class _LeveranstiderGridState extends State<LeveranstiderGrid> {
  DateTime startDate = DateTime.now();

  List<String> get timeIntervals {
    List<String> intervals = [];
    for (int h = 8; h <= 16; h += 2) {
      if (h + 2 <= 18) {
        intervals.add('${h.toString().padLeft(2, '0')}:00-${(h + 2).toString().padLeft(2, '0')}:00');
      }
    }
    return intervals;
  }

  List<List<Map<String, dynamic>>> get slots {
    return List.generate(
      3,
      (_) => List.generate(
        timeIntervals.length,
        (i) => {
          'ledig': true,
          'pris': 39 + (i % 3) * 10,
        },
      ),
    );
  }

  void _showPreviousDays() {
    final newStartDate = startDate.subtract(const Duration(days: 3));
    final today = DateTime.now();
    final newStartDateDateOnly = DateTime(newStartDate.year, newStartDate.month, newStartDate.day);
    final todayDateOnly = DateTime(today.year, today.month, today.day);

    if (!newStartDateDateOnly.isBefore(todayDateOnly)) {
      setState(() {
        startDate = newStartDate;
      });
    }
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

    final newStartDate = startDate.subtract(const Duration(days: 3));
    final today = DateTime.now();
    final newStartDateDateOnly = DateTime(newStartDate.year, newStartDate.month, newStartDate.day);
    final todayDateOnly = DateTime(today.year, today.month, today.day);
    final canGoBack = !newStartDateDateOnly.isBefore(todayDateOnly);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: canGoBack ? _showPreviousDays : null,
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
        // Rubrikrad
        Row(
          children: [
            const SizedBox(width: 110, child: Text('Tid', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
            for (int day = 0; day < 3; day++)
              Expanded(
                child: Center(
                  child: Text(
                    "${weekdays[(startDate.add(Duration(days: day)).weekday - 1) % 7]} "
                    "${startDate.add(Duration(days: day)).day.toString().padLeft(2, '0')}/"
                    "${startDate.add(Duration(days: day)).month.toString().padLeft(2, '0')}",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        // Tidsrader
        for (int i = 0; i < timeIntervals.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                SizedBox(
                  width: 110,
                  child: Text(
                    timeIntervals[i],
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                for (int day = 0; day < 3; day++)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: slots[day][i]['ledig']
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: imat.selectedDeliveryTime ==
                                        "${startDate.add(Duration(days: day)).toIso8601String()} ${timeIntervals[i]}"
                                    ? AppTheme.selectedGreen
                                    : Colors.grey[100],
                                foregroundColor: Colors.black,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                              onPressed: () {
                                String slotValue =
                                    "${startDate.add(Duration(days: day)).toIso8601String()} ${timeIntervals[i]}";
                                widget.onSelectSlot(slotValue);
                              },
                              child: Center(
                                child: Text(
                                  '${slots[day][i]['pris']} kr',
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          : Container(
                              height: 44,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Icon(Icons.cancel, color: Colors.red, size: 22),
                              ),
                            ),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}