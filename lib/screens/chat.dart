import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:the_dig_app/routes/routes.dart';

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

  Chat(
      {super.key,
      required this.chatId,
      required this.userId,
      required this.otherUserId});

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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.teal,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat,
              color: Colors.teal,
            ),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.event,
              color: Colors.teal,
            ),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: Colors.teal,
            ),
            label: 'Settings',
          ),
        ],
        onTap: (index) {
          context.push(routes[index].path);
        },
      ),
    );
  }
}
