import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
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
    setState(() {});
    print("Contacts ${contacts.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Envoyer de l'argent"),
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
                decoration: InputDecoration(
                  labelText: "A",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(45)),
                      child: const Icon(
                        Icons.add_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        "Envoyer à un nouveau numéro",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              const Text(
                "Contacts",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20,
              ),
              ListView.builder(
                itemCount: contacts.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index) => Column(
                  children: [
                    Text(contacts[index].displayName),
                    Text(contacts[index].phones.isNotEmpty
                        ? contacts[index].phones[0].normalizedNumber
                        : "")
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
