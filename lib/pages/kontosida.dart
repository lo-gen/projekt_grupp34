import 'package:flutter/material.dart';
import 'package:projekt_grupp34/app_theme.dart';
import 'package:projekt_grupp34/model/imat/customer.dart';
import 'package:projekt_grupp34/pages/startsida.dart';
import 'package:projekt_grupp34/widgets/Header.dart';
import 'package:projekt_grupp34/widgets/footer.dart';
import 'package:projekt_grupp34/model/imat_data_handler.dart';
import 'package:provider/provider.dart';

class Kontosida extends StatefulWidget {
  const Kontosida({Key? key}) : super(key: key);

  @override
  State<Kontosida> createState() => _KontosidaState();
}

class _KontosidaState extends State<Kontosida> {
  late Customer customer;
  late String firstName = "If you see this something went wrong - firstName";
  late String lastName = "If you see this something went wrong - lastName";
  late String email = "If you see this something went wrong - email";
  late String phone = "If you see this something went wrong - phone";
  late String address = "If you see this something went wrong - address";
  late String postal = "If you see this something went wrong - postal";
  late String postAddress =
      "If you see this something went wrong - postAddress";

  ///Metod för att öppna en dialogruta för att redigera information
  ///Triggeras när användaren trycker på "Ändra" knappen
  ///Tar emot en titel och en callback-funktion som körs när informationen ändras
  Future<void> _editInfo(String title, ValueChanged<String> onChanged) async {
    final controller = TextEditingController();
    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            //Ändra titel och innehåll i dialogrutan
            title: Text('Ändra $title'),
            content: TextField(controller: controller, autofocus: true),
            actions: [
              //Avbryt och spara knappar
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Avbryt'),
              ),
              ElevatedButton(
                onPressed: () {
                  onChanged(controller.text);
                  Navigator.pop(context);
                },
                child: const Text('Spara'),
              ),
            ],
          ),
    );
  }

  //Card widget för att visa information om kunden
  Widget _infoCard({
    required IconData icon,
    required String title,
    required String info,
    required VoidCallback onEdit,
  }) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 8),
            Icon(icon, size: 36, color: Colors.black87),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      decoration: TextDecoration.underline,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    info,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: onEdit,
              child: Row(
                children: const [
                  Icon(Icons.edit_outlined, color: Color(0xFF8B0000), size: 22),
                  SizedBox(width: 2),
                  Text(
                    "Ändra",
                    style: TextStyle(
                      color: Color(0xFF8B0000),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Setup för att hämta kundinformation ifrån server
    var dataHandler = context.watch<ImatDataHandler>();
    var customer = dataHandler.getCustomer();

    firstName = customer.firstName;
    lastName = customer.lastName;
    email = customer.email;
    phone = customer.mobilePhoneNumber;
    address = customer.address;
    postal = customer.postCode;
    postAddress = customer.postAddress;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF6F6),
      body: SafeArea(
        child: Column(
          children: [
            const Header(),

            Expanded(
              child: Container(
                color: const Color(0xFFFAF6F6),
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 34,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //"Dina uppgifter" rubrik
                            const SizedBox(height: 24),
                            const Text(
                              "Dina uppgifter",
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.underline,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),

                            //Container för kundens namn
                            Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.03),
                                    blurRadius: 2,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),

                              //Namn på kunden
                              child: Center(
                                child: Text(
                                  "${customer.firstName} ${customer.lastName}",
                                  style: const TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            //Container för kundens info:
                            //E-post, telefon, adress och postnummer
                            Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              child: Column(
                                children: [
                                  //Container epost
                                  _infoCard(
                                    icon: Icons.email_outlined,
                                    title: "E-post",
                                    info: email,
                                    onEdit:
                                        //Editar E-post både i databasen och i UI om den är giltig
                                        () => _editInfo("E-post", (val) {
                                          if (val.contains("@") &&
                                              val.contains(".")) {
                                            setState(() {
                                              customer.email = val;
                                              email = customer.email;
                                              ImatDataHandler().setCustomer(
                                                customer,
                                              );
                                            });
                                          }
                                          //Ger felmeddelande om e-post är ogiltig
                                          else {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'Ogiltig e-postadress',
                                                ),
                                              ),
                                            );
                                          }
                                        }),
                                  ),

                                  //Container telefon
                                  _infoCard(
                                    icon: Icons.phone_outlined,
                                    title: "Telefon",
                                    info: phone,
                                    onEdit:
                                        //Editar telefon både i databasen och i UI om den är giltig
                                        () => _editInfo("Telefon", (val) {
                                          if (val.isNotEmpty &&
                                              val.runes.every(
                                                (c) => c >= 48 && c <= 57,
                                              )) {
                                            setState(() {
                                              customer.mobilePhoneNumber = val;
                                              phone =
                                                  customer.mobilePhoneNumber;
                                              ImatDataHandler().setCustomer(
                                                customer,
                                              );
                                            });
                                          }
                                          //Ger felmeddelande om telefon är ogiltig
                                          else {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'Ogiltigt telefonnummer',
                                                ),
                                              ),
                                            );
                                          }
                                        }),
                                  ),

                                  //Container adress
                                  _infoCard(
                                    icon: Icons.home_outlined,
                                    title: "Address",
                                    info: address,
                                    onEdit:
                                        () => _editInfo("Address", (val) {
                                          //Editar adress både i databasen och i UI om den är giltig
                                          if (val.isNotEmpty) {
                                            setState(() {
                                              customer.address = val;
                                              address = customer.address;
                                              ImatDataHandler().setCustomer(
                                                customer,
                                              );
                                            });
                                          }
                                          //Ger felmeddelande om adress är ogiltig
                                          else {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text('Ogiltig adress'),
                                              ),
                                            );
                                          }
                                        }),
                                  ),

                                  //Container postnummer
                                  _infoCard(
                                    icon: Icons.location_on_outlined,
                                    title: "Postnummer",
                                    info: postal,
                                    onEdit:
                                        () => _editInfo("Postnummer", (val) {
                                          //Editar postnummer både i databasen och i UI om den är giltig
                                          if (val.length == 5 &&
                                              val.runes.every(
                                                (c) => c >= 48 && c <= 57,
                                              )) {
                                            setState(() {
                                              customer.postCode = val;
                                              postal = customer.postCode;
                                              ImatDataHandler().setCustomer(
                                                customer,
                                              );
                                            });
                                          }
                                          //Ger felmeddelande om postnummer är ogiltig
                                          else {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'Ogiltigt postnummer',
                                                ),
                                              ),
                                            );
                                          }
                                        }),
                                  ),

                                  //Container postadress
                                  _infoCard(
                                    icon: Icons.inbox_outlined,
                                    title: "Postaddress",
                                    info: postAddress,
                                    onEdit:
                                        () => _editInfo("Postaddress", (val) {
                                          //Editar adress både i databasen och i UI om den är giltig
                                          if (val.isNotEmpty) {
                                            setState(() {
                                              customer.postAddress = val;
                                              postAddress =
                                                  customer.postAddress;
                                              ImatDataHandler().setCustomer(
                                                customer,
                                              );
                                            });
                                          }
                                          //Ger felmeddelande om adress är ogiltig
                                          else {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'Ogiltig postadress',
                                                ),
                                              ),
                                            );
                                          }
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 100),
                            Footer(),
                            const SizedBox(height: 32),
                          ],
                        ),
                      ),
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ),
                                );
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
