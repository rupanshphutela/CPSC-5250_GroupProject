import 'package:flutter/material.dart';
import 'package:the_dig_app/models/app_database.dart';
import 'package:the_dig_app/models/profile.dart';
import 'dart:async';

class DigProvider extends ChangeNotifier {
  final AppDatabase _database;

  DigProvider(this._database);



  Future<void> insertProfile(Profile profile) async {
    await _database.profileDao.insertProfile(profile);
        final result = await _database.database.rawQuery(
        'SELECT * FROM profile'
    );
    print(result.length);
    notifyListeners();
  }

    Future<List<Profile>?> getProfiles() => _database.profileDao.getAllProfiles();
  
}
