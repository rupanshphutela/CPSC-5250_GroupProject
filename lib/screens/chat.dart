import 'package:flutter/material.dart';
import 'package:the_dig_app/util/bottom_navigation_bar.dart';

class Chat extends StatelessWidget {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black);
  // static const List<Widget> _widgetOptions = <Widget>[
  // ];

  final ScrollController _scrollController = new ScrollController();
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
  }
}
