import 'package:flutter/material.dart';
import 'package:the_dig_app/models/app_database.dart';

class DigProvider extends ChangeNotifier {
  final AppDatabase _database;

  DigProvider(this._database);
}
