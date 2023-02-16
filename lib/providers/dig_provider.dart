import 'package:flutter/material.dart';
import 'package:the_dig_app/models/app_database.dart';
import 'package:the_dig_app/models/left_swipe.dart';
import 'package:the_dig_app/models/owner.dart';
import 'package:the_dig_app/models/profile.dart';
import 'dart:async';
import 'package:the_dig_app/models/right_swipe.dart';
import 'package:the_dig_app/models/top_swipe.dart';

class DigProvider extends ChangeNotifier {
  final AppDatabase _database;

  DigProvider(this._database);

  List<Profile> _profiles = [];

  bool created = false;

  bool get areCardsEmpty {
    if (_profiles.isEmpty) {
      return true;
    }
    return false;
  }

  List<Profile> get profiles {
    getProfiles();
    return _profiles.toList();
  }

  Future<void> insertOwnerProfile(Owner owner) async {
    await _database.ownerProfileDao.insertOwnerProfile(owner);
    notifyListeners();
  }

  Future<void> insertProfile(Profile profile) async {
    await _database.profileDao.insertProfile(profile);
    notifyListeners();
  }

  Future<void> insertLeftSwipe(LeftSwipe leftSwipe) async {
    await _database.leftSwipeDao.insertLeftSwipe(leftSwipe);
    notifyListeners();
  }

  Future<void> insertRightSwipe(RightSwipe rightSwipe) async {
    await _database.rightSwipeDao.insertRightSwipe(rightSwipe);
    notifyListeners();
  }

  Future<void> insertTopSwipe(TopSwipe topSwipe) async {
    await _database.topSwipeDao.insertTopSwipe(topSwipe);
    notifyListeners();
  }

  void getProfiles() async {
    _profiles = await _database.profileDao.getAllProfiles();
    notifyListeners();
  }

  void createDummyProfiles() async {
    int uniqueId = UniqueKey().hashCode;
    if (created == false) {
      await insertOwnerProfile(Owner(
        id: uniqueId,
        fName: 'Shahrukh $uniqueId',
        lName: 'Khan',
        phone: '4251112222',
        email: 'shah@gmail.com',
        picture: 'assets/images/owner1.jpg',
      ));
      await insertProfile(Profile(
        id: uniqueId + 1,
        fName: 'Bruno ${uniqueId + 1}',
        lName: 'bruzo',
        profilePicture: 'assets/images/dog1.jpg',
        ownerId: uniqueId,
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

      uniqueId = UniqueKey().hashCode;
      await insertOwnerProfile(Owner(
        id: uniqueId,
        fName: 'Salman $uniqueId',
        lName: 'Khan',
        phone: '4251112223',
        email: 'salman@gmail.com',
        picture: 'assets/images/owner2.jpg',
      ));
      await insertProfile(Profile(
        id: uniqueId + 1,
        fName: 'Tyson ${uniqueId + 1}',
        lName: 'tyso',
        profilePicture: 'assets/images/dog2.jpg',
        ownerId: uniqueId,
        gender: 'Male',
        breed: 'Pug',
        color: 'White',
        isVaccinated: true,
        registrationDate: '2/12/23',
        isSpayed: false,
        isNeutered: true,
        joiningDate: '2/12/23',
        size: '5',
      ));

      uniqueId = UniqueKey().hashCode;
      await insertOwnerProfile(Owner(
        id: uniqueId,
        fName: 'AB',
        lName: 'de',
        phone: '4251112225',
        email: 'ab@gmail.com',
        picture: 'assets/images/owner4.jpg',
      ));
      await insertProfile(Profile(
        id: uniqueId + 1,
        fName: 'Junior $uniqueId',
        lName: 'juno',
        profilePicture: 'assets/images/dog4.jpg',
        ownerId: 3,
        gender: 'Male',
        breed: 'Saint Bernard',
        color: 'White',
        isVaccinated: true,
        registrationDate: '2/12/23',
        isSpayed: false,
        isNeutered: true,
        joiningDate: '2/12/23',
        size: '15',
      ));

      uniqueId = UniqueKey().hashCode;
      await insertOwnerProfile(Owner(
        id: uniqueId,
        fName: 'Virat $uniqueId',
        lName: 'Kohli',
        phone: '4251112224',
        email: 'virat@gmail.com',
        picture: 'assets/images/owner3.jpg',
      ));
      await insertProfile(Profile(
        id: uniqueId + 1,
        fName: 'Auggie ${uniqueId + 1}',
        lName: 'auggy',
        profilePicture: 'assets/images/dog3.jpg',
        ownerId: uniqueId,
        gender: 'Male',
        breed: 'Sheepadoodle',
        color: 'Black',
        isVaccinated: true,
        registrationDate: '2/12/23',
        isSpayed: false,
        isNeutered: true,
        joiningDate: '2/12/23',
        size: '10',
      ));
      created = true;
    }
  }
}
