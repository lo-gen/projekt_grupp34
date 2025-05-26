import 'package:flutter/material.dart';
import 'package:projekt_grupp34/model/imat_data_handler.dart';
import 'package:projekt_grupp34/widgets/simple_header.dart';
import 'package:projekt_grupp34/widgets/footer.dart';
import 'package:projekt_grupp34/widgets/LeveranstiderGrid.dart';
import 'package:provider/provider.dart';
import '../widgets/LeveranstiderGrid.dart';

class Betalsida extends StatefulWidget {
  const Betalsida({super.key});

  @override
  State<Betalsida> createState() => _BetalsidaState();
}

class _BetalsidaState extends State<Betalsida> {
  int step = 0;

  // Controllers för betalsteg
  final TextEditingController kontonummerController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController utgangsdatumController = TextEditingController();

  DateTime leveransStartDate = DateTime.now();

  void _showPreviousDays() {
    setState(() {
      leveransStartDate = leveransStartDate.subtract(const Duration(days: 3));
    });
  }

  void _showNextDays() {
    setState(() {
      leveransStartDate = leveransStartDate.add(const Duration(days: 3));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SimpleHeader()),
          SliverToBoxAdapter(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 1000),
                padding: const EdgeInsets.all(24),
                color: const Color(0xFFF9F7F7),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildStepper(),
                    const SizedBox(height: 24),
                    if (step == 0) _buildLeveranssatt(),
                    if (step == 1) _buildOversikt(),
                    if (step == 2) _buildBetala(),
                    if (step == 3) _buildBekraftelse(),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 50)),
          SliverToBoxAdapter(child: Footer()),
        ],
      ),
    );
  }

  Widget _buildStepper() {
    Color active = Colors.green;
    Color inactive = const Color(0xFF3F4257);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _stepButton("1. Leveranssätt", step == 0 ? active : inactive),
        const Icon(Icons.arrow_forward, size: 28),
        _stepButton("2. Översikt", step == 1 ? active : inactive),
        const Icon(Icons.arrow_forward, size: 28),
        _stepButton("3. Betala", step == 2 ? active : inactive),
      ],
    );
  }

  Widget _stepButton(String text, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildLeveranssatt() {
    final imat = Provider.of<ImatDataHandler>(context);
    String? selectedDeliveryTime = imat.selectedDeliveryTime;
    String? selectedType = imat.selectedDeliveryType;
    bool showTable = selectedType != null;

    final newStartDate = startDate.subtract(const Duration(days: 3));
    final today = DateTime.now();
    final newStartDateDateOnly = DateTime(newStartDate.year, newStartDate.month, newStartDate.day);
    final todayDateOnly = DateTime(today.year, today.month, today.day);
    final canGoBack = !newStartDateDateOnly.isBefore(todayDateOnly);

    return Column(
      children: [
        const SizedBox(height: 16),
        const Text("Välj ditt leveranssätt:", style: TextStyle(fontSize: 18)),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    selectedType == "hem" ? Colors.green : Colors.grey[200],
                foregroundColor: Colors.black,
                minimumSize: const Size(140, 40),
              ),
              onPressed: () {
                imat.setSelectedDeliveryType("hem");
                setState(() {});
              },
              child: const Text("Hemleverans"),
            ),
            const SizedBox(width: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedType == "upphämtning"
                    ? Colors.green
                    : Colors.grey[200],
                foregroundColor: Colors.black,
                minimumSize: const Size(140, 40),
              ),
              onPressed: () {
                imat.setSelectedDeliveryType("upphämtning");
                setState(() {});
              },
              child: const Text("Upphämtning i butik"),
            ),
          ],
        ),
        const SizedBox(height: 24),
        if (showTable)
          LeveranstiderGrid(
            onSelectSlot: (String slotValue) {
              imat.setSelectedDeliveryTime(slotValue);
              setState(() {});
            },
          ),
        const SizedBox(height: 32),
        if (selectedDeliveryTime != null && selectedDeliveryTime.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Vald leveranstid: $selectedDeliveryTime",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text("Tillbaka till startsidan"),
            ),
            const SizedBox(width: 16),
            if (selectedDeliveryTime != null && selectedDeliveryTime.isNotEmpty)
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    step = 1;
                  });
                },
                child: const Text("Fortsätt"),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildOversikt() {
    final imat = Provider.of<ImatDataHandler>(context);
    final cart = imat.getShoppingCart();
    final items = cart.items;
    final total = items.fold<double>(
      0,
      (sum, item) => sum + (item.product.price * item.amount),
    );

    return Column(
      children: [
        const SizedBox(height: 16),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text("Dina artiklar:", style: TextStyle(fontSize: 18)),
        ),
        const SizedBox(height: 16),
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              if (items.isEmpty)
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Kundvagnen är tom."),
                )
              else
                ...items.map((item) => Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${item.amount}x ${item.product.name} - ${(item.product.price * item.amount).toStringAsFixed(2)} kr",
                      ),
                    )),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Totalt: ${total.toStringAsFixed(2)} kr",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  step = 0;
                });
              },
              child: const Text("Gå tillbaka"),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  step = 2;
                });
              },
              child: const Text("Fortsätt"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBetala() {
    return Column(
      children: [
        const SizedBox(height: 16),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text("Betala", style: TextStyle(fontSize: 18)),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: kontonummerController,
          decoration: const InputDecoration(labelText: "Kontonummer"),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: cvvController,
          decoration: const InputDecoration(labelText: "CVV2"),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: utgangsdatumController,
          decoration: const InputDecoration(labelText: "Utgångsdatum"),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Image.asset("assets/images/bankid.png", height: 40),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                var imat = Provider.of<ImatDataHandler>(context, listen: false);
                imat.placeOrder();
                setState(() {
                  step = 3;
                });
              },
              child: const Text("Identifiera med bank-ID"),
            ),
          ],
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            setState(() {
              step = 1;
            });
          },
          child: const Text("Gå tillbaka"),
        ),
      ],
    );
  }

  Widget _buildBekraftelse() {
    return Column(
      children: [
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          color: Colors.green,
          padding: const EdgeInsets.all(8),
          child: const Center(
            child: Text(
              "Betalning genomförd!",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Image.asset("assets/images/gubbe.png", height: 120),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          child: const Text("Återgå till startsidan"),
        ),
      ],
    );
  }
}
