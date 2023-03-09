import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_dig_app/models/contact.dart';
import 'package:the_dig_app/providers/dig_firebase_provider.dart';
import 'package:the_dig_app/screens/login_page.dart';
import 'package:the_dig_app/util/bottom_navigation_bar.dart';

class Chat extends StatelessWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black);
  // static const List<Widget> _widgetOptions = <Widget>[
  // ];

  final ScrollController _scrollController = ScrollController();
  final messageTextController = TextEditingController();
  static const String id = 'chat';

  final String chatId;
  final String userId;
  final String otherUserId;
  final String email;

  Chat({
    super.key,
    required this.chatId,
    required this.userId,
    required this.otherUserId,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DigFirebaseProvider>(context);
    bool isLoggedIn = provider.isLoggedIn;
    if (isLoggedIn) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Icon(Icons.pets_outlined),
        ),
        body: const Center(
            child: Text(
          'To be done later...',
          style: optionStyle,
        )),
        bottomNavigationBar: DigBottomNavBar(email: email),
      );
    } else {
      const CircularProgressIndicator();

      return const LoginScreen();
    }
  }
}
