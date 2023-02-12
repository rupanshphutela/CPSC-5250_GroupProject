import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_dig_app/screens/chat.dart';
import 'package:my_dig_app/screens/dog_profile.dart';
import 'package:my_dig_app/screens/event.dart';
import 'package:my_dig_app/screens/settings.dart';

void main() {
  runApp(const MyApp());
}

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
];

final _router = GoRouter(
  initialLocation: '/dogprofile',
  routes: _routes,
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      routerConfig: _router,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("DIG"),
      ),
      body: const DogProfile(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, color: Colors.teal), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.chat, color: Colors.teal), label: 'Chats'),
          BottomNavigationBarItem(icon: Icon(Icons.event, color: Colors.teal), label: 'Events'),
          BottomNavigationBarItem(icon: Icon(Icons.settings, color: Colors.teal), label: 'Settings'),
        ],
        onTap: (index){
          context.push(_routes[index].path);
        },
      ),
    );
  }
}

