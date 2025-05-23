import 'package:flutter/material.dart';
import 'package:projekt_grupp34/widgets/simple_header.dart';
import 'package:projekt_grupp34/widgets/footer.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SimpleHeader(),
          Expanded(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 500),
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
          Footer(), // Footer längst ner
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
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildLeveranssatt() {
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
                backgroundColor: Colors.grey[200],
                foregroundColor: Colors.black,
                minimumSize: const Size(140, 40),
              ),
              onPressed: () {
                setState(() {
                  step = 1;
                });
              },
              child: const Text("Hemleverans"),
            ),
            const SizedBox(width: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[200],
                foregroundColor: Colors.black,
                minimumSize: const Size(140, 40),
              ),
              onPressed: () {
                setState(() {
                  step = 1;
                });
              },
              child: const Text("Upphämtning i butik"),
            ),
          ],
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          child: const Text("Tillbaka till startsidan"),
        ),
      ],
    );
  }

  Widget _buildOversikt() {
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
            children: const [
              Align(
                alignment: Alignment.centerLeft,
                child: Text("5x ägg.............................................50kr"),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("1x fil.................................................30kr"),
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: Text("Totalt: 330kr", style: TextStyle(fontWeight: FontWeight.bold)),
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
            Image.asset(
              "assets/images/bankid.png",
              height: 40,
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
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
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Image.asset(
          "assets/images/gubbe.png",
          height: 120,
        ),
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