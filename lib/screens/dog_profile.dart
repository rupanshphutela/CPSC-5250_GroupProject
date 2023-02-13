import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_dig_app/firebase/auth.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:the_dig_app/models/profile.dart';
import 'package:the_dig_app/screens/chat.dart';
import 'package:the_dig_app/screens/event.dart';
import 'package:the_dig_app/screens/settings.dart';
import 'package:the_dig_app/util/profile_card.dart';
import 'package:the_dig_app/providers/digProvider.dart';

import '../models/profile_model.dart';
// import '../util/profile_card.dart';

final _routes = [
  GoRoute(
    path: '/dogprofile',
    builder: (context, state) => DogProfile(),
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
    builder: (context, state) => Settings(),
  ),
];

final _router = GoRouter(
  initialLocation: '/dogprofile',
  routes: _routes,
);

class DogProfile extends StatefulWidget {
  DogProfile({super.key});

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _userId() {
    return Text(user?.email ?? 'User email');
  }

  Widget _signOutButton() {
    return ElevatedButton(
      onPressed: signOut,
      child: const Text('Sign Out'),
    );
  }

  @override
  State<DogProfile> createState() => _DogProfileState();
}

class _DogProfileState extends State<DogProfile> {
  int counter = 4;
  final CardSwiperController controller = CardSwiperController();

  @override
  void initState() {
    final digProvider = Provider.of<DigProvider>(context, listen: false);
    super.initState();

    //   for(var i = 14; i<17; i++){
    //     digProvider.insertProfile(
    //         Profile(
    //     id: i,
    //     fName: 'Bruno $i',
    //     lName: 'dsf $i ',
    //     profilePicture: 'assets/images/dog$i.jpg',
    //     ownerId: 1,
    //     gender: 'Male',
    //     breed: 'Labrador',
    //     color: 'Golden',
    //     isVaccinated: true,
    //     registrationDate: '2/12/23',
    //     isSpayed: false,
    //     isNeutered: true,
    //     joiningDate: '2/12/23',
    //     size: '10',
    // )

    //     );
    // }
    var cards;
    void _allProfiles() async {
      // final digProvider = Provider.of<DigProvider>(context, listen: false);
      List<Profile>? profiles = await digProvider.getProfiles();
      cards = await profiles!
          .map((candidate) => ProfileCard(
                card: candidate,
              ))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final digProvider = Provider.of<DigProvider>(context, listen: false);
    for (var i = 22; i < 25; i++) {
      digProvider.insertProfile(Profile(
        id: i,
        fName: 'Bruno $i',
        lName: 'dsf $i ',
        profilePicture: 'assets/images/dog$i.jpg',
        ownerId: 1,
        gender: 'Male',
        breed: 'Labrador',
        color: 'Golden',
        isVaccinated: true,
        registrationDate: '2/12/23',
        isSpayed: false,
        isNeutered: true,
        joiningDate: '2/12/23',
        size: '10',
      ));
    }
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    print(digProvider.getProfiles());

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
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          widget._userId(),
          widget._signOutButton(),
        ]),
      ),
      //   body: SafeArea(
      //     child: Column(
      //     children: [
      //       Flexible(
      //         child: CardSwiper(
      //           controller: controller,
      //           cards: cards,
      //           onSwipe: _swipe,
      //           padding: const EdgeInsets.all(24.0),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),

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
          context.push(_routes[index].path);
        },
      ),
    );
  }

  void _swipe(int index, CardSwiperDirection direction) {
    debugPrint('the card $index was swiped to the: ${direction.name}');
  }
}
