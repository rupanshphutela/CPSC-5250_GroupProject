import 'dart:io';

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
import 'package:the_dig_app/routes/routes.dart';
import 'package:the_dig_app/screens/chat.dart';
import 'package:the_dig_app/screens/dog_profile.dart';
import 'package:the_dig_app/screens/event.dart';
import 'package:the_dig_app/screens/settings.dart';
import 'package:the_dig_app/providers/feedback_position_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

final _router = GoRouter(
  initialLocation: '/dogprofile',
  routes: routes,
);

class MyApp extends StatelessWidget {
  final AppDatabase _database;

  const MyApp(this._database, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // First NotifierProvider
        ChangeNotifierProvider(create: (_) => DigProvider(_database)),
        // Second NotifierProvider
        ChangeNotifierProvider(create: (context) => FeedbackPositionProvider()),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.teal,
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
      body: const DogProfile(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.teal), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat, color: Colors.teal), label: 'Chats'),
          BottomNavigationBarItem(
              icon: Icon(Icons.event, color: Colors.teal), label: 'Events'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings, color: Colors.teal),
              label: 'Settings'),
        ],
        onTap: (index) {
          context.push(routes[index].path);
        },
      ),
    );
  }
}
