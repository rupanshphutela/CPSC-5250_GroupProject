import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:the_dig_app/screens/chat.dart';
import 'package:the_dig_app/screens/dog_profile.dart';
import 'package:the_dig_app/screens/event.dart';
import 'package:the_dig_app/screens/left_swipe_page.dart';

final _routes = [
  GoRoute(
    path: '/dogprofile',
    builder: (context, state) => const DogProfile(),
  ),
  GoRoute(
    path: '/chats',
    builder: (context, state) => const Chat(),
  ),
  GoRoute(
    path: '/events',
    builder: (context, state) => const Event(),
  ),
  GoRoute(
    path: '/settings',
    builder: (context, state) => const Settings(),
  ),
  GoRoute(
    path: '/left_swipe',
    builder: (context, state) => const LeftSwipePage(),
  ),
  GoRoute(
    path: '/right_swipe',
    builder: (context, state) =>
        const LeftSwipePage(), //Will update after creating
  ),
  GoRoute(
    path: '/top_swipe',
    builder: (context, state) =>
        const LeftSwipePage(), //Will update after creating
  ),
];

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.teal);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Chats',
      style: optionStyle,
    ),
    Text(
      'Index 2: Events',
      style: optionStyle,
    ),
    Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DIG'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('My Activities'),
            tiles: [
              SettingsTile(
                title: const Text('Rejects'),
                leading: const Icon(Icons.arrow_back_ios),
                onPressed: (BuildContext context) {
                  context.push('/left_swipe');
                },
              ),
              SettingsTile(
                title: const Text('Likes'),
                leading: const Icon(Icons.arrow_forward_ios),
                onPressed: (BuildContext context) {
                  context.push('/right_swipe');
                },
              ),
              SettingsTile(
                title: const Text('Superlikes'),
                leading: const Icon(Icons.arrow_upward_outlined),
                onPressed: (BuildContext context) {
                  context.push('/top_swipe');
                },
              ),
            ],
          ),
          SettingsSection(
            title: const Text('Account Details'),
            tiles: [
              SettingsTile(
                title: const Text('Security'),
                leading: const Icon(Icons.lock),
                onPressed: (BuildContext context) {},
              ),
            ],
          ),
        ],
      ),
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
