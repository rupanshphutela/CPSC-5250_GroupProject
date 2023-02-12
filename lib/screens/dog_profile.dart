import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:go_router/go_router.dart';
import 'package:the_dig_app/screens/chat.dart';
import 'package:the_dig_app/screens/event.dart';
import 'package:the_dig_app/screens/settings.dart';
import 'package:the_dig_app/util/profile_card.dart';
import 'package:swipeable_card_stack/swipeable_card_stack.dart';

import '../models/profile_model.dart';
// import '../util/profile_card.dart';


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

class DogProfile extends StatefulWidget {
  const DogProfile({super.key});

  @override
  State<DogProfile> createState() => _DogProfileState();
}

class _DogProfileState extends State<DogProfile> {
  int counter = 4;
  final CardSwiperController controller = CardSwiperController();

  final cards = candidates.map((candidate) => ProfileCard(card: candidate,)).toList();
  @override
  Widget build(BuildContext context) {
    
    SwipeableCardSectionController _cardController =
        SwipeableCardSectionController();
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Notch"),
          backgroundColor: Colors.white,
          leading: const Icon(Icons.person),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.chat,
                color: Colors.white,
              ),
              onPressed: () {},
            )
          ],
        ),
        body: SafeArea(
          child: Column(
          children: [
            Flexible(
              child: CardSwiper(
                controller: controller,
                cards: cards,
                onSwipe: _swipe,
                padding: const EdgeInsets.all(24.0),
              ),
            ),
          ],
        ),
      ),
      

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
  void _swipe(int index, CardSwiperDirection direction) {
    debugPrint('the card $index was swiped to the: ${direction.name}');
  }
}

