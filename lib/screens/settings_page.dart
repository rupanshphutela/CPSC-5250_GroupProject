import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:the_dig_app/providers/dig_firebase_provider.dart';
import 'package:the_dig_app/util/bottom_navigation_bar.dart';

class SettingsPage extends StatelessWidget {
  final String email;
  const SettingsPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DigFirebaseProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Icon(Icons.settings),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('My Activities'),
            tiles: [
              SettingsTile(
                title: const Text('Left Swipes'),
                leading: const Icon(Icons.arrow_back_ios),
                onPressed: (BuildContext context) {
                  provider.clearSwipesList();
                  context.push('/swipes?email=$email&direction=left');
                },
              ),
              SettingsTile(
                title: const Text('Right Swipes'),
                leading: const Icon(Icons.arrow_forward_ios),
                onPressed: (BuildContext context) {
                  provider.clearSwipesList();
                  context.push('/swipes?email=$email&direction=right');
                },
              ),
              SettingsTile(
                title: const Text('Top Swipes'),
                leading: const Icon(Icons.arrow_upward_outlined),
                onPressed: (BuildContext context) {
                  provider.clearSwipesList();
                  context.push('/swipes?email=$email&direction=top');
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
