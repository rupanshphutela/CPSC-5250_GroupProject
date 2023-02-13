import 'package:the_dig_app/firebase/auth.dart';
import 'package:the_dig_app/screens/login_register.dart';
import 'package:flutter/material.dart';
import 'package:the_dig_app/screens/settings.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Settings();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
