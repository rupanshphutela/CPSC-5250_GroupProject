import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:the_dig_app/providers/dig_firebase_provider.dart';
import 'package:the_dig_app/routes/routes.dart';

//firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:the_dig_app/services/local_notification_service.dart';
import 'firebase_options.dart';

// FlutterFire's Firebase Cloud Messaging plugin
import 'package:firebase_messaging/firebase_messaging.dart';

// core Flutter primitives
import 'package:flutter/foundation.dart';

//Add stream controller
import 'package:rxdart/rxdart.dart';

//http for notification API
import 'package:http/http.dart' as http;

// used to pass messages from event handler to the UI
final _messageStreamController = BehaviorSubject<RemoteMessage>();

//Define the background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
    print('Message data: ${message.data}');
    print('Message notification: ${message.notification?.title}');
    print('Message notification: ${message.notification?.body}');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Initialize firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  LocalNotificationService.initialize();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  firestore.settings = const Settings(
      persistenceEnabled: true, cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);

  //Request permission
  final messaging = FirebaseMessaging.instance;

  final settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (kDebugMode) {
    print('Permission granted: ${settings.authorizationStatus}');
  }

  // Register with FCM
  // It requests a registration token for sending messages to users from your App server or other trusted server environment.
  String? token = await messaging.getToken();

  if (kDebugMode) {
    print('Registration Token=$token');
  }

  // Set up foreground message handler
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // if (kDebugMode) {
    //   print('Handling a foreground message: ${message.messageId}');
    //   print('Message data: ${message.data}');
    //   print('Message notification: ${message.notification?.title}');
    //   print('Message notification: ${message.notification?.body}');
    // }
    LocalNotificationService.display(message);

    _messageStreamController.sink.add(message);
  });

  // Set up background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

final _router = GoRouter(
  initialLocation: '/login',
  routes: routes,
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DigFirebaseProvider>(
      create: (_) => DigFirebaseProvider(Firebase.app()),
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        routerConfig: _router,
      ),
    );
  }

  sendNotification(String title, String token) async {
    final data = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': '1',
      'status': 'done',
      'message': title,
    };

    try {
      http.Response response = await http.post(
          Uri.parse(
              'fcm.googleapis.com/v1/projects/myproject-b5ae1/messages:send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC9vmATeG9QqKbU\n3yLsE/AUVWUU5vJheJUEdmvMK7w7fXch8Rm7kOSfSXLIg/Rt9bOLiZfyXRpfNC6k\npS4VAl7ei/eppM3qRazN7uvgrLAiHM7muhhEFUEEBbQnLvuGz6zTQfVRq59IQxWs\nPJmm1PkXeaQ3ghHgoqY93nv621ChcSrsSWMYkcnHMsQaosGIMLGCrDpEH1wUuUgL\nuPSaxL0B8fXDxfhCQqMXuXiEXh07Tl+retJgQ1wQuMoj64KOxAwhGROxRUlG6oj5\nKDRd8ci30sKWb+adtTPtJKKkg8ngxKJ6ihFQl/hMloQuIILZ+2nLXva7/yAfIczL\neEGrtPONAgMBAAECggEACthw4WwG4NNjBdPjSR8yn9bpujIhNJUR33ltW/Q8BCJ9\nxsDjOadkif5Gw1NXi1l588Xfm4ja0wpGiD6wzZ6fEZVqiJXU90kYQYUgkm0MfEat\nRN7qOCoG11YEICE9W01PkZu5i/uFVToQaRHlrnWJ71+SlWGn5/EkE3E+IO6cQz39\nd/4xGOa20RJf+zZxdU6LxToORGWV+6YYMIeijifjkFnAeso7LNZ6SBbX8i83HQeM\nxmZHQIqae/NmpkQ+P3pu48hY7dt4egRWmb6697lo3jyvM+jz85kcQO5XlKCOJ9wG\nmkF8to5TEJaVm563D6EQh48l3mRmqA6dq3OGaxfseQKBgQDrcgAIYVqD2bItmjc1\npBglNpolI9jKeX7/ULuANKLf2dEbXiAa2NP3SqHkQVJKy9XjUnLAKboJe6qY0b7q\nEYoM+APLhnmjAHDrKJw1Pu3ZRmEoniQTdt9ltGq0NqQQ2DI0Q//6DhGyrbhRuYoH\nR7KkwxBpCTKzBW1eB/tGkBajFwKBgQDOTvuCaiRLRdotbG+Z2W9EAmmXfK5IQxB4\nqYHSlc2NUdy67IBqzTtXBXa0laheGtIpHRgWHuaatgDB0ESds7cIcJ5SinGOHjxX\njk2fRyxaE7ZjquzXn9w9VsFG7lfPa6bmm60DtjiHBwqaukWopuoKSUBgwy59eHkh\n8gOeZazU+wKBgGojcjBU8uENem1kYA8mclwUSVkE1+4u5zlhw6UAFYykPMgBnqd7\np9KLKoAjkl11lm5r9J78MIml3joWE+KhFYLTK6LMdHku8biRDhpSzBZuy83rvIep\nxvuqYY/sMfoF/Fvja7nmLcRG3Bi7c6XkhHwSE4vGQbzCbZM+NeCRhCLxAoGBAIBy\nVk7tDKm81MjBIX6VDJw4MEu7ubqN3pxxVL2qvO6GkDnk81MLci2M3koyf0APzNcC\nITPsi0C5niENLRtOf9+GVlwni+mi04jjtVo8ctWmPkExcwIQqouaDv29ePhQGvqq\n4/5SnkEbVjPdU29cdIxw7N8RxkkiD7Ddv/kHbqKvAoGAdvKxdSOhDTMsJVOrir4x\nb5wUcS0qP96tDk58BeyvomU3dMhadYVXFwod362rtMyF+KbZFl4hbY6Z0IhifT1x\nXJ3FrmZH5lQqBW2PRc/kNBBNLmB6nSs2xZxsgBvZ2MWPhrtwQD1npahUSK6bImoG\nnmB4CzvI/gFjTjueUw4AX5s='
          },
          body: jsonEncode(<String, dynamic>{
            'message': <String, dynamic>{
              'notification': <String, dynamic>{
                'title': title,
                'body': 'You are followed by someone'
              },
              'priority': 'high',
              'data': data,
              'token': token
            },
          }));

      if (response.statusCode == 200) {
        print("Notification is sent");
      } else {
        print("Error");
      }
    } catch (e) {}
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
    );
  }
}
