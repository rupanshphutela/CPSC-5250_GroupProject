import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_dig_app/models/owner.dart';
import 'package:the_dig_app/models/profile.dart';
import 'package:the_dig_app/models/swipe.dart';
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

  ///Profiles Page Start

  List<Profile> _profiles = [];
  List<ProfileCard> _cards = [];

  bool created = false;
  bool isLastCard = false;

  void onLastSwipe() {
    isLastCard = true;
    // _profiles.clear();
    // _cards.clear();
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
    var allProfiles =
        profileDocs.docs.map((doc) => Profile.fromJson(doc)).toList();

    final swipedProfileDocs = await FirebaseFirestore.instance
        .collection('swipe')
        .where('sourceProfileEmail', isEqualTo: email)
        .get();

    List<Swipe> swipedProfileList =
        swipedProfileDocs.docs.map((doc) => Swipe.fromJson(doc)).toList();

    List<String> swipedProfileEmailList =
        swipedProfileList.map((e) => e.destinationProfileEmail).toList();

    _profiles = allProfiles
        .where((element) => !swipedProfileEmailList.contains(element.email))
        .toList();

    _cards = profiles
        .map((candidate) => ProfileCard(
              card: candidate,
            ))
        .toList();
    notifyListeners();
  }

  Future<void> insertSwipe(int index, CardSwiperDirection direction) async {
    if (direction.name == 'right' ||
        direction.name == 'top' ||
        direction.name == 'left') {
      int swipeId = UniqueKey().hashCode;
      Profile currentUserProfile;
      String email = FirebaseAuth.instance.currentUser!.email.toString();

      final profileDocs = await FirebaseFirestore.instance
          .collection('profile')
          .where('email', isEqualTo: email)
          .get();
      var currentUserProfileList =
          profileDocs.docs.map((doc) => Profile.fromJson(doc)).toList();

      if (currentUserProfileList.isNotEmpty) {
        currentUserProfile = currentUserProfileList.first;

        Swipe swipeObject = Swipe(
            id: swipeId,
            sourceProfileEmail: currentUserProfile.email,
            sourceProfileId: currentUserProfile.id,
            sourceProfileFName: currentUserProfile.fName,
            sourceProfileLName: currentUserProfile.lName,
            swipeDate: DateTime.now().toString(),
            destinationProfileEmail: _profiles[index].email,
            destinationProfileId: _profiles[index].id,
            destinationProfileFName: _profiles[index].fName,
            destinationProfileLName: _profiles[index].lName,
            direction: direction.name);

        Map<String, dynamic> dataToSave = swipeObject.toJson(swipeObject);

        await FirebaseFirestore.instance.collection("swipe").add(dataToSave);
      }
      notifyListeners();
    }
  }

  ///Profiles Page End

  ///Outgoing Swipes Start
  List<Swipe> _swipesList = [];
  List<Swipe> get swipesList => _swipesList.toList();
  Future<void> getSwipesList(String email, String direction) async {
    final currentUserSwipesDocs = await FirebaseFirestore.instance
        .collection('swipe')
        .where('sourceProfileEmail', isEqualTo: email)
        .get();

    List<Swipe> currentUserSwipesList =
        currentUserSwipesDocs.docs.map((doc) => Swipe.fromJson(doc)).toList();

    _swipesList = currentUserSwipesList
        .where((element) => element.direction == direction)
        .toList();
  }

  void clearSwipesList() {
    _swipesList.clear();
    swipesList.clear();
    notifyListeners();
  }

  ///Outgoing Swipes End

  ///Incoming Swipes Start
  List<Swipe> _incomingSwipesList = [];
  List<Swipe> get incomingSwipesList => _incomingSwipesList.toList();
  Future<void> getIncomingSwipesList(String email) async {
    final incomingSwipesDocs = await FirebaseFirestore.instance
        .collection('swipe')
        .where('destinationProfileEmail', isEqualTo: email)
        .get();

    List<Swipe> incomingSwipesList =
        incomingSwipesDocs.docs.map((doc) => Swipe.fromJson(doc)).toList();

    //Users who have requested to connect with current user
    List<Swipe> connectRequestList = incomingSwipesList
        .where((element) =>
            element.direction == 'top' || element.direction == 'right')
        .toList();

    //Current User's swipes
    final currentUserSwipesDocs = await FirebaseFirestore.instance
        .collection('swipe')
        .where('sourceProfileEmail', isEqualTo: email)
        .get();

    List<Swipe> currentUserSwipesList =
        currentUserSwipesDocs.docs.map((doc) => Swipe.fromJson(doc)).toList();

    //Users whose requests are accepted by current user
    List<Swipe> acceptSwipesList = currentUserSwipesList
        .where((element) => element.direction == 'right')
        .toList();

    List<String> acceptSwipesEmailList =
        acceptSwipesList.map((e) => e.destinationProfileEmail).toList();

    _incomingSwipesList = connectRequestList
        .where((element) =>
            !acceptSwipesEmailList.contains(element.sourceProfileEmail))
        .toList();
  }

  void clearIncomingSwipesList() {
    _incomingSwipesList.clear();
    incomingSwipesList.clear();
    notifyListeners();
  }

  ///Incoming Swipes End

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
