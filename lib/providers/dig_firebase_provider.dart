import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_dig_app/models/contact.dart';
import 'package:the_dig_app/models/owner.dart';
import 'package:the_dig_app/models/profile.dart';
import 'package:the_dig_app/models/swipe.dart';
import 'package:the_dig_app/util/profile_card.dart';

//http for notification API
import 'package:http/http.dart' as http;

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

  storeNotificationToken(String profileId) async {
    String? token = await FirebaseMessaging.instance.getToken();
    FirebaseFirestore.instance
        .collection('profile')
        .doc(profileId)
        .set({'token': token}, SetOptions(merge: true));
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

  late List<Profile> currentProfile;

  Future<void> getCurrentUserProfile(String email) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("profile")
        .where("email", isEqualTo: email)
        .get();
    if (snapshot.docs.isNotEmpty) {
      currentProfile =
          snapshot.docs.map((doc) => Profile.fromJson(doc)).toList();
    }
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

  ///
  ///Fetching images.
  ///

  Future<String> getImagesFromFirestoreAndStorage(String email) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('profile')
        .where("email", isEqualTo: email)
        .get();

    final List<String> imageUrls = [];
    for (final DocumentSnapshot doc in snapshot.docs) {
      final String storagePath = 'images/${doc.id}';
      final ListResult result =
          await FirebaseStorage.instance.ref(storagePath).listAll();
      final List<String> urls = await Future.wait(
          result.items.map((ref) => ref.getDownloadURL()).toList());
      imageUrls.addAll(urls);
    }

    return imageUrls.join();
  }

  ///Notification start
  sendNotification(String title, String token) async {
    final data = {
      'click_action': 'FLUTTER_NOTIFICATION_CLICK',
      'id': '1',
      'status': 'done',
      'message': title,
    };

    try {
      http.Response response = await http.post(
          Uri.parse(
              'fcm.googleapis.com/v1/projects/myproject-b5ae1/messages:send'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC9vmATeG9QqKbU\n3yLsE/AUVWUU5vJheJUEdmvMK7w7fXch8Rm7kOSfSXLIg/Rt9bOLiZfyXRpfNC6k\npS4VAl7ei/eppM3qRazN7uvgrLAiHM7muhhEFUEEBbQnLvuGz6zTQfVRq59IQxWs\nPJmm1PkXeaQ3ghHgoqY93nv621ChcSrsSWMYkcnHMsQaosGIMLGCrDpEH1wUuUgL\nuPSaxL0B8fXDxfhCQqMXuXiEXh07Tl+retJgQ1wQuMoj64KOxAwhGROxRUlG6oj5\nKDRd8ci30sKWb+adtTPtJKKkg8ngxKJ6ihFQl/hMloQuIILZ+2nLXva7/yAfIczL\neEGrtPONAgMBAAECggEACthw4WwG4NNjBdPjSR8yn9bpujIhNJUR33ltW/Q8BCJ9\nxsDjOadkif5Gw1NXi1l588Xfm4ja0wpGiD6wzZ6fEZVqiJXU90kYQYUgkm0MfEat\nRN7qOCoG11YEICE9W01PkZu5i/uFVToQaRHlrnWJ71+SlWGn5/EkE3E+IO6cQz39\nd/4xGOa20RJf+zZxdU6LxToORGWV+6YYMIeijifjkFnAeso7LNZ6SBbX8i83HQeM\nxmZHQIqae/NmpkQ+P3pu48hY7dt4egRWmb6697lo3jyvM+jz85kcQO5XlKCOJ9wG\nmkF8to5TEJaVm563D6EQh48l3mRmqA6dq3OGaxfseQKBgQDrcgAIYVqD2bItmjc1\npBglNpolI9jKeX7/ULuANKLf2dEbXiAa2NP3SqHkQVJKy9XjUnLAKboJe6qY0b7q\nEYoM+APLhnmjAHDrKJw1Pu3ZRmEoniQTdt9ltGq0NqQQ2DI0Q//6DhGyrbhRuYoH\nR7KkwxBpCTKzBW1eB/tGkBajFwKBgQDOTvuCaiRLRdotbG+Z2W9EAmmXfK5IQxB4\nqYHSlc2NUdy67IBqzTtXBXa0laheGtIpHRgWHuaatgDB0ESds7cIcJ5SinGOHjxX\njk2fRyxaE7ZjquzXn9w9VsFG7lfPa6bmm60DtjiHBwqaukWopuoKSUBgwy59eHkh\n8gOeZazU+wKBgGojcjBU8uENem1kYA8mclwUSVkE1+4u5zlhw6UAFYykPMgBnqd7\np9KLKoAjkl11lm5r9J78MIml3joWE+KhFYLTK6LMdHku8biRDhpSzBZuy83rvIep\nxvuqYY/sMfoF/Fvja7nmLcRG3Bi7c6XkhHwSE4vGQbzCbZM+NeCRhCLxAoGBAIBy\nVk7tDKm81MjBIX6VDJw4MEu7ubqN3pxxVL2qvO6GkDnk81MLci2M3koyf0APzNcC\nITPsi0C5niENLRtOf9+GVlwni+mi04jjtVo8ctWmPkExcwIQqouaDv29ePhQGvqq\n4/5SnkEbVjPdU29cdIxw7N8RxkkiD7Ddv/kHbqKvAoGAdvKxdSOhDTMsJVOrir4x\nb5wUcS0qP96tDk58BeyvomU3dMhadYVXFwod362rtMyF+KbZFl4hbY6Z0IhifT1x\nXJ3FrmZH5lQqBW2PRc/kNBBNLmB6nSs2xZxsgBvZ2MWPhrtwQD1npahUSK6bImoG\nnmB4CzvI/gFjTjueUw4AX5s='
          },
          body: jsonEncode(<String, dynamic>{
            'message': <String, dynamic>{
              'notification': <String, dynamic>{
                'title': title,
                'body': 'You are followed by someone'
              },
              'priority': 'high',
              'data': data,
              'token': token
            },
          }));

      if (response.statusCode == 200) {
        print("Notification is sent");
      } else {
        print("Error");
      }
    } catch (e) {}
  }

  ///Notification
}
