import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:the_dig_app/models/left_swipe.dart';
import 'package:the_dig_app/models/owner.dart';
import 'package:the_dig_app/models/profile.dart';
import 'package:the_dig_app/models/right_swipe.dart';
import 'package:the_dig_app/screens/chat.dart';
import 'package:the_dig_app/screens/event.dart';
import 'package:the_dig_app/screens/left_swipe_page.dart';
import 'package:the_dig_app/screens/settings.dart';
import 'package:the_dig_app/util/profile_card.dart';
import 'package:the_dig_app/providers/digProvider.dart';

import '../models/profile_model.dart';


final _routes = [
    GoRoute(
      path: '/dogprofile',
      builder: (context, state) => const DogProfile(),
    ),
    GoRoute(
      path: '/leftSwipe',
      builder: (context, state) => const LeftSwipePage(),
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
  late List<ProfileCard> cards;
  final CardSwiperController controller = CardSwiperController();

  @override
  void initState() {
    final digProvider = Provider.of<DigProvider>(context, listen: false);
    super.initState();
    allProfiles();
    // digProvider.insertOwnerProfile(
    //   Owner(id: 0, 
    //         fName: 'Shahrukh', 
    //         lName: 'Khan', 
    //         phone: '4251112222', 
    //         email: 'shah@gmail.com', 
    //         picture: 'assets/images/owner1.jpg',
    //       )
    //   );
    // digProvider.insertProfile(
    //   Profile(
    //   id: 0,
    //   fName: 'Bruno',
    //   lName: 'bruzo',
    //   profilePicture: 'assets/images/dog1.jpg',
    //   ownerId: 0,
    //   gender: 'Male',
    //   breed: 'Labrador',
    //   color: 'Golden',
    //   isVaccinated: true,
    //   registrationDate: '2/12/23',
    //   isSpayed: false,
    //   isNeutered: true,
    //   joiningDate: '2/12/23',
    //   size: '10',
    // ));
    // digProvider.insertOwnerProfile(
    //   Owner(id: 1, 
    //         fName: 'Salman', 
    //         lName: 'Khan', 
    //         phone: '4251112223', 
    //         email: 'salman@gmail.com', 
    //         picture: 'assets/images/owner2.jpg',
    //       )
    //   );
    // digProvider.insertProfile(
    //   Profile(
    //   id: 1,
    //   fName: 'Tyson',
    //   lName: 'tyso',
    //   profilePicture: 'assets/images/dog2.jpg',
    //   ownerId: 1,
    //   gender: 'Male',
    //   breed: 'Pug',
    //   color: 'White',
    //   isVaccinated: true,
    //   registrationDate: '2/12/23',
    //   isSpayed: false,
    //   isNeutered: true,
    //   joiningDate: '2/12/23',
    //   size: '5',
    // )); 

    // digProvider.insertOwnerProfile(
    //   Owner(id: 2, 
    //         fName: 'Virat', 
    //         lName: 'Kohli', 
    //         phone: '4251112224', 
    //         email: 'virat@gmail.com', 
    //         picture: 'assets/images/owner3.jpg',
    //       )
    //   );
    // digProvider.insertProfile(
    //   Profile(
    //   id: 2,
    //   fName: 'Auggie',
    //   lName: 'auggy',
    //   profilePicture: 'assets/images/dog3.jpg',
    //   ownerId: 2,
    //   gender: 'Male',
    //   breed: 'Sheepadoodle',
    //   color: 'Black',
    //   isVaccinated: true,
    //   registrationDate: '2/12/23',
    //   isSpayed: false,
    //   isNeutered: true,
    //   joiningDate: '2/12/23',
    //   size: '10',
    // )); 

    // digProvider.insertOwnerProfile(
    //   Owner(id: 3, 
    //         fName: 'AB', 
    //         lName: 'de', 
    //         phone: '4251112225', 
    //         email: 'ab@gmail.com', 
    //         picture: 'assets/images/owner4.jpg',
    //       )
    //   );
    // digProvider.insertProfile(
    //   Profile(
    //   id: 3,
    //   fName: 'Junior',
    //   lName: 'juno',
    //   profilePicture: 'assets/images/dog4.jpg',
    //   ownerId: 3,
    //   gender: 'Male',
    //   breed: 'Saint Bernard',
    //   color: 'White',
    //   isVaccinated: true,
    //   registrationDate: '2/12/23',
    //   isSpayed: false,
    //   isNeutered: true,
    //   joiningDate: '2/12/23',
    //   size: '15',
    // ));
    
  }

   void allProfiles() async {
    final digProvider = Provider.of<DigProvider>(context, listen: false);
    List<Profile> profiles = await digProvider.getProfiles();
    cards = profiles.map((candidate) => ProfileCard(card: candidate,)).toList();

    }

  @override
  Widget build(context) {
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
          BottomNavigationBarItem(icon: Icon(Icons.arrow_back, color: Colors.teal), label: 'Left Swiped Profiles'),
          BottomNavigationBarItem(icon: Icon(Icons.arrow_forward, color: Colors.teal), label: 'Right Swiped Profiles'),
          BottomNavigationBarItem(icon: Icon(Icons.settings, color: Colors.teal), label: 'Settings'),
        ],
        onTap: (index){
          context.push(_routes[index].path);
        },
      ),
    );
  }
  void _swipe(int index, CardSwiperDirection direction) {
    final digProvider = Provider.of<DigProvider>(context, listen: false);
    debugPrint('the card $index was swiped to the: ${direction.name}');
    if(direction.name == 'right'){
      digProvider.insertRightSwipe(
        RightSwipe(
          profileId: index, 
          ownerId: index, 
          swipeDate: '2/12/23', 
          targetId: index)
        );
    }
    else{
      digProvider.insertLeftSwipe(
        LeftSwipe(
            profileId: index, 
            ownerId: index, 
            swipeDate: '2/12/23', 
            targetId: index)
          );
    }
  }
}

