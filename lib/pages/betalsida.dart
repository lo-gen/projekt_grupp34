import 'package:flutter/material.dart';
import 'package:projekt_grupp34/app_theme.dart';
import 'package:projekt_grupp34/model/imat_data_handler.dart';
import 'package:projekt_grupp34/pages/startsida.dart';
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
  final TextEditingController korttypController = TextEditingController();
  final TextEditingController namnController = TextEditingController();
  final TextEditingController manadController = TextEditingController();
  final TextEditingController arController = TextEditingController();
  final TextEditingController kortnummerController = TextEditingController();
  final TextEditingController cvcController = TextEditingController();

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
  void initState() {
    super.initState();
    final imat = Provider.of<ImatDataHandler>(context, listen: false);
    final card = imat.getCreditCard();
    if (card.cardNumber.isNotEmpty) {
      korttypController.text = card.cardType;
      namnController.text = card.holdersName;
      manadController.text = card.validMonth.toString().padLeft(2, '0');
      arController.text = card.validYear.toString().padLeft(2, '0');
      kortnummerController.text = card.cardNumber;
      cvcController.text = card.verificationCode.toString().padLeft(3, '0');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SimpleHeader()),
          SliverToBoxAdapter(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            
           Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 16.0),
              child: Align(
                alignment: Alignment.topLeft,
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
          
         Column(
              children: [ Container(
                constraints: const BoxConstraints(maxWidth: 1000),
                padding: const EdgeInsets.all(24),
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
              ]
            ),
          
        ],
      ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 50)),
            SliverFillRemaining(
            hasScrollBody: false,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Footer(),
            ),
            ),
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

    final newStartDate = leveransStartDate.subtract(const Duration(days: 3));
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
                    selectedType == "hem" ? Colors.green : const Color(0xFF3F4257),
                foregroundColor: Colors.black,
                minimumSize: const Size(200, 40),
              ),
              onPressed: () {
                imat.setSelectedDeliveryType("hem");
                setState(() {});
              },
              child: const Text("Hemleverans", style: TextStyle(color: AppTheme.white),),
            ),
            const SizedBox(width: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedType == "upphämtning"
                    ? Colors.green
                    : const Color(0xFF3F4257),
                foregroundColor: Colors.black,
                minimumSize: const Size(200, 40),
              ),
              onPressed: () {
                imat.setSelectedDeliveryType("upphämtning");
                setState(() {});
              },
              child: const Text("Upphämtning i butik", style: TextStyle(color: AppTheme.white),),
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
        
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 790,),
            if (selectedDeliveryTime != null && selectedDeliveryTime.isNotEmpty)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    step = 1;
                  });
                },
                child: const Text("Fortsätt", style: TextStyle(fontSize: 30, color: AppTheme.white),),
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
          color: Colors.grey[200],
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
                      child: 
                      Column(
                        children: [
                      Text(
                        "${item.amount}x ${item.product.name} - ${(item.product.price * item.amount).toStringAsFixed(2)} kr",
                      ),
                      const SizedBox(height: 10),
                        ],
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
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.darkblue,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  step = 0;
                });
              },
              child: const Text("Gå tillbaka", style: TextStyle(fontSize: 30, color: AppTheme.white),),
            ),
            const SizedBox(width: 600),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  step = 2;
                });
              },
              child: const Text("Fortsätt", style: TextStyle(fontSize: 30, color: AppTheme.white),),
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
          controller: korttypController,
          decoration: const InputDecoration(labelText: "Korttyp"),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: namnController,
          decoration: const InputDecoration(labelText: "Namn på kortet"),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: manadController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Månad (MM)"),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: arController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "År (YY)"),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: kortnummerController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: "Kortnummer"),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: cvcController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: "Verifikationskod (CVC)"),
        ),
        const SizedBox(height: 16),
          
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 2,),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.darkblue,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            setState(() {
              step = 1;
            });
          },
          child: const Text("Gå tillbaka", style: TextStyle(fontSize: 30, color: AppTheme.white),),
        ),
        const SizedBox(width: 400),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                var imat = Provider.of<ImatDataHandler>(context, listen: false);
                imat.placeOrder();
                setState(() {
                  step = 3;
                });
              },
              child: const Text("Identifiera med bank-ID", style: TextStyle(fontSize: 30, color: AppTheme.white),),
            ),
      ],
        ),
      ]
    );
  }

  Widget _buildBekraftelse() {
    return Column(
      children: [
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.green,
          ),
          width: double.infinity,
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
        
        Image.asset("assets/images/thumbsup.jpg", height: 250),

        Text('Kvitto skickas till din e-postadress',
            style: TextStyle(fontSize: 24, color: Colors.black)),

        const SizedBox(height: AppTheme.paddingHuge),
        
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.darkblue,
            foregroundColor: Colors.white,
            minimumSize: const Size(300, 60),
          ),
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          child: const Text("Tack för att du handlar hos oss!", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
        ),
      ],
    );
  }
}
