import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/imat_data_handler.dart';
import '../app_theme.dart';

class LeveranstiderGrid extends StatelessWidget {
  final DateTime startDate;
  final Function onSelectSlot;
  final List<String> timeIntervals;
  final List<List<Map<String, dynamic>>> slots;

  const LeveranstiderGrid({
    super.key,
    required this.startDate,
    required this.onSelectSlot,
    required this.timeIntervals,
    required this.slots,
  });

  @override
  Widget build(BuildContext context) {
    const weekdays = ['Mån', 'Tis', 'Ons', 'Tor', 'Fre', 'Lör', 'Sön'];
    final imat = Provider.of<ImatDataHandler>(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Table(
        border: TableBorder.all(),
        defaultColumnWidth: const FixedColumnWidth(180.0),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
            children: [
              const TableCell(
                child: Center(
                  child: Text(
                    'Tid',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ),
              ),
              for (int day = 0; day < 3; day++)
                TableCell(
                  child: Center(
                    child: Text(
                      "${weekdays[(startDate.add(Duration(days: day)).weekday - 1) % 7]} "
                      "${startDate.add(Duration(days: day)).day.toString().padLeft(2, '0')}/"
                      "${startDate.add(Duration(days: day)).month.toString().padLeft(2, '0')}",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                  ),
                ),
            ],
          ),
          for (int i = 0; i < timeIntervals.length; i++)
            TableRow(
              children: [
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Center(
                      child: Text(
                        timeIntervals[i],
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                for (int day = 0; day < 3; day++)
                  TableCell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Center(
                        child: slots[day][i]['ledig']
                            ? InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () {
                                  String slotValue =
                                      "${startDate.add(Duration(days: day)).toIso8601String()} ${timeIntervals[i]}";
                                  onSelectSlot(slotValue);
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
                                      size: 40,
                                    ),
                                    Text(
                                      '${slots[day][i]['pris']} kr',
                                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )
                            : const Icon(Icons.cancel, color: Colors.red, size: 40),
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}