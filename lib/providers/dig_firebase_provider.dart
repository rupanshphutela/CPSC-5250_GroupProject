import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_dig_app/models/contact.dart';
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

  onLogout() {
    _profiles.clear();
    _cards.clear();
    _contacts.clear();
    _profiles.clear();
    _swipesList.clear();
    _incomingSwipesList.clear();
    notifyListeners();
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
    //Find profiles where email is not same as current user's email
    final profileDocs = await FirebaseFirestore.instance
        .collection('profile')
        .where('email', isNotEqualTo: email)
        .get();
    var allProfiles =
        profileDocs.docs.map((doc) => Profile.fromJson(doc)).toList();

    //Find profiles which user has already swiped
    final swipedProfileDocs = await FirebaseFirestore.instance
        .collection('swipe')
        .where('sourceProfileEmail', isEqualTo: email)
        .get();

    List<Swipe> swipedProfileList =
        swipedProfileDocs.docs.map((doc) => Swipe.fromJson(doc)).toList();

    List<String> swipedProfileEmailList =
        swipedProfileList.map((e) => e.destinationProfileEmail).toList();

    //Find profiles who have right/top swiped the current user
    final currentUserSwipedDocs = await FirebaseFirestore.instance
        .collection('swipe')
        .where('destinationProfileEmail', isEqualTo: email)
        .get();

    List<Swipe> currentUserSwipedList =
        currentUserSwipedDocs.docs.map((doc) => Swipe.fromJson(doc)).toList();

    List<Swipe> filteredCurrentUserSwipedList = currentUserSwipedList
        .where((element) =>
            (element.direction == 'right' || element.direction == 'top') &&
            element.status == 'Pending')
        .toList();

    List<String> filteredCurrentUserSwipedEmailList =
        filteredCurrentUserSwipedList
            .map((e) => e.destinationProfileEmail)
            .toList();

    //combine email addresses of those profiles
    List<String> combinedSwipeList =
        filteredCurrentUserSwipedEmailList.toList();
    combinedSwipeList.addAll(swipedProfileEmailList);

    //filter email addresses from all profiles
    _profiles = allProfiles
        .where((element) => !combinedSwipeList.contains(element.email))
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
            sourceBreed: currentUserProfile.breed,
            sourceColor: currentUserProfile.color,
            swipeDate: DateTime.now().toString(),
            destinationProfileEmail: _profiles[index].email,
            destinationProfileId: _profiles[index].id,
            destinationProfileFName: _profiles[index].fName,
            destinationProfileLName: _profiles[index].lName,
            destinationBreed: _profiles[index].breed,
            destinationColor: _profiles[index].color,
            direction: direction.name,
            status: direction.name == 'top' || direction.name == 'right'
                ? 'Pending'
                : direction.name == 'left'
                    ? 'Rejected'
                    : 'Invalid');

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

    _swipesList =
        currentUserSwipesDocs.docs.map((doc) => Swipe.fromJson(doc)).toList();
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

    _incomingSwipesList =
        incomingSwipesDocs.docs.map((doc) => Swipe.fromJson(doc)).toList();
    notifyListeners();
  }

  void clearIncomingSwipesList() {
    _incomingSwipesList.clear();
    incomingSwipesList.clear();
    notifyListeners();
  }

  respondToRequest(int id, String action) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('swipe')
        .where('id', isEqualTo: id)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      String docId = querySnapshot.docs.first.id;

      final DocumentReference documentReference =
          FirebaseFirestore.instance.collection('swipe').doc(docId);

      await documentReference.update({
        'status': action,
      }).then((value) {
        debugPrint('Update successful');
      }).catchError((error) {
        debugPrint('Update failed: $error');
      });
      notifyListeners();
    }
  }

  ///Incoming Swipes End

  ///Contacts Start
  List<Contact> _contacts = [];
  List<Contact> get contacts => _contacts.toList();
  Future<void> getContacts(String email) async {
    final contactsDocs = await FirebaseFirestore.instance
        .collection('contact')
        .where('email', isEqualTo: email)
        .get();

    _contacts = contactsDocs.docs.map((doc) => Contact.fromJson(doc)).toList();
    notifyListeners();
  }

  Future<void> createContact(Swipe swipe) async {
    int requestorContactId = UniqueKey().hashCode;
    int acceptorContactId = UniqueKey().hashCode;

    Contact contactAcceptor = Contact(
        id: acceptorContactId,
        email: swipe.destinationProfileEmail,
        profileId: swipe.destinationProfileId,
        fName: swipe.destinationProfileFName,
        lName: swipe.destinationProfileLName,
        connectionSince: DateTime.now().toString(),
        destinationProfileId: swipe.sourceProfileId,
        destinationFName: swipe.sourceProfileFName,
        destinationLName: swipe.sourceProfileLName,
        destinationEmail: swipe.sourceProfileEmail,
        destinationBreed: swipe.sourceBreed,
        destinationColor: swipe.sourceColor);

    Contact contactRequestor = Contact(
        id: requestorContactId,
        email: swipe.sourceProfileEmail,
        profileId: swipe.sourceProfileId,
        fName: swipe.sourceProfileFName,
        lName: swipe.sourceProfileLName,
        connectionSince: DateTime.now().toString(),
        destinationProfileId: swipe.destinationProfileId,
        destinationFName: swipe.destinationProfileFName,
        destinationLName: swipe.destinationProfileLName,
        destinationEmail: swipe.destinationProfileEmail,
        destinationBreed: swipe.destinationBreed,
        destinationColor: swipe.destinationColor);

    Map<String, dynamic> dataToSaveAcceptor =
        contactAcceptor.toJson(contactAcceptor);
    Map<String, dynamic> dataToSaveRequestor =
        contactAcceptor.toJson(contactRequestor);

    await FirebaseFirestore.instance
        .collection("contact")
        .add(dataToSaveAcceptor);

    await FirebaseFirestore.instance
        .collection("contact")
        .add(dataToSaveRequestor)
        .then((value) => _incomingSwipesList.clear());
    notifyListeners();
  }

  ///Contacts End

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

  ///Sign Up/Login Start
  Future createProfile(Profile profile, String profileId) async {
    final docUser =
        FirebaseFirestore.instance.collection("profile").doc(profileId);
    final json = profile.toJson();
    await docUser.set(json);
  }

  ///Sign Up/Login End
  
  ///Fetching user profile
  Future<List<Profile>> readProfiles(String email) async {
    final snapshot = await FirebaseFirestore.instance
      .collection("profile")
      .where("email", isEqualTo: email)
      .get();
    final profiles = snapshot.docs.map((doc) => Profile.fromJson(doc)).toList();
    return profiles;
}


}
