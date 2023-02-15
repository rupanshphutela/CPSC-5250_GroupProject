import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:the_dig_app/models/left_swipe.dart';
import 'package:the_dig_app/models/profile.dart';
import 'package:the_dig_app/models/right_swipe.dart';
import 'package:the_dig_app/models/top_swipe.dart';
import 'package:the_dig_app/routes/routes.dart';
import 'package:the_dig_app/util/profile_card.dart';
import 'package:the_dig_app/providers/dig_provider.dart';

class DogProfile extends StatefulWidget {
  const DogProfile({super.key});

  @override
  State<DogProfile> createState() => _DogProfileState();
}

class _DogProfileState extends State<DogProfile> {
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('No dogs in your area!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Swiping disabled.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  final CardSwiperController controller = CardSwiperController();
  bool _isEmpty = false;
  List<ProfileCard> cards = [];
  @override
  Widget build(context) {
    // context.read<DigProvider>().createDummyProfiles();
    List<Profile> profiles = context.watch<DigProvider>().profiles;

    if (profiles.isNotEmpty) {
      cards = profiles
          .map((candidate) => ProfileCard(
                card: candidate,
              ))
          .toList();

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
                  controller: controller,
                  cards: cards,
                  isDisabled: _isEmpty,
                  onEnd: () {
                    _showMyDialog();
                    setState(() {
                      _isEmpty = true;
                    });
                  },
                  onSwipe: _swipe,
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
      context.read<DigProvider>().createDummyProfiles();
      return const CircularProgressIndicator();
    }
  }

  void _swipe(int index, CardSwiperDirection direction) async {
    final digProvider = Provider.of<DigProvider>(context, listen: false);
    if (direction.name == 'right') {
      await digProvider.insertRightSwipe(RightSwipe(
          swiperProfileId: UniqueKey().hashCode,
          swiperOwnerId: cards[index].card.ownerId,
          swipeDate: DateTime.now().toString(),
          swipedProfileId: cards[index].card.id));
      debugPrint('the card $index was swiped to the: ${direction.name}');
    } else if (direction.name == 'left') {
      await digProvider.insertLeftSwipe(LeftSwipe(
          swiperProfileId: UniqueKey().hashCode,
          swiperOwnerId: cards[index].card.ownerId,
          swipeDate: DateTime.now().toString(),
          swipedProfileId: cards[index].card.id));
      debugPrint('the card $index was swiped to the: ${direction.name}');
    } else if (direction.name == 'top') {
      await digProvider.insertTopSwipe(TopSwipe(
          swiperProfileId: UniqueKey().hashCode,
          swiperOwnerId: cards[index].card.ownerId,
          swipeDate: DateTime.now().toString(),
          swipedProfileId: cards[index].card.id));
      debugPrint('the card $index was swiped to the: ${direction.name}');
    }
  }
}
