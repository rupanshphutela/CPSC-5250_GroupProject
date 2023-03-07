import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_dig_app/models/contact.dart';
import 'package:the_dig_app/providers/dig_firebase_provider.dart';
import 'package:the_dig_app/util/bottom_navigation_bar.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({
    super.key,
    required this.email,
  });
  final String email;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DigFirebaseProvider>(context);
    List<Contact>? contacts = provider.contacts.toList();

    if (contacts.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Icon(Icons.group),
        ),
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              Center(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Color(0xff764abc),
                      ),
                      title: Text(
                        '${contacts[index].destinationFName} ${contacts[index].destinationLName}',
                        style: const TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(
                          '${contacts[index].destinationBreed}, ${contacts[index].destinationColor}'),
                      trailing: CircleAvatar(
                        backgroundColor: Colors.brown,
                        child: IconButton(
                          icon: const Icon(Icons.chat),
                          onPressed: () {},
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: DigBottomNavBar(email: email),
      );
    } else {
      provider.getContacts(email); //???? dont you hardcode user
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Icon(Icons.swipe),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text(
                "No contacts found, but we'll keep checking...",
                style: TextStyle(fontSize: 16),
              ),
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        ),
        bottomNavigationBar: DigBottomNavBar(email: email),
      );
    }
  }
}
