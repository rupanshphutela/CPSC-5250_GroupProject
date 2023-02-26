import 'package:go_router/go_router.dart';
import 'package:the_dig_app/screens/add_profile.dart';
import 'package:the_dig_app/screens/add_profile_form.dart';
import 'package:the_dig_app/screens/left_swipe_page.dart';
import '../screens/dog_profile.dart';
import '../screens/chat.dart';
import '../screens/event.dart';
import '../screens/settings.dart';

final routes = [
  GoRoute(
    path: '/dogprofile',
    builder: (context, state) => DogProfile(context: context),
  ),
  GoRoute(
    path: '/addprofile',
    builder: (context, state) => AddProfile(),
  ),
    GoRoute(
    path: '/addprofileform',
    builder: (context, state) => AddProfileForm(),
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
  GoRoute(
    path: '/left_swipe',
    builder: (context, state) => const LeftSwipePage(),
  ),
  GoRoute(
    path: '/right_swipe',
    builder: (context, state) =>
        const LeftSwipePage(), //Will update after creating
  ),
  GoRoute(
    path: '/top_swipe',
    builder: (context, state) =>
        const LeftSwipePage(), //Will update after creating
  ),
];
