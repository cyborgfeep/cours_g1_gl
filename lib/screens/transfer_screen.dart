import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class OperationScreen extends StatefulWidget {
  final bool isTransfer;

  const OperationScreen({super.key, required this.isTransfer});

  @override
  State<OperationScreen> createState() => _OperationScreenState();
}

class _OperationScreenState extends State<OperationScreen> {
  List<Contact> filteredContacts = [];
  List<Contact> contacts = [];

  @override
  void initState() {
    getContacts();
    super.initState();
  }

  getContacts() async {
    if (await FlutterContacts.requestPermission()) {
      /* contacts = await FlutterContacts.getContacts();
      print("Contacts ${contacts.length}");*/
    }
    contacts = await FlutterContacts.getContacts(withProperties: true);
    contacts.removeWhere((element) => element.phones.isEmpty);
    contacts.removeWhere(
        (element) => !element.phones[0].normalizedNumber.startsWith("+221"));
    filteredContacts.addAll(contacts);
    setState(() {});
    print("Contacts ${contacts.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.isTransfer ? "Envoyer de l'argent" : "Achat de crédit"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: "A",
                ),
                onChanged: (value) {
                  setState(() {
                    if (value.isEmpty) {
                      filteredContacts.clear();
                      filteredContacts.addAll(contacts);
                    } else {
                      filteredContacts.clear();
                      filteredContacts.addAll(contacts
                          .where(
                            (element) =>
                                element.displayName
                                    .toLowerCase()
                                    .contains(value.toLowerCase()) ||
                                element.phones[0].normalizedNumber
                                    .toLowerCase()
                                    .contains(value.toLowerCase()),
                          )
                          .toList());
                    }
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(45)),
                      child: const Icon(
                        Icons.add_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        widget.isTransfer
                            ? "Envoyer à un nouveau numéro"
                            : "Achat du crédit pour un nouveau numéro",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Contacts",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                itemCount:
                    filteredContacts.length > 50 ? 50 : filteredContacts.length,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  String number = filteredContacts[index]
                      .phones[0]
                      .normalizedNumber
                      .replaceAll("+221", "");
                  Color color = number.startsWith("76")
                      ? Colors.blue.shade900
                      : number.startsWith("70")
                          ? Colors.deepPurple
                          : Colors.orange;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        widget.isTransfer
                            ? Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(45)),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey.shade600,
                                  size: 25,
                                ),
                              )
                            : Container(
                                height: 35,
                                width: 35,
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: color,
                                    borderRadius: BorderRadius.circular(45)),
                              ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              filteredContacts[index].displayName,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              number,
                              style: TextStyle(color: Colors.grey.shade500),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
