import 'dart:io';

import 'package:the_dig_app/widget_tree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:the_dig_app/models/app_database.dart';
import 'package:the_dig_app/providers/digProvider.dart';
import 'package:the_dig_app/screens/chat.dart';
import 'package:the_dig_app/screens/dog_profile.dart';
import 'package:the_dig_app/screens/event.dart';
import 'package:the_dig_app/screens/settings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (kDebugMode) {
    print('initializing database');
  }
  await initializeDatabase();
  if (kDebugMode) {
    print('loading database');
  }
  final AppDatabase database =
      await $FloorAppDatabase.databaseBuilder('dbdig.sqlite').build();

  if (kDebugMode) {
    print('running app');
  }
  runApp(MyApp(database));
}

Future<void> initializeDatabase() async {
  final databaseFilename =
      await sqfliteDatabaseFactory.getDatabasePath('dbdig.sqlite');

  if (!(await databaseExists(databaseFilename))) {
    try {
      await Directory(dirname(databaseFilename)).create(recursive: true);
    } catch (_) {}
    ByteData data = await rootBundle.load(join('assets', 'dbdig.sqlite'));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(databaseFilename).writeAsBytes(bytes, flush: true);
  }
}

final _routes = [
  GoRoute(
    path: '/widget_tree',
    builder: (context, state) => const WidgetTree(),
  ),
  GoRoute(
    path: '/dogprofile',
    builder: (context, state) => DogProfile(),
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
    builder: (context, state) => Settings(),
  ),
];

final _router = GoRouter(
  initialLocation: '/widget_tree',
  // initialLocation: '/dogprofile',
  routes: _routes,
);

class MyApp extends StatelessWidget {
  final AppDatabase _database;

  const MyApp(this._database, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DigProvider(_database),
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: _router,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DIG"),
      ),
      body: DogProfile(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.blue), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat, color: Colors.blue), label: 'Chats'),
          BottomNavigationBarItem(
              icon: Icon(Icons.event, color: Colors.blue), label: 'Events'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings, color: Colors.blue),
              label: 'Settings'),
        ],
        onTap: (index) {
          context.push(_routes[index].path);
        },
      ),
    );
  }
}
