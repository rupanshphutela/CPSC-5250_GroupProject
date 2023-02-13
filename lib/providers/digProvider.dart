import 'package:flutter/material.dart';
import 'package:the_dig_app/models/app_database.dart';
import 'package:the_dig_app/models/left_swipe.dart';
import 'package:the_dig_app/models/owner.dart';
import 'package:the_dig_app/models/profile.dart';
import 'dart:async';

import 'package:the_dig_app/models/right_swipe.dart';

class DigProvider extends ChangeNotifier {
  final AppDatabase _database;

  DigProvider(this._database);

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

    Future<List<Profile>> getProfiles() => _database.profileDao.getAllProfiles();
  
}
