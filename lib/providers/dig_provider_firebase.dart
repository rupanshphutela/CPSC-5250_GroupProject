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

  List<Owner> _ownerProfiles = [];

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

  List<Owner?> get ownerProfiles => _ownerProfiles.toList();

  Future<void> getOwnerProfilebyId(int ownerId) async {
    var profileDocs = await FirebaseFirestore.instance
        .collection('owner_profiles')
        .where('id', isEqualTo: ownerId)
        .get();
    _ownerProfiles =
        profileDocs.docs.map((doc) => Owner.fromJson(doc)).toList();
    notifyListeners();
  }
}
