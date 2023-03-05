import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_dig_app/models/owner.dart';
import 'package:the_dig_app/models/profile.dart';
import 'package:the_dig_app/util/profile_card.dart';

class DigFirebaseProvider extends ChangeNotifier {
  FirebaseApp app;

  DigFirebaseProvider(this.app);

  Owner? _ownerProfile;

  /// Login Start
  StreamSubscription<User?>? _authSubscription;
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: <String>['email', 'profile'],
  );

  void checkFirebaseAuth() {
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      _isLoggedIn = user != null;
      notifyListeners();
    });
  }

  /// Login End

  ///Profile Page Start

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

  Future<void> getProfiles(String email) async {
    final profileDocs = await FirebaseFirestore.instance
        .collection('profile')
        .where('email', isNotEqualTo: email)
        .get();
    _profiles = profileDocs.docs.map((doc) => Profile.fromJson(doc)).toList();

    _cards = _profiles
        .map((candidate) => ProfileCard(
              card: candidate,
            ))
        .toList();
    notifyListeners();
  }

  // Future<void> insertSwipe(int index, CardSwiperDirection direction) async {
  //   if (direction.name == 'right') {
  //     await _database.rightSwipeDao.insertRightSwipe(RightSwipe(
  //         swiperProfileId: UniqueKey().hashCode,
  //         swiperOwnerId: _cards[index].card.ownerId,
  //         swipeDate: DateTime.now().toString(),
  //         swipedProfileId: _cards[index].card.id));
  //   } else if (direction.name == 'left') {
  //     await _database.leftSwipeDao.insertLeftSwipe(LeftSwipe(
  //         swiperProfileId: UniqueKey().hashCode,
  //         swiperOwnerId: _cards[index].card.ownerId,
  //         swipeDate: DateTime.now().toString(),
  //         swipedProfileId: _cards[index].card.id));
  //   } else if (direction.name == 'top') {
  //     await _database.topSwipeDao.insertTopSwipe(TopSwipe(
  //         swiperProfileId: UniqueKey().hashCode,
  //         swiperOwnerId: _cards[index].card.ownerId,
  //         swipeDate: DateTime.now().toString(),
  //         swipedProfileId: _cards[index].card.id));
  //   }
  //   notifyListeners();
  // }

  ///Profile Page End

  Owner? get ownerProfile => _ownerProfile;

  // Future<void> getOwnerProfilebyId(int ownerId) async {
  //   var profileDocs = await FirebaseFirestore.instance
  //       .collection('owner_profile')
  //       .where('id', isEqualTo: ownerId)
  //       .get();
  //   _ownerProfile =
  //       profileDocs.docs.map((doc) => Owner.fromJson(doc)).toList().first;
  //   notifyListeners();
  // }

  addOwnerProfile(Owner ownerObject) async {
    Owner owner = Owner(
        id: ownerObject.id,
        fName: ownerObject.fName,
        lName: ownerObject.lName,
        phone: ownerObject.phone,
        email: ownerObject.email,
        city: ownerObject.city,
        picture: ownerObject.picture);

    Map<String, dynamic> dataToSave = owner.toJson(owner);

    await FirebaseFirestore.instance
        .collection("owner_profile")
        .add(dataToSave);
  }
}
