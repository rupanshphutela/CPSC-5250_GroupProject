import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:the_dig_app/models/app_database.dart';
import 'package:the_dig_app/models/left_swipe.dart';
import 'package:the_dig_app/models/owner.dart';
import 'package:the_dig_app/models/profile.dart';
import 'dart:async';
import 'package:the_dig_app/models/right_swipe.dart';
import 'package:the_dig_app/models/top_swipe.dart';
import 'package:the_dig_app/util/profile_card.dart';

class DigProvider extends ChangeNotifier {
  final AppDatabase _database;

  DigProvider(this._database);

  List<Profile> _profiles = [];
  List<ProfileCard> _cards = [];

  bool created = false;
  bool isLastCard = false;

  void onLastSwipe() {
    isLastCard = true;
    _profiles.clear();
    _cards.clear();
    notifyListeners();
  }

  List<Profile> get profiles {
    // getProfiles();
    return _profiles.toList();
  }

  List<ProfileCard> get cards {
    return _cards.toList();
  }

  void getProfiles() async {
    if (created == false) {
      created = true;
      int uniqueId = UniqueKey().hashCode;
      // await insertProfile(Profile(
      //   id: uniqueId,
      //   fName: 'Bruno $uniqueId',
      //   lName: 'bruzo',
      //   profilePicture: 'assets/images/dog1.jpg',
      //   ownerId: uniqueId,
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

      // uniqueId = UniqueKey().hashCode;
      // await insertProfile(Profile(
      //   id: uniqueId,
      //   fName: 'Tyson $uniqueId',
      //   lName: 'tyso',
      //   profilePicture: 'assets/images/dog2.jpg',
      //   ownerId: uniqueId,
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

      // uniqueId = UniqueKey().hashCode;
      // await insertProfile(Profile(
      //   id: uniqueId,
      //   fName: 'Junior $uniqueId',
      //   lName: 'juno',
      //   profilePicture: 'assets/images/dog4.jpg',
      //   ownerId: uniqueId,
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

      // uniqueId = UniqueKey().hashCode;
      // await insertProfile(Profile(
      //   id: uniqueId,
      //   fName: 'Auggie $uniqueId',
      //   lName: 'auggy',
      //   profilePicture: 'assets/images/dog3.jpg',
      //   ownerId: uniqueId,
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
    }
    _profiles = await _database.profileDao.getAllProfiles();
    _cards = _profiles
        .map((candidate) => ProfileCard(
              card: candidate,
            ))
        .toList();
    notifyListeners();
  }

  Future<void> insertOwnerProfile(Owner owner) async {
    await _database.ownerProfileDao.insertOwnerProfile(owner);
    notifyListeners();
  }

  Future<void> insertProfile(Profile profile) async {
    await _database.profileDao.insertProfile(profile);
    notifyListeners();
  }

  Future<void> insertSwipe(int index, CardSwiperDirection direction) async {
    if (direction.name == 'right') {
      await _database.rightSwipeDao.insertRightSwipe(RightSwipe(
          swiperProfileId: UniqueKey().hashCode,
          swiperOwnerId: _cards[index].card.ownerId,
          swipeDate: DateTime.now().toString(),
          swipedProfileId: _cards[index].card.id));
    } else if (direction.name == 'left') {
      await _database.leftSwipeDao.insertLeftSwipe(LeftSwipe(
          swiperProfileId: UniqueKey().hashCode,
          swiperOwnerId: _cards[index].card.ownerId,
          swipeDate: DateTime.now().toString(),
          swipedProfileId: _cards[index].card.id));
    } else if (direction.name == 'top') {
      await _database.topSwipeDao.insertTopSwipe(TopSwipe(
          swiperProfileId: UniqueKey().hashCode,
          swiperOwnerId: _cards[index].card.ownerId,
          swipeDate: DateTime.now().toString(),
          swipedProfileId: _cards[index].card.id));
    }
    notifyListeners();
  }
}
