import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:the_dig_app/models/profile.dart';
import 'package:the_dig_app/routes/routes.dart';
import 'package:the_dig_app/providers/dig_provider.dart';

class DogProfile extends StatelessWidget {
  final BuildContext context;
  const DogProfile({super.key, required this.context});

  @override
  Widget build(context) {
    List<Profile> profiles = context.watch<DigProvider>().profiles;

    if (profiles.isNotEmpty) {
      // List<ProfileCard> cards = profiles
      //     .map((candidate) => ProfileCard(
      //           card: candidate,
      //         ))
      //     .toList();

      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Icon(Icons.pets_outlined),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Flexible(
                child: CardSwiper(
                  cards: context.watch<DigProvider>().cards,
                  isDisabled: context.watch<DigProvider>().isLastCard,
                  onSwipe: _swipe,
                  onEnd: context.read<DigProvider>().onLastSwipe,
                  padding: const EdgeInsets.all(24.0),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.teal,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.chat,
                color: Colors.teal,
              ),
              label: 'Chats',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.event,
                color: Colors.teal,
              ),
              label: 'Events',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color: Colors.teal,
              ),
              label: 'Settings',
            ),
          ],
          onTap: (index) {
            context.push(routes[index].path);
          },
        ),
      );
    } else {
      context.watch<DigProvider>().getProfiles();
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Icon(Icons.pets_outlined),
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Flexible(
                    child: Text(
                  'No More dogs found in your area',
                  style: TextStyle(fontSize: 24),
                )),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.teal,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.chat,
                color: Colors.teal,
              ),
              label: 'Chats',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.event,
                color: Colors.teal,
              ),
              label: 'Events',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color: Colors.teal,
              ),
              label: 'Settings',
            ),
          ],
          onTap: (index) {
            context.push(routes[index].path);
          },
        ),
      );
    }
  }

  void _swipe(int index, CardSwiperDirection direction) async {
    await context.read<DigProvider>().insertSwipe(index, direction);
  }
}
