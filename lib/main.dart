import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:the_dig_app/models/app_database.dart';
import 'package:the_dig_app/providers/dig_provider.dart';
import 'package:the_dig_app/routes/routes.dart';
import 'package:the_dig_app/screens/dog_profile.dart';

//firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kDebugMode) {
    print('initializing database');
  }

  //Initialize firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true, cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);

  //initialize SQLite DB
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
  initialLocation: '/login',
  routes: routes,
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
      body: DogProfile(context: context),
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
