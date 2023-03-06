import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';
import 'package:the_dig_app/models/profile.dart';
import 'package:the_dig_app/providers/dig_firebase_provider.dart';
import 'package:the_dig_app/util/bottom_navigation_bar.dart';
import 'package:the_dig_app/util/profile_card.dart';

class ProfilesPage extends StatelessWidget {
  final String email;
  const ProfilesPage({super.key, required this.email});

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
                  onSwipe: (int index, CardSwiperDirection direction) async {
                    await provider.insertSwipe(index, direction);
                  },
                  onEnd: onLastSwipe,
                  padding: const EdgeInsets.all(24.0),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: DigBottomNavBar(email: email),
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
        bottomNavigationBar: DigBottomNavBar(email: email),
      );
    }
  }
}
