import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:the_dig_app/providers/dig_firebase_provider.dart';
import 'package:the_dig_app/routes/routes.dart';
import 'package:the_dig_app/util/bottom_navigation_bar.dart';

class SettingsPage extends StatelessWidget {
  final String email;
  const SettingsPage({super.key, required this.email});

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
      bottomNavigationBar: DigBottomNavBar(email: email),
    );
  }
}
