import 'package:go_router/go_router.dart';
import 'package:the_dig_app/screens/profile_form.dart';
import 'package:the_dig_app/screens/owner_profile_form.dart';
import 'package:the_dig_app/screens/left_swipe_page.dart';
import '../screens/profile_page.dart';
import '../screens/chat.dart';
import '../screens/event.dart';
import '../screens/login_page.dart';
import '../screens/settings.dart';

final routes = [
  GoRoute(
    path: '/login',
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: '/profile',
    builder: (context, state) {
      final String email = state.queryParams['email'].toString();
      return ProfilePage(email: email);
    },
  ),
  GoRoute(
    path: '/add/profile',
    builder: (context, state) => const ProfileForm(),
  ),
  GoRoute(
      path: '/add/owner/profile',
      builder: (context, state) {
        final String email = state.queryParams['email'].toString();
        return OwnerProfileForm(email: email);
      }),
  GoRoute(
    path: '/chats',
    builder: (context, state) => Chat(
      chatId: '',
      otherUserId: '',
      userId: '',
    ),
  ),
  GoRoute(
    path: '/settings',
    builder: (context, state) {
      final String email = state.queryParams['email'].toString();
      return SettingsPage(email: email);
    },
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
