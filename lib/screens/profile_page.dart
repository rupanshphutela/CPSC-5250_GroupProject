import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:the_dig_app/models/profile.dart';
import 'package:the_dig_app/providers/dig_firebase_provider.dart';
import 'package:the_dig_app/routes/routes.dart';
import 'package:the_dig_app/util/profile_card.dart';

class ProfilePage extends StatelessWidget {
  final String email;
  final BuildContext context;
  const ProfilePage({super.key, required this.context, required this.email});

  @override
  Widget build(context) {
    final provider = Provider.of<DigFirebaseProvider>(context);

    List<Profile> profiles = provider.profiles;
    List<ProfileCard> cards = provider.cards;
    bool isLastCard = provider.isLastCard;
    void onLastSwipe() {
      provider.onLastSwipe();
    }

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
                  scale: 0,
                  cards: cards,
                  isDisabled: isLastCard,
                  onSwipe: _swipe,
                  onEnd: onLastSwipe,
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
                Icons.person,
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
            if (index == 0) {
            } else if (index == 1) {
            } else if (index == 2) {
              context.push('/add/owner/profile?email=$email');
            } else if (index == 3) {}
          },
        ),
      );
    } else {
      context.watch<DigFirebaseProvider>().getProfiles(email);
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
                Icons.person,
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
            if (index == 0) {
            } else if (index == 1) {
            } else if (index == 2) {
              context.push('/add/owner/profile?email=$email');
            } else if (index == 3) {}
          },
        ),
      );
    }
  }

  void _swipe(int index, CardSwiperDirection direction) async {
    final provider = Provider.of<DigFirebaseProvider>(context);
  }
}
