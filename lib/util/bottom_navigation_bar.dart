import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DigBottomNavBar extends StatelessWidget {
  final String email;

  const DigBottomNavBar({
    required this.email,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
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
            Icons.person,
            color: Colors.teal,
          ),
          label: 'Profile',
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
        var route = ModalRoute.of(context);
        if (route?.settings.name != '/profiles' && index == 0) {
          context.push('/profiles?email=$email');
        } else if (index == 1) {
        } else if (route?.settings.name != '/add/owner/profile' && index == 2) {
          context.push('/add/owner/profile?email=$email');
        } else if (route?.settings.name != '/settings' && index == 3) {
          context.push('/settings?email=$email');
        } else {}
      },
    );
  }
}
