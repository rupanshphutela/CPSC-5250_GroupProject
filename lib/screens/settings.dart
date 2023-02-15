import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:the_dig_app/routes/routes.dart';

class Settings extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("To be done later..."),
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
                  // context.push('/left_swipe');
                },
              ),
              SettingsTile(
                title: const Text('Likes'),
                leading: const Icon(Icons.arrow_forward_ios),
                onPressed: (BuildContext context) {
                  // context.push('/right_swipe');
                },
              ),
              SettingsTile(
                title: const Text('Superlikes'),
                leading: const Icon(Icons.arrow_upward_outlined),
                onPressed: (BuildContext context) {
                  // context.push('/top_swipe');
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
        onTap: (index) {
          context.push(routes[index].path);
        },
      ),
    );
  }
}
