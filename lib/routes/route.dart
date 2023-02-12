import 'package:go_router/go_router.dart';
import '../screens/dog_profile.dart';
import '../screens/chat.dart';
import '../screens/event.dart';
import '../screens/settings.dart';

final _router = GoRouter(
  initialLocation: '/dogprofile',
  routes: [
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
  ]
);
