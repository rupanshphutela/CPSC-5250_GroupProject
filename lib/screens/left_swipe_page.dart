import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:the_dig_app/models/profile.dart';
import 'package:the_dig_app/routes/routes.dart';
import 'package:the_dig_app/screens/dog_profile.dart';
import 'package:the_dig_app/screens/event.dart';
import 'package:the_dig_app/screens/settings.dart';
import 'package:the_dig_app/util/profile_card.dart';
import 'package:the_dig_app/providers/digProvider.dart';

class LeftSwipePage extends StatefulWidget {
  const LeftSwipePage({super.key});

  @override
  State<LeftSwipePage> createState() => _LeftSwipePageState();
}

class _LeftSwipePageState extends State<LeftSwipePage> {
  late List<ProfileCard> cards;
  final CardSwiperController controller = CardSwiperController();

  @override
  void initState() {
    super.initState();
    allProfiles();
  }

  void allProfiles() async {
    final digProvider = Provider.of<DigProvider>(context, listen: false);
    List<Profile> profiles = await digProvider.getProfiles();
    cards = profiles
        .map((candidate) => ProfileCard(
              card: candidate,
              isUserinFocus: false,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
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
          children: const [
            Flexible(child: Card()
                // child: CardSwiper(
                //   controller: controller,
                //   cards: cards,
                //   onSwipe: _swipe,
                //   padding: const EdgeInsets.all(24.0),
                // ),
                ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.teal), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.arrow_back, color: Colors.teal),
              label: 'Left Swiped Profiles'),
          BottomNavigationBarItem(
              icon: Icon(Icons.arrow_forward, color: Colors.teal),
              label: 'Right Swiped Profiles'),
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
