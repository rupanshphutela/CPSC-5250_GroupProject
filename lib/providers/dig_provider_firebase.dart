import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_dig_app/models/owner.dart';

class FirebaseProvider extends ChangeNotifier {
  FirebaseApp app;

  FirebaseProvider(this.app);

  Owner? _ownerProfile;

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

  Owner? get ownerProfile => _ownerProfile;

  Future<void> getOwnerProfilebyId(int ownerId) async {
    var profileDocs = await FirebaseFirestore.instance
        .collection('owner_profile')
        .where('id', isEqualTo: ownerId)
        .get();
    _ownerProfile =
        profileDocs.docs.map((doc) => Owner.fromJson(doc)).toList().first;
    notifyListeners();
  }

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
